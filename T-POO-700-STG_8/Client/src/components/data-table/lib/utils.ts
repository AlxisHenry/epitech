import type { Row, Table } from "@tanstack/vue-table"

export const getOriginal = (row: Row<any>) => row.original

export const getRowFields = (row: Row<any>) => {
    const original = getOriginal(row)

    return Object.keys(original).map((key) => ({
        key,
        value: original[key],
    }))
}

export const getTaleColumns = (table: any) => {
    return table.getAllColumns()?.map((column: any) => ({
        id: column.id,
        ...(column.columnDef.props || {}),
    }))
}

export const getAutoFormFieldConfig = (row: Row<any>, schema: any) => {
    console.log(row)
}