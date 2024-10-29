<script setup lang="ts">
import { DataTableViewOptions } from '@/components/data-table'
import { AutoForm } from '@/components/ui/auto-form'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
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
import type { ColumnDef, Table } from '@tanstack/vue-table'
import { X as Cross2Icon, Plus } from 'lucide-vue-next'
import { computed } from 'vue'
import * as z from 'zod'

interface DataTableToolbarProps<TData> {
  columns: ColumnDef<TData, any>[]
  table: Table<TData>
  search?: {
    label?: string
    field?: string
  }
  onCreate?: (employee: any) => void
  schema?: z.ZodObject<any>
}

const props = defineProps<DataTableToolbarProps<any>>()

const { table, search, onCreate, schema } = props

const isFiltered = computed(() => table.getState().columnFilters.length > 0)

const searchField = computed(() => search?.field ?? 'name')
</script>

<template>
  <div class="flex items-center justify-between">
    <div class="flex flex-1 items-center justify-between space-x-2">
      <div class="flex items-center space-x-2">
        <Input
          :placeholder="search?.label ?? 'Search...'"
          :model-value="(table.getColumn(searchField)?.getFilterValue() as string) ?? ''"
          class="h-8 p-2 w-[150px] lg:w-[250px]"
          @input="table.getColumn(searchField)?.setFilterValue($event.target.value)"
        />

        <Button
          v-if="isFiltered"
          variant="ghost"
          class="h-8 px-2 lg:px-3"
          @click="table.resetColumnFilters()"
        >
          Reset
          <Cross2Icon class="ml-2 h-4 w-4" />
        </Button>
      </div>
      <div class="flex items-center space-x-2">
        <Sheet v-if="onCreate && schema">
          <SheetTrigger as-child>
            <Button variant="outline" size="sm" class="ml-auto flex h-8">
              <Plus class="mr-2 h-4 w-4" />
              Create
            </Button>
          </SheetTrigger>
          <SheetContent>
            <SheetHeader>
              <SheetTitle>Create record</SheetTitle>
              <SheetDescription> Fill out the form below to create a new record. </SheetDescription>
            </SheetHeader>
            <div>
              <AutoForm
                class="grid gap-4 py-4"
                v-auto-animate
                :schema="schema"
                @submit="onCreate"
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
                  <Button type="submit" class="flex-1"> Create </Button>
                </SheetClose>
              </AutoForm>
            </div>
          </SheetContent>
        </Sheet>
        <DataTableViewOptions :table="table" />
      </div>
    </div>
  </div>
</template>
