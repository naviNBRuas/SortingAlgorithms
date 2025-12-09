pub fn gnome_sort(arr: &mut [i32]) {
    let mut i = 1;
    while i < arr.len() {
        if arr[i] >= arr[i - 1] {
            i += 1;
        } else {
            arr.swap(i, i - 1);
            if i > 1 {
                i -= 1;
            } else {
                i += 1;
            }
        }
    }
}
