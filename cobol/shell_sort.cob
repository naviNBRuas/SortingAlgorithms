      *> GENERATED from kernels/algos/shell_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. shell-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-gap USAGE BINARY-DOUBLE SIGNED.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 v-key USAGE BINARY-DOUBLE SIGNED.
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
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-n USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING t-a v-n.
    COMPUTE w-1 = FUNCTION INTEGER-PART(v-n / 2)
    MOVE w-1 TO v-gap
    PERFORM UNTIL 1 = 2
        IF v-gap > 0
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        MOVE v-gap TO v-i
        MOVE v-n TO w-2
        PERFORM UNTIL 1 = 2
            IF v-i >= w-2
                EXIT PERFORM
            END-IF
            COMPUTE w-3 = v-i + 1
            MOVE t-a-e(w-3) TO w-4
            MOVE w-4 TO v-key
            MOVE v-i TO v-j
            PERFORM UNTIL 1 = 2
                IF v-j >= v-gap
                    MOVE 1 TO f-2
                ELSE
                    MOVE 0 TO f-2
                END-IF
                IF f-2 = 1
                    COMPUTE w-5 = v-j - v-gap
                    COMPUTE w-6 = w-5 + 1
                    MOVE t-a-e(w-6) TO w-7
                    IF w-7 > v-key
                        MOVE 1 TO f-2
                    ELSE
                        MOVE 0 TO f-2
                    END-IF
                END-IF
                IF f-2 = 0
                    EXIT PERFORM
                END-IF
                COMPUTE w-8 = v-j - v-gap
                COMPUTE w-9 = w-8 + 1
                MOVE t-a-e(w-9) TO w-10
                COMPUTE w-11 = v-j + 1
                MOVE w-10 TO t-a-e(w-11)
                COMPUTE w-12 = v-j - v-gap
                MOVE w-12 TO v-j
            END-PERFORM
            COMPUTE w-13 = v-j + 1
            MOVE v-key TO t-a-e(w-13)
            ADD 1 TO v-i
        END-PERFORM
        COMPUTE w-14 = FUNCTION INTEGER-PART(v-gap / 2)
        MOVE w-14 TO v-gap
    END-PERFORM
    GOBACK.
END PROGRAM shell-sort.

