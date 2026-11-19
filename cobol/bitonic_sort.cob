      *> GENERATED from kernels/algos/bitonic_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. bitonic-sort-x-cmp-swap IS RECURSIVE.
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
PROCEDURE DIVISION USING BY REFERENCE t-a BY VALUE v-i BY VALUE v-j.
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
END PROGRAM bitonic-sort-x-cmp-swap.

IDENTIFICATION DIVISION.
PROGRAM-ID. bitonic-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-size USAGE BINARY-DOUBLE SIGNED.
01 v-k USAGE BINARY-DOUBLE SIGNED.
01 v-blk USAGE BINARY-DOUBLE SIGNED.
01 v-t USAGE BINARY-DOUBLE SIGNED.
01 v-j USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
01 f-5 USAGE BINARY-DOUBLE SIGNED.
01 f-6 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-n USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-a BY VALUE v-n.
    MOVE 1 TO v-size
    PERFORM UNTIL 1 = 2
        IF v-size < v-n
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-1 = v-size * 2
        MOVE w-1 TO v-size
    END-PERFORM
    MOVE 2 TO v-k
    PERFORM UNTIL 1 = 2
        IF v-k <= v-size
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 0
            EXIT PERFORM
        END-IF
        MOVE 0 TO v-blk
        PERFORM UNTIL 1 = 2
            IF v-blk < v-size
                MOVE 1 TO f-3
            ELSE
                MOVE 0 TO f-3
            END-IF
            IF f-3 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-2 = FUNCTION INTEGER-PART(v-k / 2)
            MOVE 0 TO v-t
            MOVE w-2 TO w-3
            PERFORM UNTIL 1 = 2
                IF v-t >= w-3
                    EXIT PERFORM
                END-IF
                COMPUTE w-4 = v-blk + v-k
                COMPUTE w-5 = w-4 - 1
                COMPUTE w-6 = w-5 - v-t
                MOVE w-6 TO v-j
                IF v-j < v-n
                    MOVE 1 TO f-4
                ELSE
                    MOVE 0 TO f-4
                END-IF
                IF f-4 = 1
                    COMPUTE w-7 = v-blk + v-t
                    CALL "bitonic-sort-x-cmp-swap" USING BY REFERENCE t-a BY VALUE w-7 BY VALUE v-j
                    END-CALL
                END-IF
                ADD 1 TO v-t
            END-PERFORM
            COMPUTE w-8 = v-blk + v-k
            MOVE w-8 TO v-blk
        END-PERFORM
        COMPUTE w-9 = FUNCTION INTEGER-PART(v-k / 4)
        MOVE w-9 TO v-j
        PERFORM UNTIL 1 = 2
            IF v-j >= 1
                MOVE 1 TO f-5
            ELSE
                MOVE 0 TO f-5
            END-IF
            IF f-5 = 0
                EXIT PERFORM
            END-IF
            MOVE 0 TO v-i
            MOVE v-size TO w-10
            PERFORM UNTIL 1 = 2
                IF v-i >= w-10
                    EXIT PERFORM
                END-IF
                COMPUTE w-11 = FUNCTION INTEGER-PART(v-i / v-j)
                COMPUTE w-12 = FUNCTION MOD(w-11, 2)
                IF w-12 = 0
                    MOVE 1 TO f-6
                ELSE
                    MOVE 0 TO f-6
                END-IF
                IF f-6 = 1
                    COMPUTE w-13 = v-i + v-j
                    IF w-13 < v-n
                        MOVE 1 TO f-6
                    ELSE
                        MOVE 0 TO f-6
                    END-IF
                END-IF
                IF f-6 = 1
                    COMPUTE w-14 = v-i + v-j
                    CALL "bitonic-sort-x-cmp-swap" USING BY REFERENCE t-a BY VALUE v-i BY VALUE w-14
                    END-CALL
                END-IF
                ADD 1 TO v-i
            END-PERFORM
            COMPUTE w-15 = FUNCTION INTEGER-PART(v-j / 2)
            MOVE w-15 TO v-j
        END-PERFORM
        COMPUTE w-16 = v-k * 2
        MOVE w-16 TO v-k
    END-PERFORM
    GOBACK.
END PROGRAM bitonic-sort.

