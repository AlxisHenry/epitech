<script setup lang="ts">
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
  AlertDialogTrigger
} from '@/components/ui/alert-dialog'
import { AutoForm } from '@/components/ui/auto-form'
import { Button } from '@/components/ui/button'
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuSeparator,
  DropdownMenuTrigger
} from '@/components/ui/dropdown-menu'
import {
  Sheet,
  SheetClose,
  SheetContent,
  SheetDescription,
  SheetHeader,
  SheetTitle,
  SheetTrigger
} from '@/components/ui/sheet'
import { vAutoAnimate } from '@formkit/auto-animate/vue'
import type { Row } from '@tanstack/vue-table'
import { Edit2Icon, EllipsisVertical, Trash2Icon } from 'lucide-vue-next'

import { ref } from 'vue'
import * as z from 'zod'
import type { CustomDataTableColumnAction } from './columns/index.js'
import { router } from '@/router'

interface DataTableRowActionsProps<TData> {
  row: Row<TData>
  onUpdate?: (row: Row<TData>, data: any) => void | undefined
  onDelete?: (row: Row<TData>) => void | undefined
  schema: z.ZodObject<any>
  actions?: CustomDataTableColumnAction[]
}

const props = defineProps<DataTableRowActionsProps<any>>()

const { row, onUpdate, onDelete, schema, actions } = props

const formData = ref({ ...row.original })
</script>

<template>
  <DropdownMenu v-if="onUpdate || actions || onDelete">
    <DropdownMenuTrigger as-child>
      <Button variant="ghost" class="flex h-8 w-8 p-0 data-[state=open]:bg-muted">
        <EllipsisVertical class="h-4 w-4" />
        <span class="sr-only">Open menu</span>
      </Button>
    </DropdownMenuTrigger>
    <DropdownMenuContent align="end" class="w-[160px]">
      <Sheet v-if="onUpdate">
        <SheetTrigger as-child>
          <Button variant="ghost" class="w-full flex justify-between font-normal p-3">
            Edit
            <Edit2Icon class="h-4 w-4" />
          </Button>
        </SheetTrigger>
        <SheetContent>
          <SheetHeader>
            <SheetTitle>Edit record</SheetTitle>
            <SheetDescription>
              Fill in the form below to edit the record details.
            </SheetDescription>
          </SheetHeader>
          <div>
            <AutoForm
              class="grid gap-4 py-4"
              v-auto-animate
              :schema="schema"
              :initial-values="formData"
              @submit="(data) => onUpdate && onUpdate(row, data)"
              :field-config="{
                password: {
                  inputProps: {
                    type: 'password',
                    placeholder: '••••••••'
                  }
                },
                start_time: {
                  label: 'Start time',
                  inputProps: {
                    type: 'datetime-local'
                  }
                },
                end_time: {
                  label: 'End time',
                  inputProps: {
                    type: 'datetime-local'
                  }
                },
                break_duration: {
                  label: 'Break duration',
                  inputProps: {
                    type: 'number',
                    min: 0
                  }
                }
              }"
            >
              <SheetClose as-child>
                <Button type="submit" class="flex-1"> Save </Button>
              </SheetClose>
            </AutoForm>
          </div>
        </SheetContent>
      </Sheet>
      <Button
        variant="ghost"
        v-for="action in actions"
        :key="action.label"
        class="w-full flex justify-between p-3 font-normal"
        @click="
          () => {
            if (action.before) action.before(row)
            router.push(action.to(row))
          }
        "
      >
        {{ action.label }}
        <component :is="action.icon" class="h-4 w-4" />
      </Button>
      <DropdownMenuSeparator v-if="onUpdate || actions" />
      <AlertDialog v-if="onDelete">
        <AlertDialogTrigger as-child>
          <Button
            variant="ghost"
            class="w-full flex justify-between p-3 font-normal text-destructive"
          >
            Delete
            <Trash2Icon class="h-4 w-4" />
          </Button>
        </AlertDialogTrigger>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Are you absolutely sure?</AlertDialogTitle>
            <AlertDialogDescription>
              This action cannot be undone. This will permanently delete the record and remove the
              data from our servers.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Cancel</AlertDialogCancel>
            <AlertDialogAction
              class="bg-destructive hover:opacity-90 hover:bg-destructive-dark"
              @click="onDelete(props.row)"
            >
              Continue
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </DropdownMenuContent>
  </DropdownMenu>
</template>
