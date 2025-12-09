pub fn cycle_sort(arr: &mut [i32]) {
    let n = arr.len();
    for cycle_start in 0..n.saturating_sub(1) {
        let mut item = arr[cycle_start];
        let mut pos = cycle_start;
        for i in cycle_start + 1..n {
            if arr[i] < item {
                pos += 1;
            }
        }
        if pos == cycle_start {
            continue;
        }
        while pos < n && item == arr[pos] {
            pos += 1;
        }
        if pos < n {
            std::mem::swap(&mut arr[pos], &mut item);
        }
        while pos != cycle_start {
            pos = cycle_start;
            for i in cycle_start + 1..n {
                if arr[i] < item {
                    pos += 1;
                }
            }
            while pos < n && item == arr[pos] {
                pos += 1;
            }
            if pos < n {
                std::mem::swap(&mut arr[pos], &mut item);
            }
        }
    }
}
