import type { ColumnDef } from '@tanstack/vue-table'
import { h } from 'vue'

import { DataTableColumnHeader, DataTableRowActions } from '@/components/data-table'
import { employeeSchema, type Employee } from '@/components/data-table/schemas'
import { ucfirst } from '@/lib/utils'

interface EmployeeColumnProps {
  onDelete: (row: any) => void
}

type EmployeeColumn = ColumnDef<Employee> & { hidden?: boolean }

export const membersColumns = (props: EmployeeColumnProps): EmployeeColumn[] => {
  const { onDelete } = props

  return [
    {
      hidden: true,
      accessorKey: 'id',
      header: ({ column }) => h(DataTableColumnHeader, { column, title: 'ID' }),
      cell: ({ row }) => {
        return h('div', { class: 'flex space-x-2' }, [
          h('span', { class: 'max-w-[500px] truncate' }, row.getValue('id'))
        ])
      },
    },
    {
      accessorKey: 'username',
      header: ({ column }) => h(DataTableColumnHeader, { column, title: 'Username' }),
      cell: ({ row }) => {
        return h('div', { class: 'flex space-x-2' }, [
          h('span', { class: 'max-w-[500px] truncate' }, row.getValue('username'))
        ])
      }
    },
    {
      accessorKey: 'password',
      hidden: true
    },
    {
      accessorKey: 'email',
      header: ({ column }) => h(DataTableColumnHeader, { column, title: 'Email' }),
      cell: ({ row }) => {
        return h('div', { class: 'flex space-x-2' }, [
          h('span', { class: 'max-w-[500px] truncate' }, row.getValue('email'))
        ])
      }
    },
    {
      accessorKey: 'role',
      header: ({ column }) => h(DataTableColumnHeader, { column, title: 'Permissions' }),
      cell: ({ row }) => {
        return h('div', { class: 'flex space-x-2' }, [
          h('div', { class: 'flex space-x-2 bg-primary px-2 py-1 text-white rounded-full text-xs' }, ucfirst(row.getValue('role')))
        ])
      }
    },
    {
      id: 'actions',
      cell: ({ row }) =>
        h(DataTableRowActions, {
          schema: employeeSchema(),
          row,
          onDelete,
        })
    }
  ]
}
