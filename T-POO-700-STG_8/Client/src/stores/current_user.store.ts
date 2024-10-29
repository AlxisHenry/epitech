import { fetch, HttpMethod } from '@/lib/proxy'
import { defineStore } from 'pinia'
import { useAuthStore } from './auth.store'
import type { UserType } from '@/types'
import { useUsersStore } from './users.store.js'
import { router } from '@/router'

export const useCurrentUserStore = defineStore('current_user', {
  state: () => ({
    user: null as UserType | null
  }),

  actions: {
    set(user: string) {
      const usersStore = useUsersStore()
      this.user = usersStore.users?.find((u) => u.email === user) || null
    },
    get(): string {
      return this.user?.email || ''
    }
  }
})
