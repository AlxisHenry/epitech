<script setup lang="ts">
import { FormControl, FormField, FormItem, FormMessage, FormLabel } from '@/components/ui/form'
import { toTypedSchema } from '@vee-validate/zod'
import * as z from 'zod'
import { useForm } from 'vee-validate'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { useAuthStore } from '@/stores'
import { vAutoAnimate } from '@formkit/auto-animate/vue'
import { RouterLink } from 'vue-router'
import { router } from '@/router'
import { toast } from '@/components/ui/toast'
import { makeToastFromResponseErrors } from '@/lib/utils'

const authStore = useAuthStore()

const loginSchema = toTypedSchema(
  z.object({
    username: z.string().min(3),
    email: z.string().email().min(1),
    password: z.string().min(8)
  })
)

const form = useForm({
  validationSchema: loginSchema
})

interface RegisterPayload {
  username: string
  email: string
  password: string
}

const onSubmit = form.handleSubmit(async (values: RegisterPayload) => {
  const { ok, errors } = await authStore.register(values)

  if (ok) {
    router.push('/login')
    toast({
      title: 'Success',
      description: 'Account created successfully.',
      duration: 3500
    })
    return
  }

  form.resetForm()

  toast({
    variant: 'destructive',
    description: errors ? makeToastFromResponseErrors(errors) : 'An error occurred',
    duration: 3500
  })
})
</script>

<template>
  <div class="flex items-center justify-center py-12">
    <div class="mx-auto grid w-[350px] gap-6">
      <div class="grid gap-2 text-center">
        <h1 class="text-3xl font-bold">Register</h1>
        <p class="text-balance text-muted-foreground">
          Enter your details below to create an account
        </p>
      </div>
      <form class="w-full space-y-6" @submit="onSubmit">
        <FormField name="email" v-slot="{ componentField }">
          <FormItem class="flex flex-col gap-1 w-full" v-auto-animate>
            <FormLabel>Email</FormLabel>
            <FormControl class="w-full">
              <Input type="email" placeholder="hello@world.fr" v-bind="componentField" />
            </FormControl>
            <FormMessage />
          </FormItem>
        </FormField>
        <FormField name="username" v-slot="{ componentField }">
          <FormItem class="flex flex-col gap-1 w-full" v-auto-animate>
            <FormLabel>Username</FormLabel>
            <FormControl class="w-full">
              <Input v-bind="componentField" />
            </FormControl>
            <FormMessage />
          </FormItem>
        </FormField>
        <FormField name="password" v-slot="{ componentField }">
          <FormItem class="flex flex-col gap-1 w-full" v-auto-animate>
            <FormLabel>Password</FormLabel>
            <FormControl class="w-full">
              <Input type="password" v-bind="componentField" />
            </FormControl>
            <FormMessage />
          </FormItem>
        </FormField>
        <Button type="submit" class="w-full"> Register </Button>
      </form>
      <div class="mt-4 text-center text-sm">
        Already have an account?
        <RouterLink to="/login" class="underline"> Sign-in </RouterLink>
      </div>
    </div>
  </div>
</template>
