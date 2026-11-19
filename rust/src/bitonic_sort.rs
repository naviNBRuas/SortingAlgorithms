// GENERATED from kernels/algos/bitonic_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn bitonic_sort_x_cmp_swap(a: &mut [i32], mut i: i64, mut j: i64) {
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    if ((a[(i) as usize] as i64) > (a[(j) as usize] as i64)) {
        _i1 = i;
        _i2 = j;
        _t1 = (a[(_i1) as usize] as i64);
        a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
        a[(_i2) as usize] = (_t1) as i32;
    }
}

fn bitonic_sort_impl(a: &mut [i32], mut n: i64) {
    let mut size: i64 = 0;
    let mut k: i64 = 0;
    let mut blk: i64 = 0;
    let mut t: i64 = 0;
    let mut j: i64 = 0;
    let mut i: i64 = 0;
    let mut _e1: i64 = 0;
    let mut _e2: i64 = 0;
    size = 1;
    while (size < n) {
        size = (size * 2);
    }
    k = 2;
    while (k <= size) {
        blk = 0;
        while (blk < size) {
            t = 0;
            _e1 = (k / 2);
            while (t < _e1) {
                j = (((blk + k) - 1) - t);
                if (j < n) {
                    bitonic_sort_x_cmp_swap(a, (blk + t), j);
                }
                t = (t + 1);
            }
            blk = (blk + k);
        }
        j = (k / 4);
        while (j >= 1) {
            i = 0;
            _e2 = size;
            while (i < _e2) {
                if ((((i / j) % 2) == 0) && ((i + j) < n)) {
                    bitonic_sort_x_cmp_swap(a, i, (i + j));
                }
                i = (i + 1);
            }
            j = (j / 2);
        }
        k = (k * 2);
    }
}

pub fn bitonic_sort(a: &mut [i32]) {
    bitonic_sort_impl(a, a.len() as i64);
}
