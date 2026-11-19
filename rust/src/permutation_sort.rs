// GENERATED from kernels/algos/permutation_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn permutation_sort_impl(a: &mut [i32], mut n: i64) {
    let mut i: i64 = 0;
    let mut found: i64 = 0;
    let mut ok: i64 = 0;
    let mut j: i64 = 0;
    let mut lo: i64 = 0;
    let mut hi: i64 = 0;
    let mut _e1: i64 = 0;
    let mut _e2: i64 = 0;
    let mut _e3: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    let mut vals_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let vals: &mut [i32] = &mut vals_store[..];
    let mut idx_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let idx: &mut [i32] = &mut idx_store[..];
    i = 0;
    _e1 = n;
    while (i < _e1) {
        vals[(i) as usize] = ((a[(i) as usize] as i64)) as i32;
        idx[(i) as usize] = (i) as i32;
        i = (i + 1);
    }
    found = 0;
    while (found == 0) {
        ok = 1;
        i = 0;
        _e2 = (n - 1);
        while (i < _e2) {
            if ((vals[((idx[((i + 1)) as usize] as i64)) as usize] as i64) < (vals[((idx[(i) as usize] as i64)) as usize] as i64)) {
                ok = 0;
            }
            i = (i + 1);
        }
        if (ok == 1) {
            found = 1;
        } else {
            i = (n - 2);
            while ((i >= 0) && ((idx[(i) as usize] as i64) > (idx[((i + 1)) as usize] as i64))) {
                i = (i - 1);
            }
            if (i < 0) {
                found = 1;
            } else {
                j = (n - 1);
                while ((idx[(j) as usize] as i64) < (idx[(i) as usize] as i64)) {
                    j = (j - 1);
                }
                _i1 = i;
                _i2 = j;
                _t1 = (idx[(_i1) as usize] as i64);
                idx[(_i1) as usize] = ((idx[(_i2) as usize] as i64)) as i32;
                idx[(_i2) as usize] = (_t1) as i32;
                lo = (i + 1);
                hi = (n - 1);
                while (lo < hi) {
                    _i1 = lo;
                    _i2 = hi;
                    _t1 = (idx[(_i1) as usize] as i64);
                    idx[(_i1) as usize] = ((idx[(_i2) as usize] as i64)) as i32;
                    idx[(_i2) as usize] = (_t1) as i32;
                    lo = (lo + 1);
                    hi = (hi - 1);
                }
            }
        }
    }
    i = 0;
    _e3 = n;
    while (i < _e3) {
        a[(i) as usize] = ((vals[((idx[(i) as usize] as i64)) as usize] as i64)) as i32;
        i = (i + 1);
    }
}

pub fn permutation_sort(a: &mut [i32]) {
    permutation_sort_impl(a, a.len() as i64);
}
