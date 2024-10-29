import { fileURLToPath, URL } from 'node:url'
import path from 'node:path'
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueJsx from '@vitejs/plugin-vue-jsx'
import vueDevTools from 'vite-plugin-vue-devtools'
import { VitePWA } from 'vite-plugin-pwa'

import tailwind from 'tailwindcss'
import autoprefixer from 'autoprefixer'

// https://vitejs.dev/config/
export default defineConfig({
  css: {
    postcss: {
      plugins: [tailwind(), autoprefixer()]
    }
  },
  plugins: [
    vue(),
    vueJsx(),
    vueDevTools(),
    VitePWA({
      registerType: "autoUpdate",
      injectRegister: "auto",
      workbox: {
        cleanupOutdatedCaches: true,
        globPatterns: ["**/*.{js,css,html,ico,png,jpg,svg,json,woff2}"],
        runtimeCaching: [
          {
            urlPattern: ({ request }) => request.destination === 'document',
            handler: 'NetworkFirst',
            options: {
              cacheName: 'documents',
              expiration: {
                maxEntries: 50,
              },
            },
          },
          {
            urlPattern: ({ request }) => request.destination === 'image',
            handler: 'CacheFirst',
            options: {
              cacheName: 'images',
              expiration: {
                maxEntries: 50,
              },
            },
          },
        ],
      },
      devOptions: {
        enabled: true
      },
      manifest: {
        id: '/',
        name: 'Time Manager',
        short_name: 'Time Manager App',
        description: 'Make your employee\'s life easier, manage their time with ease. Be productive and efficient.',
        start_url: '/',
        display: 'standalone',
        background_color: '#ffffff',
        theme_color: '#000000',
        icons: [
          {
            src: '/pwa/icon.png',
            sizes: '512x512',
            type: 'image/png',
          },
        ],
        "screenshots": [
          {
            "src": "/pwa/screenshots/1.jpg",
            "sizes": "1080x1920",
            "type": "image/png",
            "form_factor":"wide"
          },
          {
            "src": "/pwa/screenshots/2.jpg",
            "sizes": "1080x1920",
            "type": "image/png"
          }
        ]
      }
    })
  ],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src')
    }
  }
})
