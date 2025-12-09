use crate::counting_sort;

pub fn bead_sort(arr: &[i32]) -> Vec<i32> {
    let mut has_negative = false;
    let mut max = 0;
    for &v in arr.iter() {
        if v < 0 {
            has_negative = true;
        }
        if v > max {
            max = v;
        }
    }
    if has_negative {
        return counting_sort(arr);
    }
    if arr.is_empty() || max == 0 {
        return arr.to_vec();
    }
    let n = arr.len();
    let mut grid = vec![vec![false; max as usize]; n];
    for (i, &v) in arr.iter().enumerate() {
        for j in 0..v as usize {
            grid[i][j] = true;
        }
    }
    for j in 0..max as usize {
        let mut sum = 0usize;
        for i in 0..n {
            if grid[i][j] {
                sum += 1;
            }
        }
        for i in (0..n).rev() {
            grid[i][j] = sum > 0;
            if sum > 0 {
                sum -= 1;
            }
        }
    }
    let mut out = vec![0i32; n];
    for i in 0..n {
        let mut h = 0;
        while h < max as usize && grid[i][h] {
            h += 1;
        }
        out[i] = h as i32;
    }
    out
}
