// GENERATED from kernels/algos/cartesian_tree_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn cartesian_tree_sort_x_sift_up(vals: &mut [i32], heap: &mut [i32], mut i: i64) {
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    while ((i > 0) && ((vals[((heap[(i) as usize] as i64)) as usize] as i64) < (vals[((heap[(((i - 1) / 2)) as usize] as i64)) as usize] as i64))) {
        _i1 = i;
        _i2 = ((i - 1) / 2);
        _t1 = (heap[(_i1) as usize] as i64);
        heap[(_i1) as usize] = ((heap[(_i2) as usize] as i64)) as i32;
        heap[(_i2) as usize] = (_t1) as i32;
        i = ((i - 1) / 2);
    }
}

fn cartesian_tree_sort_x_sift_down(vals: &mut [i32], heap: &mut [i32], mut size: i64, mut i: i64) {
    let mut going: i64 = 0;
    let mut c: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    going = 1;
    while (going == 1) {
        c = ((2 * i) + 1);
        if (c >= size) {
            going = 0;
        } else {
            if (((c + 1) < size) && ((vals[((heap[((c + 1)) as usize] as i64)) as usize] as i64) < (vals[((heap[(c) as usize] as i64)) as usize] as i64))) {
                c = (c + 1);
            }
            if ((vals[((heap[(c) as usize] as i64)) as usize] as i64) < (vals[((heap[(i) as usize] as i64)) as usize] as i64)) {
                _i1 = i;
                _i2 = c;
                _t1 = (heap[(_i1) as usize] as i64);
                heap[(_i1) as usize] = ((heap[(_i2) as usize] as i64)) as i32;
                heap[(_i2) as usize] = (_t1) as i32;
                i = c;
            } else {
                going = 0;
            }
        }
    }
}

fn cartesian_tree_sort_impl(a: &mut [i32], mut n: i64) {
    let mut i: i64 = 0;
    let mut sp: i64 = 0;
    let mut last: i64 = 0;
    let mut size: i64 = 0;
    let mut out: i64 = 0;
    let mut node: i64 = 0;
    let mut _e1: i64 = 0;
    let mut _e2: i64 = 0;
    let mut _e3: i64 = 0;
    if (n < 2) {
        return;
    }
    let mut vals_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let vals: &mut [i32] = &mut vals_store[..];
    let mut left_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let left: &mut [i32] = &mut left_store[..];
    let mut right_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let right: &mut [i32] = &mut right_store[..];
    let mut stack_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let stack: &mut [i32] = &mut stack_store[..];
    let mut heap_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let heap: &mut [i32] = &mut heap_store[..];
    i = 0;
    _e1 = n;
    while (i < _e1) {
        vals[(i) as usize] = ((a[(i) as usize] as i64)) as i32;
        left[(i) as usize] = ((-1)) as i32;
        right[(i) as usize] = ((-1)) as i32;
        i = (i + 1);
    }
    sp = 0;
    i = 0;
    _e2 = n;
    while (i < _e2) {
        last = (-1);
        while ((sp > 0) && ((vals[(i) as usize] as i64) < (vals[((stack[((sp - 1)) as usize] as i64)) as usize] as i64))) {
            sp = (sp - 1);
            last = (stack[(sp) as usize] as i64);
        }
        left[(i) as usize] = (last) as i32;
        if (sp > 0) {
            right[((stack[((sp - 1)) as usize] as i64)) as usize] = (i) as i32;
        }
        stack[(sp) as usize] = (i) as i32;
        sp = (sp + 1);
        i = (i + 1);
    }
    heap[(0) as usize] = ((stack[(0) as usize] as i64)) as i32;
    size = 1;
    out = 0;
    _e3 = n;
    while (out < _e3) {
        node = (heap[(0) as usize] as i64);
        size = (size - 1);
        heap[(0) as usize] = ((heap[(size) as usize] as i64)) as i32;
        cartesian_tree_sort_x_sift_down(vals, heap, size, 0);
        a[(out) as usize] = ((vals[(node) as usize] as i64)) as i32;
        if ((left[(node) as usize] as i64) >= 0) {
            heap[(size) as usize] = ((left[(node) as usize] as i64)) as i32;
            size = (size + 1);
            cartesian_tree_sort_x_sift_up(vals, heap, (size - 1));
        }
        if ((right[(node) as usize] as i64) >= 0) {
            heap[(size) as usize] = ((right[(node) as usize] as i64)) as i32;
            size = (size + 1);
            cartesian_tree_sort_x_sift_up(vals, heap, (size - 1));
        }
        out = (out + 1);
    }
}

pub fn cartesian_tree_sort(a: &mut [i32]) {
    cartesian_tree_sort_impl(a, a.len() as i64);
}
