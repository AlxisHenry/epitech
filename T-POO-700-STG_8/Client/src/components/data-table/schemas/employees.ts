import { Role } from '@/types'
import { z } from 'zod'

export const employeeSchema = (managers: any = []) => z.object({
  username: z.string().min(3).max(30),
  email: z.string().email().min(1),
  password: z.string().min(8).max(30),
  role: z.nativeEnum(Role).default(Role.Employee),
  manager: z.enum(managers).nullable().default(null)
})

const schema = employeeSchema()

export type Employee = z.infer<typeof schema>
