<script setup lang="ts">
import { DataTable } from '@/components/data-table'
import { toast } from '@/components/ui/toast'
import { useAuthStore, useTeamsStore, useUsersStore } from '@/stores'
import { membersColumns } from '@/components/data-table/columns/members.js'
import { useRoute } from 'vue-router'
import { onMounted } from 'vue'
import { Alert, AlertDescription, AlertTitle } from '@/components/ui/alert'
import { Users2 } from 'lucide-vue-next'
import { Separator } from '@/components/ui/separator'
import { Button } from '@/components/ui/button'
import {
  Command,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList
} from '@/components/ui/command'
import {
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage
} from '@/components/ui/form'
import { Popover, PopoverContent, PopoverTrigger } from '@/components/ui/popover'
import { cn } from '@/lib/utils'
import { toTypedSchema } from '@vee-validate/zod'
import { Check, ChevronsUpDown } from 'lucide-vue-next'
import { useForm } from 'vee-validate'
import { h } from 'vue'
import * as z from 'zod'

const teamsStore = useTeamsStore()
const authStore = useAuthStore()
const usersStore = useUsersStore()

const { params } = useRoute()

onMounted(() => {
  teamsStore.getTeam(params.id as string)
  usersStore.all()
})


const deleteMember = async (row: any) => {
  if (await teamsStore.unsubscribe(row.original.id)) {
    toast({
      title: 'Member removed',
      description: 'The member has been removed from the team.',
      duration: 3500
    })
  } else {
    toast({
      variant: 'destructive',
      title: 'Member removal failed',
      description: 'An error occurred while removing the member from the team.',
      duration: 3500
    })
  }
}

const formSchema = toTypedSchema(
  z.object({
    user: z.string().nonempty('Please select a member.')
  })
)

const { handleSubmit, setFieldValue, values } = useForm({
  validationSchema: formSchema
})

const onSubmit = handleSubmit(async (values) => {
  if (await teamsStore.subscribe(values.user)) {
    toast({
      title: 'Member added',
      description: 'The member has been added to the team.',
      duration: 3500
    })
  } else {
    toast({
      variant: 'destructive',
      title: 'Member addition failed',
      description: 'An error occurred while adding the member to the team.',
      duration: 3500
    })
  }
})
</script>

<template>
  <div
    class="grid grid-cols-1 lg:grid-cols-1 gap-4 mb-4"
    v-if="teamsStore.currentTeam.manager?.id === authStore.user?.id"
  >
    <Alert>
      <Users2 class="h-4 w-4" />
      <AlertTitle>This team belongs to {{ teamsStore.currentTeam.manager?.email }}</AlertTitle>
      <AlertDescription> You can add members to this team by selecting a member. </AlertDescription>
    </Alert>
  </div>
  <form class="space-y-6 flex flex-col sm:flex-row gap-4" @submit="onSubmit">
    <FormField name="member">
      <FormItem class="flex flex-col">
        <FormLabel> Members </FormLabel>
        <Popover>
          <PopoverTrigger as-child>
            <FormControl>
              <Button
                variant="outline"
                role="combobox"
                :class="
                  cn('w-full sm:w-[200px] justify-between', !values.user&& 'text-muted-foreground')
                "
              >
                {{
                  values.user
                    ? usersStore.users.find((user) => user.id === values.user)?.email
                    : 'Select a member...'
                }}
                <ChevronsUpDown class="ml-2 h-4 w-4 shrink-0 opacity-50" />
              </Button>
            </FormControl>
          </PopoverTrigger>
          <PopoverContent class="w-full sm:w-[200px] p-0">
            <Command>
              <CommandInput placeholder="Search employee..." />
              <CommandEmpty>Nothing found.</CommandEmpty>
              <CommandList>
                <CommandGroup>
                  <CommandItem
                    v-for="user in usersStore.users"
                    :key="user.id"
                    :value="user.email"
                    @select="
                      () => {
                        setFieldValue('user', user.id)
                      }
                    "
                  >
                    <Check
                      :class="
                        cn(
                          'mr-2 h-4 w-4',
                          user.id === values.user ? 'opacity-100' : 'opacity-0'
                        )
                      "
                    />
                    {{ user.email }}
                  </CommandItem>
                </CommandGroup>
              </CommandList>
            </Command>
          </PopoverContent>
        </Popover>
        <FormMessage />
      </FormItem>
    </FormField>
    <Button type="submit" class="sm:w-fit w-full mt-2"> Add Member </Button>
  </form>
  <Separator class="my-4" />
  <DataTable
    toolbar
    :key="teamsStore.currentTeam?.users?.data?.length"
    :data="teamsStore.currentTeam?.users?.data ?? []"
    :columns="membersColumns({ onDelete: deleteMember })"
    :search="{
      label: 'Search members...',
      field: 'username'
    }"
  />
</template>
