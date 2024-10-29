import { ref, computed, type Ref } from 'vue'
import { defineStore } from 'pinia'
import { useCurrentUserStore } from '@/stores'
import { fetch, HttpMethod } from '@/lib/proxy'
import moment from 'moment'

export type StatsPeriod = {
  start_time: string
  end_time: string
}

interface StatsStore {
  currentWeekStats: Ref<WeekStats | null>
  currentWeek: () => Promise<void>
  daily: () => Promise<void>
  period: StatsPeriod
  setPeriod: (period: StatsPeriod) => void
  dailyStats: any
}

export type WeekStats = {
  last_stats_week: number
  percentage: number
  this_week_stats: number
}

export type DailyStats = {
  [key: string]: number
}

export const useStatsStore = defineStore('stats', () => {
  const currentUserStore = useCurrentUserStore()

  const currentUserId = computed(() => currentUserStore.user?.id)
  const period: { start_time: string; end_time: string } = {
    start_time: moment().startOf('isoWeek').format('YYYY-MM-DD'),
    end_time: moment().endOf('isoWeek').format('YYYY-MM-DD')
  }

  const setPeriod = (period: StatsPeriod) => {
    period.start_time = moment(period.start_time).startOf('isoWeek').format('YYYY-MM-DD')
    period.end_time = moment(period.end_time).startOf('isoWeek').format('YYYY-MM-DD')
  }

  const currentWeekStats = ref<WeekStats | null>(null)
  const dailyStats = ref<DailyStats | null>(null)

  async function currentWeek() {
    try {
      const response = await fetch({
        endpoint: `/clocks/week_stats/${currentUserId.value}`,
        method: HttpMethod.GET
      })
      const data: WeekStats = await response.json()
      currentWeekStats.value = data
    } catch (error) {
      console.error('Error fetching week stats:', error)
    }
  }

  async function daily() {
    try {
      const response = await fetch({
        endpoint: `/clocks/stats/daily/${currentUserStore.user?.id}`,
        method: HttpMethod.GET,
        payload: period
      })
      const { data } = await response.json()
      dailyStats.value = data
      console.log('Daily stats from the week : ', data)
    } catch (error) {
      console.error('Error fetching week stats:', error)
    }
  }

  return { currentWeek, currentWeekStats, setPeriod, period, daily, dailyStats } as StatsStore
})
