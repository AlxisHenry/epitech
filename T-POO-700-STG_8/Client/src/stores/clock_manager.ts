import { defineStore } from 'pinia'
import axios from 'axios'
import type { CreatedClockType, CreatedClock } from '@/types'
import moment from 'moment'
import { set } from 'zod'
import { useCurrentUserStore } from '@/stores'
import { fetch, HttpMethod } from '@/lib/proxy'

export const useClockManagerStore = defineStore('clockManager', {
  state: () => ({
    clocks: [] as any[],
    weekStats: {} as any,
    dailyStats: [] as any[]
  }),
  actions: {
    async getAllClocks() {
      const currentUserStore = useCurrentUserStore()
      try {
        const response = await fetch({
          endpoint: `/clocks`,
          method: HttpMethod.GET
        })
        const { data } = await response.json()
        this.clocks = data?.reverse()
      } catch (error) {
        console.error('Error fetching all clocks:', error)
      }
    },
    async getClocksByUser() {
      const currentUserStore = useCurrentUserStore()
      try {
        const response = await fetch({
          endpoint: `/clocks/${currentUserStore.user?.id}`,
          method: HttpMethod.GET
        })
        const { data } = await response.json()
        this.clocks = data?.reverse()
      } catch (error) {
        console.error('Error fetching clocks by user:', error)
      }
    },
    async clock() {
      const currentUserStore = useCurrentUserStore()
      try {
        const response = await fetch({
          endpoint: `/clocks/`,
          method: HttpMethod.POST,
          payload: { user_id: currentUserStore.user?.id }
        })
        this.getClocksByUser()
      } catch (error) {
        console.error('Error creating a clock state:', error)
      }
    },
    async getWeekstats() {
      const currentUserStore = useCurrentUserStore()
      try {
        console.log(currentUserStore.user?.id)
        const response = await fetch({
          endpoint: `/clocks/week_stats/${currentUserStore.user?.id}`,
          method: HttpMethod.GET
        })
        const data = await response.json()
        this.weekStats = data
      } catch (error) {
        console.error('Error fetching week stats:', error)
      }
    },
    async getDailyStats() {
      const currentUserStore = useCurrentUserStore()
      try {
        const response = await fetch({
          endpoint: `/clocks/stats/daily/${currentUserStore.user?.id}`,
          method: HttpMethod.GET,
          payload: {
            start_time: moment().startOf('isoWeek').format('YYYY-MM-DD'),
            end_time: moment().endOf('isoWeek').format('YYYY-MM-DD')
          }
        })
        const data = await response.json()
        console.log('Daily stats from the week : ', data)
      } catch (error) {
        console.error('Error fetching week stats:', error)
      }
    }
  }
})
