// GENERATED from kernels/algos/counting_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn counting_sort_x_fallback(a: &mut [i32], mut n: i64) {
    let mut gap: i64 = 0;
    let mut i: i64 = 0;
    let mut key: i64 = 0;
    let mut j: i64 = 0;
    let mut _e1: i64 = 0;
    gap = (n / 2);
    while (gap > 0) {
        i = gap;
        _e1 = n;
        while (i < _e1) {
            key = (a[(i) as usize] as i64);
            j = i;
            while ((j >= gap) && ((a[((j - gap)) as usize] as i64) > key)) {
                a[(j) as usize] = ((a[((j - gap)) as usize] as i64)) as i32;
                j = (j - gap);
            }
            a[(j) as usize] = (key) as i32;
            i = (i + 1);
        }
        gap = (gap / 2);
    }
}

fn counting_sort_impl(a: &mut [i32], mut n: i64) {
    let mut mn: i64 = 0;
    let mut mx: i64 = 0;
    let mut i: i64 = 0;
    let mut rng: i64 = 0;
    let mut _e1: i64 = 0;
    let mut _e2: i64 = 0;
    let mut _e3: i64 = 0;
    let mut _e4: i64 = 0;
    let mut _e5: i64 = 0;
    if (n < 2) {
        return;
    }
    mn = (a[(0) as usize] as i64);
    mx = (a[(0) as usize] as i64);
    i = 1;
    _e1 = n;
    while (i < _e1) {
        if ((a[(i) as usize] as i64) < mn) {
            mn = (a[(i) as usize] as i64);
        }
        if ((a[(i) as usize] as i64) > mx) {
            mx = (a[(i) as usize] as i64);
        }
        i = (i + 1);
    }
    rng = ((mx - mn) + 1);
    if (rng > 4000000) {
        counting_sort_x_fallback(a, n);
        return;
    }
    let mut count_store: Vec<i32> = vec![0; std::cmp::max(1, (rng + 1)) as usize]; let count: &mut [i32] = &mut count_store[..];
    let mut out_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let out: &mut [i32] = &mut out_store[..];
    i = 0;
    _e2 = n;
    while (i < _e2) {
        count[((((a[(i) as usize] as i64) - mn) + 1)) as usize] = (((count[((((a[(i) as usize] as i64) - mn) + 1)) as usize] as i64) + 1)) as i32;
        i = (i + 1);
    }
    i = 1;
    _e3 = (rng + 1);
    while (i < _e3) {
        count[(i) as usize] = (((count[(i) as usize] as i64) + (count[((i - 1)) as usize] as i64))) as i32;
        i = (i + 1);
    }
    i = 0;
    _e4 = n;
    while (i < _e4) {
        out[((count[(((a[(i) as usize] as i64) - mn)) as usize] as i64)) as usize] = ((a[(i) as usize] as i64)) as i32;
        count[(((a[(i) as usize] as i64) - mn)) as usize] = (((count[(((a[(i) as usize] as i64) - mn)) as usize] as i64) + 1)) as i32;
        i = (i + 1);
    }
    i = 0;
    _e5 = n;
    while (i < _e5) {
        a[(i) as usize] = ((out[(i) as usize] as i64)) as i32;
        i = (i + 1);
    }
}

pub fn counting_sort(a: &mut [i32]) {
    counting_sort_impl(a, a.len() as i64);
}
