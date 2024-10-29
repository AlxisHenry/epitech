import { z } from 'zod'

export const teamSchema = z.object({
  name: z.string()
})

export type Team = z.infer<typeof teamSchema>
