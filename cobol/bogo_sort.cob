      *> GENERATED from kernels/algos/bogo_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. bogo-sort-x-is-sorted IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-i USAGE BINARY-DOUBLE SIGNED.
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
01 v-n USAGE BINARY-DOUBLE SIGNED.
01 r-val USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-a BY VALUE v-n RETURNING r-val.
    MOVE 0 TO v-i
    PERFORM UNTIL 1 = 2
        COMPUTE w-1 = v-i + 1
        IF w-1 < v-n
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-2 = v-i + 1
        MOVE t-a-e(w-2) TO w-3
        COMPUTE w-4 = v-i + 1
        COMPUTE w-5 = w-4 + 1
        MOVE t-a-e(w-5) TO w-6
        IF w-3 > w-6
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 1
            MOVE 0 TO r-val
            GOBACK
        END-IF
        COMPUTE w-7 = v-i + 1
        MOVE w-7 TO v-i
    END-PERFORM
    MOVE 1 TO r-val
    GOBACK
    GOBACK.
END PROGRAM bogo-sort-x-is-sorted.

IDENTIFICATION DIVISION.
PROGRAM-ID. bogo-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-state USAGE BINARY-DOUBLE SIGNED.
01 v-count USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-n USAGE BINARY-DOUBLE SIGNED.
01 v-max-shuffles USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-a BY VALUE v-n BY VALUE v-max-shuffles.
    MOVE 123456789 TO v-state
    MOVE 0 TO v-count
    PERFORM UNTIL 1 = 2
        CALL "bogo-sort-x-is-sorted" USING BY REFERENCE t-a BY VALUE v-n RETURNING w-1
        END-CALL
        IF w-1 = 0
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 1
            IF v-count < v-max-shuffles
                MOVE 1 TO f-1
            ELSE
                MOVE 0 TO f-1
            END-IF
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-2 = v-n - 1
        MOVE w-2 TO v-i
        PERFORM UNTIL 1 = 2
            IF v-i > 0
                MOVE 1 TO f-2
            ELSE
                MOVE 0 TO f-2
            END-IF
            IF f-2 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-3 = v-state * 1103515245
            COMPUTE w-4 = w-3 + 12345
            COMPUTE w-5 = FUNCTION MOD(w-4, 2147483648)
            MOVE w-5 TO v-state
            COMPUTE w-6 = FUNCTION INTEGER-PART(v-state / 16)
            COMPUTE w-7 = v-i + 1
            COMPUTE w-8 = FUNCTION MOD(w-6, w-7)
            COMPUTE w-9 = v-i + 1
            COMPUTE w-10 = w-8 + 1
            MOVE t-a-e(w-9) TO w-11
            MOVE t-a-e(w-10) TO t-a-e(w-9)
            MOVE w-11 TO t-a-e(w-10)
            COMPUTE w-12 = v-i - 1
            MOVE w-12 TO v-i
        END-PERFORM
        COMPUTE w-13 = v-count + 1
        MOVE w-13 TO v-count
    END-PERFORM
    GOBACK.
END PROGRAM bogo-sort.

