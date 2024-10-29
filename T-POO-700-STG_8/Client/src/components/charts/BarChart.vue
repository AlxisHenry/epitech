<script setup lang="ts">
import { BarChart } from '@/components/ui/chart-bar'

const props = defineProps<{
  data: any
}>()


const monthlyData = [
  { name: 'Janvier', managerHours: 160, employeeHours: 150 },
  { name: 'Février', managerHours: 140, employeeHours: 130 },
  { name: 'Mars', managerHours: 170, employeeHours: 160 },
  { name: 'Avril', managerHours: 180, employeeHours: 175 },
  { name: 'Mai', managerHours: 160, employeeHours: 165 },
  { name: 'Juin', managerHours: 150, employeeHours: 140 },
  { name: 'Juillet', managerHours: 160, employeeHours: 155 },
  { name: 'Août', managerHours: 170, employeeHours: 160 },
  { name: 'Septembre', managerHours: 175, employeeHours: 165 },
  { name: 'Octobre', managerHours: 180, employeeHours: 175 },
  { name: 'Novembre', managerHours: 160, employeeHours: 155 },
  { name: 'Décembre', managerHours: 150, employeeHours: 145 },
];


</script>

<template>
    <div class="mx-auto overflow-x-auto">
        <div class="min-w-[1200px]">
        <BarChart
            title="Working times/Clocks"
            :data="monthlyData"
            index="name"
            :categories="['managerHours', 'employeeHours']"
            :y-formatter="(tick) => {
                return typeof tick === 'number'
                    ? (tick % 1 === 0 ? tick.toString() : `${tick.toFixed(2)}%`)
                    : ''
            }"
        />
        </div>
    </div>
</template>
