type BaseUserType = {
  username: string
  email: string
}

type BaseWorkingTimeType = {
  user_id?: string
  start_time: string
  end_time: string
  break_duration: number
}
type UpdateWorkingTimeType = {
  start_time?: string
  end_time?: string
  break_duration?: number
}

type BaseClockType = {
  status: boolean
  time: string
  user_id?: string
}

export type UpdatedUserType = {
  id: string
  user: BaseUserType
}

export enum Role {
  Admin = 'admin',
  Manager = 'manager',
  Employee = 'user'
}

export type UserType = {
  id: string
  role: Role
  manager?: string | UserType
} & BaseUserType

export type CreatedUserType = {
  user: BaseUserType
}

export type CreatedWorkingTime = {
  working_time: BaseWorkingTimeType
}

export type UpdatedWorkingTime = {
  working_time: UpdateWorkingTimeType
}

export type CreatedWorkingTimeType = {
  working_time: BaseWorkingTimeType
}

export type CreatedClockType = BaseClockType

export type CreatedClock = {
  userID: string
  clock: CreatedClockType
}
