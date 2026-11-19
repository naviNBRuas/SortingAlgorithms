      *> GENERATED from kernels/algos/bottom_up_heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. bottom-up-heap-sort-x-sift IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-j USAGE BINARY-DOUBLE SIGNED.
01 v-x USAGE BINARY-DOUBLE SIGNED.
01 v-cur USAGE BINARY-DOUBLE SIGNED.
01 v-c USAGE BINARY-DOUBLE SIGNED.
01 w-1 USAGE BINARY-DOUBLE SIGNED.
01 w-2 USAGE BINARY-DOUBLE SIGNED.
01 w-3 USAGE BINARY-DOUBLE SIGNED.
01 w-4 USAGE BINARY-DOUBLE SIGNED.
01 w-5 USAGE BINARY-DOUBLE SIGNED.
01 w-6 USAGE BINARY-DOUBLE SIGNED.
01 w-7 USAGE BINARY-DOUBLE SIGNED.
01 w-8 USAGE BINARY-DOUBLE SIGNED.
01 w-9 USAGE BINARY-DOUBLE SIGNED.
01 w-10 USAGE BINARY-DOUBLE SIGNED.
01 w-11 USAGE BINARY-DOUBLE SIGNED.
01 w-12 USAGE BINARY-DOUBLE SIGNED.
01 w-13 USAGE BINARY-DOUBLE SIGNED.
01 w-14 USAGE BINARY-DOUBLE SIGNED.
01 w-15 USAGE BINARY-DOUBLE SIGNED.
01 w-16 USAGE BINARY-DOUBLE SIGNED.
01 w-17 USAGE BINARY-DOUBLE SIGNED.
01 w-18 USAGE BINARY-DOUBLE SIGNED.
01 w-19 USAGE BINARY-DOUBLE SIGNED.
01 w-20 USAGE BINARY-DOUBLE SIGNED.
01 w-21 USAGE BINARY-DOUBLE SIGNED.
01 w-22 USAGE BINARY-DOUBLE SIGNED.
01 w-23 USAGE BINARY-DOUBLE SIGNED.
01 w-24 USAGE BINARY-DOUBLE SIGNED.
01 w-25 USAGE BINARY-DOUBLE SIGNED.
01 w-26 USAGE BINARY-DOUBLE SIGNED.
01 w-27 USAGE BINARY-DOUBLE SIGNED.
01 w-28 USAGE BINARY-DOUBLE SIGNED.
01 w-29 USAGE BINARY-DOUBLE SIGNED.
01 w-30 USAGE BINARY-DOUBLE SIGNED.
01 w-31 USAGE BINARY-DOUBLE SIGNED.
01 w-32 USAGE BINARY-DOUBLE SIGNED.
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
01 f-5 USAGE BINARY-DOUBLE SIGNED.
01 f-6 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-root USAGE BINARY-DOUBLE SIGNED.
01 v-size USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-a BY VALUE v-root BY VALUE v-size.
    MOVE v-root TO v-j
    PERFORM UNTIL 1 = 2
        COMPUTE w-1 = 2 * v-j
        COMPUTE w-2 = w-1 + 2
        IF w-2 < v-size
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-3 = 2 * v-j
        COMPUTE w-4 = w-3 + 1
        COMPUTE w-5 = w-4 + 1
        MOVE t-a-e(w-5) TO w-6
        COMPUTE w-7 = 2 * v-j
        COMPUTE w-8 = w-7 + 2
        COMPUTE w-9 = w-8 + 1
        MOVE t-a-e(w-9) TO w-10
        IF w-6 < w-10
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 1
            COMPUTE w-11 = 2 * v-j
            COMPUTE w-12 = w-11 + 2
            MOVE w-12 TO v-j
        ELSE
            COMPUTE w-13 = 2 * v-j
            COMPUTE w-14 = w-13 + 1
            MOVE w-14 TO v-j
        END-IF
    END-PERFORM
    COMPUTE w-15 = 2 * v-j
    COMPUTE w-16 = w-15 + 1
    IF w-16 < v-size
        MOVE 1 TO f-3
    ELSE
        MOVE 0 TO f-3
    END-IF
    IF f-3 = 1
        COMPUTE w-17 = 2 * v-j
        COMPUTE w-18 = w-17 + 1
        MOVE w-18 TO v-j
    END-IF
    COMPUTE w-19 = v-root + 1
    MOVE t-a-e(w-19) TO w-20
    MOVE w-20 TO v-x
    PERFORM UNTIL 1 = 2
        COMPUTE w-21 = v-j + 1
        MOVE t-a-e(w-21) TO w-22
        IF w-22 < v-x
            MOVE 1 TO f-4
        ELSE
            MOVE 0 TO f-4
        END-IF
        IF f-4 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-23 = v-j - 1
        COMPUTE w-24 = FUNCTION INTEGER-PART(w-23 / 2)
        MOVE w-24 TO v-j
    END-PERFORM
    MOVE v-root TO v-cur
    PERFORM UNTIL 1 = 2
        IF v-cur NOT = v-j
            MOVE 1 TO f-5
        ELSE
            MOVE 0 TO f-5
        END-IF
        IF f-5 = 0
            EXIT PERFORM
        END-IF
        MOVE v-j TO v-c
        PERFORM UNTIL 1 = 2
            COMPUTE w-25 = v-c - 1
            COMPUTE w-26 = FUNCTION INTEGER-PART(w-25 / 2)
            IF w-26 NOT = v-cur
                MOVE 1 TO f-6
            ELSE
                MOVE 0 TO f-6
            END-IF
            IF f-6 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-27 = v-c - 1
            COMPUTE w-28 = FUNCTION INTEGER-PART(w-27 / 2)
            MOVE w-28 TO v-c
        END-PERFORM
        COMPUTE w-29 = v-c + 1
        MOVE t-a-e(w-29) TO w-30
        COMPUTE w-31 = v-cur + 1
        MOVE w-30 TO t-a-e(w-31)
        MOVE v-c TO v-cur
    END-PERFORM
    COMPUTE w-32 = v-j + 1
    MOVE v-x TO t-a-e(w-32)
    GOBACK.
END PROGRAM bottom-up-heap-sort-x-sift.

IDENTIFICATION DIVISION.
PROGRAM-ID. bottom-up-heap-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-s USAGE BINARY-DOUBLE SIGNED.
01 v-end USAGE BINARY-DOUBLE SIGNED.
01 w-1 USAGE BINARY-DOUBLE SIGNED.
01 w-2 USAGE BINARY-DOUBLE SIGNED.
01 w-3 USAGE BINARY-DOUBLE SIGNED.
01 w-4 USAGE BINARY-DOUBLE SIGNED.
01 w-5 USAGE BINARY-DOUBLE SIGNED.
01 w-6 USAGE BINARY-DOUBLE SIGNED.
01 w-7 USAGE BINARY-DOUBLE SIGNED.
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-n USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-a BY VALUE v-n.
    COMPUTE w-1 = FUNCTION INTEGER-PART(v-n / 2)
    MOVE w-1 TO v-s
    PERFORM UNTIL 1 = 2
        IF v-s > 0
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-2 = v-s - 1
        MOVE w-2 TO v-s
        CALL "bottom-up-heap-sort-x-sift" USING BY REFERENCE t-a BY VALUE v-s BY VALUE v-n
        END-CALL
    END-PERFORM
    COMPUTE w-3 = v-n - 1
    MOVE w-3 TO v-end
    PERFORM UNTIL 1 = 2
        IF v-end > 0
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-4 = 0 + 1
        COMPUTE w-5 = v-end + 1
        MOVE t-a-e(w-4) TO w-6
        MOVE t-a-e(w-5) TO t-a-e(w-4)
        MOVE w-6 TO t-a-e(w-5)
        CALL "bottom-up-heap-sort-x-sift" USING BY REFERENCE t-a BY VALUE 0 BY VALUE v-end
        END-CALL
        COMPUTE w-7 = v-end - 1
        MOVE w-7 TO v-end
    END-PERFORM
    GOBACK.
END PROGRAM bottom-up-heap-sort.

