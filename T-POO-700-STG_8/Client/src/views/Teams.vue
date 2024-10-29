<script setup lang="ts">
import { DataTable } from '@/components/data-table'
import { teamsColumns } from '@/components/data-table/columns'
import { teamSchema } from '@/components/data-table/schemas'
import { toast } from '@/components/ui/toast'
import { useTeamsStore } from '@/stores'
import { onMounted } from 'vue'

const teamsStore = useTeamsStore()

onMounted(() => {
  teamsStore.all()
})

const onDelete = async (row: any) => {
  if (await teamsStore.delete(row.original.id)) {
    toast({
      title: 'Team deleted',
      description: 'The team has been deleted successfully',
      duration: 3500
    })
  } else {
    toast({
      variant: 'destructive',
      title: 'Team deletion failed',
      description: 'The team could not be deleted',
      duration: 3500
    })
  }
}

const onCreate = async (team: any) => {
  if (await teamsStore.create(team)) {
    toast({
      title: 'Team created',
      description: 'The team has been created successfully',
      duration: 3500
    })
  } else {
    toast({
      variant: 'destructive',
      title: 'Team creation failed',
      description: 'The team could not be created',
      duration: 3500
    })
  }
}
</script>

<template>
  <DataTable
    toolbar
    :key="teamsStore.teams?.length"
    :schema="teamSchema"
    :data="teamsStore.teams || []"
    :columns="teamsColumns({ onDelete })"
    :search="{
      label: 'Search teams...',
      field: 'name'
    }"
    :on-create="onCreate"
  />
</template>
