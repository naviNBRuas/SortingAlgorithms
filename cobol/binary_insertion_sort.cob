      *> GENERATED from kernels/algos/binary_insertion_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. binary-insertion-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 v-key USAGE BINARY-DOUBLE SIGNED.
01 v-lo USAGE BINARY-DOUBLE SIGNED.
01 v-hi USAGE BINARY-DOUBLE SIGNED.
01 v-mid USAGE BINARY-DOUBLE SIGNED.
01 v-j USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-n USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-a BY VALUE v-n.
    MOVE 1 TO v-i
    MOVE v-n TO w-1
    PERFORM UNTIL 1 = 2
        IF v-i >= w-1
            EXIT PERFORM
        END-IF
        COMPUTE w-2 = v-i + 1
        MOVE t-a-e(w-2) TO w-3
        MOVE w-3 TO v-key
        MOVE 0 TO v-lo
        MOVE v-i TO v-hi
        PERFORM UNTIL 1 = 2
            IF v-lo < v-hi
                MOVE 1 TO f-1
            ELSE
                MOVE 0 TO f-1
            END-IF
            IF f-1 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-4 = v-lo + v-hi
            COMPUTE w-5 = FUNCTION INTEGER-PART(w-4 / 2)
            MOVE w-5 TO v-mid
            COMPUTE w-6 = v-mid + 1
            MOVE t-a-e(w-6) TO w-7
            IF v-key < w-7
                MOVE 1 TO f-2
            ELSE
                MOVE 0 TO f-2
            END-IF
            IF f-2 = 1
                MOVE v-mid TO v-hi
            ELSE
                COMPUTE w-8 = v-mid + 1
                MOVE w-8 TO v-lo
            END-IF
        END-PERFORM
        MOVE v-i TO v-j
        PERFORM UNTIL 1 = 2
            IF v-j > v-lo
                MOVE 1 TO f-3
            ELSE
                MOVE 0 TO f-3
            END-IF
            IF f-3 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-9 = v-j - 1
            COMPUTE w-10 = w-9 + 1
            MOVE t-a-e(w-10) TO w-11
            COMPUTE w-12 = v-j + 1
            MOVE w-11 TO t-a-e(w-12)
            COMPUTE w-13 = v-j - 1
            MOVE w-13 TO v-j
        END-PERFORM
        COMPUTE w-14 = v-lo + 1
        MOVE v-key TO t-a-e(w-14)
        ADD 1 TO v-i
    END-PERFORM
    GOBACK.
END PROGRAM binary-insertion-sort.

