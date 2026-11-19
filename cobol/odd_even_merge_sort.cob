      *> GENERATED from kernels/algos/odd_even_merge_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. oemsfca-cmp-swap IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 w-1 USAGE BINARY-DOUBLE SIGNED.
01 w-2 USAGE BINARY-DOUBLE SIGNED.
01 w-3 USAGE BINARY-DOUBLE SIGNED.
01 w-4 USAGE BINARY-DOUBLE SIGNED.
01 w-5 USAGE BINARY-DOUBLE SIGNED.
01 w-6 USAGE BINARY-DOUBLE SIGNED.
01 w-7 USAGE BINARY-DOUBLE SIGNED.
01 f-1 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 v-j USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING t-a v-i v-j.
    COMPUTE w-1 = v-i + 1
    MOVE t-a-e(w-1) TO w-2
    COMPUTE w-3 = v-j + 1
    MOVE t-a-e(w-3) TO w-4
    IF w-2 > w-4
        MOVE 1 TO f-1
    ELSE
        MOVE 0 TO f-1
    END-IF
    IF f-1 = 1
        COMPUTE w-5 = v-i + 1
        COMPUTE w-6 = v-j + 1
        MOVE t-a-e(w-5) TO w-7
        MOVE t-a-e(w-6) TO t-a-e(w-5)
        MOVE w-7 TO t-a-e(w-6)
    END-IF
    GOBACK.
END PROGRAM oemsfca-cmp-swap.

IDENTIFICATION DIVISION.
PROGRAM-ID. odd-even-merge-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-p USAGE BINARY-DOUBLE SIGNED.
01 v-k USAGE BINARY-DOUBLE SIGNED.
01 v-j USAGE BINARY-DOUBLE SIGNED.
01 v-lim USAGE BINARY-DOUBLE SIGNED.
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
01 w-14 USAGE BINARY-DOUBLE SIGNED.
01 w-15 USAGE BINARY-DOUBLE SIGNED.
01 w-16 USAGE BINARY-DOUBLE SIGNED.
01 w-17 USAGE BINARY-DOUBLE SIGNED.
01 w-18 USAGE BINARY-DOUBLE SIGNED.
01 w-19 USAGE BINARY-DOUBLE SIGNED.
01 w-20 USAGE BINARY-DOUBLE SIGNED.
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-n USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING t-a v-n.
    MOVE 1 TO v-p
    PERFORM UNTIL 1 = 2
        IF v-p < v-n
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        MOVE v-p TO v-k
        PERFORM UNTIL 1 = 2
            IF v-k >= 1
                MOVE 1 TO f-2
            ELSE
                MOVE 0 TO f-2
            END-IF
            IF f-2 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-1 = FUNCTION MOD(v-k, v-p)
            MOVE w-1 TO v-j
            PERFORM UNTIL 1 = 2
                COMPUTE w-2 = v-n - v-k
                IF v-j < w-2
                    MOVE 1 TO f-3
                ELSE
                    MOVE 0 TO f-3
                END-IF
                IF f-3 = 0
                    EXIT PERFORM
                END-IF
                COMPUTE w-3 = v-n - v-j
                COMPUTE w-4 = w-3 - v-k
                IF v-k < w-4
                    MOVE v-k TO w-5
                ELSE
                    MOVE w-4 TO w-5
                END-IF
                MOVE w-5 TO v-lim
                MOVE 0 TO v-i
                MOVE v-lim TO w-6
                PERFORM UNTIL 1 = 2
                    IF v-i >= w-6
                        EXIT PERFORM
                    END-IF
                    COMPUTE w-7 = v-i + v-j
                    COMPUTE w-8 = 2 * v-p
                    COMPUTE w-9 = FUNCTION INTEGER-PART(w-7 / w-8)
                    COMPUTE w-10 = v-i + v-j
                    COMPUTE w-11 = w-10 + v-k
                    COMPUTE w-12 = 2 * v-p
                    COMPUTE w-13 = FUNCTION INTEGER-PART(w-11 / w-12)
                    IF w-9 = w-13
                        MOVE 1 TO f-4
                    ELSE
                        MOVE 0 TO f-4
                    END-IF
                    IF f-4 = 1
                        COMPUTE w-14 = v-i + v-j
                        COMPUTE w-15 = v-i + v-j
                        COMPUTE w-16 = w-15 + v-k
                        CALL "oemsfca-cmp-swap" USING BY REFERENCE t-a BY CONTENT w-14 BY CONTENT w-16
                        END-CALL
                    END-IF
                    ADD 1 TO v-i
                END-PERFORM
                COMPUTE w-17 = 2 * v-k
                COMPUTE w-18 = v-j + w-17
                MOVE w-18 TO v-j
            END-PERFORM
            COMPUTE w-19 = FUNCTION INTEGER-PART(v-k / 2)
            MOVE w-19 TO v-k
        END-PERFORM
        COMPUTE w-20 = v-p * 2
        MOVE w-20 TO v-p
    END-PERFORM
    GOBACK.
END PROGRAM odd-even-merge-sort.

