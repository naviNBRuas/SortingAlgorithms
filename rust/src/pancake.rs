pub fn pancake_sort(arr: &mut [i32]) {
    let mut curr = arr.len();
    while curr > 1 {
        let mut max_idx = 0;
        for i in 1..curr {
            if arr[i] > arr[max_idx] {
                max_idx = i;
            }
        }
        if max_idx == curr - 1 {
            curr -= 1;
            continue;
        }
        flip(arr, max_idx);
        flip(arr, curr - 1);
        curr -= 1;
    }
}

fn flip(arr: &mut [i32], k: usize) {
    let mut i = 0;
    let mut j = k;
    while i < j {
        arr.swap(i, j);
        i += 1;
        if j == 0 {
            break;
        }
        j -= 1;
    }
}
