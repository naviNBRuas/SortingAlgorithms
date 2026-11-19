      *> GENERATED from kernels/algos/tournament_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. ts636-better IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 w-1 USAGE BINARY-DOUBLE SIGNED.
01 w-2 USAGE BINARY-DOUBLE SIGNED.
01 w-3 USAGE BINARY-DOUBLE SIGNED.
01 w-4 USAGE BINARY-DOUBLE SIGNED.
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-vals.
    05 t-vals-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-x USAGE BINARY-DOUBLE SIGNED.
01 v-y USAGE BINARY-DOUBLE SIGNED.
01 r-val USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING t-vals v-x v-y r-val.
    IF v-x < 0
        MOVE 1 TO f-1
    ELSE
        MOVE 0 TO f-1
    END-IF
    IF f-1 = 1
        MOVE v-y TO r-val
        GOBACK
    END-IF
    IF v-y < 0
        MOVE 1 TO f-2
    ELSE
        MOVE 0 TO f-2
    END-IF
    IF f-2 = 1
        MOVE v-x TO r-val
        GOBACK
    END-IF
    COMPUTE w-1 = v-x + 1
    MOVE t-vals-e(w-1) TO w-2
    COMPUTE w-3 = v-y + 1
    MOVE t-vals-e(w-3) TO w-4
    IF w-2 <= w-4
        MOVE 1 TO f-3
    ELSE
        MOVE 0 TO f-3
    END-IF
    IF f-3 = 1
        MOVE v-x TO r-val
        GOBACK
    END-IF
    MOVE v-y TO r-val
    GOBACK
    GOBACK.
END PROGRAM ts636-better.

IDENTIFICATION DIVISION.
PROGRAM-ID. tournament-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-size USAGE BINARY-DOUBLE SIGNED.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 v-k USAGE BINARY-DOUBLE SIGNED.
01 v-w USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
01 t-vals.
    05 t-vals-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-out.
    05 t-out-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-tree.
    05 t-tree-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
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
    MOVE 1 TO v-size
    PERFORM UNTIL 1 = 2
        IF v-size < v-n
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-1 = v-size * 2
        MOVE w-1 TO v-size
    END-PERFORM
    INITIALIZE t-vals
    INITIALIZE t-out
    INITIALIZE t-tree
    COMPUTE w-2 = 2 * v-size
    MOVE 0 TO v-i
    MOVE w-2 TO w-3
    PERFORM UNTIL 1 = 2
        IF v-i >= w-3
            EXIT PERFORM
        END-IF
        COMPUTE w-4 = 0 - 1
        COMPUTE w-5 = v-i + 1
        MOVE w-4 TO t-tree-e(w-5)
        ADD 1 TO v-i
    END-PERFORM
    MOVE 0 TO v-i
    MOVE v-n TO w-6
    PERFORM UNTIL 1 = 2
        IF v-i >= w-6
            EXIT PERFORM
        END-IF
        COMPUTE w-7 = v-i + 1
        MOVE t-a-e(w-7) TO w-8
        COMPUTE w-9 = v-i + 1
        MOVE w-8 TO t-vals-e(w-9)
        COMPUTE w-10 = v-size + v-i
        COMPUTE w-11 = w-10 + 1
        MOVE v-i TO t-tree-e(w-11)
        ADD 1 TO v-i
    END-PERFORM
    COMPUTE w-12 = v-size - 1
    MOVE w-12 TO v-i
    PERFORM UNTIL 1 = 2
        IF v-i >= 1
            MOVE 1 TO f-3
        ELSE
            MOVE 0 TO f-3
        END-IF
        IF f-3 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-13 = 2 * v-i
        COMPUTE w-14 = w-13 + 1
        MOVE t-tree-e(w-14) TO w-15
        COMPUTE w-16 = 2 * v-i
        COMPUTE w-17 = w-16 + 1
        COMPUTE w-18 = w-17 + 1
        MOVE t-tree-e(w-18) TO w-19
        CALL "ts636-better" USING BY REFERENCE t-vals BY CONTENT w-15 BY CONTENT w-19 BY REFERENCE w-20
        END-CALL
        COMPUTE w-21 = v-i + 1
        MOVE w-20 TO t-tree-e(w-21)
        COMPUTE w-22 = v-i - 1
        MOVE w-22 TO v-i
    END-PERFORM
    MOVE 0 TO v-k
    MOVE v-n TO w-23
    PERFORM UNTIL 1 = 2
        IF v-k >= w-23
            EXIT PERFORM
        END-IF
        COMPUTE w-24 = 1 + 1
        MOVE t-tree-e(w-24) TO w-25
        MOVE w-25 TO v-w
        COMPUTE w-26 = v-w + 1
        MOVE t-vals-e(w-26) TO w-27
        COMPUTE w-28 = v-k + 1
        MOVE w-27 TO t-out-e(w-28)
        COMPUTE w-29 = v-size + v-w
        MOVE w-29 TO v-node
        COMPUTE w-30 = 0 - 1
        COMPUTE w-31 = v-node + 1
        MOVE w-30 TO t-tree-e(w-31)
        COMPUTE w-32 = FUNCTION INTEGER-PART(v-node / 2)
        MOVE w-32 TO v-node
        PERFORM UNTIL 1 = 2
            IF v-node >= 1
                MOVE 1 TO f-4
            ELSE
                MOVE 0 TO f-4
            END-IF
            IF f-4 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-33 = 2 * v-node
            COMPUTE w-34 = w-33 + 1
            MOVE t-tree-e(w-34) TO w-35
            COMPUTE w-36 = 2 * v-node
            COMPUTE w-37 = w-36 + 1
            COMPUTE w-38 = w-37 + 1
            MOVE t-tree-e(w-38) TO w-39
            CALL "ts636-better" USING BY REFERENCE t-vals BY CONTENT w-35 BY CONTENT w-39 BY REFERENCE w-40
            END-CALL
            COMPUTE w-41 = v-node + 1
            MOVE w-40 TO t-tree-e(w-41)
            COMPUTE w-42 = FUNCTION INTEGER-PART(v-node / 2)
            MOVE w-42 TO v-node
        END-PERFORM
        ADD 1 TO v-k
    END-PERFORM
    MOVE 0 TO v-i
    MOVE v-n TO w-43
    PERFORM UNTIL 1 = 2
        IF v-i >= w-43
            EXIT PERFORM
        END-IF
        COMPUTE w-44 = v-i + 1
        MOVE t-out-e(w-44) TO w-45
        COMPUTE w-46 = v-i + 1
        MOVE w-45 TO t-a-e(w-46)
        ADD 1 TO v-i
    END-PERFORM
    GOBACK.
END PROGRAM tournament-sort.

