// GENERATED from kernels/algos/tree_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn tree_sort_impl(a: &mut [i32], mut n: i64) {
    let mut i: i64 = 0;
    let mut cur: i64 = 0;
    let mut placed: i64 = 0;
    let mut node: i64 = 0;
    let mut sp: i64 = 0;
    let mut out: i64 = 0;
    let mut _e1: i64 = 0;
    let mut _e2: i64 = 0;
    if (n < 2) {
        return;
    }
    let mut vals_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let vals: &mut [i32] = &mut vals_store[..];
    let mut left_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let left: &mut [i32] = &mut left_store[..];
    let mut right_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let right: &mut [i32] = &mut right_store[..];
    let mut stack_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let stack: &mut [i32] = &mut stack_store[..];
    i = 0;
    _e1 = n;
    while (i < _e1) {
        vals[(i) as usize] = ((a[(i) as usize] as i64)) as i32;
        i = (i + 1);
    }
    i = 1;
    _e2 = n;
    while (i < _e2) {
        cur = 0;
        placed = 0;
        while (placed == 0) {
            if ((vals[(i) as usize] as i64) < (vals[(cur) as usize] as i64)) {
                if ((left[(cur) as usize] as i64) == 0) {
                    left[(cur) as usize] = ((i + 1)) as i32;
                    placed = 1;
                } else {
                    cur = ((left[(cur) as usize] as i64) - 1);
                }
            } else {
                if ((right[(cur) as usize] as i64) == 0) {
                    right[(cur) as usize] = ((i + 1)) as i32;
                    placed = 1;
                } else {
                    cur = ((right[(cur) as usize] as i64) - 1);
                }
            }
        }
        i = (i + 1);
    }
    node = 1;
    sp = 0;
    out = 0;
    while ((node != 0) || (sp > 0)) {
        if (node != 0) {
            stack[(sp) as usize] = (node) as i32;
            sp = (sp + 1);
            node = (left[((node - 1)) as usize] as i64);
        } else {
            sp = (sp - 1);
            node = (stack[(sp) as usize] as i64);
            a[(out) as usize] = ((vals[((node - 1)) as usize] as i64)) as i32;
            out = (out + 1);
            node = (right[((node - 1)) as usize] as i64);
        }
    }
}

pub fn tree_sort(a: &mut [i32]) {
    tree_sort_impl(a, a.len() as i64);
}
