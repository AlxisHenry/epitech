import { fetch, HttpMethod } from '@/lib/proxy'
import { defineStore } from 'pinia'
import { useCurrentUserStore } from '@/stores'
import type { UserType } from '@/types'

type Team = {
  id: string
  name: string
  users: {
    data: UserType[]
  }
  manager: UserType
}

export const useTeamsStore = defineStore('teams', {
  state: () => ({
    teams: [] as Team[],
    subscribedTeams: [] as Team[],
    currentTeam: {} as Team & { stats: any }
  }),

  actions: {
    async create(payload: any): Promise<boolean> {
      try {
        const currentUserStore = useCurrentUserStore()

        const response = await fetch({
          endpoint: '/teams',
          method: HttpMethod.POST,
          payload: {
            team: {
              manager_id: currentUserStore.user?.id,
              ...payload
            }
          }
        })

        if (response.ok) {
          this.all()
          return true
        }

        return false
      } catch (error) {
        console.error('Error creating team:', error)
        return false
      }
    },

    async delete(id: string): Promise<boolean> {
      try {
        const response = await fetch({
          endpoint: `/teams/${id}`,
          method: HttpMethod.DELETE
        })

        if (response.ok) {
          this.all()
          return true
        }

        return false
      } catch (error) {
        console.error('Error deleting team:', error)
        return false
      }
    },

    async all(): Promise<void> {
      try {
        const response = await fetch({
          endpoint: '/teams'
        })
        const { data } = await response.json()
        this.teams = data
      } catch (error) {
        console.error('Error fetching teams:', error)
      }
    },

    async subscribe(user: string): Promise<boolean> {
      try {
        const response = await fetch({
          endpoint: `/teams/${this.currentTeam.id}/users`,
          method: HttpMethod.POST,
          payload: {
            user_id: user
          }
        })

        if (response.ok) {
          this.all()
          this.getTeam(this.currentTeam.id)
          return true
        }

        return false
      } catch (error) {
        console.error('Error subscribing to team:', error)
        return false
      }
    },

    async unsubscribe(user_id: string): Promise<boolean> {
      try {
        const response = await fetch({
          endpoint: `/teams/${this.currentTeam.id}/users/${user_id}`,
          method: HttpMethod.DELETE
        })

        if (response.ok) {
          this.all()
          this.getTeam(this.currentTeam.id)
          return true
        }

        return false
      } catch (error) {
        console.error('Error unsubscribing from team:', error)
        return false
      }
    },

    async getTeam(id: string): Promise<void> {
      try {
        const response = await fetch({
          endpoint: `/teams/${id}`
        })
        // const statsResponse = await fetch({
        //   endpoint: `/teams/stats/${id}`,
        //   payload: {
        //     start_time: new Date("2021-01-01").toISOString(),
        //     end_time: new Date().toISOString()
        //   }
        // })
        const data = await response.json()
        this.currentTeam = data
      } catch (error) {
        console.error('Error fetching team:', error)
      }
    },

    async subscribed(): Promise<boolean> {
      try {
        const currentUserStore = useCurrentUserStore()
        console.log(currentUserStore.user)
        const response = await fetch({
          endpoint: `/teams/user/${currentUserStore?.user?.id}`,
          persist: true
        })

        if (response.ok) {
          const { data } = await response.json()
          this.subscribedTeams = data
          return true
        }

        return false
      } catch (error) {
        console.error('Error fetching subscribed teams:', error)
        return false
      }
    }
  }
})
