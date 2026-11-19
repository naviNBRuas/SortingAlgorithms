      *> GENERATED from kernels/algos/patience_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. patience-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 v-piles USAGE BINARY-DOUBLE SIGNED.
01 v-lo USAGE BINARY-DOUBLE SIGNED.
01 v-hi USAGE BINARY-DOUBLE SIGNED.
01 v-mid USAGE BINARY-DOUBLE SIGNED.
01 v-out USAGE BINARY-DOUBLE SIGNED.
01 v-best USAGE BINARY-DOUBLE SIGNED.
01 v-p USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
01 f-5 USAGE BINARY-DOUBLE SIGNED.
01 f-6 USAGE BINARY-DOUBLE SIGNED.
01 t-vals.
    05 t-vals-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-prev.
    05 t-prev-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-top.
    05 t-top-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
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
    INITIALIZE t-vals
    INITIALIZE t-prev
    INITIALIZE t-top
    MOVE 0 TO v-i
    MOVE v-n TO w-1
    PERFORM UNTIL 1 = 2
        IF v-i >= w-1
            EXIT PERFORM
        END-IF
        COMPUTE w-2 = v-i + 1
        MOVE t-a-e(w-2) TO w-3
        COMPUTE w-4 = v-i + 1
        MOVE w-3 TO t-vals-e(w-4)
        ADD 1 TO v-i
    END-PERFORM
    MOVE 0 TO v-piles
    MOVE 0 TO v-i
    MOVE v-n TO w-5
    PERFORM UNTIL 1 = 2
        IF v-i >= w-5
            EXIT PERFORM
        END-IF
        MOVE 0 TO v-lo
        MOVE v-piles TO v-hi
        PERFORM UNTIL 1 = 2
            IF v-lo < v-hi
                MOVE 1 TO f-2
            ELSE
                MOVE 0 TO f-2
            END-IF
            IF f-2 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-6 = v-lo + v-hi
            COMPUTE w-7 = FUNCTION INTEGER-PART(w-6 / 2)
            MOVE w-7 TO v-mid
            COMPUTE w-8 = v-mid + 1
            MOVE t-top-e(w-8) TO w-9
            COMPUTE w-10 = w-9 - 1
            COMPUTE w-11 = w-10 + 1
            MOVE t-vals-e(w-11) TO w-12
            COMPUTE w-13 = v-i + 1
            MOVE t-vals-e(w-13) TO w-14
            IF w-12 < w-14
                MOVE 1 TO f-3
            ELSE
                MOVE 0 TO f-3
            END-IF
            IF f-3 = 1
                COMPUTE w-15 = v-mid + 1
                MOVE w-15 TO v-lo
            ELSE
                MOVE v-mid TO v-hi
            END-IF
        END-PERFORM
        COMPUTE w-16 = v-lo + 1
        MOVE t-top-e(w-16) TO w-17
        COMPUTE w-18 = v-i + 1
        MOVE w-17 TO t-prev-e(w-18)
        COMPUTE w-19 = v-i + 1
        COMPUTE w-20 = v-lo + 1
        MOVE w-19 TO t-top-e(w-20)
        IF v-lo = v-piles
            MOVE 1 TO f-4
        ELSE
            MOVE 0 TO f-4
        END-IF
        IF f-4 = 1
            COMPUTE w-21 = v-piles + 1
            MOVE w-21 TO v-piles
        END-IF
        ADD 1 TO v-i
    END-PERFORM
    MOVE 0 TO v-out
    MOVE v-n TO w-22
    PERFORM UNTIL 1 = 2
        IF v-out >= w-22
            EXIT PERFORM
        END-IF
        COMPUTE w-23 = 0 - 1
        MOVE w-23 TO v-best
        MOVE 0 TO v-p
        MOVE v-piles TO w-24
        PERFORM UNTIL 1 = 2
            IF v-p >= w-24
                EXIT PERFORM
            END-IF
            COMPUTE w-25 = v-p + 1
            MOVE t-top-e(w-25) TO w-26
            IF w-26 NOT = 0
                MOVE 1 TO f-5
            ELSE
                MOVE 0 TO f-5
            END-IF
            IF f-5 = 1
                IF v-best < 0
                    MOVE 1 TO f-6
                ELSE
                    MOVE 0 TO f-6
                END-IF
                IF f-6 = 0
                    COMPUTE w-27 = v-p + 1
                    MOVE t-top-e(w-27) TO w-28
                    COMPUTE w-29 = w-28 - 1
                    COMPUTE w-30 = w-29 + 1
                    MOVE t-vals-e(w-30) TO w-31
                    COMPUTE w-32 = v-best + 1
                    MOVE t-top-e(w-32) TO w-33
                    COMPUTE w-34 = w-33 - 1
                    COMPUTE w-35 = w-34 + 1
                    MOVE t-vals-e(w-35) TO w-36
                    IF w-31 < w-36
                        MOVE 1 TO f-6
                    ELSE
                        MOVE 0 TO f-6
                    END-IF
                END-IF
                IF f-6 = 1
                    MOVE v-p TO v-best
                END-IF
            END-IF
            ADD 1 TO v-p
        END-PERFORM
        COMPUTE w-37 = v-best + 1
        MOVE t-top-e(w-37) TO w-38
        COMPUTE w-39 = w-38 - 1
        COMPUTE w-40 = w-39 + 1
        MOVE t-vals-e(w-40) TO w-41
        COMPUTE w-42 = v-out + 1
        MOVE w-41 TO t-a-e(w-42)
        COMPUTE w-43 = v-best + 1
        MOVE t-top-e(w-43) TO w-44
        COMPUTE w-45 = w-44 - 1
        COMPUTE w-46 = w-45 + 1
        MOVE t-prev-e(w-46) TO w-47
        COMPUTE w-48 = v-best + 1
        MOVE w-47 TO t-top-e(w-48)
        ADD 1 TO v-out
    END-PERFORM
    GOBACK.
END PROGRAM patience-sort.

