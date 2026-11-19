      *> GENERATED from kernels/algos/tree_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. tree-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 v-cur USAGE BINARY-DOUBLE SIGNED.
01 v-placed USAGE BINARY-DOUBLE SIGNED.
01 v-node USAGE BINARY-DOUBLE SIGNED.
01 v-sp USAGE BINARY-DOUBLE SIGNED.
01 v-out USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
01 f-5 USAGE BINARY-DOUBLE SIGNED.
01 f-6 USAGE BINARY-DOUBLE SIGNED.
01 f-7 USAGE BINARY-DOUBLE SIGNED.
01 t-vals.
    05 t-vals-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-left.
    05 t-left-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-right.
    05 t-right-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-stack.
    05 t-stack-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
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
        ADD 1 TO v-i
    END-PERFORM
    MOVE 1 TO v-i
    MOVE v-n TO w-5
    PERFORM UNTIL 1 = 2
        IF v-i >= w-5
            EXIT PERFORM
        END-IF
        MOVE 0 TO v-cur
        MOVE 0 TO v-placed
        PERFORM UNTIL 1 = 2
            IF v-placed = 0
                MOVE 1 TO f-2
            ELSE
                MOVE 0 TO f-2
            END-IF
            IF f-2 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-6 = v-i + 1
            MOVE t-vals-e(w-6) TO w-7
            COMPUTE w-8 = v-cur + 1
            MOVE t-vals-e(w-8) TO w-9
            IF w-7 < w-9
                MOVE 1 TO f-3
            ELSE
                MOVE 0 TO f-3
            END-IF
            IF f-3 = 1
                COMPUTE w-10 = v-cur + 1
                MOVE t-left-e(w-10) TO w-11
                IF w-11 = 0
                    MOVE 1 TO f-4
                ELSE
                    MOVE 0 TO f-4
                END-IF
                IF f-4 = 1
                    COMPUTE w-12 = v-i + 1
                    COMPUTE w-13 = v-cur + 1
                    MOVE w-12 TO t-left-e(w-13)
                    MOVE 1 TO v-placed
                ELSE
                    COMPUTE w-14 = v-cur + 1
                    MOVE t-left-e(w-14) TO w-15
                    COMPUTE w-16 = w-15 - 1
                    MOVE w-16 TO v-cur
                END-IF
            ELSE
                COMPUTE w-17 = v-cur + 1
                MOVE t-right-e(w-17) TO w-18
                IF w-18 = 0
                    MOVE 1 TO f-5
                ELSE
                    MOVE 0 TO f-5
                END-IF
                IF f-5 = 1
                    COMPUTE w-19 = v-i + 1
                    COMPUTE w-20 = v-cur + 1
                    MOVE w-19 TO t-right-e(w-20)
                    MOVE 1 TO v-placed
                ELSE
                    COMPUTE w-21 = v-cur + 1
                    MOVE t-right-e(w-21) TO w-22
                    COMPUTE w-23 = w-22 - 1
                    MOVE w-23 TO v-cur
                END-IF
            END-IF
        END-PERFORM
        ADD 1 TO v-i
    END-PERFORM
    MOVE 1 TO v-node
    MOVE 0 TO v-sp
    MOVE 0 TO v-out
    PERFORM UNTIL 1 = 2
        IF v-node NOT = 0
            MOVE 1 TO f-6
        ELSE
            MOVE 0 TO f-6
        END-IF
        IF f-6 = 0
            IF v-sp > 0
                MOVE 1 TO f-6
            ELSE
                MOVE 0 TO f-6
            END-IF
        END-IF
        IF f-6 = 0
            EXIT PERFORM
        END-IF
        IF v-node NOT = 0
            MOVE 1 TO f-7
        ELSE
            MOVE 0 TO f-7
        END-IF
        IF f-7 = 1
            COMPUTE w-24 = v-sp + 1
            MOVE v-node TO t-stack-e(w-24)
            COMPUTE w-25 = v-sp + 1
            MOVE w-25 TO v-sp
            COMPUTE w-26 = v-node - 1
            COMPUTE w-27 = w-26 + 1
            MOVE t-left-e(w-27) TO w-28
            MOVE w-28 TO v-node
        ELSE
            COMPUTE w-29 = v-sp - 1
            MOVE w-29 TO v-sp
            COMPUTE w-30 = v-sp + 1
            MOVE t-stack-e(w-30) TO w-31
            MOVE w-31 TO v-node
            COMPUTE w-32 = v-node - 1
            COMPUTE w-33 = w-32 + 1
            MOVE t-vals-e(w-33) TO w-34
            COMPUTE w-35 = v-out + 1
            MOVE w-34 TO t-a-e(w-35)
            COMPUTE w-36 = v-out + 1
            MOVE w-36 TO v-out
            COMPUTE w-37 = v-node - 1
            COMPUTE w-38 = w-37 + 1
            MOVE t-right-e(w-38) TO w-39
            MOVE w-39 TO v-node
        END-IF
    END-PERFORM
    GOBACK.
END PROGRAM tree-sort.

