#include "../sorting_algorithms.h"
#include <stdint.h>

/* Dijkstra's smoothsort over Leonardo heaps (Orson Peters' formulation).
 * O(n) on sorted input, O(n log n) worst case, O(1) extra space. */

static size_t LP[64];
static int lp_ready;

static void init_lp(void) {
    if (lp_ready) return;
    LP[0] = LP[1] = 1;
    for (int i = 2; i < 64; ++i) {
        LP[i] = LP[i - 1] + LP[i - 2] + 1;
        if (LP[i] > ((size_t)1 << 56)) { for (int j = i + 1; j < 64; ++j) LP[j] = LP[i]; break; }
    }
    lp_ready = 1;
}

static int ctz_no_low(uint64_t p) { return __builtin_ctzll(p & ~(uint64_t)1); }

static void sift(int *a, size_t head, int pshift) {
    int val = a[head];
    while (pshift > 1) {
        size_t rt = head - 1, lf = head - 1 - LP[pshift - 2];
        if (val >= a[lf] && val >= a[rt]) break;
        if (a[lf] >= a[rt]) { a[head] = a[lf]; head = lf; pshift -= 1; }
        else { a[head] = a[rt]; head = rt; pshift -= 2; }
    }
    a[head] = val;
}

static void trinkle(int *a, size_t head, uint64_t p, int pshift, int trusty) {
    int val = a[head];
    while (p != 1) {
        size_t stepson = head - LP[pshift];
        if (a[stepson] <= val) break;
        if (!trusty && pshift > 1) {
            size_t rt = head - 1, lf = head - 1 - LP[pshift - 2];
            if (a[rt] >= a[stepson] || a[lf] >= a[stepson]) break;
        }
        a[head] = a[stepson];
        head = stepson;
        int trail = ctz_no_low(p);
        p >>= trail;
        pshift += trail;
        trusty = 0;
    }
    if (!trusty) { a[head] = val; sift(a, head, pshift); }
}

void smooth_sort(int *arr, size_t n) {
    if (n < 2) return;
    init_lp();
    size_t hi = n - 1, head = 0;
    uint64_t p = 1;
    int pshift = 1;
    while (head < hi) {
        if ((p & 3) == 3) {
            sift(arr, head, pshift);
            p >>= 2;
            pshift += 2;
        } else {
            if (LP[pshift - 1] >= hi - head) trinkle(arr, head, p, pshift, 0);
            else sift(arr, head, pshift);
            if (pshift == 1) { p <<= 1; pshift = 0; }
            else { p <<= (pshift - 1); pshift = 1; }
        }
        p |= 1;
        head++;
    }
    trinkle(arr, head, p, pshift, 0);
    while (pshift != 1 || p != 1) {
        if (pshift <= 1) {
            int trail = ctz_no_low(p);
            p >>= trail;
            pshift += trail;
        } else {
            p <<= 2;
            p ^= 7;
            pshift -= 2;
            trinkle(arr, head - LP[pshift] - 1, p >> 1, pshift + 1, 1);
            trinkle(arr, head - 1, p, pshift, 1);
        }
        head--;
    }
}
