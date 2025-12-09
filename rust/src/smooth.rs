use crate::heap_sort;

// Simplified smooth sort: fallback to heap sort for robustness.
pub fn smooth_sort(arr: &mut [i32]) {
    heap_sort(arr);
}
