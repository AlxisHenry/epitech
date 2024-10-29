import { defineStore } from 'pinia'
import { Role, type UserType } from '@/types'
import { router } from '@/router'
import { fetch, HttpMethod } from '@/lib/proxy'
import { useCurrentUserStore } from './current_user.store.js'

interface LoginPayload {
  email: string
  password: string
}

interface RegisterPayload {
  username: string
  email: string
  password: string
}

interface ResponseError {
  [key: string]: string[]
}

const extractResponseErrors = async (response: Response): Promise<ResponseError | null> => {
  if (response.status === 422) {
    const data = await response.json()
    return data.errors
  }

  return null
}

const persistAuth = (user: UserType | null, token: string | null): void => {
  if (user) {
    localStorage.setItem('token', token || '')
    localStorage.setItem(
      'user',
      JSON.stringify({
        ...user,
        role: null
      })
    )
  }
}

export const useAuthStore = defineStore('auth', {
  state: () => ({
    token: localStorage.getItem('token') || null,
    user: localStorage.getItem('user') ? JSON.parse(localStorage.getItem('user') || '') : null,
    isLogged: localStorage.getItem('token') ? true : false,
    isLoading: false
  }),

  getters: {
    isLoggedIn: (state): boolean => state.isLogged,
    hasRole:
      (state) =>
      (role: Role): boolean => {
        if (!state.user) return false
        return state.user.role === role
      },
    hasAnyRole: (state) => (): boolean => {
      const roles = [Role.Admin, Role.Manager]
      if (!state.user) return false
      return roles.includes(state.user.role) || false
    },
    isAdmin: (state) => state.user?.role === Role.Admin,
    isManager: (state) => state.user?.role === Role.Manager
  },

  actions: {
    async login(payload: LoginPayload): Promise<boolean> {
      try {
        this.isLoading = true
        const response = await fetch({
          endpoint: '/auth',
          method: HttpMethod.POST,
          payload,
          withToken: false
        })

        if (response.ok) {
          const data = await response.json()
          this.token = data.token
          this.user = data.user
          this.isLogged = true
          persistAuth(this.user, this.token)
          this.isLoading = false
          router.push('/dashboard')
          return true
        }

        this.isLoading = false
        return false
      } catch (error) {
        console.error(error)
        this.isLoading = false
        return false
      }
    },
    async logout() {
      this.token = null
      this.user = null
      this.isLogged = false
      localStorage.removeItem('token')
      localStorage.removeItem('user')
      router.replace('/login')
    },
    async register(payload: RegisterPayload): Promise<any> {
      try {
        this.isLoading = true
        const response = await fetch({
          endpoint: '/registration',
          method: HttpMethod.POST,
          payload,
          withToken: false
        })

        const errors = await extractResponseErrors(response)

        this.isLoading = false
        return {
          ok: response.ok,
          errors
        }
      } catch (error) {
        this.isLoading = false
        console.error(error)
        return {
          ok: false,
          errors: null
        }
      }
    },
    async me() {
      try {
        this.isLoading = true
        const response = await fetch({
          endpoint: '/auth/me',
          method: HttpMethod.GET,
          payload: null,
          withToken: true,
          persist: true
        })

        if (response.status === 504) {
          console.log('Gateway timeout, request persisted')
          this.isLoading = false
          return
        }

        if (response.ok) {
          const data = await response.json()
          this.user = data.user
          this.token = data.token
          persistAuth(this.user, this.token)
          this.isLoading = false

          const currentUserStore = useCurrentUserStore()
          if (currentUserStore.user === null) {
            currentUserStore.user = this.user
          }
          return
        }

        this.logout()
      } catch (error) {
        console.error(error)
        this.logout()
      }
    },
    async deleteAccount(): Promise<boolean> {
      const authStore = useAuthStore()
      try {
        const response = await fetch({
          endpoint: `/users/${authStore.user?.id}`,
          method: HttpMethod.DELETE
        })

        if (response.ok) {
          console.log('User deleted')
          this.logout()
          return true
        }

        return false
      } catch (error) {
        console.error('Error deleting user:', error)
        return false
      }
    },
    async updatePassword(password: string): Promise<boolean> {
      const authStore = useAuthStore()
      try {
        const response = await fetch({
          endpoint: `/users/${authStore.user?.id}`,
          method: HttpMethod.PUT,
          payload: {
            user: {
              password
            }
          }
        })

        if (response.ok) {
          console.log('Password updated')
          return true
        }

        return false
      } catch (error) {
        console.error('Error updating password:', error)
        return false
      }
    },
    async updateUsername(username: string): Promise<boolean> {
      const authStore = useAuthStore()
      try {
        const response = await fetch({
          endpoint: `/users/${authStore.user?.id}`,
          method: HttpMethod.PUT,
          payload: {
            user: {
              username
            }
          }
        })

        if (response.ok) {
          console.log('Username updated')
          this.me()
          return true
        }

        return false
      } catch (error) {
        console.error('Error updating username:', error)
        return false
      }
    }
  }
})
