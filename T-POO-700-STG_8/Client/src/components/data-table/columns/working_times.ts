import type { ColumnDef } from '@tanstack/vue-table'
import { h } from 'vue'

import { DataTableColumnHeader, DataTableRowActions } from '@/components/data-table'
import { workingTimeSchema, type WorkingTime } from '@/components/data-table/schemas'
import moment from 'moment'

interface WorkingTimesColumnProps {
  onDelete: ((row: any) => void) | undefined
  onUpdate: ((row: any, data: any) => void) | undefined
}

type WorkingTimesColumn = ColumnDef<WorkingTime> & { hidden?: boolean }

export const workingTimesColumns = (props: WorkingTimesColumnProps): WorkingTimesColumn[] => {
  const { onDelete, onUpdate } = props

  return [
    {
      accessorKey: 'start_time',
      header: ({ column }) => h(DataTableColumnHeader, { column, title: 'Start time' }),
      cell: ({ row }) => {
        return h('div', { class: 'flex space-x-2' }, [
          h(
            'span',
            { class: 'max-w-[500px] truncate' },
            moment(row.getValue('start_time')).utc(false).format('DD/MM/YYYY - HH:mm')
          )
        ])
      }
    },
    {
      accessorKey: 'end_time',
      header: ({ column }) => h(DataTableColumnHeader, { column, title: 'End time' }),
      cell: ({ row }) => {
        return h('div', { class: 'flex space-x-2' }, [
          h(
            'span',
            { class: 'max-w-[500px] truncate' },
            moment(row.getValue('end_time')).utc(false).format('DD/MM/YYYY - HH:mm')
          )
        ])
      }
    },
    {
      accessorKey: 'break_duration',
      header: ({ column }) => h(DataTableColumnHeader, { column, title: 'Break duration' }),
      cell: ({ row }) => {
        return h('div', { class: 'flex space-x-2' }, [
          h('span', { class: 'max-w-[500px] truncate' }, row.getValue('break_duration'))
        ])
      }
    },
    {
      id: 'actions',
      cell: ({ row }) =>
        h(DataTableRowActions, {
          schema: workingTimeSchema(),
          row,
          onUpdate,
          onDelete
        })
    }
  ]
}
