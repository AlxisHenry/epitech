<template>
  <svg
    xmlns="http://www.w3.org/2000/svg"
    :width="size"
    :height="size"
    viewBox="0 0 24 24"
    fill="none"
    stroke="currentColor"
    stroke-width="2"
    stroke-linecap="round"
    stroke-linejoin="round"
    :class="cn('animate-spin', className)"
    v-bind="$attrs"
  >
    <path d="M21 12a9 9 0 1 1-6.219-8.56" />
  </svg>
</template>

<script lang="ts">
import { cn } from '@/lib/utils';
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'Loader',
  props: {
    size: {
      type: Number,
      default: 64
    },
    className: {
      type: String,
      default: ''
    }
  },
  methods: {
    cn
  }
})
</script>
