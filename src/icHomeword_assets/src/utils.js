export function timeSince(str, addBreak = false) {
    const timeStamp = new Date(str)
    const now = new Date()
    const secondsPast = Math.round((now.getTime() - timeStamp) / 1000)
    if (secondsPast < 60) {
        return `${secondsPast} secs ago`
    }
    if (secondsPast <= 300) {
        return `${Math.round((secondsPast * 1) / 60)} min ago`
    }

    if (secondsPast > 300) {
        return dateTimeFmt(str)
    }
}

export function dateFmt(str) {
    const dt = new Date(str)
    return dt.toLocaleDateString()
}

export function timeFmt(str) {
    const dt = new Date(str)
    return dt.toLocaleTimeString(undefined, {
        hour12: false
    })
}

export function dateTimeFmt(str) {
    const dt = new Date(str)
    return `${dt.toLocaleDateString()} ${dt.toLocaleTimeString(undefined, {
        hour12: false
    })}`
}