import { useAuthStore } from '@/stores'
import { createRouter, createWebHistory } from 'vue-router'

export const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'landing',
      component: () => import('@/views/Landing.vue')
    },
    {
      path: '/login',
      name: 'login',
      component: () => import('@/views/auth/Login.vue')
    },
    {
      path: '/register',
      name: 'register',
      component: () => import('@/views/auth/Register.vue')
    },
    {
      path: '/dashboard',
      name: 'dashboard',
      component: () => import('@/views/Dashboard.vue'),
      meta: { requiresAuth: true }
    },
    {
      path: '/analytics',
      name: 'analytics',
      component: () => import('@/views/Analytics.vue'),
      meta: { requiresAuth: true }
    },
    {
      path: '/settings',
      name: 'settings',
      component: () => import('@/views/Settings.vue'),
      meta: { requiresAuth: true }
    },
    {
      path: '/employees',
      name: 'employees',
      component: () => import('@/views/Employees.vue'),
      meta: { requiresAuth: true }
    },
    {
      path: '/teams',
      name: 'teams',
      component: () => import('@/views/Teams.vue'),
      meta: { requiresAuth: true }
    },
    {
      path: '/teams/:id/members',
      name: 'members',
      component: () => import('../views/TeamMembers.vue'),
      meta: { requiresAuth: true }
    },
    {
      path: '/agenda',
      name: 'agenda',
      component: () => import('@/views/Agenda.vue'),
      meta: { requiresAuth: true }
    }
  ]
})

router.beforeEach(async (to, from, next) => {
  const authStore = useAuthStore()

  if (authStore.token) {
    await authStore.me()
  }

  if (to.meta.requiresAuth && !authStore.isLoggedIn) {
    next('/login')
  } else if (!to.meta.requiresAuth && authStore.isLoggedIn) {
    next('/dashboard')
  } else {
    next()
  }
})
