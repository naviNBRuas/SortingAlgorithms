#include "../sorting_algorithms.h"
#include <stdlib.h>

typedef struct {
    int *cards;
    size_t size;
} Pile;

void patience_sort(int *arr, size_t n) {
    if (n == 0) return;
    Pile *piles = (Pile *)calloc(n, sizeof(Pile));
    if (!piles) return;
    size_t pile_count = 0;

    // Build piles
    for (size_t i = 0; i < n; ++i) {
        int x = arr[i];
        size_t l = 0, r = pile_count;
        while (l < r) {
            size_t m = (l + r) / 2;
            int top = piles[m].cards[piles[m].size - 1];
            if (top >= x) r = m; else l = m + 1;
        }
        if (l == pile_count) pile_count++;
        Pile *pile = &piles[l];
        int *new_cards = (int *)realloc(pile->cards, (pile->size + 1) * sizeof(int));
        if (!new_cards) continue;
        pile->cards = new_cards;
        pile->cards[pile->size++] = x;
    }

    // Collect into output by repeatedly taking smallest pile top
    size_t idx = 0;
    while (pile_count > 0) {
        size_t min_pile = 0;
        int min_val = piles[0].cards[piles[0].size - 1];
        for (size_t i = 1; i < pile_count; ++i) {
            int top = piles[i].cards[piles[i].size - 1];
            if (top < min_val) { min_val = top; min_pile = i; }
        }
        arr[idx++] = min_val;
        Pile *p = &piles[min_pile];
        p->size--;
        if (p->size == 0) {
            free(p->cards);
            for (size_t j = min_pile + 1; j < pile_count; ++j) piles[j - 1] = piles[j];
            pile_count--;
        }
    }

    for (size_t i = 0; i < pile_count; ++i) free(piles[i].cards);
    free(piles);
}
