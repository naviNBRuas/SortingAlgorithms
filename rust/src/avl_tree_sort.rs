// GENERATED from kernels/algos/avl_tree_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn avl_tree_sort_x_height(ht: &mut [i32], mut t: i64) -> i64 {
    if (t == 0) {
        return 0;
    }
    return (ht[((t - 1)) as usize] as i64);
}

fn avl_tree_sort_x_fix(lc: &mut [i32], rc: &mut [i32], ht: &mut [i32], mut t: i64) {
    ht[((t - 1)) as usize] = ((1 + std::cmp::max(avl_tree_sort_x_height(ht, (lc[((t - 1)) as usize] as i64)), avl_tree_sort_x_height(ht, (rc[((t - 1)) as usize] as i64))))) as i32;
}

fn avl_tree_sort_x_rot_right(lc: &mut [i32], rc: &mut [i32], ht: &mut [i32], mut y: i64) -> i64 {
    let mut x: i64 = 0;
    x = (lc[((y - 1)) as usize] as i64);
    lc[((y - 1)) as usize] = ((rc[((x - 1)) as usize] as i64)) as i32;
    rc[((x - 1)) as usize] = (y) as i32;
    avl_tree_sort_x_fix(lc, rc, ht, y);
    avl_tree_sort_x_fix(lc, rc, ht, x);
    return x;
}

fn avl_tree_sort_x_rot_left(lc: &mut [i32], rc: &mut [i32], ht: &mut [i32], mut x: i64) -> i64 {
    let mut y: i64 = 0;
    y = (rc[((x - 1)) as usize] as i64);
    rc[((x - 1)) as usize] = ((lc[((y - 1)) as usize] as i64)) as i32;
    lc[((y - 1)) as usize] = (x) as i32;
    avl_tree_sort_x_fix(lc, rc, ht, x);
    avl_tree_sort_x_fix(lc, rc, ht, y);
    return y;
}

fn avl_tree_sort_x_insert(vals: &mut [i32], lc: &mut [i32], rc: &mut [i32], ht: &mut [i32], mut t: i64, mut v: i64) -> i64 {
    let mut bal: i64 = 0;
    let mut l: i64 = 0;
    let mut r: i64 = 0;
    if (t == 0) {
        ht[(v) as usize] = (1) as i32;
        return (v + 1);
    }
    if ((vals[(v) as usize] as i64) < (vals[((t - 1)) as usize] as i64)) {
        lc[((t - 1)) as usize] = (avl_tree_sort_x_insert(vals, lc, rc, ht, (lc[((t - 1)) as usize] as i64), v)) as i32;
    } else {
        rc[((t - 1)) as usize] = (avl_tree_sort_x_insert(vals, lc, rc, ht, (rc[((t - 1)) as usize] as i64), v)) as i32;
    }
    avl_tree_sort_x_fix(lc, rc, ht, t);
    bal = (avl_tree_sort_x_height(ht, (lc[((t - 1)) as usize] as i64)) - avl_tree_sort_x_height(ht, (rc[((t - 1)) as usize] as i64)));
    if (bal > 1) {
        l = (lc[((t - 1)) as usize] as i64);
        if (avl_tree_sort_x_height(ht, (lc[((l - 1)) as usize] as i64)) < avl_tree_sort_x_height(ht, (rc[((l - 1)) as usize] as i64))) {
            lc[((t - 1)) as usize] = (avl_tree_sort_x_rot_left(lc, rc, ht, l)) as i32;
        }
        return avl_tree_sort_x_rot_right(lc, rc, ht, t);
    }
    if (bal < (-1)) {
        r = (rc[((t - 1)) as usize] as i64);
        if (avl_tree_sort_x_height(ht, (rc[((r - 1)) as usize] as i64)) < avl_tree_sort_x_height(ht, (lc[((r - 1)) as usize] as i64))) {
            rc[((t - 1)) as usize] = (avl_tree_sort_x_rot_right(lc, rc, ht, r)) as i32;
        }
        return avl_tree_sort_x_rot_left(lc, rc, ht, t);
    }
    return t;
}

fn avl_tree_sort_impl(a: &mut [i32], mut n: i64) {
    let mut i: i64 = 0;
    let mut root: i64 = 0;
    let mut node: i64 = 0;
    let mut sp: i64 = 0;
    let mut out: i64 = 0;
    let mut _e1: i64 = 0;
    let mut _e2: i64 = 0;
    if (n < 2) {
        return;
    }
    let mut vals_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let vals: &mut [i32] = &mut vals_store[..];
    let mut lc_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let lc: &mut [i32] = &mut lc_store[..];
    let mut rc_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let rc: &mut [i32] = &mut rc_store[..];
    let mut ht_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let ht: &mut [i32] = &mut ht_store[..];
    let mut stack_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let stack: &mut [i32] = &mut stack_store[..];
    i = 0;
    _e1 = n;
    while (i < _e1) {
        vals[(i) as usize] = ((a[(i) as usize] as i64)) as i32;
        i = (i + 1);
    }
    root = 0;
    i = 0;
    _e2 = n;
    while (i < _e2) {
        root = avl_tree_sort_x_insert(vals, lc, rc, ht, root, i);
        i = (i + 1);
    }
    node = root;
    sp = 0;
    out = 0;
    while ((node != 0) || (sp > 0)) {
        if (node != 0) {
            stack[(sp) as usize] = (node) as i32;
            sp = (sp + 1);
            node = (lc[((node - 1)) as usize] as i64);
        } else {
            sp = (sp - 1);
            node = (stack[(sp) as usize] as i64);
            a[(out) as usize] = ((vals[((node - 1)) as usize] as i64)) as i32;
            out = (out + 1);
            node = (rc[((node - 1)) as usize] as i64);
        }
    }
}

pub fn avl_tree_sort(a: &mut [i32]) {
    avl_tree_sort_impl(a, a.len() as i64);
}
