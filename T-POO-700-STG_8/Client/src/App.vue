<script setup lang="ts">
import { Sidebar, Loader } from '@/components'
import { RouterView } from 'vue-router'
import { useAuthStore } from '@/stores'
import { Toaster } from '@/components/ui/toast'
import { listen } from '@/lib/proxy'
import moment from 'moment'

moment().startOf('isoWeek').day(0+7);

const authStore = useAuthStore()

listen()
</script>

<template>
  <main class="w-full h-screen mx-auto" v-if="authStore.isLoading && !authStore.isLoggedIn">
    <div class="flex h-full">
      <Loader class="mx-auto my-auto" />
    </div>
  </main>

  <main
    class="w-full lg:grid lg:min-h-[600px] h-screen"
    v-if="!authStore.isLoggedIn && !authStore.isLoading"
  >
    <RouterView />
  </main>

  <div
    class="flex min-h-screen w-full flex-col bg-muted/40"
    v-if="authStore.isLoggedIn && !authStore.isLoading"
  >
    <Sidebar />

    <main class="flex flex-col sm:mt-0 mt-6 sm:gap-4 sm:py-4 ml-6 sm:ml-20 mr-6 mb-6">
      <RouterView />
    </main>
  </div>
  <Toaster />
</template>
