pub fn odd_even_sort(arr: &mut [i32]) {
    let mut sorted = false;
    let n = arr.len();
    while !sorted {
        sorted = true;
        let mut i = 1;
        while i + 1 < n {
            if arr[i] > arr[i + 1] {
                arr.swap(i, i + 1);
                sorted = false;
            }
            i += 2;
        }
        i = 0;
        while i + 1 < n {
            if arr[i] > arr[i + 1] {
                arr.swap(i, i + 1);
                sorted = false;
            }
            i += 2;
        }
    }
}
