pub fn strand_sort(arr: &[i32]) -> Vec<i32> {
    let mut input: Vec<i32> = arr.to_vec();
    let mut output: Vec<i32> = Vec::new();
    while !input.is_empty() {
        let mut sub = vec![input[0]];
        input.remove(0);
        let mut i = 0;
        while i < input.len() {
            if input[i] >= *sub.last().unwrap() {
                sub.push(input[i]);
                input.remove(i);
            } else {
                i += 1;
            }
        }
        output = merge(&output, &sub);
    }
    output
}

fn merge(a: &[i32], b: &[i32]) -> Vec<i32> {
    let mut res = Vec::with_capacity(a.len() + b.len());
    let mut i = 0;
    let mut j = 0;
    while i < a.len() && j < b.len() {
        if a[i] <= b[j] {
            res.push(a[i]);
            i += 1;
        } else {
            res.push(b[j]);
            j += 1;
        }
    }
    res.extend_from_slice(&a[i..]);
    res.extend_from_slice(&b[j..]);
    res
}
