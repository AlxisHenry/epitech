export { teamsColumns } from './teams'
export { employeesColumns } from './employees'
export { workingTimesColumns } from './working_times'

export type CustomDataTableColumnAction = {
    label: string
    to: (row: any) => { name: string, params: any }
    before?: (row: any) => boolean
    icon: any
}