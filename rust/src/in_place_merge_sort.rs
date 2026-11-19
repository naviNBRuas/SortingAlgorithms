// GENERATED from kernels/algos/in_place_merge_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn in_place_merge_sort_x_reverse(a: &mut [i32], mut i: i64, mut j: i64) {
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    j = (j - 1);
    while (i < j) {
        _i1 = i;
        _i2 = j;
        _t1 = (a[(_i1) as usize] as i64);
        a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
        a[(_i2) as usize] = (_t1) as i32;
        i = (i + 1);
        j = (j - 1);
    }
}

fn in_place_merge_sort_x_rotate(a: &mut [i32], mut i: i64, mut m: i64, mut j: i64) {
    in_place_merge_sort_x_reverse(a, i, m);
    in_place_merge_sort_x_reverse(a, m, j);
    in_place_merge_sort_x_reverse(a, i, j);
}

fn in_place_merge_sort_x_merge(a: &mut [i32], mut lo: i64, mut mid: i64, mut hi: i64) {
    let mut i: i64 = 0;
    let mut pivot: i64 = 0;
    let mut l: i64 = 0;
    let mut h: i64 = 0;
    let mut m: i64 = 0;
    let mut j: i64 = 0;
    let mut nm: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    if ((lo >= mid) || (mid >= hi)) {
        return;
    }
    if ((hi - lo) == 2) {
        if ((a[(mid) as usize] as i64) < (a[(lo) as usize] as i64)) {
            _i1 = lo;
            _i2 = mid;
            _t1 = (a[(_i1) as usize] as i64);
            a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
            a[(_i2) as usize] = (_t1) as i32;
        }
        return;
    }
    if ((mid - lo) >= (hi - mid)) {
        i = ((lo + mid) / 2);
        pivot = (a[(i) as usize] as i64);
        l = mid;
        h = hi;
        while (l < h) {
            m = ((l + h) / 2);
            if ((a[(m) as usize] as i64) < pivot) {
                l = (m + 1);
            } else {
                h = m;
            }
        }
        j = l;
        in_place_merge_sort_x_rotate(a, i, mid, j);
        nm = (i + (j - mid));
        in_place_merge_sort_x_merge(a, lo, i, nm);
        in_place_merge_sort_x_merge(a, (nm + 1), j, hi);
    } else {
        j = ((mid + hi) / 2);
        pivot = (a[(j) as usize] as i64);
        l = lo;
        h = mid;
        while (l < h) {
            m = ((l + h) / 2);
            if (pivot < (a[(m) as usize] as i64)) {
                h = m;
            } else {
                l = (m + 1);
            }
        }
        i = l;
        in_place_merge_sort_x_rotate(a, i, mid, (j + 1));
        nm = (i + ((j + 1) - mid));
        in_place_merge_sort_x_merge(a, lo, i, (nm - 1));
        in_place_merge_sort_x_merge(a, nm, (j + 1), hi);
    }
}

fn in_place_merge_sort_x_rec(a: &mut [i32], mut lo: i64, mut hi: i64) {
    let mut mid: i64 = 0;
    if ((hi - lo) < 2) {
        return;
    }
    mid = ((lo + hi) / 2);
    in_place_merge_sort_x_rec(a, lo, mid);
    in_place_merge_sort_x_rec(a, mid, hi);
    in_place_merge_sort_x_merge(a, lo, mid, hi);
}

fn in_place_merge_sort_impl(a: &mut [i32], mut n: i64) {
    in_place_merge_sort_x_rec(a, 0, n);
}

pub fn in_place_merge_sort(a: &mut [i32]) {
    in_place_merge_sort_impl(a, a.len() as i64);
}
