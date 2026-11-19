// GENERATED from kernels/algos/smooth_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn smooth_sort_x_tz(mut x: i64) -> i64 {
    let mut c: i64 = 0;
    c = 0;
    while ((x % 2) == 0) {
        x = (x / 2);
        c = (c + 1);
    }
    return c;
}

fn smooth_sort_x_pow2(mut k: i64) -> i64 {
    let mut r: i64 = 0;
    let mut i: i64 = 0;
    let mut _e1: i64 = 0;
    r = 1;
    i = 0;
    _e1 = k;
    while (i < _e1) {
        r = (r * 2);
        i = (i + 1);
    }
    return r;
}

fn smooth_sort_x_sift(a: &mut [i32], lp: &mut [i32], mut head: i64, mut pshift: i64) {
    let mut val: i64 = 0;
    let mut going: i64 = 0;
    let mut rt: i64 = 0;
    let mut lf: i64 = 0;
    val = (a[(head) as usize] as i64);
    going = 1;
    while ((pshift > 1) && (going == 1)) {
        rt = (head - 1);
        lf = ((head - 1) - (lp[((pshift - 2)) as usize] as i64));
        if ((val >= (a[(lf) as usize] as i64)) && (val >= (a[(rt) as usize] as i64))) {
            going = 0;
        } else {
            if ((a[(lf) as usize] as i64) >= (a[(rt) as usize] as i64)) {
                a[(head) as usize] = ((a[(lf) as usize] as i64)) as i32;
                head = lf;
                pshift = (pshift - 1);
            } else {
                a[(head) as usize] = ((a[(rt) as usize] as i64)) as i32;
                head = rt;
                pshift = (pshift - 2);
            }
        }
    }
    a[(head) as usize] = (val) as i32;
}

fn smooth_sort_x_trinkle(a: &mut [i32], lp: &mut [i32], mut head: i64, mut p: i64, mut pshift: i64, mut trusty: i64) {
    let mut val: i64 = 0;
    let mut going: i64 = 0;
    let mut stepson: i64 = 0;
    let mut stop: i64 = 0;
    let mut rt: i64 = 0;
    let mut lf: i64 = 0;
    let mut trail: i64 = 0;
    val = (a[(head) as usize] as i64);
    going = 1;
    while ((p != 1) && (going == 1)) {
        stepson = (head - (lp[(pshift) as usize] as i64));
        if ((a[(stepson) as usize] as i64) <= val) {
            going = 0;
        } else {
            stop = 0;
            if ((trusty == 0) && (pshift > 1)) {
                rt = (head - 1);
                lf = ((head - 1) - (lp[((pshift - 2)) as usize] as i64));
                if (((a[(rt) as usize] as i64) >= (a[(stepson) as usize] as i64)) || ((a[(lf) as usize] as i64) >= (a[(stepson) as usize] as i64))) {
                    stop = 1;
                }
            }
            if (stop == 1) {
                going = 0;
            } else {
                a[(head) as usize] = ((a[(stepson) as usize] as i64)) as i32;
                head = stepson;
                trail = smooth_sort_x_tz((p - (p % 2)));
                p = (p / smooth_sort_x_pow2(trail));
                pshift = (pshift + trail);
                trusty = 0;
            }
        }
    }
    if (trusty == 0) {
        a[(head) as usize] = (val) as i32;
        smooth_sort_x_sift(a, lp, head, pshift);
    }
}

fn smooth_sort_impl(a: &mut [i32], mut n: i64) {
    let mut i: i64 = 0;
    let mut hi: i64 = 0;
    let mut head: i64 = 0;
    let mut p: i64 = 0;
    let mut pshift: i64 = 0;
    let mut trail: i64 = 0;
    let mut _e1: i64 = 0;
    if (n < 2) {
        return;
    }
    let mut lp_store: Vec<i32> = vec![0; std::cmp::max(1, 64) as usize]; let lp: &mut [i32] = &mut lp_store[..];
    lp[(0) as usize] = (1) as i32;
    lp[(1) as usize] = (1) as i32;
    i = 2;
    _e1 = 64;
    while (i < _e1) {
        lp[(i) as usize] = ((((lp[((i - 1)) as usize] as i64) + (lp[((i - 2)) as usize] as i64)) + 1)) as i32;
        i = (i + 1);
    }
    hi = (n - 1);
    head = 0;
    p = 1;
    pshift = 1;
    while (head < hi) {
        if ((p % 4) == 3) {
            smooth_sort_x_sift(a, lp, head, pshift);
            p = (p / 4);
            pshift = (pshift + 2);
        } else {
            if ((lp[((pshift - 1)) as usize] as i64) >= (hi - head)) {
                smooth_sort_x_trinkle(a, lp, head, p, pshift, 0);
            } else {
                smooth_sort_x_sift(a, lp, head, pshift);
            }
            if (pshift == 1) {
                p = (p * 2);
                pshift = 0;
            } else {
                p = (p * smooth_sort_x_pow2((pshift - 1)));
                pshift = 1;
            }
        }
        p = ((p + 1) - (p % 2));
        head = (head + 1);
    }
    smooth_sort_x_trinkle(a, lp, head, p, pshift, 0);
    while ((pshift != 1) || (p != 1)) {
        if (pshift <= 1) {
            trail = smooth_sort_x_tz((p - (p % 2)));
            p = (p / smooth_sort_x_pow2(trail));
            pshift = (pshift + trail);
        } else {
            p = (p * 4);
            if (((p / 4) % 2) == 0) {
                p = (p + 7);
            } else {
                p = (p - 1);
            }
            pshift = (pshift - 2);
            smooth_sort_x_trinkle(a, lp, ((head - (lp[(pshift) as usize] as i64)) - 1), (p / 2), (pshift + 1), 1);
            smooth_sort_x_trinkle(a, lp, (head - 1), p, pshift, 1);
        }
        head = (head - 1);
    }
}

pub fn smooth_sort(a: &mut [i32]) {
    smooth_sort_impl(a, a.len() as i64);
}
