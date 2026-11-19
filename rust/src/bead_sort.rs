// GENERATED from kernels/algos/bead_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn bead_sort_x_fallback(a: &mut [i32], mut n: i64) {
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

fn bead_sort_impl(a: &mut [i32], mut n: i64) {
    let mut mn: i64 = 0;
    let mut mx: i64 = 0;
    let mut i: i64 = 0;
    let mut maxv: i64 = 0;
    let mut r: i64 = 0;
    let mut level: i64 = 0;
    let mut k: i64 = 0;
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
    maxv = (mx - mn);
    if (maxv > 20000) {
        bead_sort_x_fallback(a, n);
        return;
    }
    let mut ge_store: Vec<i32> = vec![0; std::cmp::max(1, (maxv + 2)) as usize]; let ge: &mut [i32] = &mut ge_store[..];
    let mut rods_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let rods: &mut [i32] = &mut rods_store[..];
    i = 0;
    _e2 = n;
    while (i < _e2) {
        ge[(((a[(i) as usize] as i64) - mn)) as usize] = (((ge[(((a[(i) as usize] as i64) - mn)) as usize] as i64) + 1)) as i32;
        i = (i + 1);
    }
    r = maxv;
    while (r > 0) {
        r = (r - 1);
        ge[(r) as usize] = (((ge[(r) as usize] as i64) + (ge[((r + 1)) as usize] as i64))) as i32;
    }
    level = 1;
    _e3 = (maxv + 1);
    while (level < _e3) {
        k = 0;
        _e4 = (ge[(level) as usize] as i64);
        while (k < _e4) {
            rods[(((n - 1) - k)) as usize] = (((rods[(((n - 1) - k)) as usize] as i64) + 1)) as i32;
            k = (k + 1);
        }
        level = (level + 1);
    }
    i = 0;
    _e5 = n;
    while (i < _e5) {
        a[(i) as usize] = (((rods[(i) as usize] as i64) + mn)) as i32;
        i = (i + 1);
    }
}

pub fn bead_sort(a: &mut [i32]) {
    bead_sort_impl(a, a.len() as i64);
}
