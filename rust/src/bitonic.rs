/// Ascending-only bitonic network (flip-first formulation). Comparators outside the
/// slice are skipped, equivalent to padding with +infinity, so any length works.
pub fn bitonic_sort(arr: &mut [i32]) {
    let n = arr.len();
    let mut size = 1;
    while size < n {
        size <<= 1;
    }
    let mut k = 2;
    while k <= size {
        for blk in (0..size).step_by(k) {
            for t in 0..k / 2 {
                let j = blk + k - 1 - t;
                if j < n && arr[blk + t] > arr[j] {
                    arr.swap(blk + t, j);
                }
            }
        }
        let mut j = k / 4;
        while j >= 1 {
            for i in 0..size {
                if i & j == 0 && i + j < n && arr[i] > arr[i + j] {
                    arr.swap(i, i + j);
                }
            }
            j /= 2;
        }
        k <<= 1;
    }
}
