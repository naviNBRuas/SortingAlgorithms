      *> GENERATED from kernels/algos/ternary_heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. ths0ac-sift IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-going USAGE BINARY-DOUBLE SIGNED.
01 v-first USAGE BINARY-DOUBLE SIGNED.
01 v-best USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
01 f-5 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-root USAGE BINARY-DOUBLE SIGNED.
01 v-size USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING t-a v-root v-size.
    MOVE 1 TO v-going
    PERFORM UNTIL 1 = 2
        IF v-going = 1
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-1 = 3 * v-root
        COMPUTE w-2 = w-1 + 1
        MOVE w-2 TO v-first
        IF v-first >= v-size
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 1
            MOVE 0 TO v-going
        ELSE
            MOVE v-first TO v-best
            COMPUTE w-3 = v-first + 1
            MOVE w-3 TO v-c
            PERFORM UNTIL 1 = 2
                COMPUTE w-4 = v-first + 3
                IF v-c < w-4
                    MOVE 1 TO f-3
                ELSE
                    MOVE 0 TO f-3
                END-IF
                IF f-3 = 1
                    IF v-c < v-size
                        MOVE 1 TO f-3
                    ELSE
                        MOVE 0 TO f-3
                    END-IF
                END-IF
                IF f-3 = 0
                    EXIT PERFORM
                END-IF
                COMPUTE w-5 = v-best + 1
                MOVE t-a-e(w-5) TO w-6
                COMPUTE w-7 = v-c + 1
                MOVE t-a-e(w-7) TO w-8
                IF w-6 < w-8
                    MOVE 1 TO f-4
                ELSE
                    MOVE 0 TO f-4
                END-IF
                IF f-4 = 1
                    MOVE v-c TO v-best
                END-IF
                COMPUTE w-9 = v-c + 1
                MOVE w-9 TO v-c
            END-PERFORM
            COMPUTE w-10 = v-root + 1
            MOVE t-a-e(w-10) TO w-11
            COMPUTE w-12 = v-best + 1
            MOVE t-a-e(w-12) TO w-13
            IF w-11 < w-13
                MOVE 1 TO f-5
            ELSE
                MOVE 0 TO f-5
            END-IF
            IF f-5 = 1
                COMPUTE w-14 = v-root + 1
                COMPUTE w-15 = v-best + 1
                MOVE t-a-e(w-14) TO w-16
                MOVE t-a-e(w-15) TO t-a-e(w-14)
                MOVE w-16 TO t-a-e(w-15)
                MOVE v-best TO v-root
            ELSE
                MOVE 0 TO v-going
            END-IF
        END-IF
    END-PERFORM
    GOBACK.
END PROGRAM ths0ac-sift.

IDENTIFICATION DIVISION.
PROGRAM-ID. ternary-heap-sort IS RECURSIVE.
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
01 w-8 USAGE BINARY-DOUBLE SIGNED.
01 w-9 USAGE BINARY-DOUBLE SIGNED.
01 w-10 USAGE BINARY-DOUBLE SIGNED.
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-n USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING t-a v-n.
    IF v-n < 2
        MOVE 1 TO f-1
    ELSE
        MOVE 0 TO f-1
    END-IF
    IF f-1 = 1
        GOBACK
    END-IF
    COMPUTE w-1 = v-n - 2
    COMPUTE w-2 = FUNCTION INTEGER-PART(w-1 / 3)
    COMPUTE w-3 = w-2 + 1
    MOVE w-3 TO v-s
    PERFORM UNTIL 1 = 2
        IF v-s > 0
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-4 = v-s - 1
        MOVE w-4 TO v-s
        CALL "ths0ac-sift" USING BY REFERENCE t-a BY CONTENT v-s BY CONTENT v-n
        END-CALL
    END-PERFORM
    COMPUTE w-5 = v-n - 1
    MOVE w-5 TO v-end
    PERFORM UNTIL 1 = 2
        IF v-end > 0
            MOVE 1 TO f-3
        ELSE
            MOVE 0 TO f-3
        END-IF
        IF f-3 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-6 = 0 + 1
        COMPUTE w-7 = v-end + 1
        MOVE t-a-e(w-6) TO w-8
        MOVE t-a-e(w-7) TO t-a-e(w-6)
        MOVE w-8 TO t-a-e(w-7)
        MOVE 0 TO w-9
        CALL "ths0ac-sift" USING BY REFERENCE t-a BY CONTENT w-9 BY CONTENT v-end
        END-CALL
        COMPUTE w-10 = v-end - 1
        MOVE w-10 TO v-end
    END-PERFORM
    GOBACK.
END PROGRAM ternary-heap-sort.

