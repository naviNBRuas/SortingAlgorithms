// GENERATED from kernels/algos/quick_sort_3way.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn quick_sort_3way_x_qs(a: &mut [i32], mut lo: i64, mut hi: i64) {
    let mut pivot: i64 = 0;
    let mut lt: i64 = 0;
    let mut i: i64 = 0;
    let mut gt: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    while (lo < hi) {
        pivot = (a[(((lo + hi) / 2)) as usize] as i64);
        lt = lo;
        i = lo;
        gt = hi;
        while (i <= gt) {
            if ((a[(i) as usize] as i64) < pivot) {
                _i1 = lt;
                _i2 = i;
                _t1 = (a[(_i1) as usize] as i64);
                a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
                a[(_i2) as usize] = (_t1) as i32;
                lt = (lt + 1);
                i = (i + 1);
            } else {
                if ((a[(i) as usize] as i64) > pivot) {
                    _i1 = i;
                    _i2 = gt;
                    _t1 = (a[(_i1) as usize] as i64);
                    a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
                    a[(_i2) as usize] = (_t1) as i32;
                    gt = (gt - 1);
                } else {
                    i = (i + 1);
                }
            }
        }
        if ((lt - lo) < (hi - gt)) {
            quick_sort_3way_x_qs(a, lo, (lt - 1));
            lo = (gt + 1);
        } else {
            quick_sort_3way_x_qs(a, (gt + 1), hi);
            hi = (lt - 1);
        }
    }
}

fn quick_sort_3way_impl(a: &mut [i32], mut n: i64) {
    quick_sort_3way_x_qs(a, 0, (n - 1));
}

pub fn quick_sort_3way(a: &mut [i32]) {
    quick_sort_3way_impl(a, a.len() as i64);
}
