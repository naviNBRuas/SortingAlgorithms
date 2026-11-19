// GENERATED from kernels/algos/patience_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn patience_sort_impl(a: &mut [i32], mut n: i64) {
    let mut i: i64 = 0;
    let mut piles: i64 = 0;
    let mut lo: i64 = 0;
    let mut hi: i64 = 0;
    let mut mid: i64 = 0;
    let mut out: i64 = 0;
    let mut best: i64 = 0;
    let mut p: i64 = 0;
    let mut _e1: i64 = 0;
    let mut _e2: i64 = 0;
    let mut _e3: i64 = 0;
    let mut _e4: i64 = 0;
    if (n < 2) {
        return;
    }
    let mut vals_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let vals: &mut [i32] = &mut vals_store[..];
    let mut prev_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let prev: &mut [i32] = &mut prev_store[..];
    let mut top_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let top: &mut [i32] = &mut top_store[..];
    i = 0;
    _e1 = n;
    while (i < _e1) {
        vals[(i) as usize] = ((a[(i) as usize] as i64)) as i32;
        i = (i + 1);
    }
    piles = 0;
    i = 0;
    _e2 = n;
    while (i < _e2) {
        lo = 0;
        hi = piles;
        while (lo < hi) {
            mid = ((lo + hi) / 2);
            if ((vals[(((top[(mid) as usize] as i64) - 1)) as usize] as i64) < (vals[(i) as usize] as i64)) {
                lo = (mid + 1);
            } else {
                hi = mid;
            }
        }
        prev[(i) as usize] = ((top[(lo) as usize] as i64)) as i32;
        top[(lo) as usize] = ((i + 1)) as i32;
        if (lo == piles) {
            piles = (piles + 1);
        }
        i = (i + 1);
    }
    out = 0;
    _e3 = n;
    while (out < _e3) {
        best = (-1);
        p = 0;
        _e4 = piles;
        while (p < _e4) {
            if ((top[(p) as usize] as i64) != 0) {
                if ((best < 0) || ((vals[(((top[(p) as usize] as i64) - 1)) as usize] as i64) < (vals[(((top[(best) as usize] as i64) - 1)) as usize] as i64))) {
                    best = p;
                }
            }
            p = (p + 1);
        }
        a[(out) as usize] = ((vals[(((top[(best) as usize] as i64) - 1)) as usize] as i64)) as i32;
        top[(best) as usize] = ((prev[(((top[(best) as usize] as i64) - 1)) as usize] as i64)) as i32;
        out = (out + 1);
    }
}

pub fn patience_sort(a: &mut [i32]) {
    patience_sort_impl(a, a.len() as i64);
}
