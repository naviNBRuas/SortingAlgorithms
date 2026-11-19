      *> GENERATED from kernels/algos/bingo_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. bingo-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-mx USAGE BINARY-DOUBLE SIGNED.
01 v-nxt USAGE BINARY-DOUBLE SIGNED.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 v-bingo USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
01 f-5 USAGE BINARY-DOUBLE SIGNED.
01 f-6 USAGE BINARY-DOUBLE SIGNED.
01 f-7 USAGE BINARY-DOUBLE SIGNED.
01 f-8 USAGE BINARY-DOUBLE SIGNED.
01 f-9 USAGE BINARY-DOUBLE SIGNED.
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
    COMPUTE w-1 = v-n - 1
    MOVE w-1 TO v-mx
    COMPUTE w-2 = v-mx + 1
    MOVE t-a-e(w-2) TO w-3
    MOVE w-3 TO v-nxt
    COMPUTE w-4 = v-mx - 1
    MOVE w-4 TO v-i
    PERFORM UNTIL 1 = 2
        IF v-i >= 0
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-5 = v-i + 1
        MOVE t-a-e(w-5) TO w-6
        IF w-6 > v-nxt
            MOVE 1 TO f-3
        ELSE
            MOVE 0 TO f-3
        END-IF
        IF f-3 = 1
            COMPUTE w-7 = v-i + 1
            MOVE t-a-e(w-7) TO w-8
            MOVE w-8 TO v-nxt
        END-IF
        COMPUTE w-9 = v-i - 1
        MOVE w-9 TO v-i
    END-PERFORM
    PERFORM UNTIL 1 = 2
        IF v-mx > 0
            MOVE 1 TO f-4
        ELSE
            MOVE 0 TO f-4
        END-IF
        IF f-4 = 1
            COMPUTE w-10 = v-mx + 1
            MOVE t-a-e(w-10) TO w-11
            IF w-11 = v-nxt
                MOVE 1 TO f-4
            ELSE
                MOVE 0 TO f-4
            END-IF
        END-IF
        IF f-4 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-12 = v-mx - 1
        MOVE w-12 TO v-mx
    END-PERFORM
    PERFORM UNTIL 1 = 2
        IF v-mx > 0
            MOVE 1 TO f-5
        ELSE
            MOVE 0 TO f-5
        END-IF
        IF f-5 = 0
            EXIT PERFORM
        END-IF
        MOVE v-nxt TO v-bingo
        COMPUTE w-13 = v-mx + 1
        MOVE t-a-e(w-13) TO w-14
        MOVE w-14 TO v-nxt
        COMPUTE w-15 = v-mx - 1
        MOVE w-15 TO v-i
        PERFORM UNTIL 1 = 2
            IF v-i >= 0
                MOVE 1 TO f-6
            ELSE
                MOVE 0 TO f-6
            END-IF
            IF f-6 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-16 = v-i + 1
            MOVE t-a-e(w-16) TO w-17
            IF w-17 = v-bingo
                MOVE 1 TO f-7
            ELSE
                MOVE 0 TO f-7
            END-IF
            IF f-7 = 1
                COMPUTE w-18 = v-i + 1
                COMPUTE w-19 = v-mx + 1
                MOVE t-a-e(w-18) TO w-20
                MOVE t-a-e(w-19) TO t-a-e(w-18)
                MOVE w-20 TO t-a-e(w-19)
                COMPUTE w-21 = v-mx - 1
                MOVE w-21 TO v-mx
            ELSE
                COMPUTE w-22 = v-i + 1
                MOVE t-a-e(w-22) TO w-23
                IF w-23 > v-nxt
                    MOVE 1 TO f-8
                ELSE
                    MOVE 0 TO f-8
                END-IF
                IF f-8 = 1
                    COMPUTE w-24 = v-i + 1
                    MOVE t-a-e(w-24) TO w-25
                    MOVE w-25 TO v-nxt
                END-IF
            END-IF
            COMPUTE w-26 = v-i - 1
            MOVE w-26 TO v-i
        END-PERFORM
        PERFORM UNTIL 1 = 2
            IF v-mx > 0
                MOVE 1 TO f-9
            ELSE
                MOVE 0 TO f-9
            END-IF
            IF f-9 = 1
                COMPUTE w-27 = v-mx + 1
                MOVE t-a-e(w-27) TO w-28
                IF w-28 = v-nxt
                    MOVE 1 TO f-9
                ELSE
                    MOVE 0 TO f-9
                END-IF
            END-IF
            IF f-9 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-29 = v-mx - 1
            MOVE w-29 TO v-mx
        END-PERFORM
    END-PERFORM
    GOBACK.
END PROGRAM bingo-sort.

