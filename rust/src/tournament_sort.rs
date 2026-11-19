// GENERATED from kernels/algos/tournament_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn tournament_sort_x_better(vals: &mut [i32], mut x: i64, mut y: i64) -> i64 {
    if (x < 0) {
        return y;
    }
    if (y < 0) {
        return x;
    }
    if ((vals[(x) as usize] as i64) <= (vals[(y) as usize] as i64)) {
        return x;
    }
    return y;
}

fn tournament_sort_impl(a: &mut [i32], mut n: i64) {
    let mut size: i64 = 0;
    let mut i: i64 = 0;
    let mut k: i64 = 0;
    let mut w: i64 = 0;
    let mut node: i64 = 0;
    let mut _e1: i64 = 0;
    let mut _e2: i64 = 0;
    let mut _e3: i64 = 0;
    let mut _e4: i64 = 0;
    if (n < 2) {
        return;
    }
    size = 1;
    while (size < n) {
        size = (size * 2);
    }
    let mut vals_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let vals: &mut [i32] = &mut vals_store[..];
    let mut out_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let out: &mut [i32] = &mut out_store[..];
    let mut tree_store: Vec<i32> = vec![0; std::cmp::max(1, (2 * size)) as usize]; let tree: &mut [i32] = &mut tree_store[..];
    i = 0;
    _e1 = (2 * size);
    while (i < _e1) {
        tree[(i) as usize] = ((-1)) as i32;
        i = (i + 1);
    }
    i = 0;
    _e2 = n;
    while (i < _e2) {
        vals[(i) as usize] = ((a[(i) as usize] as i64)) as i32;
        tree[((size + i)) as usize] = (i) as i32;
        i = (i + 1);
    }
    i = (size - 1);
    while (i >= 1) {
        tree[(i) as usize] = (tournament_sort_x_better(vals, (tree[((2 * i)) as usize] as i64), (tree[(((2 * i) + 1)) as usize] as i64))) as i32;
        i = (i - 1);
    }
    k = 0;
    _e3 = n;
    while (k < _e3) {
        w = (tree[(1) as usize] as i64);
        out[(k) as usize] = ((vals[(w) as usize] as i64)) as i32;
        node = (size + w);
        tree[(node) as usize] = ((-1)) as i32;
        node = (node / 2);
        while (node >= 1) {
            tree[(node) as usize] = (tournament_sort_x_better(vals, (tree[((2 * node)) as usize] as i64), (tree[(((2 * node) + 1)) as usize] as i64))) as i32;
            node = (node / 2);
        }
        k = (k + 1);
    }
    i = 0;
    _e4 = n;
    while (i < _e4) {
        a[(i) as usize] = ((out[(i) as usize] as i64)) as i32;
        i = (i + 1);
    }
}

pub fn tournament_sort(a: &mut [i32]) {
    tournament_sort_impl(a, a.len() as i64);
}
