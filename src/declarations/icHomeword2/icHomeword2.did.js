export const idlFactory = ({ IDL }) => {
  const User = IDL.Record({ 'id' : IDL.Principal, 'name' : IDL.Text });
  const Time = IDL.Int;
  const Message = IDL.Record({
    'text' : IDL.Text,
    'time' : Time,
    'author' : IDL.Text,
  });
  return IDL.Service({
    'follow' : IDL.Func([IDL.Principal], [], []),
    'follows' : IDL.Func([], [IDL.Vec(User)], ['query']),
    'get_name' : IDL.Func([], [IDL.Text], ['query']),
    'post' : IDL.Func([IDL.Text, IDL.Text], [], []),
    'posts' : IDL.Func([], [IDL.Vec(Message)], ['query']),
    'postsById' : IDL.Func([IDL.Principal], [IDL.Vec(Message)], []),
    'postsByTime' : IDL.Func([Time], [IDL.Vec(Message)], ['query']),
    'set_name' : IDL.Func([IDL.Text, IDL.Text], [], []),
    'timeline' : IDL.Func([], [IDL.Vec(Message)], []),
    'timelineByTime' : IDL.Func([Time], [IDL.Vec(Message)], []),
    'unfollow' : IDL.Func([IDL.Principal], [], []),
  });
};
export const init = ({ IDL }) => { return []; };
