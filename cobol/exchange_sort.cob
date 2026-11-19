      *> GENERATED from kernels/algos/exchange_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. exchange-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-i USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-n USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-a BY VALUE v-n.
    COMPUTE w-1 = v-n - 1
    MOVE 0 TO v-i
    MOVE w-1 TO w-2
    PERFORM UNTIL 1 = 2
        IF v-i >= w-2
            EXIT PERFORM
        END-IF
        COMPUTE w-3 = v-i + 1
        MOVE w-3 TO v-j
        MOVE v-n TO w-4
        PERFORM UNTIL 1 = 2
            IF v-j >= w-4
                EXIT PERFORM
            END-IF
            COMPUTE w-5 = v-j + 1
            MOVE t-a-e(w-5) TO w-6
            COMPUTE w-7 = v-i + 1
            MOVE t-a-e(w-7) TO w-8
            IF w-6 < w-8
                MOVE 1 TO f-1
            ELSE
                MOVE 0 TO f-1
            END-IF
            IF f-1 = 1
                COMPUTE w-9 = v-i + 1
                COMPUTE w-10 = v-j + 1
                MOVE t-a-e(w-9) TO w-11
                MOVE t-a-e(w-10) TO t-a-e(w-9)
                MOVE w-11 TO t-a-e(w-10)
            END-IF
            ADD 1 TO v-j
        END-PERFORM
        ADD 1 TO v-i
    END-PERFORM
    GOBACK.
END PROGRAM exchange-sort.

