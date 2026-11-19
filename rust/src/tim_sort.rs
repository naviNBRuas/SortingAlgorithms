// GENERATED from kernels/algos/tim_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn tim_sort_x_insertion(a: &mut [i32], mut lo: i64, mut hi: i64) {
    let mut i: i64 = 0;
    let mut key: i64 = 0;
    let mut j: i64 = 0;
    let mut _e1: i64 = 0;
    i = (lo + 1);
    _e1 = hi;
    while (i < _e1) {
        key = (a[(i) as usize] as i64);
        j = (i - 1);
        while ((j >= lo) && ((a[(j) as usize] as i64) > key)) {
            a[((j + 1)) as usize] = ((a[(j) as usize] as i64)) as i32;
            j = (j - 1);
        }
        a[((j + 1)) as usize] = (key) as i32;
        i = (i + 1);
    }
}

fn tim_sort_x_merge_at(a: &mut [i32], tmp: &mut [i32], rs: &mut [i32], rl: &mut [i32], mut cnt: i64, mut i: i64) -> i64 {
    let mut s1: i64 = 0;
    let mut l1: i64 = 0;
    let mut l2: i64 = 0;
    let mut x: i64 = 0;
    let mut j: i64 = 0;
    let mut k: i64 = 0;
    let mut end: i64 = 0;
    let mut t: i64 = 0;
    let mut _e1: i64 = 0;
    let mut _e2: i64 = 0;
    s1 = (rs[(i) as usize] as i64);
    l1 = (rl[(i) as usize] as i64);
    l2 = (rl[((i + 1)) as usize] as i64);
    x = 0;
    _e1 = l1;
    while (x < _e1) {
        tmp[(x) as usize] = ((a[((s1 + x)) as usize] as i64)) as i32;
        x = (x + 1);
    }
    x = 0;
    j = (s1 + l1);
    k = s1;
    end = (j + l2);
    while ((x < l1) && (j < end)) {
        if ((a[(j) as usize] as i64) < (tmp[(x) as usize] as i64)) {
            a[(k) as usize] = ((a[(j) as usize] as i64)) as i32;
            j = (j + 1);
        } else {
            a[(k) as usize] = ((tmp[(x) as usize] as i64)) as i32;
            x = (x + 1);
        }
        k = (k + 1);
    }
    while (x < l1) {
        a[(k) as usize] = ((tmp[(x) as usize] as i64)) as i32;
        x = (x + 1);
        k = (k + 1);
    }
    rl[(i) as usize] = ((l1 + l2)) as i32;
    t = (i + 1);
    _e2 = (cnt - 1);
    while (t < _e2) {
        rs[(t) as usize] = ((rs[((t + 1)) as usize] as i64)) as i32;
        rl[(t) as usize] = ((rl[((t + 1)) as usize] as i64)) as i32;
        t = (t + 1);
    }
    return (cnt - 1);
}

fn tim_sort_x_collapse(a: &mut [i32], tmp: &mut [i32], rs: &mut [i32], rl: &mut [i32], mut cnt: i64) -> i64 {
    let mut going: i64 = 0;
    let mut m: i64 = 0;
    let mut need: i64 = 0;
    going = 1;
    while ((going == 1) && (cnt > 1)) {
        m = (cnt - 2);
        need = 0;
        if ((m > 0) && ((rl[((m - 1)) as usize] as i64) <= ((rl[(m) as usize] as i64) + (rl[((m + 1)) as usize] as i64)))) {
            need = 1;
        }
        if ((m > 1) && ((rl[((m - 2)) as usize] as i64) <= ((rl[((m - 1)) as usize] as i64) + (rl[(m) as usize] as i64)))) {
            need = 1;
        }
        if (need == 1) {
            if ((m > 0) && ((rl[((m - 1)) as usize] as i64) < (rl[((m + 1)) as usize] as i64))) {
                m = (m - 1);
            }
            cnt = tim_sort_x_merge_at(a, tmp, rs, rl, cnt, m);
        } else {
            if ((rl[(m) as usize] as i64) <= (rl[((m + 1)) as usize] as i64)) {
                cnt = tim_sort_x_merge_at(a, tmp, rs, rl, cnt, m);
            } else {
                going = 0;
            }
        }
    }
    return cnt;
}

fn tim_sort_impl(a: &mut [i32], mut n: i64) {
    let mut r: i64 = 0;
    let mut t: i64 = 0;
    let mut minrun: i64 = 0;
    let mut cnt: i64 = 0;
    let mut lo: i64 = 0;
    let mut e: i64 = 0;
    let mut x: i64 = 0;
    let mut y: i64 = 0;
    let mut force: i64 = 0;
    let mut m: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    if (n < 2) {
        return;
    }
    let mut tmp_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let tmp: &mut [i32] = &mut tmp_store[..];
    let mut rs_store: Vec<i32> = vec![0; std::cmp::max(1, 128) as usize]; let rs: &mut [i32] = &mut rs_store[..];
    let mut rl_store: Vec<i32> = vec![0; std::cmp::max(1, 128) as usize]; let rl: &mut [i32] = &mut rl_store[..];
    r = 0;
    t = n;
    while (t >= 64) {
        r = (r + (t % 2));
        if (r > 1) {
            r = 1;
        }
        t = (t / 2);
    }
    minrun = (t + r);
    cnt = 0;
    lo = 0;
    while (lo < n) {
        e = (lo + 1);
        if (e < n) {
            if ((a[(e) as usize] as i64) < (a[((e - 1)) as usize] as i64)) {
                while ((e < n) && ((a[(e) as usize] as i64) < (a[((e - 1)) as usize] as i64))) {
                    e = (e + 1);
                }
                x = lo;
                y = (e - 1);
                while (x < y) {
                    _i1 = x;
                    _i2 = y;
                    _t1 = (a[(_i1) as usize] as i64);
                    a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
                    a[(_i2) as usize] = (_t1) as i32;
                    x = (x + 1);
                    y = (y - 1);
                }
            } else {
                while ((e < n) && ((a[(e) as usize] as i64) >= (a[((e - 1)) as usize] as i64))) {
                    e = (e + 1);
                }
            }
        }
        force = std::cmp::min(minrun, (n - lo));
        if ((e - lo) < force) {
            tim_sort_x_insertion(a, lo, (lo + force));
            e = (lo + force);
        }
        rs[(cnt) as usize] = (lo) as i32;
        rl[(cnt) as usize] = ((e - lo)) as i32;
        cnt = (cnt + 1);
        cnt = tim_sort_x_collapse(a, tmp, rs, rl, cnt);
        lo = e;
    }
    while (cnt > 1) {
        m = (cnt - 2);
        if ((m > 0) && ((rl[((m - 1)) as usize] as i64) < (rl[((m + 1)) as usize] as i64))) {
            m = (m - 1);
        }
        cnt = tim_sort_x_merge_at(a, tmp, rs, rl, cnt, m);
    }
}

pub fn tim_sort(a: &mut [i32]) {
    tim_sort_impl(a, a.len() as i64);
}
