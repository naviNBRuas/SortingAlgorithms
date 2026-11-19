// GENERATED from kernels/algos/pigeonhole_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn pigeonhole_sort_x_fallback(a: &mut [i32], mut n: i64) {
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

fn pigeonhole_sort_impl(a: &mut [i32], mut n: i64) {
    let mut mn: i64 = 0;
    let mut mx: i64 = 0;
    let mut i: i64 = 0;
    let mut rng: i64 = 0;
    let mut k: i64 = 0;
    let mut h: i64 = 0;
    let mut c: i64 = 0;
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
        pigeonhole_sort_x_fallback(a, n);
        return;
    }
    let mut holes_store: Vec<i32> = vec![0; std::cmp::max(1, rng) as usize]; let holes: &mut [i32] = &mut holes_store[..];
    i = 0;
    _e2 = n;
    while (i < _e2) {
        holes[(((a[(i) as usize] as i64) - mn)) as usize] = (((holes[(((a[(i) as usize] as i64) - mn)) as usize] as i64) + 1)) as i32;
        i = (i + 1);
    }
    k = 0;
    h = 0;
    _e3 = rng;
    while (h < _e3) {
        c = (holes[(h) as usize] as i64);
        while (c > 0) {
            a[(k) as usize] = ((mn + h)) as i32;
            k = (k + 1);
            c = (c - 1);
        }
        h = (h + 1);
    }
}

pub fn pigeonhole_sort(a: &mut [i32]) {
    pigeonhole_sort_impl(a, a.len() as i64);
}
