      *> GENERATED from kernels/algos/pairwise_sorting_network.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. psnd28-cmp-swap IS RECURSIVE.
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
01 f-2 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 v-j USAGE BINARY-DOUBLE SIGNED.
01 v-n USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING t-a v-i v-j v-n.
    IF v-j < v-n
        MOVE 1 TO f-1
    ELSE
        MOVE 0 TO f-1
    END-IF
    IF f-1 = 1
        COMPUTE w-1 = v-i + 1
        MOVE t-a-e(w-1) TO w-2
        COMPUTE w-3 = v-j + 1
        MOVE t-a-e(w-3) TO w-4
        IF w-2 > w-4
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 1
            COMPUTE w-5 = v-i + 1
            COMPUTE w-6 = v-j + 1
            MOVE t-a-e(w-5) TO w-7
            MOVE t-a-e(w-6) TO t-a-e(w-5)
            MOVE w-7 TO t-a-e(w-6)
        END-IF
    END-IF
    GOBACK.
END PROGRAM psnd28-cmp-swap.

IDENTIFICATION DIVISION.
PROGRAM-ID. pairwise-sorting-network IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-size USAGE BINARY-DOUBLE SIGNED.
01 v-step USAGE BINARY-DOUBLE SIGNED.
01 v-b USAGE BINARY-DOUBLE SIGNED.
01 v-c USAGE BINARY-DOUBLE SIGNED.
01 v-e USAGE BINARY-DOUBLE SIGNED.
01 v-d USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
01 f-5 USAGE BINARY-DOUBLE SIGNED.
01 f-6 USAGE BINARY-DOUBLE SIGNED.
01 f-7 USAGE BINARY-DOUBLE SIGNED.
01 f-8 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-n USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING t-a v-n.
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
    MOVE 1 TO v-step
    PERFORM UNTIL 1 = 2
        IF v-step < v-size
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 0
            EXIT PERFORM
        END-IF
        MOVE v-step TO v-b
        MOVE 0 TO v-c
        PERFORM UNTIL 1 = 2
            IF v-b < v-size
                MOVE 1 TO f-3
            ELSE
                MOVE 0 TO f-3
            END-IF
            IF f-3 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-2 = v-b - v-step
            CALL "psnd28-cmp-swap" USING BY REFERENCE t-a BY CONTENT w-2 BY CONTENT v-b BY CONTENT v-n
            END-CALL
            COMPUTE w-3 = v-b + 1
            MOVE w-3 TO v-b
            COMPUTE w-4 = v-c + 1
            MOVE w-4 TO v-c
            IF v-c >= v-step
                MOVE 1 TO f-4
            ELSE
                MOVE 0 TO f-4
            END-IF
            IF f-4 = 1
                MOVE 0 TO v-c
                COMPUTE w-5 = v-b + v-step
                MOVE w-5 TO v-b
            END-IF
        END-PERFORM
        COMPUTE w-6 = v-step * 2
        MOVE w-6 TO v-step
    END-PERFORM
    COMPUTE w-7 = FUNCTION INTEGER-PART(v-step / 4)
    MOVE w-7 TO v-step
    MOVE 1 TO v-e
    PERFORM UNTIL 1 = 2
        IF v-step > 0
            MOVE 1 TO f-5
        ELSE
            MOVE 0 TO f-5
        END-IF
        IF f-5 = 0
            EXIT PERFORM
        END-IF
        MOVE v-e TO v-d
        PERFORM UNTIL 1 = 2
            IF v-d > 0
                MOVE 1 TO f-6
            ELSE
                MOVE 0 TO f-6
            END-IF
            IF f-6 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-8 = v-d + 1
            COMPUTE w-9 = w-8 * v-step
            MOVE w-9 TO v-b
            MOVE 0 TO v-c
            PERFORM UNTIL 1 = 2
                IF v-b < v-size
                    MOVE 1 TO f-7
                ELSE
                    MOVE 0 TO f-7
                END-IF
                IF f-7 = 0
                    EXIT PERFORM
                END-IF
                COMPUTE w-10 = v-d * v-step
                COMPUTE w-11 = v-b - w-10
                CALL "psnd28-cmp-swap" USING BY REFERENCE t-a BY CONTENT w-11 BY CONTENT v-b BY CONTENT v-n
                END-CALL
                COMPUTE w-12 = v-b + 1
                MOVE w-12 TO v-b
                COMPUTE w-13 = v-c + 1
                MOVE w-13 TO v-c
                IF v-c >= v-step
                    MOVE 1 TO f-8
                ELSE
                    MOVE 0 TO f-8
                END-IF
                IF f-8 = 1
                    MOVE 0 TO v-c
                    COMPUTE w-14 = v-b + v-step
                    MOVE w-14 TO v-b
                END-IF
            END-PERFORM
            COMPUTE w-15 = FUNCTION INTEGER-PART(v-d / 2)
            MOVE w-15 TO v-d
        END-PERFORM
        COMPUTE w-16 = FUNCTION INTEGER-PART(v-step / 2)
        MOVE w-16 TO v-step
        COMPUTE w-17 = v-e * 2
        COMPUTE w-18 = w-17 + 1
        MOVE w-18 TO v-e
    END-PERFORM
    GOBACK.
END PROGRAM pairwise-sorting-network.

