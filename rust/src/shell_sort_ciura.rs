// GENERATED from kernels/algos/shell_sort_ciura.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn shell_sort_ciura_impl(a: &mut [i32], mut n: i64) {
    let mut k: i64 = 0;
    let mut gap: i64 = 0;
    let mut i: i64 = 0;
    let mut key: i64 = 0;
    let mut j: i64 = 0;
    let mut _e1: i64 = 0;
    let mut g_store: Vec<i32> = vec![0; std::cmp::max(1, 10) as usize]; let g: &mut [i32] = &mut g_store[..];
    g[(0) as usize] = (1) as i32;
    g[(1) as usize] = (4) as i32;
    g[(2) as usize] = (10) as i32;
    g[(3) as usize] = (23) as i32;
    g[(4) as usize] = (57) as i32;
    g[(5) as usize] = (132) as i32;
    g[(6) as usize] = (301) as i32;
    g[(7) as usize] = (701) as i32;
    g[(8) as usize] = (1750) as i32;
    g[(9) as usize] = (4377) as i32;
    k = 9;
    while (k >= 0) {
        gap = (g[(k) as usize] as i64);
        if (gap < n) {
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
        }
        k = (k - 1);
    }
}

pub fn shell_sort_ciura(a: &mut [i32]) {
    shell_sort_ciura_impl(a, a.len() as i64);
}
