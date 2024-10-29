import { fetch, HttpMethod } from '@/lib/proxy'
import { useAuthStore } from '@/stores'
import { Role, type UserType } from '@/types'
import { defineStore } from 'pinia'

const getManagerId = (managers: UserType[], manager: string) => {
  return managers.find((m: UserType) => m.email === manager)?.id
}

const formatPayload = (payload: UserType, managers: UserType[]) => {
  const managerId = getManagerId(managers, payload.manager as string)
  const _payload = { ...payload, manager_id: managerId }
  delete _payload.manager
  return _payload
}

export const useUsersStore = defineStore('users', {
  state: () => ({
    managers: [] as UserType[],
    users: [] as UserType[]
  }),

  actions: {
    async create(payload: UserType): Promise<boolean> {
      try {
        const response = await fetch({
          endpoint: '/users',
          method: HttpMethod.POST,
          payload: {
            user: formatPayload(payload, this.managers)
          }
        })

        if (response.ok) {
          this.all()
          return true
        }

        return false
      } catch (error) {
        console.error('Error creating user:', error)
        return false
      }
    },

    async update(id: string, payload: UserType): Promise<boolean> {
      console.log(formatPayload(payload, this.managers))
      try {
        const response = await fetch({
          endpoint: `/users/${id}`,
          method: HttpMethod.PUT,
          payload: {
            user: formatPayload(payload, this.managers)
          }
        })

        if (response.ok) {
          this.all()
          return true
        }

        return false
      } catch (error) {
        console.error('Error updating user:', error)
        return false
      }
    },

    async delete(id: string): Promise<boolean> {
      try {
        const response = await fetch({
          endpoint: `/users/${id}`,
          method: HttpMethod.DELETE
        })

        if (response.ok) {
          this.all()
          return true
        }

        return false
      } catch (error) {
        console.error('Error deleting user:', error)
        return false
      }
    },

    async all(): Promise<void> {
      try {
        const response = await fetch({
          endpoint: '/users'
        })
        const { data } = await response.json()
        this.users = data
        this.managers = data.filter((user: UserType) => user.role === Role.Manager)
      } catch (error) {
        console.error('Error fetching users:', error)
      }
    }
  }
})
