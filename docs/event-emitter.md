# EventType

callback: Function

once: boolean

# EventsType

Record<string, EventType[]>

# EventEmitter

_events: EventsType = {}

on(evt: string, callback: Function, once?: boolean)    监听一个事件

once(evt: string, callback: Function)    监听一个事件一次

emit(evt: string, ...args: any[])    触发一个事件

off(evt?: string, callback?: Function)    取消监听一个事件，或者一个channel

getEvents()    当前所有的事件