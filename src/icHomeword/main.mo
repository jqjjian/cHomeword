import Array "mo:base/Array";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Debug "mo:base/Debug";

actor ICHomework {
    func quicksort(arr: [var Int]) {
        let yy = Array.freeze(arr);
        let xs = Array.sort(yy, Int.compare);
        // var i = 0;
        Debug.print(debug_show(xs));
    };
    let ary = [8, 3, 4, 2, 6, 1, 5];
    quicksort(Array.thaw(ary));

    public func qsort(arr: [Int]) : async [Int] {
        Array.sort(arr, Int.compare);
    }
}

