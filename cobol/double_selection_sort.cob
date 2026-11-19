      *> GENERATED from kernels/algos/double_selection_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. double-selection-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-lo USAGE BINARY-DOUBLE SIGNED.
01 v-hi USAGE BINARY-DOUBLE SIGNED.
01 v-mn USAGE BINARY-DOUBLE SIGNED.
01 v-mx USAGE BINARY-DOUBLE SIGNED.
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
01 w-15 USAGE BINARY-DOUBLE SIGNED.
01 w-16 USAGE BINARY-DOUBLE SIGNED.
01 w-17 USAGE BINARY-DOUBLE SIGNED.
01 w-18 USAGE BINARY-DOUBLE SIGNED.
01 w-19 USAGE BINARY-DOUBLE SIGNED.
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
01 f-5 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-n USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-a BY VALUE v-n.
    MOVE 0 TO v-lo
    COMPUTE w-1 = v-n - 1
    MOVE w-1 TO v-hi
    PERFORM UNTIL 1 = 2
        IF v-lo < v-hi
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        MOVE v-lo TO v-mn
        MOVE v-lo TO v-mx
        COMPUTE w-2 = v-lo + 1
        MOVE w-2 TO v-j
        PERFORM UNTIL 1 = 2
            IF v-j <= v-hi
                MOVE 1 TO f-2
            ELSE
                MOVE 0 TO f-2
            END-IF
            IF f-2 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-3 = v-j + 1
            MOVE t-a-e(w-3) TO w-4
            COMPUTE w-5 = v-mn + 1
            MOVE t-a-e(w-5) TO w-6
            IF w-4 < w-6
                MOVE 1 TO f-3
            ELSE
                MOVE 0 TO f-3
            END-IF
            IF f-3 = 1
                MOVE v-j TO v-mn
            ELSE
                COMPUTE w-7 = v-j + 1
                MOVE t-a-e(w-7) TO w-8
                COMPUTE w-9 = v-mx + 1
                MOVE t-a-e(w-9) TO w-10
                IF w-8 > w-10
                    MOVE 1 TO f-4
                ELSE
                    MOVE 0 TO f-4
                END-IF
                IF f-4 = 1
                    MOVE v-j TO v-mx
                END-IF
            END-IF
            COMPUTE w-11 = v-j + 1
            MOVE w-11 TO v-j
        END-PERFORM
        COMPUTE w-12 = v-lo + 1
        COMPUTE w-13 = v-mn + 1
        MOVE t-a-e(w-12) TO w-14
        MOVE t-a-e(w-13) TO t-a-e(w-12)
        MOVE w-14 TO t-a-e(w-13)
        IF v-mx = v-lo
            MOVE 1 TO f-5
        ELSE
            MOVE 0 TO f-5
        END-IF
        IF f-5 = 1
            MOVE v-mn TO v-mx
        END-IF
        COMPUTE w-15 = v-hi + 1
        COMPUTE w-16 = v-mx + 1
        MOVE t-a-e(w-15) TO w-17
        MOVE t-a-e(w-16) TO t-a-e(w-15)
        MOVE w-17 TO t-a-e(w-16)
        COMPUTE w-18 = v-lo + 1
        MOVE w-18 TO v-lo
        COMPUTE w-19 = v-hi - 1
        MOVE w-19 TO v-hi
    END-PERFORM
    GOBACK.
END PROGRAM double-selection-sort.

