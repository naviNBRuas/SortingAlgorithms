      *> GENERATED from kernels/algos/quick_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. quick-sort-x-qs IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-pivot USAGE BINARY-DOUBLE SIGNED.
01 v-i USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
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
        COMPUTE w-1 = v-hi + 1
        MOVE t-a-e(w-1) TO w-2
        MOVE w-2 TO v-pivot
        MOVE v-lo TO v-i
        MOVE v-lo TO v-j
        PERFORM UNTIL 1 = 2
            IF v-j < v-hi
                MOVE 1 TO f-2
            ELSE
                MOVE 0 TO f-2
            END-IF
            IF f-2 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-3 = v-j + 1
            MOVE t-a-e(w-3) TO w-4
            IF w-4 <= v-pivot
                MOVE 1 TO f-3
            ELSE
                MOVE 0 TO f-3
            END-IF
            IF f-3 = 1
                COMPUTE w-5 = v-i + 1
                COMPUTE w-6 = v-j + 1
                MOVE t-a-e(w-5) TO w-7
                MOVE t-a-e(w-6) TO t-a-e(w-5)
                MOVE w-7 TO t-a-e(w-6)
                COMPUTE w-8 = v-i + 1
                MOVE w-8 TO v-i
            END-IF
            COMPUTE w-9 = v-j + 1
            MOVE w-9 TO v-j
        END-PERFORM
        COMPUTE w-10 = v-i + 1
        COMPUTE w-11 = v-hi + 1
        MOVE t-a-e(w-10) TO w-12
        MOVE t-a-e(w-11) TO t-a-e(w-10)
        MOVE w-12 TO t-a-e(w-11)
        COMPUTE w-13 = v-i - v-lo
        COMPUTE w-14 = v-hi - v-i
        IF w-13 < w-14
            MOVE 1 TO f-4
        ELSE
            MOVE 0 TO f-4
        END-IF
        IF f-4 = 1
            COMPUTE w-15 = v-i - 1
            CALL "quick-sort-x-qs" USING BY REFERENCE t-a BY VALUE v-lo BY VALUE w-15
            END-CALL
            COMPUTE w-16 = v-i + 1
            MOVE w-16 TO v-lo
        ELSE
            COMPUTE w-17 = v-i + 1
            CALL "quick-sort-x-qs" USING BY REFERENCE t-a BY VALUE w-17 BY VALUE v-hi
            END-CALL
            COMPUTE w-18 = v-i - 1
            MOVE w-18 TO v-hi
        END-IF
    END-PERFORM
    GOBACK.
END PROGRAM quick-sort-x-qs.

IDENTIFICATION DIVISION.
PROGRAM-ID. quick-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 w-1 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-n USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-a BY VALUE v-n.
    COMPUTE w-1 = v-n - 1
    CALL "quick-sort-x-qs" USING BY REFERENCE t-a BY VALUE 0 BY VALUE w-1
    END-CALL
    GOBACK.
END PROGRAM quick-sort.

