// GENERATED from kernels/algos/library_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn library_sort_x_locate(vals: &mut [i32], s: &mut [i32], mut size: i64, mut x: i64) -> i64 {
    let mut lo: i64 = 0;
    let mut hi: i64 = 0;
    let mut mid: i64 = 0;
    let mut m: i64 = 0;
    lo = 0;
    hi = (size - 1);
    while (lo <= hi) {
        mid = ((lo + hi) / 2);
        m = mid;
        while ((m <= hi) && ((s[(m) as usize] as i64) == 0)) {
            m = (m + 1);
        }
        if (m > hi) {
            hi = (mid - 1);
        } else {
            if (x < (vals[(((s[(m) as usize] as i64) - 1)) as usize] as i64)) {
                hi = (mid - 1);
            } else {
                lo = (m + 1);
            }
        }
    }
    return lo;
}

fn library_sort_impl(a: &mut [i32], mut n: i64) {
    let mut size: i64 = 0;
    let mut i: i64 = 0;
    let mut nextpow: i64 = 0;
    let mut k: i64 = 0;
    let mut cnt: i64 = 0;
    let mut j: i64 = 0;
    let mut lo: i64 = 0;
    let mut p: i64 = 0;
    let mut q: i64 = 0;
    let mut g: i64 = 0;
    let mut out: i64 = 0;
    let mut _e1: i64 = 0;
    let mut _e2: i64 = 0;
    let mut _e3: i64 = 0;
    let mut _e4: i64 = 0;
    let mut _e5: i64 = 0;
    let mut _e6: i64 = 0;
    if (n < 2) {
        return;
    }
    size = ((2 * n) + 2);
    let mut vals_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let vals: &mut [i32] = &mut vals_store[..];
    let mut s_store: Vec<i32> = vec![0; std::cmp::max(1, size) as usize]; let s: &mut [i32] = &mut s_store[..];
    let mut tmp_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let tmp: &mut [i32] = &mut tmp_store[..];
    i = 0;
    _e1 = n;
    while (i < _e1) {
        vals[(i) as usize] = ((a[(i) as usize] as i64)) as i32;
        i = (i + 1);
    }
    nextpow = 1;
    k = 0;
    _e2 = n;
    while (k < _e2) {
        if (k == nextpow) {
            nextpow = (nextpow * 2);
            cnt = 0;
            i = 0;
            _e3 = size;
            while (i < _e3) {
                if ((s[(i) as usize] as i64) != 0) {
                    tmp[(cnt) as usize] = ((s[(i) as usize] as i64)) as i32;
                    cnt = (cnt + 1);
                    s[(i) as usize] = (0) as i32;
                }
                i = (i + 1);
            }
            j = 0;
            _e4 = cnt;
            while (j < _e4) {
                s[(((j * size) / cnt)) as usize] = ((tmp[(j) as usize] as i64)) as i32;
                j = (j + 1);
            }
        }
        lo = library_sort_x_locate(vals, s, size, (vals[(k) as usize] as i64));
        p = (lo - 1);
        while ((p >= 0) && ((s[(p) as usize] as i64) == 0)) {
            p = (p - 1);
        }
        q = lo;
        while ((q < size) && ((s[(q) as usize] as i64) == 0)) {
            q = (q + 1);
        }
        if ((q - p) > 1) {
            s[(((p + q) / 2)) as usize] = ((k + 1)) as i32;
        } else {
            g = q;
            while ((g < size) && ((s[(g) as usize] as i64) != 0)) {
                g = (g + 1);
            }
            if (g < size) {
                j = g;
                while (j > q) {
                    s[(j) as usize] = ((s[((j - 1)) as usize] as i64)) as i32;
                    j = (j - 1);
                }
                s[(q) as usize] = ((k + 1)) as i32;
            } else {
                g = p;
                while ((s[(g) as usize] as i64) != 0) {
                    g = (g - 1);
                }
                j = g;
                while (j < p) {
                    s[(j) as usize] = ((s[((j + 1)) as usize] as i64)) as i32;
                    j = (j + 1);
                }
                s[(p) as usize] = ((k + 1)) as i32;
            }
        }
        k = (k + 1);
    }
    out = 0;
    i = 0;
    _e5 = size;
    while (i < _e5) {
        if ((s[(i) as usize] as i64) != 0) {
            tmp[(out) as usize] = ((vals[(((s[(i) as usize] as i64) - 1)) as usize] as i64)) as i32;
            out = (out + 1);
        }
        i = (i + 1);
    }
    i = 0;
    _e6 = n;
    while (i < _e6) {
        a[(i) as usize] = ((tmp[(i) as usize] as i64)) as i32;
        i = (i + 1);
    }
}

pub fn library_sort(a: &mut [i32]) {
    library_sort_impl(a, a.len() as i64);
}
