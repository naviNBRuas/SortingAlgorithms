      *> GENERATED from kernels/algos/comb_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. comb-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-gap USAGE BINARY-DOUBLE SIGNED.
01 v-swapped USAGE BINARY-DOUBLE SIGNED.
01 v-i USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-n USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-a BY VALUE v-n.
    MOVE v-n TO v-gap
    MOVE 1 TO v-swapped
    PERFORM UNTIL 1 = 2
        IF v-gap > 1
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 0
            IF v-swapped = 1
                MOVE 1 TO f-1
            ELSE
                MOVE 0 TO f-1
            END-IF
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-1 = v-gap * 10
        COMPUTE w-2 = FUNCTION INTEGER-PART(w-1 / 13)
        MOVE w-2 TO v-gap
        IF v-gap < 1
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 1
            MOVE 1 TO v-gap
        END-IF
        MOVE 0 TO v-swapped
        MOVE 0 TO v-i
        PERFORM UNTIL 1 = 2
            COMPUTE w-3 = v-i + v-gap
            IF w-3 < v-n
                MOVE 1 TO f-3
            ELSE
                MOVE 0 TO f-3
            END-IF
            IF f-3 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-4 = v-i + 1
            MOVE t-a-e(w-4) TO w-5
            COMPUTE w-6 = v-i + v-gap
            COMPUTE w-7 = w-6 + 1
            MOVE t-a-e(w-7) TO w-8
            IF w-5 > w-8
                MOVE 1 TO f-4
            ELSE
                MOVE 0 TO f-4
            END-IF
            IF f-4 = 1
                COMPUTE w-9 = v-i + v-gap
                COMPUTE w-10 = v-i + 1
                COMPUTE w-11 = w-9 + 1
                MOVE t-a-e(w-10) TO w-12
                MOVE t-a-e(w-11) TO t-a-e(w-10)
                MOVE w-12 TO t-a-e(w-11)
                MOVE 1 TO v-swapped
            END-IF
            COMPUTE w-13 = v-i + 1
            MOVE w-13 TO v-i
        END-PERFORM
    END-PERFORM
    GOBACK.
END PROGRAM comb-sort.

