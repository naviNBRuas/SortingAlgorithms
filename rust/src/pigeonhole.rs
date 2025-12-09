pub fn pigeonhole_sort(arr: &[i32]) -> Vec<i32> {
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
    let mut holes = vec![0usize; (max - min + 1) as usize];
    for &v in arr.iter() {
        holes[(v - min) as usize] += 1;
    }
    let mut out = Vec::with_capacity(arr.len());
    for (i, &c) in holes.iter().enumerate() {
        for _ in 0..c {
            out.push(i as i32 + min);
        }
    }
    out
}
