pub fn bucket_sort(arr: &[i32]) -> Vec<i32> {
    let n = arr.len();
    if n == 0 {
        return Vec::new();
    }
    let mut min = arr[0];
    let mut max = arr[0];
    for &v in arr.iter() {
        if v < min {
            min = v;
        }
        if v > max {
            max = v;
        }
    }
    let bucket_count = n;
    let mut buckets: Vec<Vec<i32>> = vec![Vec::new(); bucket_count];
    let range = (max - min + 1) as f64;
    for &v in arr.iter() {
        let mut idx = (((v - min) as f64) / range * bucket_count as f64) as usize;
        if idx >= bucket_count {
            idx = bucket_count - 1;
        }
        insert_sorted(&mut buckets[idx], v);
    }
    let mut out = Vec::with_capacity(n);
    for b in buckets.into_iter() {
        out.extend(b);
    }
    out
}

fn insert_sorted(bucket: &mut Vec<i32>, v: i32) {
    let pos = bucket.iter().position(|&x| x > v).unwrap_or(bucket.len());
    bucket.insert(pos, v);
}
