pub fn patience_sort(arr: &[i32]) -> Vec<i32> {
    if arr.is_empty() {
        return Vec::new();
    }
    let mut piles: Vec<Vec<i32>> = Vec::with_capacity(arr.len());
    for &x in arr.iter() {
        let mut l = 0usize;
        let mut r = piles.len();
        while l < r {
            let m = (l + r) / 2;
            let top = *piles[m].last().unwrap();
            if top >= x {
                r = m;
            } else {
                l = m + 1;
            }
        }
        if l == piles.len() {
            piles.push(vec![x]);
        } else {
            piles[l].push(x);
        }
    }
    let mut out = Vec::with_capacity(arr.len());
    while !piles.is_empty() {
        let mut min_idx = 0;
        let mut min_val = *piles[0].last().unwrap();
        for i in 1..piles.len() {
            let top = *piles[i].last().unwrap();
            if top < min_val {
                min_val = top;
                min_idx = i;
            }
        }
        out.push(min_val);
        piles[min_idx].pop();
        if piles[min_idx].is_empty() {
            piles.remove(min_idx);
        }
    }
    out
}
