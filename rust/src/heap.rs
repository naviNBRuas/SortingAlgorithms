pub fn heap_sort(arr: &mut [i32]) {
    let n = arr.len();
    if n == 0 { return; }
    for i in (0..=n/2).rev() {
        heapify(arr, n, i);
    }
    for i in (1..n).rev() {
        arr.swap(0, i);
        heapify(arr, i, 0);
    }
}

fn heapify(arr: &mut [i32], n: usize, i: usize) {
    let mut largest = i;
    let l = 2 * i + 1;
    let r = 2 * i + 2;
    if l < n && arr[l] > arr[largest] { largest = l; }
    if r < n && arr[r] > arr[largest] { largest = r; }
    if largest != i {
        arr.swap(i, largest);
        heapify(arr, n, largest);
    }
}
