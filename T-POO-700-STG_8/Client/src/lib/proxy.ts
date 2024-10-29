import { toast } from '@/components/ui/toast/use-toast.js'
import { useNetwork } from '@vueuse/core'

export enum HttpMethod {
  GET = 'GET',
  POST = 'POST',
  PUT = 'PUT',
  DELETE = 'DELETE'
}

const { VITE_API_URL = 'https://api.timemanager.alexishenry.eu/api' } = import.meta.env

interface FetchParamsInterface {
  endpoint: string
  method?: HttpMethod
  payload?: any
  withToken?: boolean
  persist?: boolean
}

enum RequestStatus {
  PENDING = 'pending',
  SUCCESS = 'success',
  ERROR = 'error'
}

const persistRequest = (request: any) => {
  const requests = JSON.parse(localStorage.getItem('requests') || '[]')
  requests.push(request)
  localStorage.setItem('requests', JSON.stringify(requests))
}

export const fetch = async (params: FetchParamsInterface): Promise<Response> => {
  let { endpoint } = params
  const { method = HttpMethod.GET, payload, withToken = true, persist = false } = params

  const { isOnline } = useNetwork()

  const headers = new Headers()

  if (withToken) {
    headers.set('Authorization', `Bearer ${localStorage.getItem('token')}`)
  }

  headers.set('Accept', 'application/json')
  headers.set('Content-Type', 'application/json')

  const options: RequestInit = {
    method,
    headers
  }

  if (payload && method !== HttpMethod.GET) {
    options.body = JSON.stringify(payload)
  }

  if (method === HttpMethod.GET && payload) {
    const params = new URLSearchParams()

    for (const key in payload) {
      params.append(key, payload[key])
    }

    endpoint += `?${params}`
  }

  if (!isOnline.value) {
    if (persist) {
      const request = {
        ...params,
        persist: false,
        status: RequestStatus.PENDING,
        id: Math.random().toString(36).substr(2, 9)
      }

      console.log('Request persisted', request)

      persistRequest(request)
    }

    return new Response(null, { status: 504, statusText: 'Gateway Timeout' })
  }

  const response = await window.fetch(`${VITE_API_URL}${endpoint}`, options)

  return response
}

type RequestInterface = FetchParamsInterface & {
  status: RequestStatus
  id: string
}

export const listen = () => {
  window.addEventListener('online', () => {
    const requests = JSON.parse(localStorage.getItem('requests') || '[]')

    let pendingRequestsCount = 0

    requests.forEach(async (request: RequestInterface) => {
      if (request.status !== RequestStatus.PENDING) return

      pendingRequestsCount++

      const response = await fetch({ ...request, persist: false })

      if (response.ok) {
        request.status = RequestStatus.SUCCESS
      } else {
        request.status = RequestStatus.ERROR
      }

      localStorage.setItem('requests', JSON.stringify(requests))
    })

    if (pendingRequestsCount) window.dispatchEvent(new Event('request:synced'))
  })

  window.addEventListener('request:synced', () => {
    toast({
      title: 'Request synced',
      description: 'Your requests have been synced with the server'
    })
  })
}