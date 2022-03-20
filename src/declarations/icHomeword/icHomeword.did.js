export const idlFactory = ({ IDL }) => {
  const User = IDL.Record({ 'id' : IDL.Principal, 'name' : IDL.Opt(IDL.Text) });
  const Message = IDL.Record({
    'text' : IDL.Text,
    'time' : IDL.Int,
    'author' : IDL.Text,
  });
  return IDL.Service({
    'follow' : IDL.Func([IDL.Principal], [], []),
    'follows' : IDL.Func([], [IDL.Vec(User)], ['query']),
    'get_name' : IDL.Func([], [IDL.Opt(IDL.Text)], ['query']),
    'post' : IDL.Func([IDL.Text, IDL.Text], [], []),
    'posts' : IDL.Func([IDL.Int], [IDL.Vec(Message)], ['query']),
    'postsById' : IDL.Func([IDL.Principal], [IDL.Vec(Message)], []),
    'postsByTime' : IDL.Func([IDL.Int], [IDL.Vec(Message)], ['query']),
    'set_name' : IDL.Func([IDL.Text, IDL.Text], [], []),
    'timeline' : IDL.Func([], [IDL.Vec(Message)], []),
    'timelineByTime' : IDL.Func([IDL.Int], [IDL.Vec(Message)], []),
    'unfollow' : IDL.Func([IDL.Principal], [], []),
  });
};
export const init = ({ IDL }) => { return []; };
