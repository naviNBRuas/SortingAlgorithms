// GENERATED from kernels/algos/strand_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn strand_sort_impl(a: &mut [i32], mut n: i64) {
    let mut i: i64 = 0;
    let mut left: i64 = 0;
    let mut o: i64 = 0;
    let mut s: i64 = 0;
    let mut keep: i64 = 0;
    let mut j: i64 = 0;
    let mut k: i64 = 0;
    let mut x: i64 = 0;
    let mut _e1: i64 = 0;
    let mut _e2: i64 = 0;
    let mut _e3: i64 = 0;
    let mut _e4: i64 = 0;
    if (n < 2) {
        return;
    }
    let mut rem_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let rem: &mut [i32] = &mut rem_store[..];
    let mut strand_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let strand: &mut [i32] = &mut strand_store[..];
    let mut out_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let out: &mut [i32] = &mut out_store[..];
    let mut tmp_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let tmp: &mut [i32] = &mut tmp_store[..];
    i = 0;
    _e1 = n;
    while (i < _e1) {
        rem[(i) as usize] = ((a[(i) as usize] as i64)) as i32;
        i = (i + 1);
    }
    left = n;
    o = 0;
    while (left > 0) {
        strand[(0) as usize] = ((rem[(0) as usize] as i64)) as i32;
        s = 1;
        keep = 0;
        i = 1;
        _e2 = left;
        while (i < _e2) {
            if ((rem[(i) as usize] as i64) >= (strand[((s - 1)) as usize] as i64)) {
                strand[(s) as usize] = ((rem[(i) as usize] as i64)) as i32;
                s = (s + 1);
            } else {
                rem[(keep) as usize] = ((rem[(i) as usize] as i64)) as i32;
                keep = (keep + 1);
            }
            i = (i + 1);
        }
        left = keep;
        i = 0;
        j = 0;
        k = 0;
        while ((i < o) && (j < s)) {
            if ((strand[(j) as usize] as i64) < (out[(i) as usize] as i64)) {
                tmp[(k) as usize] = ((strand[(j) as usize] as i64)) as i32;
                j = (j + 1);
            } else {
                tmp[(k) as usize] = ((out[(i) as usize] as i64)) as i32;
                i = (i + 1);
            }
            k = (k + 1);
        }
        while (i < o) {
            tmp[(k) as usize] = ((out[(i) as usize] as i64)) as i32;
            i = (i + 1);
            k = (k + 1);
        }
        while (j < s) {
            tmp[(k) as usize] = ((strand[(j) as usize] as i64)) as i32;
            j = (j + 1);
            k = (k + 1);
        }
        o = k;
        x = 0;
        _e3 = o;
        while (x < _e3) {
            out[(x) as usize] = ((tmp[(x) as usize] as i64)) as i32;
            x = (x + 1);
        }
    }
    i = 0;
    _e4 = n;
    while (i < _e4) {
        a[(i) as usize] = ((out[(i) as usize] as i64)) as i32;
        i = (i + 1);
    }
}

pub fn strand_sort(a: &mut [i32]) {
    strand_sort_impl(a, a.len() as i64);
}
