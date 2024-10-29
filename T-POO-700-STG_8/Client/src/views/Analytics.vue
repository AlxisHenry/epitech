<script setup lang="ts">
import Card from '@/components/ui/card/Card.vue'
import CardContent from '@/components/ui/card/CardContent.vue'
import { AreaChart } from '@/components/ui/chart-area'
import { useStatsStore } from '@/stores'
import { onMounted, ref, watch } from 'vue'
import type { StatsPeriod } from '@/stores/stats.store'
import { Switch } from '@/components/ui/switch'

const statsStore = useStatsStore()
const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

onMounted(async () => {
  await statsStore.daily()
})

const handlePeriodChange = async (range: StatsPeriod) => {
  statsStore.setPeriod(range)
}

const fakeMode = ref(true)
const realData: any = ref([])
const fakeData: any = ref([])

const aggregateMonthlyData = (dailyStats: Record<string, string>) => {
  const monthlyData: Record<string, number> = {}

  // Parcours de chaque entrée pour regrouper les données par mois
  for (const [date, time] of Object.entries(dailyStats)) {
    console.log(date, time)
    // year is the first 4 characters of the date, month is the next 2 characters, and day is the last 2 characters
    const year = parseInt(date.slice(0, 4), 10)
    const month = parseInt(date.slice(4, 6), 10)
    console.log(year, month)
    const monthKey = `${year}-${month?.toString().padStart(2, '0')}` // Format: "2024-09"
    console.log(monthKey)

    // Convertir "8h 0m" en minutes
    const [hours, minutes] = time.split(' ').map((val) => parseInt(val, 10) || 0)
    const totalMinutes = hours * 60 + minutes

    // Ajouter le total des minutes au mois correspondant
    if (monthlyData[monthKey]) {
      monthlyData[monthKey] += totalMinutes
    } else {
      monthlyData[monthKey] = totalMinutes
    }
  }

  // Transformation des minutes en heures et structure finale pour le graphique
  const result = []
  for (const [monthKey, totalMinutes] of Object.entries(monthlyData)) {
    const [year, month] = monthKey.split('-').map(Number)
    result.push({
      name: `${months[month - 1]} ${year}`, // Exemple: "Sep 2024"
      'Worked hours': (totalMinutes / 60).toFixed(2) // Convertir les minutes en heures
    })
  }

  console.log(result)

  return result
}

watch(
  () => statsStore.dailyStats,
  () => {
    realData.value = aggregateMonthlyData(statsStore.dailyStats)
    fakeData.value = aggregateMonthlyData({
      2024_09_01: '12h 0m',
      2024_09_02: '8h 0m',
      2024_10_29: '8h 0m',
      2024_10_31: '4h 0m',
      2024_11_01: '8h 0m',
      2024_11_02: '8h 0m',
      2024_11_03: '8h 0m',
      2024_11_04: '8h 0m',
      2024_11_05: '8h 0m'
    })
  }
)
</script>

<template>
  <div class="grid grid-cols-1 gap-4">
    <div class="flex items-center gap-2 my-4">
      <Switch v-model="fakeMode" />
      <span class="text-sm">Fake data</span>
    </div>
    <Card class="w-full mx-auto">
      <CardContent class="w-full">
        <AreaChart v-if="!fakeData" :data="realData" index="name" :categories="['Worked hours']" />
        <AreaChart v-if="fakeData" :data="fakeData" index="name" :categories="['Worked hours']" />
      </CardContent>
    </Card>
  </div>
</template>
