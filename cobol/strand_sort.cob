      *> GENERATED from kernels/algos/strand_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. strand-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 v-left USAGE BINARY-DOUBLE SIGNED.
01 v-o USAGE BINARY-DOUBLE SIGNED.
01 v-s USAGE BINARY-DOUBLE SIGNED.
01 v-keep USAGE BINARY-DOUBLE SIGNED.
01 v-j USAGE BINARY-DOUBLE SIGNED.
01 v-k USAGE BINARY-DOUBLE SIGNED.
01 v-x USAGE BINARY-DOUBLE SIGNED.
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
01 w-52 USAGE BINARY-DOUBLE SIGNED.
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
01 f-5 USAGE BINARY-DOUBLE SIGNED.
01 f-6 USAGE BINARY-DOUBLE SIGNED.
01 f-7 USAGE BINARY-DOUBLE SIGNED.
01 t-rem.
    05 t-rem-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-strand.
    05 t-strand-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-out.
    05 t-out-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-tmp.
    05 t-tmp-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
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
    INITIALIZE t-rem
    INITIALIZE t-strand
    INITIALIZE t-out
    INITIALIZE t-tmp
    MOVE 0 TO v-i
    MOVE v-n TO w-1
    PERFORM UNTIL 1 = 2
        IF v-i >= w-1
            EXIT PERFORM
        END-IF
        COMPUTE w-2 = v-i + 1
        MOVE t-a-e(w-2) TO w-3
        COMPUTE w-4 = v-i + 1
        MOVE w-3 TO t-rem-e(w-4)
        ADD 1 TO v-i
    END-PERFORM
    MOVE v-n TO v-left
    MOVE 0 TO v-o
    PERFORM UNTIL 1 = 2
        IF v-left > 0
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-5 = 0 + 1
        MOVE t-rem-e(w-5) TO w-6
        COMPUTE w-7 = 0 + 1
        MOVE w-6 TO t-strand-e(w-7)
        MOVE 1 TO v-s
        MOVE 0 TO v-keep
        MOVE 1 TO v-i
        MOVE v-left TO w-8
        PERFORM UNTIL 1 = 2
            IF v-i >= w-8
                EXIT PERFORM
            END-IF
            COMPUTE w-9 = v-i + 1
            MOVE t-rem-e(w-9) TO w-10
            COMPUTE w-11 = v-s - 1
            COMPUTE w-12 = w-11 + 1
            MOVE t-strand-e(w-12) TO w-13
            IF w-10 >= w-13
                MOVE 1 TO f-3
            ELSE
                MOVE 0 TO f-3
            END-IF
            IF f-3 = 1
                COMPUTE w-14 = v-i + 1
                MOVE t-rem-e(w-14) TO w-15
                COMPUTE w-16 = v-s + 1
                MOVE w-15 TO t-strand-e(w-16)
                COMPUTE w-17 = v-s + 1
                MOVE w-17 TO v-s
            ELSE
                COMPUTE w-18 = v-i + 1
                MOVE t-rem-e(w-18) TO w-19
                COMPUTE w-20 = v-keep + 1
                MOVE w-19 TO t-rem-e(w-20)
                COMPUTE w-21 = v-keep + 1
                MOVE w-21 TO v-keep
            END-IF
            ADD 1 TO v-i
        END-PERFORM
        MOVE v-keep TO v-left
        MOVE 0 TO v-i
        MOVE 0 TO v-j
        MOVE 0 TO v-k
        PERFORM UNTIL 1 = 2
            IF v-i < v-o
                MOVE 1 TO f-4
            ELSE
                MOVE 0 TO f-4
            END-IF
            IF f-4 = 1
                IF v-j < v-s
                    MOVE 1 TO f-4
                ELSE
                    MOVE 0 TO f-4
                END-IF
            END-IF
            IF f-4 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-22 = v-j + 1
            MOVE t-strand-e(w-22) TO w-23
            COMPUTE w-24 = v-i + 1
            MOVE t-out-e(w-24) TO w-25
            IF w-23 < w-25
                MOVE 1 TO f-5
            ELSE
                MOVE 0 TO f-5
            END-IF
            IF f-5 = 1
                COMPUTE w-26 = v-j + 1
                MOVE t-strand-e(w-26) TO w-27
                COMPUTE w-28 = v-k + 1
                MOVE w-27 TO t-tmp-e(w-28)
                COMPUTE w-29 = v-j + 1
                MOVE w-29 TO v-j
            ELSE
                COMPUTE w-30 = v-i + 1
                MOVE t-out-e(w-30) TO w-31
                COMPUTE w-32 = v-k + 1
                MOVE w-31 TO t-tmp-e(w-32)
                COMPUTE w-33 = v-i + 1
                MOVE w-33 TO v-i
            END-IF
            COMPUTE w-34 = v-k + 1
            MOVE w-34 TO v-k
        END-PERFORM
        PERFORM UNTIL 1 = 2
            IF v-i < v-o
                MOVE 1 TO f-6
            ELSE
                MOVE 0 TO f-6
            END-IF
            IF f-6 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-35 = v-i + 1
            MOVE t-out-e(w-35) TO w-36
            COMPUTE w-37 = v-k + 1
            MOVE w-36 TO t-tmp-e(w-37)
            COMPUTE w-38 = v-i + 1
            MOVE w-38 TO v-i
            COMPUTE w-39 = v-k + 1
            MOVE w-39 TO v-k
        END-PERFORM
        PERFORM UNTIL 1 = 2
            IF v-j < v-s
                MOVE 1 TO f-7
            ELSE
                MOVE 0 TO f-7
            END-IF
            IF f-7 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-40 = v-j + 1
            MOVE t-strand-e(w-40) TO w-41
            COMPUTE w-42 = v-k + 1
            MOVE w-41 TO t-tmp-e(w-42)
            COMPUTE w-43 = v-j + 1
            MOVE w-43 TO v-j
            COMPUTE w-44 = v-k + 1
            MOVE w-44 TO v-k
        END-PERFORM
        MOVE v-k TO v-o
        MOVE 0 TO v-x
        MOVE v-o TO w-45
        PERFORM UNTIL 1 = 2
            IF v-x >= w-45
                EXIT PERFORM
            END-IF
            COMPUTE w-46 = v-x + 1
            MOVE t-tmp-e(w-46) TO w-47
            COMPUTE w-48 = v-x + 1
            MOVE w-47 TO t-out-e(w-48)
            ADD 1 TO v-x
        END-PERFORM
    END-PERFORM
    MOVE 0 TO v-i
    MOVE v-n TO w-49
    PERFORM UNTIL 1 = 2
        IF v-i >= w-49
            EXIT PERFORM
        END-IF
        COMPUTE w-50 = v-i + 1
        MOVE t-out-e(w-50) TO w-51
        COMPUTE w-52 = v-i + 1
        MOVE w-51 TO t-a-e(w-52)
        ADD 1 TO v-i
    END-PERFORM
    GOBACK.
END PROGRAM strand-sort.

