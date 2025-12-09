use rand::seq::SliceRandom;
use rand::thread_rng;

pub fn bogo_sort(arr: &mut [i32], max_shuffles: usize) -> Result<(), &'static str> {
    let mut rng = thread_rng();
    for _ in 0..max_shuffles {
        if is_sorted(arr) {
            return Ok(());
        }
        arr.shuffle(&mut rng);
    }
    if is_sorted(arr) {
        Ok(())
    } else {
        Err("bogo sort exceeded max_shuffles")
    }
}

fn is_sorted(arr: &[i32]) -> bool {
    arr.windows(2).all(|w| w[0] <= w[1])
}
