      *> GENERATED from kernels/algos/bubble_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. bubble-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-end USAGE BINARY-DOUBLE SIGNED.
01 v-swapped USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-n USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-a BY VALUE v-n.
    COMPUTE w-1 = v-n - 1
    MOVE w-1 TO v-end
    MOVE 1 TO v-swapped
    PERFORM UNTIL 1 = 2
        IF v-end > 0
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 1
            IF v-swapped = 1
                MOVE 1 TO f-1
            ELSE
                MOVE 0 TO f-1
            END-IF
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        MOVE 0 TO v-swapped
        MOVE 0 TO v-j
        PERFORM UNTIL 1 = 2
            IF v-j < v-end
                MOVE 1 TO f-2
            ELSE
                MOVE 0 TO f-2
            END-IF
            IF f-2 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-2 = v-j + 1
            MOVE t-a-e(w-2) TO w-3
            COMPUTE w-4 = v-j + 1
            COMPUTE w-5 = w-4 + 1
            MOVE t-a-e(w-5) TO w-6
            IF w-3 > w-6
                MOVE 1 TO f-3
            ELSE
                MOVE 0 TO f-3
            END-IF
            IF f-3 = 1
                COMPUTE w-7 = v-j + 1
                COMPUTE w-8 = v-j + 1
                COMPUTE w-9 = w-7 + 1
                MOVE t-a-e(w-8) TO w-10
                MOVE t-a-e(w-9) TO t-a-e(w-8)
                MOVE w-10 TO t-a-e(w-9)
                MOVE 1 TO v-swapped
            END-IF
            COMPUTE w-11 = v-j + 1
            MOVE w-11 TO v-j
        END-PERFORM
        COMPUTE w-12 = v-end - 1
        MOVE w-12 TO v-end
    END-PERFORM
    GOBACK.
END PROGRAM bubble-sort.

