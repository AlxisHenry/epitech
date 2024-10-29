import axios from 'axios'
import { defineStore } from 'pinia'
import type { CreatedWorkingTime, UpdatedWorkingTime } from '@/types'
import { useAuthStore, useCurrentUserStore } from '@/stores'
import { fetch, HttpMethod } from '@/lib/proxy'
import moment from 'moment'

export const useWorkingTimeStore = defineStore('workingTime', {
  state: () => ({
    workingTimes: [] as any[]
  }),
  actions: {
    async all() {
      const currentUserStore = useCurrentUserStore()
      try {
        const response = await fetch({
          endpoint: `/working_times/${currentUserStore.user?.id}`,
          method: HttpMethod.GET,
          payload: {
            start_time: moment().subtract(10, 'year').format('YYYY-MM-DD'),
            end_time: moment().add(10, 'year').format('YYYY-MM-DD')
          }
        })
        const { data } = await response.json()
        this.workingTimes = data
      } catch (error) {
        console.error('Error fetching working times:', error)
      }
    },
    async getWorkingTimesByUser(userID: string, startTime: string, endTime: string) {
      try {
        const response = await fetch({
          endpoint: `/working_times/${userID}/${startTime}/${endTime}`,
          method: HttpMethod.GET
        })
        const { data } = await response.json()
        this.workingTimes = data
      } catch (error) {
        console.error('Error fetching working times:', error)
      }
    },
    async getWorkingTimesOfWeek() {
      const currentUserStore = useCurrentUserStore()
      try {
        const response = await fetch({
          endpoint: `/working_times/${currentUserStore.user?.id}/${moment().startOf('isoWeek').format('YYYY-MM-DD')}/${moment().endOf('isoWeek').format('YYYY-MM-DD')}`,
          method: HttpMethod.GET
        })
        const { data } = await response.json()
        this.workingTimes = data
      } catch (error) {
        console.error('Error fetching working times:', error)
      }
    },
    async create(createdWorkingTime: CreatedWorkingTime): Promise<boolean> {
      try {
        const currentUserStore = useCurrentUserStore()
        const response = await fetch({
          endpoint: `/working_times`,
          method: HttpMethod.POST,
          payload: {
            working_time: {
              user_id: currentUserStore.user?.id,
              ...createdWorkingTime
            }
          }
        })

        if (response.ok) {
          this.getWorkingTimesOfWeek()
          return true
        }

        return false
      } catch (error) {
        console.error('Error creating working time:', error)
        return false
      }
    },
    async delete(id: string): Promise<boolean> {
      try {
        const response = await fetch({
          endpoint: `/working_times/${id}`,
          method: HttpMethod.DELETE
        })

        if (response.ok) {
          this.getWorkingTimesOfWeek()
          return true
        }

        return false
      } catch (error) {
        console.error('Error creating working time:', error)
        return false
      }
    },
    async update(id: string, updatedWorkingTime: UpdatedWorkingTime) {
      try {
        const response = await fetch({
          endpoint: `/working_times/${id}`,
          method: HttpMethod.PUT,
          payload: {
            working_time: updatedWorkingTime
          }
        })

        if (response.ok) {
          this.getWorkingTimesOfWeek()
          return true
        }

        return false
      } catch (error) {
        console.error('Error updating working time:', error)
        return false
      }
    }
  }
})
