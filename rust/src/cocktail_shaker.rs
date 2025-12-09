pub fn cocktail_shaker_sort(arr: &mut [i32]) {
    if arr.is_empty() {
        return;
    }
    let mut start = 0usize;
    let mut end = arr.len() - 1;
    let mut swapped = true;
    while swapped {
        swapped = false;
        for i in start..end {
            if arr[i] > arr[i + 1] {
                arr.swap(i, i + 1);
                swapped = true;
            }
        }
        if !swapped {
            break;
        }
        swapped = false;
        if end > 0 {
            end -= 1;
        }
        for i in (start + 1..=end).rev() {
            if arr[i] < arr[i - 1] {
                arr.swap(i, i - 1);
                swapped = true;
            }
        }
        start += 1;
    }
}
