import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Nat16 "mo:base/Nat16";
import Nat8 "mo:base/Nat8";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Time "mo:base/Time";


actor ICHomework {
    // 第四课作业
    public type Message = {
        text : Text;
        time : Time.Time;
    };

    public type Microblog = actor {
        follow : shared(Principal) -> async (); // 添加关注对象
        follows : shared query () -> async [Principal];
        post : shared (Text) -> async ();
        posts : shared query (Time.Time) -> async [Message];
        timeline : shared (Time.Time) -> async [Message];
    };

    stable var followed : List.List<Principal> = List.nil();

    public shared func follow(id: Principal): async () {
        followed := List.push(id, followed)
    };

    public shared func unfollow(id: Principal): async () {
        followed := List.filter(followed, func(pid: Principal) : Bool {pid != id })
    };

    public shared query func follows() : async [Principal] {
        List.toArray(followed)
    };

    stable var messages: List.List<Message> = List.nil();

    public shared(msg) func post(text: Text) : async () {
        assert(Principal.toText(msg.caller) == "ninf7-o7cqb-munqg-a5ypi-xcrzi-njyy6-ckagk-a4gcc-5t3pv-dmstw-xae");
        let _msg : Message = {
            text;
            time = Time.now();
        };
        messages := List.push(_msg, messages)
    };

    public shared query func posts(since: Time.Time) : async [Message] {
        let filterMsg: List.List<Message> = List.filter(messages, func (msg: Message): Bool {msg.time > since});
        List.toArray(filterMsg)
    };

    public shared func timeline(since: Time.Time) : async [Message] {
        var all : List.List<Message> = List.nil();
        for (id in Iter.fromList(followed)) {
            let canister : Microblog = actor(Principal.toText(id));
            let msgs = await canister.posts(since);
            for (msg in Iter.fromArray(msgs)) {
                all := List.push(msg, all)
            }
        };
        let filterMsg: List.List<Message> = List.filter(all, func (msg: Message): Bool {msg.time > since});
        List.toArray(filterMsg)
    };


    // 第三课作业
    // counter
    // stable var currentValue : Nat = 0;

    // // Increment the counter with the increment function.
    // public func increment() : async () {
    //     currentValue += 1;
    // };

    // // Read the counter value with a get function.
    // public query func getCurrentValue() : async Nat {
    //     currentValue
    // };

    // // Write an arbitrary value with a set function.
    // public func setCurrentValue(n: Nat) : async () {
    //     currentValue := n;
    // };



    // // request counter

    // private type HeaderField = (Text, Text);
    // private type HttpRequest = {
    //     url: Text;
    //     method: Text;
    //     body: [Nat8];
    //     headers: [HeaderField];
    // };
    // private type Key = Text;
    // private type Path = Text;
    // private type ChunkId = Nat;
    // private type SetAssetContentArguments = {
    //     key : Key;
    //     sha256: ?[Nat8];
    //     chunk_ids: [ChunkId];
    // };
    // private type StreamingCallbackToken = {
    //     key: Text;
    //     sha256: ?[Nat8];
    //     index: Nat;
    //     content_encoding: Text;
    // };
    // private type StreamingCallbackHttpResponse = {
    //     token: ?StreamingCallbackToken;
    //     body: [Nat8];
    // };
    // private type StreamingStrategy = {
    //     #Callback: {
    //         token: StreamingCallbackToken;
    //         callback: shared query StreamingCallbackToken -> async StreamingCallbackHttpResponse;
    //     };
    // };
    // private type HttpResponse = {
    //     body: Blob;
    //     headers: [HeaderField];
    //     streaming_strategy: ?StreamingStrategy;
    //     status_code: Nat16;
    // };
    // public shared query func http_request(request: HttpRequest): async HttpResponse {
    //     {
    //         body = Text.encodeUtf8("<html><body><h1>" #Nat.toText(currentValue)# "</h1></body></html>");
    //         headers = [];
    //         streaming_strategy = null;
    //         status_code = 200;
    //     }
    // };

    // // 第二课作业
    // private func quicksort(arr: [var Int]): [Int] {
    //     let list: List.List<Int> = List.fromVarArray<Int>(arr);
    //     if (List.size(list) < 2) {
    //         let newArr = Array.freeze<Int>(arr);
    //         return newArr;
    //     };
    //     let pivotIndex: Nat = List.size(list) / 2;
    //     let iarr: [Int] = Array.freeze<Int>(arr);
    //     let pivot = iarr[pivotIndex];
    //     let l = Array.filter<Int>(iarr, func(v: Int) {v < pivot});
    //     let r = Array.filter<Int>(iarr, func(v: Int) {v > pivot});
    //     let newArr: [Int] = Array.append<Int>(Array.append<Int>(l, [pivot]), quicksort(Array.thaw<Int>(r)));
    //     return newArr;
    // };
    // // let ary: [Int] = [8, 3, 4, 2, 6, 1, 5];
    // // Debug.print(debug_show(quicksort(Array.thaw<Int>(ary))));

    // private func qsort(arr: [Int]) : async [Int] {
    //     quicksort(Array.thaw<Int>(arr))
    // };
};

