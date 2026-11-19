      *> GENERATED from kernels/algos/bead_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. bs3e8-fallback IS RECURSIVE.
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
END PROGRAM bs3e8-fallback.

IDENTIFICATION DIVISION.
PROGRAM-ID. bead-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-mn USAGE BINARY-DOUBLE SIGNED.
01 v-mx USAGE BINARY-DOUBLE SIGNED.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 v-maxv USAGE BINARY-DOUBLE SIGNED.
01 v-r USAGE BINARY-DOUBLE SIGNED.
01 v-level USAGE BINARY-DOUBLE SIGNED.
01 v-k USAGE BINARY-DOUBLE SIGNED.
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
01 w-34 USAGE BINARY-DOUBLE SIGNED.
01 w-35 USAGE BINARY-DOUBLE SIGNED.
01 w-36 USAGE BINARY-DOUBLE SIGNED.
01 w-37 USAGE BINARY-DOUBLE SIGNED.
01 w-38 USAGE BINARY-DOUBLE SIGNED.
01 w-39 USAGE BINARY-DOUBLE SIGNED.
01 w-40 USAGE BINARY-DOUBLE SIGNED.
01 w-41 USAGE BINARY-DOUBLE SIGNED.
01 w-42 USAGE BINARY-DOUBLE SIGNED.
01 w-43 USAGE BINARY-DOUBLE SIGNED.
01 w-44 USAGE BINARY-DOUBLE SIGNED.
01 w-45 USAGE BINARY-DOUBLE SIGNED.
01 w-46 USAGE BINARY-DOUBLE SIGNED.
01 w-47 USAGE BINARY-DOUBLE SIGNED.
01 w-48 USAGE BINARY-DOUBLE SIGNED.
01 w-49 USAGE BINARY-DOUBLE SIGNED.
01 w-50 USAGE BINARY-DOUBLE SIGNED.
01 w-51 USAGE BINARY-DOUBLE SIGNED.
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
01 f-5 USAGE BINARY-DOUBLE SIGNED.
01 t-ge.
    05 t-ge-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-rods.
    05 t-rods-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
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
    MOVE w-14 TO v-maxv
    IF v-maxv > 20000
        MOVE 1 TO f-4
    ELSE
        MOVE 0 TO f-4
    END-IF
    IF f-4 = 1
        CALL "bs3e8-fallback" USING BY REFERENCE t-a BY CONTENT v-n
        END-CALL
        GOBACK
    END-IF
    INITIALIZE t-ge
    INITIALIZE t-rods
    MOVE 0 TO v-i
    MOVE v-n TO w-15
    PERFORM UNTIL 1 = 2
        IF v-i >= w-15
            EXIT PERFORM
        END-IF
        COMPUTE w-16 = v-i + 1
        MOVE t-a-e(w-16) TO w-17
        COMPUTE w-18 = w-17 - v-mn
        COMPUTE w-19 = w-18 + 1
        MOVE t-ge-e(w-19) TO w-20
        COMPUTE w-21 = w-20 + 1
        COMPUTE w-22 = v-i + 1
        MOVE t-a-e(w-22) TO w-23
        COMPUTE w-24 = w-23 - v-mn
        COMPUTE w-25 = w-24 + 1
        MOVE w-21 TO t-ge-e(w-25)
        ADD 1 TO v-i
    END-PERFORM
    MOVE v-maxv TO v-r
    PERFORM UNTIL 1 = 2
        IF v-r > 0
            MOVE 1 TO f-5
        ELSE
            MOVE 0 TO f-5
        END-IF
        IF f-5 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-26 = v-r - 1
        MOVE w-26 TO v-r
        COMPUTE w-27 = v-r + 1
        MOVE t-ge-e(w-27) TO w-28
        COMPUTE w-29 = v-r + 1
        COMPUTE w-30 = w-29 + 1
        MOVE t-ge-e(w-30) TO w-31
        COMPUTE w-32 = w-28 + w-31
        COMPUTE w-33 = v-r + 1
        MOVE w-32 TO t-ge-e(w-33)
    END-PERFORM
    COMPUTE w-34 = v-maxv + 1
    MOVE 1 TO v-level
    MOVE w-34 TO w-35
    PERFORM UNTIL 1 = 2
        IF v-level >= w-35
            EXIT PERFORM
        END-IF
        COMPUTE w-36 = v-level + 1
        MOVE t-ge-e(w-36) TO w-37
        MOVE 0 TO v-k
        MOVE w-37 TO w-38
        PERFORM UNTIL 1 = 2
            IF v-k >= w-38
                EXIT PERFORM
            END-IF
            COMPUTE w-39 = v-n - 1
            COMPUTE w-40 = w-39 - v-k
            COMPUTE w-41 = w-40 + 1
            MOVE t-rods-e(w-41) TO w-42
            COMPUTE w-43 = w-42 + 1
            COMPUTE w-44 = v-n - 1
            COMPUTE w-45 = w-44 - v-k
            COMPUTE w-46 = w-45 + 1
            MOVE w-43 TO t-rods-e(w-46)
            ADD 1 TO v-k
        END-PERFORM
        ADD 1 TO v-level
    END-PERFORM
    MOVE 0 TO v-i
    MOVE v-n TO w-47
    PERFORM UNTIL 1 = 2
        IF v-i >= w-47
            EXIT PERFORM
        END-IF
        COMPUTE w-48 = v-i + 1
        MOVE t-rods-e(w-48) TO w-49
        COMPUTE w-50 = w-49 + v-mn
        COMPUTE w-51 = v-i + 1
        MOVE w-50 TO t-a-e(w-51)
        ADD 1 TO v-i
    END-PERFORM
    GOBACK.
END PROGRAM bead-sort.

