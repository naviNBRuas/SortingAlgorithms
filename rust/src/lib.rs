pub mod bubble;
pub mod selection;
pub mod insertion;
pub mod quick;
pub mod merge;
pub mod heap;

pub use bubble::bubble_sort;
pub use selection::selection_sort;
pub use insertion::insertion_sort;
pub use quick::quick_sort;
pub use merge::merge_sort;
pub use heap::heap_sort;
