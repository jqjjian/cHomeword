import type { Principal } from '@dfinity/principal';
export interface Message { 'text' : string, 'time' : bigint, 'author' : string }
export interface User { 'id' : Principal, 'name' : [] | [string] }
export interface _SERVICE {
  'follow' : (arg_0: Principal) => Promise<undefined>,
  'follows' : () => Promise<Array<User>>,
  'get_name' : () => Promise<[] | [string]>,
  'post' : (arg_0: string, arg_1: string) => Promise<undefined>,
  'posts' : (arg_0: bigint) => Promise<Array<Message>>,
  'postsById' : (arg_0: Principal) => Promise<Array<Message>>,
  'postsByTime' : (arg_0: bigint) => Promise<Array<Message>>,
  'set_name' : (arg_0: string, arg_1: string) => Promise<undefined>,
  'timeline' : () => Promise<Array<Message>>,
  'timelineByTime' : (arg_0: bigint) => Promise<Array<Message>>,
  'unfollow' : (arg_0: Principal) => Promise<undefined>,
}
