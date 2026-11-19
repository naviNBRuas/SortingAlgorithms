// GENERATED from kernels/algos/pairwise_sorting_network.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn pairwise_sorting_network_x_cmp_swap(a: &mut [i32], mut i: i64, mut j: i64, mut n: i64) {
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    if (j < n) {
        if ((a[(i) as usize] as i64) > (a[(j) as usize] as i64)) {
            _i1 = i;
            _i2 = j;
            _t1 = (a[(_i1) as usize] as i64);
            a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
            a[(_i2) as usize] = (_t1) as i32;
        }
    }
}

fn pairwise_sorting_network_impl(a: &mut [i32], mut n: i64) {
    let mut size: i64 = 0;
    let mut step: i64 = 0;
    let mut b: i64 = 0;
    let mut c: i64 = 0;
    let mut e: i64 = 0;
    let mut d: i64 = 0;
    size = 1;
    while (size < n) {
        size = (size * 2);
    }
    step = 1;
    while (step < size) {
        b = step;
        c = 0;
        while (b < size) {
            pairwise_sorting_network_x_cmp_swap(a, (b - step), b, n);
            b = (b + 1);
            c = (c + 1);
            if (c >= step) {
                c = 0;
                b = (b + step);
            }
        }
        step = (step * 2);
    }
    step = (step / 4);
    e = 1;
    while (step > 0) {
        d = e;
        while (d > 0) {
            b = ((d + 1) * step);
            c = 0;
            while (b < size) {
                pairwise_sorting_network_x_cmp_swap(a, (b - (d * step)), b, n);
                b = (b + 1);
                c = (c + 1);
                if (c >= step) {
                    c = 0;
                    b = (b + step);
                }
            }
            d = (d / 2);
        }
        step = (step / 2);
        e = ((e * 2) + 1);
    }
}

pub fn pairwise_sorting_network(a: &mut [i32]) {
    pairwise_sorting_network_impl(a, a.len() as i64);
}
