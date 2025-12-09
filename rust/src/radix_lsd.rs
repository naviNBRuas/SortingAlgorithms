pub fn radix_sort_lsd(arr: &mut [i32]) {
    if arr.is_empty() {
        return;
    }
    let mut min = arr[0];
    let mut max = arr[0];
    for &v in arr.iter() {
        if v < min {
            min = v;
        }
        if v > max {
            max = v;
        }
    }
    if min < 0 {
        for v in arr.iter_mut() {
            *v -= min;
        }
        max -= min;
    }
    let mut exp = 1;
    while max / exp > 0 {
        counting_sort_exp(arr, exp);
        exp *= 10;
    }
    if min < 0 {
        for v in arr.iter_mut() {
            *v += min;
        }
    }
}

fn counting_sort_exp(arr: &mut [i32], exp: i32) {
    let n = arr.len();
    let mut output = vec![0i32; n];
    let mut count = [0usize; 10];
    for &v in arr.iter() {
        let digit = ((v / exp) % 10) as usize;
        count[digit] += 1;
    }
    for i in 1..10 {
        count[i] += count[i - 1];
    }
    for &v in arr.iter().rev() {
        let digit = ((v / exp) % 10) as usize;
        count[digit] -= 1;
        output[count[digit]] = v;
    }
    arr.copy_from_slice(&output);
}
