// GENERATED from kernels/algos/flash_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn flash_sort_impl(a: &mut [i32], mut n: i64) {
    let mut mn: i64 = 0;
    let mut mx: i64 = 0;
    let mut i: i64 = 0;
    let mut m: i64 = 0;
    let mut rng: i64 = 0;
    let mut s: i64 = 0;
    let mut c: i64 = 0;
    let mut b: i64 = 0;
    let mut d: i64 = 0;
    let mut key: i64 = 0;
    let mut j: i64 = 0;
    let mut _e1: i64 = 0;
    let mut _e2: i64 = 0;
    let mut _e3: i64 = 0;
    let mut _e4: i64 = 0;
    let mut _e5: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
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
    if (mn == mx) {
        return;
    }
    m = std::cmp::max(2, ((43 * n) / 100));
    rng = (mx - mn);
    let mut count_store: Vec<i32> = vec![0; std::cmp::max(1, m) as usize]; let count: &mut [i32] = &mut count_store[..];
    let mut starts_store: Vec<i32> = vec![0; std::cmp::max(1, (m + 1)) as usize]; let starts: &mut [i32] = &mut starts_store[..];
    let mut nxt_store: Vec<i32> = vec![0; std::cmp::max(1, m) as usize]; let nxt: &mut [i32] = &mut nxt_store[..];
    i = 0;
    _e2 = n;
    while (i < _e2) {
        count[(((((a[(i) as usize] as i64) - mn) * (m - 1)) / rng)) as usize] = (((count[(((((a[(i) as usize] as i64) - mn) * (m - 1)) / rng)) as usize] as i64) + 1)) as i32;
        i = (i + 1);
    }
    s = 0;
    c = 0;
    _e3 = m;
    while (c < _e3) {
        starts[(c) as usize] = (s) as i32;
        nxt[(c) as usize] = (s) as i32;
        s = (s + (count[(c) as usize] as i64));
        c = (c + 1);
    }
    starts[(m) as usize] = (s) as i32;
    b = 0;
    _e4 = m;
    while (b < _e4) {
        while ((nxt[(b) as usize] as i64) < (starts[((b + 1)) as usize] as i64)) {
            d = ((((a[((nxt[(b) as usize] as i64)) as usize] as i64) - mn) * (m - 1)) / rng);
            if (d == b) {
                nxt[(b) as usize] = (((nxt[(b) as usize] as i64) + 1)) as i32;
            } else {
                _i1 = (nxt[(b) as usize] as i64);
                _i2 = (nxt[(d) as usize] as i64);
                _t1 = (a[(_i1) as usize] as i64);
                a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
                a[(_i2) as usize] = (_t1) as i32;
                nxt[(d) as usize] = (((nxt[(d) as usize] as i64) + 1)) as i32;
            }
        }
        b = (b + 1);
    }
    i = 1;
    _e5 = n;
    while (i < _e5) {
        key = (a[(i) as usize] as i64);
        j = (i - 1);
        while ((j >= 0) && ((a[(j) as usize] as i64) > key)) {
            a[((j + 1)) as usize] = ((a[(j) as usize] as i64)) as i32;
            j = (j - 1);
        }
        a[((j + 1)) as usize] = (key) as i32;
        i = (i + 1);
    }
}

pub fn flash_sort(a: &mut [i32]) {
    flash_sort_impl(a, a.len() as i64);
}
