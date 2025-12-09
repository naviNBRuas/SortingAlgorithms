pub fn merge_sort(arr: &[i32]) -> Vec<i32> {
    if arr.len() <= 1 {
        return arr.to_vec();
    }
    let mid = arr.len() / 2;
    let left = merge_sort(&arr[..mid]);
    let right = merge_sort(&arr[mid..]);
    merge(&left, &right)
}

fn merge(a: &[i32], b: &[i32]) -> Vec<i32> {
    let mut res = Vec::with_capacity(a.len() + b.len());
    let mut i = 0;
    let mut j = 0;
    while i < a.len() && j < b.len() {
        if a[i] <= b[j] {
            res.push(a[i]);
            i += 1;
        } else {
            res.push(b[j]);
            j += 1;
        }
    }
    res.extend_from_slice(&a[i..]);
    res.extend_from_slice(&b[j..]);
    res
}
