// GENERATED from kernels/algos/enumeration_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn enumeration_sort_impl(a: &mut [i32], mut n: i64) {
    let mut i: i64 = 0;
    let mut rank: i64 = 0;
    let mut j: i64 = 0;
    let mut _e1: i64 = 0;
    let mut _e2: i64 = 0;
    let mut _e3: i64 = 0;
    let mut out_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let out: &mut [i32] = &mut out_store[..];
    i = 0;
    _e1 = n;
    while (i < _e1) {
        rank = 0;
        j = 0;
        _e2 = n;
        while (j < _e2) {
            if (((a[(j) as usize] as i64) < (a[(i) as usize] as i64)) || (((a[(j) as usize] as i64) == (a[(i) as usize] as i64)) && (j < i))) {
                rank = (rank + 1);
            }
            j = (j + 1);
        }
        out[(rank) as usize] = ((a[(i) as usize] as i64)) as i32;
        i = (i + 1);
    }
    i = 0;
    _e3 = n;
    while (i < _e3) {
        a[(i) as usize] = ((out[(i) as usize] as i64)) as i32;
        i = (i + 1);
    }
}

pub fn enumeration_sort(a: &mut [i32]) {
    enumeration_sort_impl(a, a.len() as i64);
}
