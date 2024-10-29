<script lang="ts" setup>
import { ref } from 'vue'

import { useColorMode } from '@vueuse/core'
const mode = useColorMode()
mode.value = 'dark'

import {
  NavigationMenu,
  NavigationMenuContent,
  NavigationMenuItem,
  NavigationMenuLink,
  NavigationMenuList,
  NavigationMenuTrigger
} from '@/components/ui/navigation-menu'
import {
  Sheet,
  SheetContent,
  SheetFooter,
  SheetHeader,
  SheetTitle,
  SheetTrigger
} from '@/components/ui/sheet'

import { Button } from '@/components/ui/button'
import { Separator } from '@/components/ui/separator'

import { ChevronsDown, Menu, Clock } from 'lucide-vue-next'
import GithubIcon from '@/assets/icons/GithubIcon.vue'
import ToggleTheme from './ToggleTheme.vue'

interface RouteProps {
  href: string
  label: string
}

interface FeatureProps {
  title: string
  description: string
}

const routeList: RouteProps[] = [
  {
    href: '#team',
    label: 'Team'
  },
  {
    href: '#contact',
    label: 'Contact'
  },
  {
    href: '#faq',
    label: 'FAQ'
  }
]

const featureList: FeatureProps[] = [
  {
    title: 'Garanteed Quality',
    description:
      'We provide the best quality for your website, we make sure that your website is the best it can be.'
  },
  {
    title: 'Ethical use',
    description: 'We make sure that your website is ethical and safe for all users.'
  },
  {
    title: 'User Focused',
    description: 'We make sure that your website is user focused and user friendly.'
  }
]

const isOpen = ref<boolean>(false)
</script>

<template>
  <header
    :class="{
      'shadow-light': mode === 'light',
      'shadow-dark': mode === 'dark',
      'w-[90%] md:w-[70%] lg:w-[75%] lg:max-w-screen-xl top-5 mx-auto sticky border z-40 rounded-2xl flex justify-between items-center p-2 bg-card shadow-md': true
    }"
  >
    <a href="/" class="font-bold text-lg flex items-center">
      <Clock
        class="bg-gradient-to-tr from-primary via-primary/70 to-primary rounded-lg w-8 h-8 mr-2 border text-white"
      />
      TimeManager</a
    >
    <!-- Mobile -->
    <div class="block items-center lg:hidden">
      <Sheet v-model:open="isOpen">
        <SheetTrigger as-child>
          <Menu @click="isOpen = true" class="cursor-pointer" />
        </SheetTrigger>

        <SheetContent
          side="left"
          class="flex flex-col justify-between rounded-tr-2xl rounded-br-2xl bg-card"
        >
          <div>
            <SheetHeader class="mb-4 ml-4">
              <SheetTitle class="flex items-center">
                <a href="/" class="flex items-center">
                  <ChevronsDown
                    class="bg-gradient-to-tr from-primary/70 via-primary to-primary/70 rounded-lg size-9 mr-2 border text-white"
                  />
                  ShadcnVue
                </a>
              </SheetTitle>
            </SheetHeader>

            <div class="flex flex-col gap-2">
              <Button
                v-for="{ href, label } in routeList"
                :key="label"
                as-child
                variant="ghost"
                class="justify-start text-base"
              >
                <a @click="isOpen = false" :href="href">
                  {{ label }}
                </a>
              </Button>
            </div>
          </div>

          <SheetFooter class="flex-col sm:flex-col justify-start items-start">
            <Separator class="mb-2" />

            <ToggleTheme />
          </SheetFooter>
        </SheetContent>
      </Sheet>
    </div>

    <!-- Desktop -->
    <NavigationMenu class="hidden lg:block">
      <NavigationMenuList>
        <NavigationMenuItem>
          <NavigationMenuTrigger class="bg-card text-base"> Features </NavigationMenuTrigger>
          <NavigationMenuContent>
            <div class="grid w-[600px] grid-cols-2 gap-5 p-4">
              <img
                src="https://www.radix-vue.com/logo.svg"
                alt="Beach"
                class="h-full w-full rounded-md object-cover"
              />
              <ul class="flex flex-col gap-2">
                <li
                  v-for="{ title, description } in featureList"
                  :key="title"
                  class="rounded-md p-3 text-sm hover:bg-muted"
                >
                  <p class="mb-1 font-semibold leading-none text-foreground">
                    {{ title }}
                  </p>
                  <p class="line-clamp-2 text-muted-foreground">
                    {{ description }}
                  </p>
                </li>
              </ul>
            </div>
          </NavigationMenuContent>
        </NavigationMenuItem>

        <NavigationMenuItem>
          <NavigationMenuLink asChild>
            <Button
              v-for="{ href, label } in routeList"
              :key="label"
              as-child
              variant="ghost"
              class="justify-start text-base"
            >
              <a :href="href">
                {{ label }}
              </a>
            </Button>
          </NavigationMenuLink>
        </NavigationMenuItem>
      </NavigationMenuList>
    </NavigationMenu>

    <div class="hidden lg:flex">
      <ToggleTheme />

      <Button as-child size="sm" variant="ghost" aria-label="View on GitHub">
        <a
          aria-label="View on GitHub"
          href="http://github.com/EpitechMscProPromo2026/T-POO-700-STG_8/"
          target="_blank"
        >
          <GithubIcon class="size-5" />
        </a>
      </Button>
    </div>
  </header>
</template>

<style scoped>
.shadow-light {
  box-shadow: inset 0 0 5px rgba(0, 0, 0, 0.085);
}

.shadow-dark {
  box-shadow: inset 0 0 5px rgba(255, 255, 255, 0.141);
}
</style>
