import type { ColumnDef } from '@tanstack/vue-table'
import { h } from 'vue'

import { DataTableColumnHeader, DataTableRowActions } from '@/components/data-table'
import { teamSchema, type Team } from '@/components/data-table/schemas'
import type { CustomDataTableColumnAction } from '@/components/data-table/columns'
import { NetworkIcon } from 'lucide-vue-next'
import { useTeamsStore } from '@/stores'

interface ColumnProps {
  onDelete: (row: any) => void
}

type TeamColumn = ColumnDef<Team> & { hidden?: boolean; actions?: CustomDataTableColumnAction[] }

export const teamsColumns = (props: ColumnProps): TeamColumn[] => {
  const { onDelete } = props

  return [
    {
      accessorKey: 'name',
      header: ({ column }) => h(DataTableColumnHeader, { column, title: 'Name' }),
      cell: ({ row }) => {
        return h('div', { class: 'flex space-x-2' }, [
          h('span', { class: 'max-w-[500px] truncate' }, row.getValue('name'))
        ])
      }
    },
    {
      id: 'actions',
      cell: ({ row }) =>
        h(DataTableRowActions, {
          schema: teamSchema,
          row,
          onDelete,
          actions: [
            {
              label: 'Members',
              to: (row: any) => ({ name: 'members', params: { id: row.original.id } }),
              icon: NetworkIcon,
              before: (row: any) => {
                const teamsStore = useTeamsStore()
                teamsStore.getTeam(row.original.id)
                return true;
              }
            }
          ]
        })
    }
  ]
}
