<script setup lang="ts">
import { AreaChart } from '@/components/ui/chart-area'

const data = [
  {
    name: 'Jan',
    value: 100
  },
  {
    name: 'Feb',
    value: 200
  },
  {
    name: 'Mar',
    value: 150
  },
  {
    name: 'Apr',
    value: 300
  }
]
</script>

<template>
  <div class="mx-auto grid w-full gap-2">
    <AreaChart
      :data="data"
      :colors="['blue', 'pink', 'orange', 'red']"
      :categories="['name', 'value']"
      index="name"
    />
  </div>
</template>
