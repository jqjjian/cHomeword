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
    // 第5课作业
    public type Message = {
        text : Text;
        time : Int;
        author : Text;
    };

    public type User = {
        id: Principal;
        name: ?Text;
    };

    public type Microblog = actor {
        follow : shared(Principal) -> async (); // 添加关注对象
        follows : shared query () -> async [User];
        post : shared (Text) -> async ();
        posts : shared query (Int) -> async [Message];
        postsById : shared (Principal) -> async [Message];
        postsByTime : shared query (Int) -> async [Message];
        timeline : shared () -> async [Message];
        timelineByTime : shared (Int) -> async [Message];
        set_name : shared (Text) -> async Text;
        get_name : shared query() -> async ?Text;
    };

    stable var followed : List.List<User> = List.nil();

    public shared func follow(id: Principal): async () {
        let canister : Microblog = actor(Principal.toText(id));
        let name = await canister.get_name();
        let user: User = {
            id;
            name;
        };
        followed := List.push(user, followed)
    };

    public shared func unfollow(id: Principal): async () {
        followed := List.filter(followed, func(user: User) : Bool {user.id != id })
    };

    public shared query func follows() : async [User] {
        List.toArray(followed)
    };

    stable var messages: List.List<Message> = List.nil();
    stable var author: Text = "";
    public shared(msg) func post(text: Text, psw: Text) : async () {
        assert(psw == "123123");
        let _msg : Message = {
            text;
            time = Time.now();
            author = author;

        };
        messages := List.push(_msg, messages)
    };

    public shared func postsById(id : Principal) : async [Message] {
        // var all : List.List<Message> = List.nil();
        let canister : Microblog = actor(Principal.toText(id));
        let msgs = await canister.posts(0);
        msgs
        // msgs := await canister.posts();
        // for (msg in Iter.fromArray(msgs)) {
        //     all := List.push(msg, all)
        // };
        // List.toArray(all)
    };

    public shared query func postsByTime(since : Int) : async [Message] {
        let filterMsg: List.List<Message> = List.filter(messages, func (msg: Message): Bool {msg.time > since});
        List.toArray(filterMsg)
    };

    public shared query func posts(since : Int) : async [Message] {
        List.toArray(messages)
    };

    public shared func timeline() : async [Message] {
        var all : List.List<Message> = List.nil();
        for (user in Iter.fromList(followed)) {
            let canister : Microblog = actor(Principal.toText(user.id));
            let msgs = await canister.posts(0);
            for (msg in Iter.fromArray(msgs)) {
                all := List.push(msg, all)
            }
        };
        List.toArray(all)
    };

    public shared func timelineByTime(since: Int) : async [Message] {
        var all : List.List<Message> = List.nil();
        for (user in Iter.fromList(followed)) {
            let canister : Microblog = actor(Principal.toText(user.id));
            let msgs = await canister.postsByTime(since);
            for (msg in Iter.fromArray(msgs)) {
                all := List.push(msg, all)
            }
        };
        let filterMsg: List.List<Message> = List.filter(all, func (msg: Message): Bool {msg.time > since});
        List.toArray(filterMsg)
    };

    public shared func set_name(name: Text, psw: Text) : async() {
        assert(psw == "123123");
        author := name;
    };

    public shared query func get_name() : async ?Text {
        return ?author
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

