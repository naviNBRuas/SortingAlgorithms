// GENERATED from kernels/algos/insertion_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn insertion_sort_impl(a: &mut [i32], mut n: i64) {
    let mut i: i64 = 0;
    let mut key: i64 = 0;
    let mut j: i64 = 0;
    let mut _e1: i64 = 0;
    i = 1;
    _e1 = n;
    while (i < _e1) {
        key = (a[(i) as usize] as i64);
        j = (i - 1);
        while ((j >= 0) && ((a[(j) as usize] as i64) > key)) {
            a[((j + 1)) as usize] = ((a[(j) as usize] as i64)) as i32;
            j = (j - 1);
        }
        a[((j + 1)) as usize] = (key) as i32;
        i = (i + 1);
    }
}

pub fn insertion_sort(a: &mut [i32]) {
    insertion_sort_impl(a, a.len() as i64);
}
