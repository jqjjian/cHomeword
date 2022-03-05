import Array "mo:base/Array";
import Int "mo:base/Int";
import List "mo:base/List";
import Iter "mo:base/Iter";
import Float "mo:base/Float";
import Debug "mo:base/Debug";
import Nat8 "mo:base/Nat8";
import Nat16 "mo:base/Nat16";
import Text "mo:base/Text";
import Nat "mo:base/Nat";


actor ICHomework {


    // 第二课作业
    private func quicksort(arr: [var Int]): [Int] {
        let list: List.List<Int> = List.fromVarArray<Int>(arr);
        if (List.size(list) < 2) {
            let newArr = Array.freeze<Int>(arr);
            return newArr;
        };
        let pivotIndex: Nat = List.size(list) / 2;
        let iarr: [Int] = Array.freeze<Int>(arr);
        let pivot = iarr[pivotIndex];
        let l = Array.filter<Int>(iarr, func(v: Int) {v < pivot});
        let r = Array.filter<Int>(iarr, func(v: Int) {v > pivot});
        let newArr: [Int] = Array.append<Int>(Array.append<Int>(l, [pivot]), quicksort(Array.thaw<Int>(r)));
        return newArr;
    };
    // let ary: [Int] = [8, 3, 4, 2, 6, 1, 5];
    // Debug.print(debug_show(quicksort(Array.thaw<Int>(ary))));

    private func qsort(arr: [Int]) : async [Int] {
        quicksort(Array.thaw<Int>(arr))
    };



    // 第三课作业
    // counter
    stable var currentValue : Nat = 0;

    // Increment the counter with the increment function.
    public func increment() : async () {
        currentValue += 1;
    };

    // Read the counter value with a get function.
    public query func getCurrentValue() : async Nat {
        currentValue
    };

    // Write an arbitrary value with a set function.
    public func setCurrentValue(n: Nat) : async () {
        currentValue := n;
    };



    // request counter

    private type HeaderField = (Text, Text);
    private type HttpRequest = {
        url: Text;
        method: Text;
        body: [Nat8];
        headers: [HeaderField];
    };
    private type Key = Text;
    private type Path = Text;
    private type ChunkId = Nat;
    private type SetAssetContentArguments = {
        key : Key;
        sha256: ?[Nat8];
        chunk_ids: [ChunkId];
    };
    private type StreamingCallbackToken = {
        key: Text;
        sha256: ?[Nat8];
        index: Nat;
        content_encoding: Text;
    };
    private type StreamingCallbackHttpResponse = {
        token: ?StreamingCallbackToken;
        body: [Nat8];
    };
    private type StreamingStrategy = {
        #Callback: {
            token: StreamingCallbackToken;
            callback: shared query StreamingCallbackToken -> async StreamingCallbackHttpResponse;
        };
    };
    private type HttpResponse = {
        body: Blob;
        headers: [HeaderField];
        streaming_strategy: ?StreamingStrategy;
        status_code: Nat16;
    };
    public shared query func http_request(request: HttpRequest): async HttpResponse {
        {
            body = Text.encodeUtf8("<html><body><h1>" #Nat.toText(currentValue)# "</h1></body></html>");
            headers = [];
            streaming_strategy = null;
            status_code = 200;
        }
    };
}

