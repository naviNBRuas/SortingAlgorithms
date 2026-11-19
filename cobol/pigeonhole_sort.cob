      *> GENERATED from kernels/algos/pigeonhole_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. psf20-fallback IS RECURSIVE.
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
END PROGRAM psf20-fallback.

IDENTIFICATION DIVISION.
PROGRAM-ID. pigeonhole-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-mn USAGE BINARY-DOUBLE SIGNED.
01 v-mx USAGE BINARY-DOUBLE SIGNED.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 v-rng USAGE BINARY-DOUBLE SIGNED.
01 v-k USAGE BINARY-DOUBLE SIGNED.
01 v-h USAGE BINARY-DOUBLE SIGNED.
01 v-c USAGE BINARY-DOUBLE SIGNED.
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
01 w-30 USAGE BINARY-DOUBLE SIGNED.
01 w-31 USAGE BINARY-DOUBLE SIGNED.
01 w-32 USAGE BINARY-DOUBLE SIGNED.
01 w-33 USAGE BINARY-DOUBLE SIGNED.
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
01 f-5 USAGE BINARY-DOUBLE SIGNED.
01 t-holes.
    05 t-holes-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-n USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING t-a v-n.
    IF v-n < 2
        MOVE 1 TO f-1
    ELSE
        MOVE 0 TO f-1
    END-IF
    IF f-1 = 1
        GOBACK
    END-IF
    COMPUTE w-1 = 0 + 1
    MOVE t-a-e(w-1) TO w-2
    MOVE w-2 TO v-mn
    COMPUTE w-3 = 0 + 1
    MOVE t-a-e(w-3) TO w-4
    MOVE w-4 TO v-mx
    MOVE 1 TO v-i
    MOVE v-n TO w-5
    PERFORM UNTIL 1 = 2
        IF v-i >= w-5
            EXIT PERFORM
        END-IF
        COMPUTE w-6 = v-i + 1
        MOVE t-a-e(w-6) TO w-7
        IF w-7 < v-mn
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 1
            COMPUTE w-8 = v-i + 1
            MOVE t-a-e(w-8) TO w-9
            MOVE w-9 TO v-mn
        END-IF
        COMPUTE w-10 = v-i + 1
        MOVE t-a-e(w-10) TO w-11
        IF w-11 > v-mx
            MOVE 1 TO f-3
        ELSE
            MOVE 0 TO f-3
        END-IF
        IF f-3 = 1
            COMPUTE w-12 = v-i + 1
            MOVE t-a-e(w-12) TO w-13
            MOVE w-13 TO v-mx
        END-IF
        ADD 1 TO v-i
    END-PERFORM
    COMPUTE w-14 = v-mx - v-mn
    COMPUTE w-15 = w-14 + 1
    MOVE w-15 TO v-rng
    IF v-rng > 60000
        MOVE 1 TO f-4
    ELSE
        MOVE 0 TO f-4
    END-IF
    IF f-4 = 1
        CALL "psf20-fallback" USING BY REFERENCE t-a BY CONTENT v-n
        END-CALL
        GOBACK
    END-IF
    INITIALIZE t-holes
    MOVE 0 TO v-i
    MOVE v-n TO w-16
    PERFORM UNTIL 1 = 2
        IF v-i >= w-16
            EXIT PERFORM
        END-IF
        COMPUTE w-17 = v-i + 1
        MOVE t-a-e(w-17) TO w-18
        COMPUTE w-19 = w-18 - v-mn
        COMPUTE w-20 = w-19 + 1
        MOVE t-holes-e(w-20) TO w-21
        COMPUTE w-22 = w-21 + 1
        COMPUTE w-23 = v-i + 1
        MOVE t-a-e(w-23) TO w-24
        COMPUTE w-25 = w-24 - v-mn
        COMPUTE w-26 = w-25 + 1
        MOVE w-22 TO t-holes-e(w-26)
        ADD 1 TO v-i
    END-PERFORM
    MOVE 0 TO v-k
    MOVE 0 TO v-h
    MOVE v-rng TO w-27
    PERFORM UNTIL 1 = 2
        IF v-h >= w-27
            EXIT PERFORM
        END-IF
        COMPUTE w-28 = v-h + 1
        MOVE t-holes-e(w-28) TO w-29
        MOVE w-29 TO v-c
        PERFORM UNTIL 1 = 2
            IF v-c > 0
                MOVE 1 TO f-5
            ELSE
                MOVE 0 TO f-5
            END-IF
            IF f-5 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-30 = v-mn + v-h
            COMPUTE w-31 = v-k + 1
            MOVE w-30 TO t-a-e(w-31)
            COMPUTE w-32 = v-k + 1
            MOVE w-32 TO v-k
            COMPUTE w-33 = v-c - 1
            MOVE w-33 TO v-c
        END-PERFORM
        ADD 1 TO v-h
    END-PERFORM
    GOBACK.
END PROGRAM pigeonhole-sort.

