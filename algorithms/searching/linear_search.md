# Linear Search

## Description
Linear search (also known as sequential search) is a method for finding an element within a list. It sequentially checks each element of the list until a match is found or the whole list has been searched.

## Time Complexity
*   **Worst-case:** O(n)
*   **Average-case:** O(n)
*   **Best-case:** O(1)

## Space Complexity
*   **Worst-case:** O(1)

## How it works
1.  Start from the first element of the list.
2.  Compare the current element with the target value.
3.  If the current element matches the target, return its index.
4.  If not, move to the next element and repeat steps 2 and 3.
5.  If the end of the list is reached and no match is found, return -1 (or an indication that the element is not present).
