import { z } from 'zod'

export const workingTimeSchema = () =>
  z.object({
    start_time: z.string(),
    end_time: z.string(),
    break_duration: z.number()
  })

const schema = workingTimeSchema()

export type WorkingTime = z.infer<typeof schema>
