import type { ColumnDef } from '@tanstack/vue-table'
import { h } from 'vue'

import { DataTableColumnHeader, DataTableRowActions } from '@/components/data-table'
import { employeeSchema, type Employee } from '@/components/data-table/schemas'
import { ucfirst } from '@/lib/utils'

interface EmployeeColumnProps {
  onDelete: undefined | ((row: any) => void )
  onUpdate: ((row: any, data: any) => void) | undefined
  managers: any[]
}

type EmployeeColumn = ColumnDef<Employee> & { hidden?: boolean }

export const employeesColumns = (props: EmployeeColumnProps): EmployeeColumn[] => {
  const { onDelete, onUpdate, managers } = props

  console.log(managers)

  return [
    {
      accessorKey: 'id',
      header: ({ column }) => h(DataTableColumnHeader, { column, title: 'ID' }),
      cell: ({ row }) => {
        return h('div', { class: 'flex space-x-2' }, [
          h('span', { class: 'max-w-[500px] truncate' }, row.getValue('id'))
        ])
      },
      hidden: true
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
      accessorKey: 'manager',
      header: ({ column }) => h(DataTableColumnHeader, { column, title: 'Manager' }),
      cell: ({ row }) => {
        return h('div', { class: 'flex space-x-2' }, [
          h('span', { class: 'max-w-[500px] truncate' }, row.getValue('manager') || 'N/A')
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
          schema: employeeSchema(managers),
          row,
          onUpdate,
          onDelete
        })
    }
  ]
}
