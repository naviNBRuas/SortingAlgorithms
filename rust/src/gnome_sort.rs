// GENERATED from kernels/algos/gnome_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn gnome_sort_impl(a: &mut [i32], mut n: i64) {
    let mut i: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    i = 0;
    while (i < n) {
        if ((i == 0) || ((a[((i - 1)) as usize] as i64) <= (a[(i) as usize] as i64))) {
            i = (i + 1);
        } else {
            _i1 = (i - 1);
            _i2 = i;
            _t1 = (a[(_i1) as usize] as i64);
            a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
            a[(_i2) as usize] = (_t1) as i32;
            i = (i - 1);
        }
    }
}

pub fn gnome_sort(a: &mut [i32]) {
    gnome_sort_impl(a, a.len() as i64);
}
