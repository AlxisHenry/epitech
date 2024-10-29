<script setup lang="ts">
import { workingTimesColumns } from '@/components/data-table/columns/working_times.js'
import DataTable from '@/components/data-table/DataTable.vue'
import { workingTimeSchema } from '@/components/data-table/schemas/working_times.js'
import { toast } from '@/components/ui/toast/use-toast.js'
import { useAuthStore, useUsersStore, useWorkingTimeStore } from '@/stores'
import { onMounted } from 'vue'

const authStore = useAuthStore()
const usersStore = useUsersStore()
const workingTimeStore = useWorkingTimeStore()

const onUpdate = authStore.hasAnyRole()
  ? async (row: any, data: any): Promise<void> => {
      if (await workingTimeStore.update(row.original.id, data)) {
        toast({
          title: 'Working time updated',
          description: 'The working time has been updated successfully',
          duration: 3500
        })
      } else {
        toast({
          variant: 'destructive',
          title: 'Working time update failed',
          description: 'The working time could not be updated',
          duration: 3500
        })
      }
    }
  : undefined

const onDelete = authStore.hasAnyRole()
  ? async (row: any) => {
      if (await workingTimeStore.delete(row.original.id)) {
        toast({
          title: 'Working time deleted',
          description: 'The working time has been deleted successfully',
          duration: 3500
        })
      } else {
        toast({
          variant: 'destructive',
          title: 'Working time deletion failed',
          description: 'The working time could not be deleted',
          duration: 3500
        })
      }
    }
  : undefined

const onCreate = authStore.hasAnyRole()
  ? async (row: any): Promise<void> => {
      if (await workingTimeStore.create(row)) {
        toast({
          title: 'Working time created',
          description: 'The working time has been created successfully',
          duration: 3500
        })
      } else {
        toast({
          variant: 'destructive',
          title: 'Working time creation failed',
          description: 'The working time could not be created',
          duration: 3500
        })
      }
    }
  : undefined

onMounted(async () => {
  await workingTimeStore.all()
})
</script>

<template>
  <DataTable
    toolbar
    :key="usersStore.users?.length"
    :schema="workingTimeSchema()"
    :data="workingTimeStore.workingTimes ?? []"
    :columns="
      workingTimesColumns({
        onUpdate,
        onDelete
      })
    "
    :search="{
      label: 'Search working time...',
      field: 'start_time'
    }"
    :on-create="onCreate"
  />
</template>
