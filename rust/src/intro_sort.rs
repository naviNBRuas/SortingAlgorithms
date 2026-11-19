// GENERATED from kernels/algos/intro_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn intro_sort_x_insertion(a: &mut [i32], mut lo: i64, mut hi: i64) {
    let mut i: i64 = 0;
    let mut key: i64 = 0;
    let mut j: i64 = 0;
    let mut _e1: i64 = 0;
    i = (lo + 1);
    _e1 = (hi + 1);
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

fn intro_sort_x_sift(a: &mut [i32], mut base: i64, mut root: i64, mut size: i64) {
    let mut going: i64 = 0;
    let mut child: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    going = 1;
    while (going == 1) {
        child = ((2 * root) + 1);
        if (child >= size) {
            going = 0;
        } else {
            if (((child + 1) < size) && ((a[((base + child)) as usize] as i64) < (a[(((base + child) + 1)) as usize] as i64))) {
                child = (child + 1);
            }
            if ((a[((base + root)) as usize] as i64) < (a[((base + child)) as usize] as i64)) {
                _i1 = (base + root);
                _i2 = (base + child);
                _t1 = (a[(_i1) as usize] as i64);
                a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
                a[(_i2) as usize] = (_t1) as i32;
                root = child;
            } else {
                going = 0;
            }
        }
    }
}

fn intro_sort_x_heap(a: &mut [i32], mut lo: i64, mut hi: i64) {
    let mut size: i64 = 0;
    let mut s: i64 = 0;
    let mut end: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    size = ((hi - lo) + 1);
    s = (size / 2);
    while (s > 0) {
        s = (s - 1);
        intro_sort_x_sift(a, lo, s, size);
    }
    end = (size - 1);
    while (end > 0) {
        _i1 = lo;
        _i2 = (lo + end);
        _t1 = (a[(_i1) as usize] as i64);
        a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
        a[(_i2) as usize] = (_t1) as i32;
        intro_sort_x_sift(a, lo, 0, end);
        end = (end - 1);
    }
}

fn intro_sort_x_sort(a: &mut [i32], mut lo: i64, mut hi: i64, mut depth: i64) {
    let mut mid: i64 = 0;
    let mut pivot: i64 = 0;
    let mut i: i64 = 0;
    let mut j: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    while (((hi - lo) + 1) > 16) {
        if (depth == 0) {
            intro_sort_x_heap(a, lo, hi);
            return;
        }
        depth = (depth - 1);
        mid = ((lo + hi) / 2);
        if ((a[(mid) as usize] as i64) < (a[(lo) as usize] as i64)) {
            _i1 = mid;
            _i2 = lo;
            _t1 = (a[(_i1) as usize] as i64);
            a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
            a[(_i2) as usize] = (_t1) as i32;
        }
        if ((a[(hi) as usize] as i64) < (a[(lo) as usize] as i64)) {
            _i1 = hi;
            _i2 = lo;
            _t1 = (a[(_i1) as usize] as i64);
            a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
            a[(_i2) as usize] = (_t1) as i32;
        }
        if ((a[(hi) as usize] as i64) < (a[(mid) as usize] as i64)) {
            _i1 = hi;
            _i2 = mid;
            _t1 = (a[(_i1) as usize] as i64);
            a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
            a[(_i2) as usize] = (_t1) as i32;
        }
        pivot = (a[(mid) as usize] as i64);
        i = lo;
        j = hi;
        while (i <= j) {
            while ((a[(i) as usize] as i64) < pivot) {
                i = (i + 1);
            }
            while ((a[(j) as usize] as i64) > pivot) {
                j = (j - 1);
            }
            if (i <= j) {
                _i1 = i;
                _i2 = j;
                _t1 = (a[(_i1) as usize] as i64);
                a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
                a[(_i2) as usize] = (_t1) as i32;
                i = (i + 1);
                j = (j - 1);
            }
        }
        intro_sort_x_sort(a, lo, j, depth);
        lo = i;
    }
    intro_sort_x_insertion(a, lo, hi);
}

fn intro_sort_impl(a: &mut [i32], mut n: i64) {
    let mut depth: i64 = 0;
    let mut t: i64 = 0;
    depth = 0;
    t = n;
    while (t > 1) {
        t = (t / 2);
        depth = (depth + 2);
    }
    intro_sort_x_sort(a, 0, (n - 1), depth);
}

pub fn intro_sort(a: &mut [i32]) {
    intro_sort_impl(a, a.len() as i64);
}
