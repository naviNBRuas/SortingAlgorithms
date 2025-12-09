pub fn counting_sort(arr: &[i32]) -> Vec<i32> {
    if arr.is_empty() {
        return Vec::new();
    }
    let (mut min, mut max) = (arr[0], arr[0]);
    for &v in arr.iter() {
        if v < min {
            min = v;
        }
        if v > max {
            max = v;
        }
    }
    let range = (max - min + 1) as usize;
    let mut count = vec![0usize; range];
    for &v in arr.iter() {
        count[(v - min) as usize] += 1;
    }
    for i in 1..count.len() {
        count[i] += count[i - 1];
    }
    let mut out = vec![0i32; arr.len()];
    for &v in arr.iter().rev() {
        let idx = (v - min) as usize;
        count[idx] -= 1;
        out[count[idx]] = v;
    }
    out
}
