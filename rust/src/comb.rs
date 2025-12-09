pub fn comb_sort(arr: &mut [i32]) {
    let mut gap = arr.len();
    let mut swapped = true;
    while gap > 1 || swapped {
        gap = (gap as f64 / 1.3).floor() as usize;
        if gap < 1 {
            gap = 1;
        }
        swapped = false;
        for i in 0..arr.len().saturating_sub(gap) {
            if arr[i] > arr[i + gap] {
                arr.swap(i, i + gap);
                swapped = true;
            }
        }
    }
}
