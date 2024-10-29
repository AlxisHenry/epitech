<script setup lang="ts">
import { Button } from '@/components/ui/button'
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle
} from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { ref } from 'vue'
import { useAuthStore } from '@/stores'
import { toast } from '@/components/ui/toast'

const authStore = useAuthStore()
const newPassword = ref('')
const newUsername = ref(authStore.user?.username || '')

const updateUsername = async () => {
    if (await authStore.updateUsername(newUsername.value)) {
      toast({
        variant: 'default',
        description: 'Username updated successfully',
        duration: 5000
      })
    } else {
      toast({
        variant: 'destructive',
        description: 'Failed to update username',
        duration: 5000
      })
    }
}

const updatePassword = async () => {
  if (await authStore.updatePassword(newPassword.value)) {
    toast({
      variant: 'default',
      description: 'Password updated successfully',
      duration: 5000
    })
  } else {
    toast({
      variant: 'destructive',
      description: 'Failed to update password',
      duration: 5000
    })
  }

  newPassword.value = ''
}

const deleteAccount = async () => {
  if (await authStore.deleteAccount()) {
    toast({
      variant: 'default',
      description: 'Account deleted successfully',
      duration: 5000
    })
  } else {
    toast({
      variant: 'destructive',
      description: 'Failed to delete account',
      duration: 5000
    })
  }
}
</script>

<template>
  <div class="mx-auto grid w-full items-start gap-6">
    <div class="grid gap-6">
      <Card>
        <CardHeader>
          <CardTitle>Profile Information</CardTitle>
          <CardDescription class="max-w-lg"> Update your account's profile information. </CardDescription>
        </CardHeader>
        <CardContent class="max-w-lg">
          <form class="flex flex-col gap-4">
            <Input v-model="newUsername" type="username" placeholder="Username" :default-value="authStore.user?.username" />
          </form>
        </CardContent>
        <CardFooter class="border-t px-6 py-4">
          <Button @click="updateUsername" class="min-w-[100px]">Save</Button>
        </CardFooter>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle>Update Password</CardTitle>
          <CardDescription class="max-w-lg"> Ensure your account is using a long, random password to stay secure. </CardDescription>
        </CardHeader>
        <CardContent class="max-w-lg">
          <form class="flex flex-col gap-4">
            <Input v-model="newPassword" type="password" placeholder="New Password" />
          </form>
        </CardContent>
        <CardFooter class="border-t px-6 py-4">
          <Button @click="updatePassword" class="min-w-[100px]">Save</Button>
        </CardFooter>
      </Card>
      <Card>
        <CardHeader>
          <CardTitle>Delete your account</CardTitle>
          <CardDescription class="max-w-lg">
            Once you delete your account, all of its resources and data will be permanently deleted. Before deleting your account, please download any data or information that you wish to retain.
          </CardDescription>
        </CardHeader>
        <CardContent class="max-w-lg">
          <Button @click="deleteAccount" variant="destructive" class="min-w-[100px]">Delete Account</Button>
        </CardContent>
      </Card>
    </div>
  </div>
</template>