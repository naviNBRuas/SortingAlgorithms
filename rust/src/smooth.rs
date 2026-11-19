//! Dijkstra's smoothsort over Leonardo heaps (Orson Peters' formulation).

fn leonardo() -> Vec<usize> {
    let mut lp = vec![1usize, 1];
    while lp.len() < 90 && lp[lp.len() - 1] < (1usize << 40) {
        let n = lp[lp.len() - 1] + lp[lp.len() - 2] + 1;
        lp.push(n);
    }
    lp
}

fn ctz_no_low(p: u64) -> u32 {
    (p & !1).trailing_zeros()
}

fn sift(a: &mut [i32], lp: &[usize], mut head: usize, mut pshift: usize) {
    let val = a[head];
    while pshift > 1 {
        let rt = head - 1;
        let lf = head - 1 - lp[pshift - 2];
        if val >= a[lf] && val >= a[rt] {
            break;
        }
        if a[lf] >= a[rt] {
            a[head] = a[lf];
            head = lf;
            pshift -= 1;
        } else {
            a[head] = a[rt];
            head = rt;
            pshift -= 2;
        }
    }
    a[head] = val;
}

fn trinkle(a: &mut [i32], lp: &[usize], mut head: usize, mut p: u64, mut pshift: usize, mut trusty: bool) {
    let val = a[head];
    while p != 1 {
        let stepson = head - lp[pshift];
        if a[stepson] <= val {
            break;
        }
        if !trusty && pshift > 1 {
            let rt = head - 1;
            let lf = head - 1 - lp[pshift - 2];
            if a[rt] >= a[stepson] || a[lf] >= a[stepson] {
                break;
            }
        }
        a[head] = a[stepson];
        head = stepson;
        let trail = ctz_no_low(p);
        p >>= trail;
        pshift += trail as usize;
        trusty = false;
    }
    if !trusty {
        a[head] = val;
        sift(a, lp, head, pshift);
    }
}

/// O(n) on sorted input, O(n log n) worst case, O(1) extra space (besides the tiny table).
pub fn smooth_sort(arr: &mut [i32]) {
    let n = arr.len();
    if n < 2 {
        return;
    }
    let lp = leonardo();
    let hi = n - 1;
    let (mut head, mut p, mut pshift) = (0usize, 1u64, 1usize);
    while head < hi {
        if p & 3 == 3 {
            sift(arr, &lp, head, pshift);
            p >>= 2;
            pshift += 2;
        } else {
            if lp[pshift - 1] >= hi - head {
                trinkle(arr, &lp, head, p, pshift, false);
            } else {
                sift(arr, &lp, head, pshift);
            }
            if pshift == 1 {
                p <<= 1;
                pshift = 0;
            } else {
                p <<= pshift - 1;
                pshift = 1;
            }
        }
        p |= 1;
        head += 1;
    }
    trinkle(arr, &lp, head, p, pshift, false);
    while pshift != 1 || p != 1 {
        if pshift <= 1 {
            let trail = ctz_no_low(p);
            p >>= trail;
            pshift += trail as usize;
        } else {
            p <<= 2;
            p ^= 7;
            pshift -= 2;
            trinkle(arr, &lp, head - lp[pshift] - 1, p >> 1, pshift + 1, true);
            trinkle(arr, &lp, head - 1, p, pshift, true);
        }
        head -= 1;
    }
}
