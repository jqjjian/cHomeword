export const idlFactory = ({ IDL }) => {
  return IDL.Service({
    'append' : IDL.Func([IDL.Vec(IDL.Text)], [], []),
    'view' : IDL.Func([IDL.Nat, IDL.Nat], [IDL.Vec(IDL.Text)], []),
  });
};
export const init = ({ IDL }) => { return []; };
