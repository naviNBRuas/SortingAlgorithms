// GENERATED from kernels/algos/sleep_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn sleep_sort_x_fallback(a: &mut [i32], mut n: i64) {
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

fn sleep_sort_impl(a: &mut [i32], mut n: i64) {
    let mut mn: i64 = 0;
    let mut mx: i64 = 0;
    let mut i: i64 = 0;
    let mut rng: i64 = 0;
    let mut t: i64 = 0;
    let mut out: i64 = 0;
    let mut node: i64 = 0;
    let mut _e1: i64 = 0;
    let mut _e2: i64 = 0;
    let mut _e3: i64 = 0;
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
        sleep_sort_x_fallback(a, n);
        return;
    }
    let mut head_store: Vec<i32> = vec![0; std::cmp::max(1, rng) as usize]; let head: &mut [i32] = &mut head_store[..];
    let mut nxt_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let nxt: &mut [i32] = &mut nxt_store[..];
    i = (n - 1);
    while (i >= 0) {
        t = ((a[(i) as usize] as i64) - mn);
        nxt[(i) as usize] = ((head[(t) as usize] as i64)) as i32;
        head[(t) as usize] = ((i + 1)) as i32;
        i = (i - 1);
    }
    let mut vals_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let vals: &mut [i32] = &mut vals_store[..];
    i = 0;
    _e2 = n;
    while (i < _e2) {
        vals[(i) as usize] = ((a[(i) as usize] as i64)) as i32;
        i = (i + 1);
    }
    out = 0;
    t = 0;
    _e3 = rng;
    while (t < _e3) {
        node = (head[(t) as usize] as i64);
        while (node != 0) {
            a[(out) as usize] = ((vals[((node - 1)) as usize] as i64)) as i32;
            out = (out + 1);
            node = (nxt[((node - 1)) as usize] as i64);
        }
        t = (t + 1);
    }
}

pub fn sleep_sort(a: &mut [i32]) {
    sleep_sort_impl(a, a.len() as i64);
}
