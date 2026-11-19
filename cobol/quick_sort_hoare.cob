      *> GENERATED from kernels/algos/quick_sort_hoare.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. quick-sort-hoare-x-qs IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-pivot USAGE BINARY-DOUBLE SIGNED.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 v-j USAGE BINARY-DOUBLE SIGNED.
01 v-going USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
01 f-5 USAGE BINARY-DOUBLE SIGNED.
01 f-6 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-lo USAGE BINARY-DOUBLE SIGNED.
01 v-hi USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-a BY VALUE v-lo BY VALUE v-hi.
    PERFORM UNTIL 1 = 2
        IF v-lo < v-hi
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-1 = v-lo + v-hi
        COMPUTE w-2 = FUNCTION INTEGER-PART(w-1 / 2)
        COMPUTE w-3 = w-2 + 1
        MOVE t-a-e(w-3) TO w-4
        MOVE w-4 TO v-pivot
        COMPUTE w-5 = v-lo - 1
        MOVE w-5 TO v-i
        COMPUTE w-6 = v-hi + 1
        MOVE w-6 TO v-j
        MOVE 1 TO v-going
        PERFORM UNTIL 1 = 2
            IF v-going = 1
                MOVE 1 TO f-2
            ELSE
                MOVE 0 TO f-2
            END-IF
            IF f-2 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-7 = v-i + 1
            MOVE w-7 TO v-i
            PERFORM UNTIL 1 = 2
                COMPUTE w-8 = v-i + 1
                MOVE t-a-e(w-8) TO w-9
                IF w-9 < v-pivot
                    MOVE 1 TO f-3
                ELSE
                    MOVE 0 TO f-3
                END-IF
                IF f-3 = 0
                    EXIT PERFORM
                END-IF
                COMPUTE w-10 = v-i + 1
                MOVE w-10 TO v-i
            END-PERFORM
            COMPUTE w-11 = v-j - 1
            MOVE w-11 TO v-j
            PERFORM UNTIL 1 = 2
                COMPUTE w-12 = v-j + 1
                MOVE t-a-e(w-12) TO w-13
                IF w-13 > v-pivot
                    MOVE 1 TO f-4
                ELSE
                    MOVE 0 TO f-4
                END-IF
                IF f-4 = 0
                    EXIT PERFORM
                END-IF
                COMPUTE w-14 = v-j - 1
                MOVE w-14 TO v-j
            END-PERFORM
            IF v-i >= v-j
                MOVE 1 TO f-5
            ELSE
                MOVE 0 TO f-5
            END-IF
            IF f-5 = 1
                MOVE 0 TO v-going
            ELSE
                COMPUTE w-15 = v-i + 1
                COMPUTE w-16 = v-j + 1
                MOVE t-a-e(w-15) TO w-17
                MOVE t-a-e(w-16) TO t-a-e(w-15)
                MOVE w-17 TO t-a-e(w-16)
            END-IF
        END-PERFORM
        COMPUTE w-18 = v-j - v-lo
        COMPUTE w-19 = v-hi - v-j
        COMPUTE w-20 = w-19 - 1
        IF w-18 < w-20
            MOVE 1 TO f-6
        ELSE
            MOVE 0 TO f-6
        END-IF
        IF f-6 = 1
            CALL "quick-sort-hoare-x-qs" USING BY REFERENCE t-a BY VALUE v-lo BY VALUE v-j
            END-CALL
            COMPUTE w-21 = v-j + 1
            MOVE w-21 TO v-lo
        ELSE
            COMPUTE w-22 = v-j + 1
            CALL "quick-sort-hoare-x-qs" USING BY REFERENCE t-a BY VALUE w-22 BY VALUE v-hi
            END-CALL
            MOVE v-j TO v-hi
        END-IF
    END-PERFORM
    GOBACK.
END PROGRAM quick-sort-hoare-x-qs.

IDENTIFICATION DIVISION.
PROGRAM-ID. quick-sort-hoare IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 w-1 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-n USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-a BY VALUE v-n.
    COMPUTE w-1 = v-n - 1
    CALL "quick-sort-hoare-x-qs" USING BY REFERENCE t-a BY VALUE 0 BY VALUE w-1
    END-CALL
    GOBACK.
END PROGRAM quick-sort-hoare.

