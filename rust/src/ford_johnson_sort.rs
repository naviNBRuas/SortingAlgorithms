// GENERATED from kernels/algos/ford_johnson_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn ford_johnson_sort_x_fj(key: &mut [i32], ids: &mut [i32], mut m: i64) {
    let mut h: i64 = 0;
    let mut k: i64 = 0;
    let mut x: i64 = 0;
    let mut y: i64 = 0;
    let mut total: i64 = 0;
    let mut size: i64 = 0;
    let mut prev: i64 = 0;
    let mut kk: i64 = 0;
    let mut t: i64 = 0;
    let mut pw: i64 = 0;
    let mut c: i64 = 0;
    let mut top: i64 = 0;
    let mut i: i64 = 0;
    let mut bound: i64 = 0;
    let mut lo: i64 = 0;
    let mut hi: i64 = 0;
    let mut mid: i64 = 0;
    let mut j: i64 = 0;
    let mut _e1: i64 = 0;
    let mut _e2: i64 = 0;
    let mut _e3: i64 = 0;
    let mut _e4: i64 = 0;
    if (m < 2) {
        return;
    }
    h = (m / 2);
    let mut small_store: Vec<i32> = vec![0; std::cmp::max(1, h) as usize]; let small: &mut [i32] = &mut small_store[..];
    let mut big_store: Vec<i32> = vec![0; std::cmp::max(1, h) as usize]; let big: &mut [i32] = &mut big_store[..];
    k = 0;
    _e1 = h;
    while (k < _e1) {
        x = (ids[((2 * k)) as usize] as i64);
        y = (ids[(((2 * k) + 1)) as usize] as i64);
        if ((key[(y) as usize] as i64) < (key[(x) as usize] as i64)) {
            small[(k) as usize] = (y) as i32;
            big[(k) as usize] = (x) as i32;
        } else {
            small[(k) as usize] = (x) as i32;
            big[(k) as usize] = (y) as i32;
        }
        k = (k + 1);
    }
    let mut bk_store: Vec<i32> = vec![0; std::cmp::max(1, h) as usize]; let bk: &mut [i32] = &mut bk_store[..];
    let mut order_store: Vec<i32> = vec![0; std::cmp::max(1, h) as usize]; let order: &mut [i32] = &mut order_store[..];
    k = 0;
    _e2 = h;
    while (k < _e2) {
        bk[(k) as usize] = ((key[((big[(k) as usize] as i64)) as usize] as i64)) as i32;
        order[(k) as usize] = (k) as i32;
        k = (k + 1);
    }
    ford_johnson_sort_x_fj(bk, order, h);
    total = h;
    if ((m % 2) == 1) {
        total = (h + 1);
    }
    let mut chain_store: Vec<i32> = vec![0; std::cmp::max(1, m) as usize]; let chain: &mut [i32] = &mut chain_store[..];
    let mut bs_store: Vec<i32> = vec![0; std::cmp::max(1, (total + 1)) as usize]; let bs: &mut [i32] = &mut bs_store[..];
    chain[(0) as usize] = ((small[((order[(0) as usize] as i64)) as usize] as i64)) as i32;
    k = 0;
    _e3 = h;
    while (k < _e3) {
        chain[((k + 1)) as usize] = ((big[((order[(k) as usize] as i64)) as usize] as i64)) as i32;
        bs[((k + 1)) as usize] = ((small[((order[(k) as usize] as i64)) as usize] as i64)) as i32;
        k = (k + 1);
    }
    size = (h + 1);
    if ((m % 2) == 1) {
        bs[((h + 1)) as usize] = ((ids[((m - 1)) as usize] as i64)) as i32;
    }
    prev = 1;
    kk = 2;
    while (prev < total) {
        t = 1;
        pw = 1;
        c = 0;
        while (c < (kk + 1)) {
            pw = (pw * 2);
            c = (c + 1);
        }
        if ((kk % 2) == 0) {
            t = ((pw + 1) / 3);
        } else {
            t = ((pw - 1) / 3);
        }
        top = std::cmp::min(t, total);
        i = top;
        while (i > prev) {
            bound = size;
            if (i <= h) {
                bound = 0;
                while ((chain[(bound) as usize] as i64) != (big[((order[((i - 1)) as usize] as i64)) as usize] as i64)) {
                    bound = (bound + 1);
                }
            }
            lo = 0;
            hi = bound;
            while (lo < hi) {
                mid = ((lo + hi) / 2);
                if ((key[((bs[(i) as usize] as i64)) as usize] as i64) < (key[((chain[(mid) as usize] as i64)) as usize] as i64)) {
                    hi = mid;
                } else {
                    lo = (mid + 1);
                }
            }
            j = size;
            while (j > lo) {
                chain[(j) as usize] = ((chain[((j - 1)) as usize] as i64)) as i32;
                j = (j - 1);
            }
            chain[(lo) as usize] = ((bs[(i) as usize] as i64)) as i32;
            size = (size + 1);
            i = (i - 1);
        }
        prev = top;
        kk = (kk + 1);
    }
    k = 0;
    _e4 = m;
    while (k < _e4) {
        ids[(k) as usize] = ((chain[(k) as usize] as i64)) as i32;
        k = (k + 1);
    }
}

fn ford_johnson_sort_impl(a: &mut [i32], mut n: i64) {
    let mut i: i64 = 0;
    let mut _e1: i64 = 0;
    let mut _e2: i64 = 0;
    if (n < 2) {
        return;
    }
    let mut key_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let key: &mut [i32] = &mut key_store[..];
    let mut ids_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let ids: &mut [i32] = &mut ids_store[..];
    i = 0;
    _e1 = n;
    while (i < _e1) {
        key[(i) as usize] = ((a[(i) as usize] as i64)) as i32;
        ids[(i) as usize] = (i) as i32;
        i = (i + 1);
    }
    ford_johnson_sort_x_fj(key, ids, n);
    i = 0;
    _e2 = n;
    while (i < _e2) {
        a[(i) as usize] = ((key[((ids[(i) as usize] as i64)) as usize] as i64)) as i32;
        i = (i + 1);
    }
}

pub fn ford_johnson_sort(a: &mut [i32]) {
    ford_johnson_sort_impl(a, a.len() as i64);
}
