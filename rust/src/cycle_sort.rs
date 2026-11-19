// GENERATED from kernels/algos/cycle_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn cycle_sort_x_rank_of(a: &mut [i32], mut n: i64, mut start: i64, mut item: i64) -> i64 {
    let mut pos: i64 = 0;
    let mut i: i64 = 0;
    let mut _e1: i64 = 0;
    pos = start;
    i = (start + 1);
    _e1 = n;
    while (i < _e1) {
        if ((a[(i) as usize] as i64) < item) {
            pos = (pos + 1);
        }
        i = (i + 1);
    }
    return pos;
}

fn cycle_sort_impl(a: &mut [i32], mut n: i64) {
    let mut start: i64 = 0;
    let mut item: i64 = 0;
    let mut pos: i64 = 0;
    let mut tmp: i64 = 0;
    let mut _e1: i64 = 0;
    start = 0;
    _e1 = (n - 1);
    while (start < _e1) {
        item = (a[(start) as usize] as i64);
        pos = cycle_sort_x_rank_of(a, n, start, item);
        if (pos != start) {
            while (item == (a[(pos) as usize] as i64)) {
                pos = (pos + 1);
            }
            tmp = (a[(pos) as usize] as i64);
            a[(pos) as usize] = (item) as i32;
            item = tmp;
            while (pos != start) {
                pos = cycle_sort_x_rank_of(a, n, start, item);
                while (item == (a[(pos) as usize] as i64)) {
                    pos = (pos + 1);
                }
                tmp = (a[(pos) as usize] as i64);
                a[(pos) as usize] = (item) as i32;
                item = tmp;
            }
        }
        start = (start + 1);
    }
}

pub fn cycle_sort(a: &mut [i32]) {
    cycle_sort_impl(a, a.len() as i64);
}
