      *> GENERATED from kernels/algos/shell_sort_ciura.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. shell-sort-ciura IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-k USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 t-g.
    05 t-g-e USAGE BINARY-LONG SIGNED OCCURS 10 TIMES.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-n USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-a BY VALUE v-n.
    INITIALIZE t-g
    COMPUTE w-1 = 0 + 1
    MOVE 1 TO t-g-e(w-1)
    COMPUTE w-2 = 1 + 1
    MOVE 4 TO t-g-e(w-2)
    COMPUTE w-3 = 2 + 1
    MOVE 10 TO t-g-e(w-3)
    COMPUTE w-4 = 3 + 1
    MOVE 23 TO t-g-e(w-4)
    COMPUTE w-5 = 4 + 1
    MOVE 57 TO t-g-e(w-5)
    COMPUTE w-6 = 5 + 1
    MOVE 132 TO t-g-e(w-6)
    COMPUTE w-7 = 6 + 1
    MOVE 301 TO t-g-e(w-7)
    COMPUTE w-8 = 7 + 1
    MOVE 701 TO t-g-e(w-8)
    COMPUTE w-9 = 8 + 1
    MOVE 1750 TO t-g-e(w-9)
    COMPUTE w-10 = 9 + 1
    MOVE 4377 TO t-g-e(w-10)
    MOVE 9 TO v-k
    PERFORM UNTIL 1 = 2
        IF v-k >= 0
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-11 = v-k + 1
        MOVE t-g-e(w-11) TO w-12
        MOVE w-12 TO v-gap
        IF v-gap < v-n
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 1
            MOVE v-gap TO v-i
            MOVE v-n TO w-13
            PERFORM UNTIL 1 = 2
                IF v-i >= w-13
                    EXIT PERFORM
                END-IF
                COMPUTE w-14 = v-i + 1
                MOVE t-a-e(w-14) TO w-15
                MOVE w-15 TO v-key
                MOVE v-i TO v-j
                PERFORM UNTIL 1 = 2
                    IF v-j >= v-gap
                        MOVE 1 TO f-3
                    ELSE
                        MOVE 0 TO f-3
                    END-IF
                    IF f-3 = 1
                        COMPUTE w-16 = v-j - v-gap
                        COMPUTE w-17 = w-16 + 1
                        MOVE t-a-e(w-17) TO w-18
                        IF w-18 > v-key
                            MOVE 1 TO f-3
                        ELSE
                            MOVE 0 TO f-3
                        END-IF
                    END-IF
                    IF f-3 = 0
                        EXIT PERFORM
                    END-IF
                    COMPUTE w-19 = v-j - v-gap
                    COMPUTE w-20 = w-19 + 1
                    MOVE t-a-e(w-20) TO w-21
                    COMPUTE w-22 = v-j + 1
                    MOVE w-21 TO t-a-e(w-22)
                    COMPUTE w-23 = v-j - v-gap
                    MOVE w-23 TO v-j
                END-PERFORM
                COMPUTE w-24 = v-j + 1
                MOVE v-key TO t-a-e(w-24)
                ADD 1 TO v-i
            END-PERFORM
        END-IF
        COMPUTE w-25 = v-k - 1
        MOVE w-25 TO v-k
    END-PERFORM
    GOBACK.
END PROGRAM shell-sort-ciura.

