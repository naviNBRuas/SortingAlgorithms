// GENERATED from kernels/algos/bubble_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn bubble_sort_impl(a: &mut [i32], mut n: i64) {
    let mut end: i64 = 0;
    let mut swapped: i64 = 0;
    let mut j: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    end = (n - 1);
    swapped = 1;
    while ((end > 0) && (swapped == 1)) {
        swapped = 0;
        j = 0;
        while (j < end) {
            if ((a[(j) as usize] as i64) > (a[((j + 1)) as usize] as i64)) {
                _i1 = j;
                _i2 = (j + 1);
                _t1 = (a[(_i1) as usize] as i64);
                a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
                a[(_i2) as usize] = (_t1) as i32;
                swapped = 1;
            }
            j = (j + 1);
        }
        end = (end - 1);
    }
}

pub fn bubble_sort(a: &mut [i32]) {
    bubble_sort_impl(a, a.len() as i64);
}
