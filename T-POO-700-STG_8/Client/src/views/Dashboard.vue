<script setup lang="ts">
import {
  ClockArrowUp,
  Loader2,
  ClockArrowDown,
  NetworkIcon,
  CircleAlert,
  Clock
} from 'lucide-vue-next'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { ref, onMounted, watch, computed } from 'vue'
import { Table, TableBody, TableCell, TableRow } from '@/components/ui/table'
import Separator from '@/components/ui/separator/Separator.vue'
import moment from 'moment'
import { toast } from '@/components/ui/toast'
import {
  useAuthStore,
  useStatsStore,
  useClockManagerStore,
  useWorkingTimeStore,
  useTeamsStore
} from '@/stores'
import { Skeleton } from '@/components/ui/skeleton'
import Badge from '@/components/ui/badge/Badge.vue'
import { Alert, AlertDescription, AlertTitle } from '@/components/ui/alert'

const authStore = useAuthStore()
const clockManagerStore = useClockManagerStore()
const teamsStore = useTeamsStore()
const workingTimeStore = useWorkingTimeStore()
const statsStore = useStatsStore()

const clockedButton = ref(false)
const loading = ref(false)
const loadingLastClock = ref(false)
const hasWorkingTime = ref(true)

const lastClock = computed(() => {
  const clocks = clockManagerStore.clocks || []

  return clocks?.length > 0 ? clocks?.reverse()[clocks?.length - 1] : null
})

const updateClockedInStatus = () => {
  if (lastClock.value) {
    clockedButton.value = lastClock.value.status === 'clock_in'
  }
}

onMounted(async () => {
  loadingLastClock.value = true
  await statsStore.currentWeek()
  await teamsStore.subscribed()

  await clockManagerStore.getClocksByUser()
  updateClockedInStatus()
  await workingTimeStore.getWorkingTimesOfWeek()
  loadingLastClock.value = false
})

watch(
  () => workingTimeStore.workingTimes,
  () => {
    console.log('workingTimeStore.workingTimes', workingTimeStore.workingTimes)
  }
)

const handleClockedIn = async () => {
  loading.value = true
  await clockManagerStore.clock()
  clockedButton.value = !clockedButton.value
  loading.value = false
  toast({
    title: `You have successfully ${clockedButton.value ? 'clocked in' : 'clocked out'}`,
    description: `You are now ${clockedButton.value ? 'in' : 'out'} of a work session`
  })
}
</script>

<template>
  <Alert v-if="clockedButton" variant="destructive" class="mb-4">
    <CircleAlert class="h-4 w-4" />
    <AlertTitle> You are currently in a work session </AlertTitle>
    <AlertDescription>
      You are currently in a work session since
      {{ moment.duration(moment().diff(moment(lastClock?.time))).humanize(true) }}. Don't forget to
      clock out when you finish your work.
    </AlertDescription>
  </Alert>
  <div class="grid grid-cols-1 lg:grid-cols-2 gap-4 md:gap-6">
    <Card class="relative">
      <CardHeader>
        <CardTitle class="text-sm font-medium"> Hello, {{ authStore.user?.username }} ! </CardTitle>
        <CardDescription>
          <div class="text-xs text-muted-foreground" v-show="!authStore.hasAnyRole()">
            {{
              hasWorkingTime
                ? clockedButton
                  ? 'You are currently in a work session!'
                  : 'What are you waiting for? Start working!'
                : null
            }}
          </div>
          <div class="text-xs text-muted-foreground" v-show="authStore.hasAnyRole()">
            How are you big boss? 🚀 Have a good
            {{ moment().format('dddd') }}!
          </div>
        </CardDescription>
      </CardHeader>
      <CardContent class="text-muted-foreground">
        <div v-show="!authStore.hasAnyRole()">
          {{
            !hasWorkingTime
              ? "I'm sorry but you don't have any working time today. If you think this is an error, please contact your manager."
              : null
          }}
          <div class="block sm:absolute -mt-4 right-4 top-4" v-if="hasWorkingTime">
            <Skeleton v-if="loadingLastClock" class="w-[123px] my-4 p-5 mx-auto">
              <Button class="max-w-xs my-4 p-5 mx-auto" disabled>
                <div class="flex items-center"><ClockArrowUp class="w-4 h-4 mr-2" /> Clock in</div>
              </Button>
            </Skeleton>
            <Button
              v-else-if="!clockedButton"
              @click="handleClockedIn"
              :disabled="loading"
              class="max-w-xs my-4 p-5 mx-auto"
            >
              <div v-if="loading" class="flex items-center">
                <Loader2 class="w-4 h-4 mr-2 animate-spin" /> Clocking in...
              </div>
              <div v-else class="flex items-center">
                <ClockArrowUp class="w-4 h-4 mr-2" /> Clock in
              </div>
            </Button>
            <Button
              v-else
              @click="handleClockedIn"
              :disabled="loading"
              class="max-w-xs my-4 p-5 mx-auto"
            >
              <div v-if="loading" class="flex items-center">
                <Loader2 class="w-4 h-4 mr-2 animate-spin" /> Clocking out...
              </div>
              <div v-else class="flex items-center">
                <ClockArrowUp class="w-4 h-4 mr-2" /> Clock out
              </div>
            </Button>
          </div>
        </div>
      </CardContent>
    </Card>
    <div class="grid gap-4 grid-cols-1 md:gap-6 sm:grid-cols-2">
      <Card>
        <CardHeader class="flex flex-row items-center justify-between space-y-0 pb-2">
          <CardTitle class="text-sm font-medium"> Hours worked this week </CardTitle>
          <Clock class="h-4 w-4 text-muted-foreground" />
        </CardHeader>
        <CardContent>
          <div class="text-2xl font-bold">
            {{ (statsStore.currentWeekStats as any)?.value?.this_week_stats || 0 }}
          </div>
          <p class="text-xs text-muted-foreground">
            +{{ (statsStore.currentWeekStats as any)?.value?.this_week_stats || 0 }}% from last week
          </p>
        </CardContent>
      </Card>
      <Card>
        <CardHeader class="flex flex-row items-center justify-between space-y-0 pb-2">
          <CardTitle class="text-sm font-medium"> Your teams </CardTitle>
          <NetworkIcon class="h-4 w-4 text-muted-foreground" />
        </CardHeader>
        <CardContent>
          <div class="flex flex-row items-center gap-2 flex-wrap">
            <span
              class="text-xs text-muted-foreground"
              v-if="teamsStore.subscribedTeams.length === 0"
            >
              You are not part of any team yet.
            </span>
            <Badge variant="outline" v-for="team in teamsStore.subscribedTeams" :key="team.id">
              {{ team.name }}
            </Badge>
          </div>
        </CardContent>
      </Card>
    </div>
  </div>

  <div class="mt-2 grid grid-cols-1 sm:grid-cols-2 gap-4 md:gap-6">
    <Card>
      <CardHeader>
        <CardTitle class="text-sm font-medium"> Recent activities </CardTitle>
      </CardHeader>
      <CardContent>
        <Separator class="-mt-2 mb-4" />
        <ul class="space-y-4">
          <li
            class="flex flex-row items-start"
            v-for="clock in clockManagerStore.clocks?.slice(0, 7)"
            :key="clock.id"
          >
            <div class="-mt-1 w-8 h-8 rounded-full flex items-center justify-center">
              <ClockArrowDown class="w-4 h-4 text-primary" v-show="clock.status === 'clock_in'" />
              <ClockArrowUp class="w-4 h-4 text-primary" v-show="clock.status === 'clock_out'" />
            </div>
            <div class="flex flex-col">
              <p class="text-sm font-medium text-primary">
                {{ clock.status === 'clock_in' ? 'Clock in' : 'Clock out' }}
              </p>
              <p class="text-xs text-muted-foreground">{{ moment(clock.time).format('LLLL') }}</p>
            </div>
          </li>
        </ul>
      </CardContent>
    </Card>
    <Card>
      <CardHeader>
        <CardTitle class="text-sm font-medium"> Your next working times </CardTitle>
      </CardHeader>
      <CardContent>
        <Separator class="-mt-2 mb-4" />
        <Table>
          <TableBody>
            <TableRow v-for="time in workingTimeStore.workingTimes?.slice(0, 7)" :key="time.id">
              <TableCell>
                {{ moment(time.start_time).format('dddd') }}
              </TableCell>
              <TableCell class="text-muted-foreground">
                {{
                  moment(time.start_time).utc(false).format('HH:mm') +
                  ' - ' +
                  moment(time.end_time).utc(false).format('HH:mm')
                }}
              </TableCell>
              <TableCell class="text-muted-foreground hidden md:block">
                {{
                  Math.floor(
                    (moment(time.end_time).diff(moment(time.start_time), 'minutes') -
                      time.break_duration) /
                      60
                  ) +
                  'h' +
                  ((moment(time.end_time).diff(moment(time.start_time), 'minutes') -
                    time.break_duration) %
                    60 >
                  0
                    ? (moment(time.end_time).diff(moment(time.start_time), 'minutes') -
                        time.break_duration) %
                      60
                    : '')
                }}
              </TableCell>
            </TableRow>
          </TableBody>
        </Table>
      </CardContent>
    </Card>
  </div>
</template>
