// Persistent logger keeping track of what is going on.

// import Array "mo:base/Array";
// import Buffer "mo:base/Buffer";
// import Deque "mo:base/Deque";
// import List "mo:base/List";
// import Map "mo:base/RBTree";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
// import Option "mo:base/Option";
import Logger "mo:ic-logger/Logger";

actor class Bucket() {
    // type Key = Nat;
    // type Value = Text;
    // let OWNER = msg.caller;
    // let map = Map.RBTree<Key, Value>(Nat.compare);
    stable var state : Logger.State<Text> = Logger.new<Text>(0, null);
    let logger = Logger.Logger<Text>(state);
    // Add a set of messages to the log.
    public shared (msg) func append(msgs: [Text]) {
        // assert(Option.isSome(Array.find(allowed, func (id: Principal) : Bool { msg.caller == id })));
        logger.append(msgs);
    };

    // Return log stats, where:
    //   start_index is the first index of log message.
    //   bucket_sizes is the size of all buckets, from oldest to newest.
    public shared func stats() : async Logger.Stats {
        logger.stats()
    };

    // Return the messages between from and to indice (inclusive).
    public shared (msg) func view(from: Nat, to: Nat) : async Logger.View<Text> {
        // assert(msg.caller == OWNER);
        logger.view(from, to)
    };

  // Drop past buckets (oldest first).
//   public shared (msg) func pop_buckets(num: Nat) {
//     assert(msg.caller == OWNER);
//     logger.pop_buckets(num)
//   }
}
