import Array "mo:base/Array";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Debug "mo:base/Debug";

actor ICHomework {
    func quicksort(arr: [var Int]) {
        let yy = Array.freeze(arr);
        let xs = Array.sort(yy, Int.compare);
        var i = 0;
        label lop for (j in Iter.range(0, xs.size())) {
            Debug.print(Int.toText(xs[i]));
            if (i == (xs.size() - 1: Nat)) {
                break lop;
            };
            i += 1;
        }
    };
    let ary = [8, 3, 4, 2, 6, 1, 5];
    quicksort(Array.thaw(ary));

    public func qsort(arr: [Int]) : async [Int] {
        Array.sort(arr, Int.compare);
    }
}

