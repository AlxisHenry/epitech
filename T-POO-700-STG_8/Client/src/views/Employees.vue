<script setup lang="ts">
import { DataTable } from '@/components/data-table'
import { employeesColumns } from '@/components/data-table/columns'
import { employeeSchema } from '@/components/data-table/schemas'
import { toast } from '@/components/ui/toast'
import { useAuthStore, useUsersStore } from '@/stores'
import { onMounted } from 'vue'

const authStore = useAuthStore()
const usersStore = useUsersStore()

onMounted(() => {
  usersStore.all()
})

const onCreate = authStore.isAdmin
  ? async (employee: any): Promise<void> => {
    if (await usersStore.create(employee)) {
      toast({
        title: 'Employee created',
        description: 'The employee has been created successfully',
        duration: 3500
      })
    } else {
      toast({
        variant: 'destructive',
        title: 'Employee creation failed',
        description: 'The employee could not be created',
        duration: 3500
      })
    }
  }
  : undefined

const onUpdate = authStore.isAdmin
  ? async (employee: any, data: any): Promise<void> => {
    if (await usersStore.update(employee.original.id, data)) {
      toast({
        title: 'Employee updated',
        description: 'The employee has been updated successfully',
        duration: 3500
      })
    } else {
      toast({
        variant: 'destructive',
        title: 'Employee update failed',
        description: 'The employee could not be updated',
        duration: 3500
      })
    }
  }
  : undefined

const onDelete = authStore.isAdmin
  ? async (row: any) => {
    if (await usersStore.delete(row.original.id)) {
      toast({
        title: 'Employee deleted',
        description: 'The employee has been deleted successfully',
        duration: 3500
      })
    } else {
      toast({
        variant: 'destructive',
        title: 'Employee deletion failed',
        description: 'The employee could not be deleted',
        duration: 3500
      })
    }
  }
  : undefined

const formatManagers = (managers: any[]) => {
  return managers.map((manager) => manager.email)
}
</script>

<template>
  <DataTable
    toolbar
    :key="usersStore.users?.length"
    :schema="employeeSchema(formatManagers(usersStore.managers))"
    :data="usersStore.users || []"
    :columns="employeesColumns({
      onUpdate,
      onDelete,
      managers: formatManagers(usersStore.managers)
    })
      "
    :search="{
      label: 'Search employees...',
      field: 'email'
    }"
    :on-create="onCreate"
  />
</template>
