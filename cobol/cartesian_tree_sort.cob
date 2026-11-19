      *> GENERATED from kernels/algos/cartesian_tree_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. cartesian-tree-sort-x-sift-up IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-vals.
    05 t-vals-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-heap.
    05 t-heap-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-i USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-vals BY REFERENCE t-heap BY VALUE v-i.
    PERFORM UNTIL 1 = 2
        IF v-i > 0
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 1
            COMPUTE w-1 = v-i + 1
            MOVE t-heap-e(w-1) TO w-2
            COMPUTE w-3 = w-2 + 1
            MOVE t-vals-e(w-3) TO w-4
            COMPUTE w-5 = v-i - 1
            COMPUTE w-6 = FUNCTION INTEGER-PART(w-5 / 2)
            COMPUTE w-7 = w-6 + 1
            MOVE t-heap-e(w-7) TO w-8
            COMPUTE w-9 = w-8 + 1
            MOVE t-vals-e(w-9) TO w-10
            IF w-4 < w-10
                MOVE 1 TO f-1
            ELSE
                MOVE 0 TO f-1
            END-IF
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-11 = v-i - 1
        COMPUTE w-12 = FUNCTION INTEGER-PART(w-11 / 2)
        COMPUTE w-13 = v-i + 1
        COMPUTE w-14 = w-12 + 1
        MOVE t-heap-e(w-13) TO w-15
        MOVE t-heap-e(w-14) TO t-heap-e(w-13)
        MOVE w-15 TO t-heap-e(w-14)
        COMPUTE w-16 = v-i - 1
        COMPUTE w-17 = FUNCTION INTEGER-PART(w-16 / 2)
        MOVE w-17 TO v-i
    END-PERFORM
    GOBACK.
END PROGRAM cartesian-tree-sort-x-sift-up.

IDENTIFICATION DIVISION.
PROGRAM-ID. cartesian-tree-sort-x-sift-down IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-going USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-vals.
    05 t-vals-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-heap.
    05 t-heap-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-size USAGE BINARY-DOUBLE SIGNED.
01 v-i USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-vals BY REFERENCE t-heap BY VALUE v-size BY VALUE v-i.
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
        COMPUTE w-1 = 2 * v-i
        COMPUTE w-2 = w-1 + 1
        MOVE w-2 TO v-c
        IF v-c >= v-size
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 1
            MOVE 0 TO v-going
        ELSE
            COMPUTE w-3 = v-c + 1
            IF w-3 < v-size
                MOVE 1 TO f-3
            ELSE
                MOVE 0 TO f-3
            END-IF
            IF f-3 = 1
                COMPUTE w-4 = v-c + 1
                COMPUTE w-5 = w-4 + 1
                MOVE t-heap-e(w-5) TO w-6
                COMPUTE w-7 = w-6 + 1
                MOVE t-vals-e(w-7) TO w-8
                COMPUTE w-9 = v-c + 1
                MOVE t-heap-e(w-9) TO w-10
                COMPUTE w-11 = w-10 + 1
                MOVE t-vals-e(w-11) TO w-12
                IF w-8 < w-12
                    MOVE 1 TO f-3
                ELSE
                    MOVE 0 TO f-3
                END-IF
            END-IF
            IF f-3 = 1
                COMPUTE w-13 = v-c + 1
                MOVE w-13 TO v-c
            END-IF
            COMPUTE w-14 = v-c + 1
            MOVE t-heap-e(w-14) TO w-15
            COMPUTE w-16 = w-15 + 1
            MOVE t-vals-e(w-16) TO w-17
            COMPUTE w-18 = v-i + 1
            MOVE t-heap-e(w-18) TO w-19
            COMPUTE w-20 = w-19 + 1
            MOVE t-vals-e(w-20) TO w-21
            IF w-17 < w-21
                MOVE 1 TO f-4
            ELSE
                MOVE 0 TO f-4
            END-IF
            IF f-4 = 1
                COMPUTE w-22 = v-i + 1
                COMPUTE w-23 = v-c + 1
                MOVE t-heap-e(w-22) TO w-24
                MOVE t-heap-e(w-23) TO t-heap-e(w-22)
                MOVE w-24 TO t-heap-e(w-23)
                MOVE v-c TO v-i
            ELSE
                MOVE 0 TO v-going
            END-IF
        END-IF
    END-PERFORM
    GOBACK.
END PROGRAM cartesian-tree-sort-x-sift-down.

IDENTIFICATION DIVISION.
PROGRAM-ID. cartesian-tree-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 v-sp USAGE BINARY-DOUBLE SIGNED.
01 v-last USAGE BINARY-DOUBLE SIGNED.
01 v-size USAGE BINARY-DOUBLE SIGNED.
01 v-out USAGE BINARY-DOUBLE SIGNED.
01 v-node USAGE BINARY-DOUBLE SIGNED.
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
01 w-33 USAGE BINARY-DOUBLE SIGNED.
01 w-34 USAGE BINARY-DOUBLE SIGNED.
01 w-35 USAGE BINARY-DOUBLE SIGNED.
01 w-36 USAGE BINARY-DOUBLE SIGNED.
01 w-37 USAGE BINARY-DOUBLE SIGNED.
01 w-38 USAGE BINARY-DOUBLE SIGNED.
01 w-39 USAGE BINARY-DOUBLE SIGNED.
01 w-40 USAGE BINARY-DOUBLE SIGNED.
01 w-41 USAGE BINARY-DOUBLE SIGNED.
01 w-42 USAGE BINARY-DOUBLE SIGNED.
01 w-43 USAGE BINARY-DOUBLE SIGNED.
01 w-44 USAGE BINARY-DOUBLE SIGNED.
01 w-45 USAGE BINARY-DOUBLE SIGNED.
01 w-46 USAGE BINARY-DOUBLE SIGNED.
01 w-47 USAGE BINARY-DOUBLE SIGNED.
01 w-48 USAGE BINARY-DOUBLE SIGNED.
01 w-49 USAGE BINARY-DOUBLE SIGNED.
01 w-50 USAGE BINARY-DOUBLE SIGNED.
01 w-51 USAGE BINARY-DOUBLE SIGNED.
01 w-52 USAGE BINARY-DOUBLE SIGNED.
01 w-53 USAGE BINARY-DOUBLE SIGNED.
01 w-54 USAGE BINARY-DOUBLE SIGNED.
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
01 f-5 USAGE BINARY-DOUBLE SIGNED.
01 t-vals.
    05 t-vals-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-left.
    05 t-left-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-right.
    05 t-right-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-stack.
    05 t-stack-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-heap.
    05 t-heap-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-n USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-a BY VALUE v-n.
    IF v-n < 2
        MOVE 1 TO f-1
    ELSE
        MOVE 0 TO f-1
    END-IF
    IF f-1 = 1
        GOBACK
    END-IF
    INITIALIZE t-vals
    INITIALIZE t-left
    INITIALIZE t-right
    INITIALIZE t-stack
    INITIALIZE t-heap
    MOVE 0 TO v-i
    MOVE v-n TO w-1
    PERFORM UNTIL 1 = 2
        IF v-i >= w-1
            EXIT PERFORM
        END-IF
        COMPUTE w-2 = v-i + 1
        MOVE t-a-e(w-2) TO w-3
        COMPUTE w-4 = v-i + 1
        MOVE w-3 TO t-vals-e(w-4)
        COMPUTE w-5 = 0 - 1
        COMPUTE w-6 = v-i + 1
        MOVE w-5 TO t-left-e(w-6)
        COMPUTE w-7 = 0 - 1
        COMPUTE w-8 = v-i + 1
        MOVE w-7 TO t-right-e(w-8)
        ADD 1 TO v-i
    END-PERFORM
    MOVE 0 TO v-sp
    MOVE 0 TO v-i
    MOVE v-n TO w-9
    PERFORM UNTIL 1 = 2
        IF v-i >= w-9
            EXIT PERFORM
        END-IF
        COMPUTE w-10 = 0 - 1
        MOVE w-10 TO v-last
        PERFORM UNTIL 1 = 2
            IF v-sp > 0
                MOVE 1 TO f-2
            ELSE
                MOVE 0 TO f-2
            END-IF
            IF f-2 = 1
                COMPUTE w-11 = v-i + 1
                MOVE t-vals-e(w-11) TO w-12
                COMPUTE w-13 = v-sp - 1
                COMPUTE w-14 = w-13 + 1
                MOVE t-stack-e(w-14) TO w-15
                COMPUTE w-16 = w-15 + 1
                MOVE t-vals-e(w-16) TO w-17
                IF w-12 < w-17
                    MOVE 1 TO f-2
                ELSE
                    MOVE 0 TO f-2
                END-IF
            END-IF
            IF f-2 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-18 = v-sp - 1
            MOVE w-18 TO v-sp
            COMPUTE w-19 = v-sp + 1
            MOVE t-stack-e(w-19) TO w-20
            MOVE w-20 TO v-last
        END-PERFORM
        COMPUTE w-21 = v-i + 1
        MOVE v-last TO t-left-e(w-21)
        IF v-sp > 0
            MOVE 1 TO f-3
        ELSE
            MOVE 0 TO f-3
        END-IF
        IF f-3 = 1
            COMPUTE w-22 = v-sp - 1
            COMPUTE w-23 = w-22 + 1
            MOVE t-stack-e(w-23) TO w-24
            COMPUTE w-25 = w-24 + 1
            MOVE v-i TO t-right-e(w-25)
        END-IF
        COMPUTE w-26 = v-sp + 1
        MOVE v-i TO t-stack-e(w-26)
        COMPUTE w-27 = v-sp + 1
        MOVE w-27 TO v-sp
        ADD 1 TO v-i
    END-PERFORM
    COMPUTE w-28 = 0 + 1
    MOVE t-stack-e(w-28) TO w-29
    COMPUTE w-30 = 0 + 1
    MOVE w-29 TO t-heap-e(w-30)
    MOVE 1 TO v-size
    MOVE 0 TO v-out
    MOVE v-n TO w-31
    PERFORM UNTIL 1 = 2
        IF v-out >= w-31
            EXIT PERFORM
        END-IF
        COMPUTE w-32 = 0 + 1
        MOVE t-heap-e(w-32) TO w-33
        MOVE w-33 TO v-node
        COMPUTE w-34 = v-size - 1
        MOVE w-34 TO v-size
        COMPUTE w-35 = v-size + 1
        MOVE t-heap-e(w-35) TO w-36
        COMPUTE w-37 = 0 + 1
        MOVE w-36 TO t-heap-e(w-37)
        CALL "cartesian-tree-sort-x-sift-down" USING BY REFERENCE t-vals BY REFERENCE t-heap BY VALUE v-size BY VALUE 0
        END-CALL
        COMPUTE w-38 = v-node + 1
        MOVE t-vals-e(w-38) TO w-39
        COMPUTE w-40 = v-out + 1
        MOVE w-39 TO t-a-e(w-40)
        COMPUTE w-41 = v-node + 1
        MOVE t-left-e(w-41) TO w-42
        IF w-42 >= 0
            MOVE 1 TO f-4
        ELSE
            MOVE 0 TO f-4
        END-IF
        IF f-4 = 1
            COMPUTE w-43 = v-node + 1
            MOVE t-left-e(w-43) TO w-44
            COMPUTE w-45 = v-size + 1
            MOVE w-44 TO t-heap-e(w-45)
            COMPUTE w-46 = v-size + 1
            MOVE w-46 TO v-size
            COMPUTE w-47 = v-size - 1
            CALL "cartesian-tree-sort-x-sift-up" USING BY REFERENCE t-vals BY REFERENCE t-heap BY VALUE w-47
            END-CALL
        END-IF
        COMPUTE w-48 = v-node + 1
        MOVE t-right-e(w-48) TO w-49
        IF w-49 >= 0
            MOVE 1 TO f-5
        ELSE
            MOVE 0 TO f-5
        END-IF
        IF f-5 = 1
            COMPUTE w-50 = v-node + 1
            MOVE t-right-e(w-50) TO w-51
            COMPUTE w-52 = v-size + 1
            MOVE w-51 TO t-heap-e(w-52)
            COMPUTE w-53 = v-size + 1
            MOVE w-53 TO v-size
            COMPUTE w-54 = v-size - 1
            CALL "cartesian-tree-sort-x-sift-up" USING BY REFERENCE t-vals BY REFERENCE t-heap BY VALUE w-54
            END-CALL
        END-IF
        ADD 1 TO v-out
    END-PERFORM
    GOBACK.
END PROGRAM cartesian-tree-sort.

