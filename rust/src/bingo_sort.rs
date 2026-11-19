// GENERATED from kernels/algos/bingo_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn bingo_sort_impl(a: &mut [i32], mut n: i64) {
    let mut mx: i64 = 0;
    let mut nxt: i64 = 0;
    let mut i: i64 = 0;
    let mut bingo: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    if (n < 2) {
        return;
    }
    mx = (n - 1);
    nxt = (a[(mx) as usize] as i64);
    i = (mx - 1);
    while (i >= 0) {
        if ((a[(i) as usize] as i64) > nxt) {
            nxt = (a[(i) as usize] as i64);
        }
        i = (i - 1);
    }
    while ((mx > 0) && ((a[(mx) as usize] as i64) == nxt)) {
        mx = (mx - 1);
    }
    while (mx > 0) {
        bingo = nxt;
        nxt = (a[(mx) as usize] as i64);
        i = (mx - 1);
        while (i >= 0) {
            if ((a[(i) as usize] as i64) == bingo) {
                _i1 = i;
                _i2 = mx;
                _t1 = (a[(_i1) as usize] as i64);
                a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
                a[(_i2) as usize] = (_t1) as i32;
                mx = (mx - 1);
            } else {
                if ((a[(i) as usize] as i64) > nxt) {
                    nxt = (a[(i) as usize] as i64);
                }
            }
            i = (i - 1);
        }
        while ((mx > 0) && ((a[(mx) as usize] as i64) == nxt)) {
            mx = (mx - 1);
        }
    }
}

pub fn bingo_sort(a: &mut [i32]) {
    bingo_sort_impl(a, a.len() as i64);
}
