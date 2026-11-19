// GENERATED from kernels/algos/shell_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn shell_sort_impl(a: &mut [i32], mut n: i64) {
    let mut gap: i64 = 0;
    let mut i: i64 = 0;
    let mut key: i64 = 0;
    let mut j: i64 = 0;
    let mut _e1: i64 = 0;
    gap = (n / 2);
    while (gap > 0) {
        i = gap;
        _e1 = n;
        while (i < _e1) {
            key = (a[(i) as usize] as i64);
            j = i;
            while ((j >= gap) && ((a[((j - gap)) as usize] as i64) > key)) {
                a[(j) as usize] = ((a[((j - gap)) as usize] as i64)) as i32;
                j = (j - gap);
            }
            a[(j) as usize] = (key) as i32;
            i = (i + 1);
        }
        gap = (gap / 2);
    }
}

pub fn shell_sort(a: &mut [i32]) {
    shell_sort_impl(a, a.len() as i64);
}
