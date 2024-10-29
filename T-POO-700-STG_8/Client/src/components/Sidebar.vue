<script setup lang="ts">
import {
  Calendar,
  Home,
  UsersRound,
  LineChart,
  PanelLeft,
  Settings,
  Network
} from 'lucide-vue-next'
import { Sheet, SheetContent, SheetTrigger } from '@/components/ui/sheet'
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger
} from '@/components/ui/dropdown-menu'
import { Tooltip, TooltipContent, TooltipProvider, TooltipTrigger } from '@/components/ui/tooltip'
import { useColorMode, useNetwork, useOnline } from '@vueuse/core'
import { Icon } from '@iconify/vue'
import { Button } from '@/components/ui/button'
import { Avatar, AvatarImage, AvatarFallback } from '@/components/ui/avatar'
import { onMounted, ref } from 'vue'
import { Check, ChevronsUpDown } from 'lucide-vue-next'
import {
  Breadcrumb,
  BreadcrumbItem,
  BreadcrumbLink,
  BreadcrumbList,
  BreadcrumbPage,
  BreadcrumbSeparator
} from '@/components/ui/breadcrumb'
import { cn } from '@/lib/utils'
import {
  Command,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList
} from '@/components/ui/command'
import { Popover, PopoverContent, PopoverTrigger } from '@/components/ui/popover'
import { RouterLink } from 'vue-router'
import { useRoute } from 'vue-router'
import { useAuthStore, useCurrentUserStore, useUsersStore } from '@/stores'
import { toast } from './ui/toast'

const route = useRoute()
const authStore = useAuthStore()
const usersStore = useUsersStore()
const currentUserStore = useCurrentUserStore()
const { isOnline } = useNetwork()
const mode = useColorMode()

const open = ref(false)
const currentUser = ref(currentUserStore.get())

interface NavItem {
  icon: any
  label: string
  path: string
  show?: boolean
}

const navItems: NavItem[] = [
  { icon: Home, label: 'Dashboard', path: '/dashboard' },
  { icon: Calendar, label: 'Agenda', path: '/agenda' },
  { icon: LineChart, label: 'Analytics', path: '/analytics' },
  { icon: UsersRound, label: 'Teams', path: '/teams', show: authStore?.hasAnyRole() },
  { icon: Network, label: 'Employees', path: '/employees', show: authStore?.hasAnyRole() },
  { icon: Settings, label: 'Settings', path: '/settings' }
]

onMounted(() => {
  usersStore.all()
})
</script>

<template>
  <aside
    class="fixed inset-y-0 left-0 z-10 sm:z-50 hidden w-14 flex-col border-r bg-background sm:flex"
  >
    <nav class="flex flex-col items-center gap-4 px-2 sm:py-5">
      <div v-for="item in navItems" :key="item.label" v-show="item.show ?? true">
        <TooltipProvider>
          <Tooltip>
            <TooltipTrigger as-child>
              <RouterLink :to="item.path">
                <Button
                  variant="ghost"
                  size="icon"
                  :class="{
                    'rounded-lg text-muted-foreground transition-colors hover:text-foreground': true,
                    'bg-gray-100 text-foreground dark:bg-gray-800 dark:text-foreground':
                      route.fullPath === item.path
                  }"
                >
                  <component :is="item.icon" class="h-5 w-5" />
                  <span class="sr-only">{{ item.label }}</span>
                </Button>
              </RouterLink>
            </TooltipTrigger>
            <TooltipContent side="right"> {{ item.label }} </TooltipContent>
          </Tooltip>
        </TooltipProvider>
      </div>
    </nav>
  </aside>
  <div
    class="fixed w-full z-[200] sm:z-30 bottom-0 sm:relative sm:flex sm:flex-col sm:gap-4 sm:py-4 sm:pl-14"
  >
    <header
      class="sticky top-0 z-30 flex h-14 items-center gap-4 border-b bg-background px-4 sm:static sm:h-auto sm:border-0 sm:bg-transparent sm:px-6"
    >
      <Sheet>
        <SheetTrigger as-child>
          <Button size="icon" variant="outline" class="sm:hidden">
            <PanelLeft class="h-5 w-5" />
            <span class="sr-only">Toggle Menu</span>
          </Button>
        </SheetTrigger>
        <SheetContent side="left" class="sm:max-w-xs flex items-center sm:block">
          <nav class="grid gap-12 sm:gap-6 text-3xl sm:text-lg font-medium">
            <RouterLink
              :to="item.path"
              class="flex items-center gap-4 px-2.5 text-muted-foreground hover:text-foreground"
              :class="{ 'text-foreground ': route.fullPath === '/' }"
              v-for="item in navItems"
              :key="item.label"
              v-show="item.show ?? true"
            >
              <component :is="item.icon" class="h-8 w-8 sm:h-5 sm:w-5" />
              {{ item.label }}
            </RouterLink>
          </nav>
        </SheetContent>
      </Sheet>
      <Breadcrumb class="hidden md:flex">
        <BreadcrumbList>
          <BreadcrumbItem v-if="route.fullPath === '/'">
            <BreadcrumbPage>Dashboard</BreadcrumbPage>
          </BreadcrumbItem>
          <BreadcrumbItem
            v-else
            v-for="(segment, index) in route.fullPath.split('/').filter(Boolean)"
            :key="index"
          >
            <BreadcrumbLink
              as-child
              v-if="index < route.fullPath.split('/').filter(Boolean).length - 1"
            >
              <RouterLink
                :to="`/${route.fullPath
                  .split('/')
                  .slice(1, index + 2)
                  .join('/')}`"
              >
                {{ segment.charAt(0).toUpperCase() + segment.slice(1) }}
              </RouterLink>
            </BreadcrumbLink>
            <BreadcrumbPage v-else>{{
              segment.charAt(0).toUpperCase() + segment.slice(1)
            }}</BreadcrumbPage>
            <BreadcrumbSeparator
              v-if="index < route.fullPath.split('/').filter(Boolean).length - 1"
            />
          </BreadcrumbItem>
        </BreadcrumbList>
      </Breadcrumb>
      <div class="relative flex items-center gap-4 ml-auto">
        <div class="hidden sm:block" v-show="authStore?.isLoggedIn && authStore?.hasAnyRole()">
          <Popover v-model:open="open">
            <PopoverTrigger as-child>
              <Button
                variant="outline"
                role="combobox"
                :aria-expanded="open"
                class="w-[200px] justify-between"
              >
                {{
                  currentUser
                    ? usersStore.users?.find((user) => user.email === currentUser)?.email
                    : 'Choose employee...'
                }}
                <ChevronsUpDown class="ml-2 h-4 w-4 shrink-0 opacity-50" />
              </Button>
            </PopoverTrigger>
            <PopoverContent class="w-[200px] p-0">
              <Command>
                <CommandInput class="h-9" placeholder="Search employee..." />
                <CommandEmpty> No employees found </CommandEmpty>
                <CommandList>
                  <CommandGroup>
                    <CommandItem
                      v-for="employee in usersStore.users"
                      :key="employee.id"
                      :value="employee.email"
                      @select="
                        (ev) => {
                          currentUser = ev.detail.value?.toString() ?? ''
                          currentUserStore.set(currentUser)
                          open = false
                        }
                      "
                    >
                      {{ employee.email }}
                      <Check
                        :class="
                          cn(
                            'ml-auto h-4 w-4',
                            currentUser === employee.email ? 'opacity-100' : 'opacity-0'
                          )
                        "
                      />
                    </CommandItem>
                  </CommandGroup>
                </CommandList>
              </Command>
            </PopoverContent>
          </Popover>
        </div>
        <DropdownMenu>
          <DropdownMenuTrigger as-child>
            <Button variant="secondary" size="icon" class="rounded-full h-[2.5rem] w-[2.5rem]">
              <Avatar>
                <AvatarImage
                  src="https://avatar.iran.liara.run/public"
                  alt="@radix-vue"
                  v-if="isOnline"
                />
                <AvatarFallback>CN</AvatarFallback>
              </Avatar>
              <span class="sr-only">Toggle user menu</span>
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="end">
            <DropdownMenuLabel>My Account</DropdownMenuLabel>
            <DropdownMenuSeparator />
            <DropdownMenuItem>
              <RouterLink to="/settings">Settings</RouterLink>
            </DropdownMenuItem>
            <DropdownMenuSeparator />
            <DropdownMenuItem
              @click="
                () => {
                  authStore.logout()
                  toast({
                    title: 'Success',
                    description: 'Logged out successfully.',
                    duration: 3500
                  })
                }
              "
              >Logout</DropdownMenuItem
            >
          </DropdownMenuContent>
        </DropdownMenu>
        <DropdownMenu>
          <DropdownMenuTrigger as-child>
            <Button variant="outline" class="rounded-full p-0 h-[2.5rem] w-[2.5rem]">
              <Icon
                icon="radix-icons:moon"
                class="h-[1.2rem] w-[1.2rem] rotate-0 scale-100 transition-all dark:-rotate-90 dark:scale-0"
              />
              <Icon
                icon="radix-icons:sun"
                class="absolute h-[1.2rem] w-[1.2rem] rotate-90 scale-0 transition-all dark:rotate-0 dark:scale-100"
              />
              <span class="sr-only">Toggle theme</span>
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="end">
            <DropdownMenuItem @click="mode = 'light'"> Light </DropdownMenuItem>
            <DropdownMenuItem @click="mode = 'dark'"> Dark </DropdownMenuItem>
            <DropdownMenuItem @click="mode = 'auto'"> System </DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      </div>
    </header>
  </div>
</template>
