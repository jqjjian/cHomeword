import Array "mo:base/Array";
import Int "mo:base/Int";
import List "mo:base/List";
import Iter "mo:base/Iter";
import Float "mo:base/Float";
import Debug "mo:base/Debug";

actor ICHomework {
    func quicksort(arr: [var Int]): [Int] {
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
    let ary: [Int] = [8, 3, 4, 2, 6, 1, 5];
    Debug.print(debug_show(quicksort(Array.thaw<Int>(ary))));

    public func qsort(arr: [Int]) : async [Int] {
        quicksort(Array.thaw<Int>(arr))
    }
}

