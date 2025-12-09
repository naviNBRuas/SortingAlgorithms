pub fn binary_insertion_sort(arr: &mut [i32]) {
    for i in 1..arr.len() {
        let key = arr[i];
        let mut left = 0;
        let mut right = i;
        while left < right {
            let mid = (left + right) / 2;
            if arr[mid] <= key {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        for j in (left..=i - 1).rev() {
            arr[j + 1] = arr[j];
        }
        arr[left] = key;
    }
}
