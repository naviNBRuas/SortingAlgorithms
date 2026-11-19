      *> GENERATED from kernels/algos/pancake_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. pancake-sort-x-flip IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 w-1 USAGE BINARY-DOUBLE SIGNED.
01 w-2 USAGE BINARY-DOUBLE SIGNED.
01 w-3 USAGE BINARY-DOUBLE SIGNED.
01 w-4 USAGE BINARY-DOUBLE SIGNED.
01 w-5 USAGE BINARY-DOUBLE SIGNED.
01 f-1 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-k USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-a BY VALUE v-k.
    MOVE 0 TO v-i
    PERFORM UNTIL 1 = 2
        IF v-i < v-k
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-1 = v-i + 1
        COMPUTE w-2 = v-k + 1
        MOVE t-a-e(w-1) TO w-3
        MOVE t-a-e(w-2) TO t-a-e(w-1)
        MOVE w-3 TO t-a-e(w-2)
        COMPUTE w-4 = v-i + 1
        MOVE w-4 TO v-i
        COMPUTE w-5 = v-k - 1
        MOVE w-5 TO v-k
    END-PERFORM
    GOBACK.
END PROGRAM pancake-sort-x-flip.

IDENTIFICATION DIVISION.
PROGRAM-ID. pancake-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-size USAGE BINARY-DOUBLE SIGNED.
01 v-mx USAGE BINARY-DOUBLE SIGNED.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 w-1 USAGE BINARY-DOUBLE SIGNED.
01 w-2 USAGE BINARY-DOUBLE SIGNED.
01 w-3 USAGE BINARY-DOUBLE SIGNED.
01 w-4 USAGE BINARY-DOUBLE SIGNED.
01 w-5 USAGE BINARY-DOUBLE SIGNED.
01 w-6 USAGE BINARY-DOUBLE SIGNED.
01 w-7 USAGE BINARY-DOUBLE SIGNED.
01 w-8 USAGE BINARY-DOUBLE SIGNED.
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
01 f-5 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-n USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-a BY VALUE v-n.
    MOVE v-n TO v-size
    PERFORM UNTIL 1 = 2
        IF v-size > 1
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        MOVE 0 TO v-mx
        MOVE 1 TO v-i
        PERFORM UNTIL 1 = 2
            IF v-i < v-size
                MOVE 1 TO f-2
            ELSE
                MOVE 0 TO f-2
            END-IF
            IF f-2 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-1 = v-i + 1
            MOVE t-a-e(w-1) TO w-2
            COMPUTE w-3 = v-mx + 1
            MOVE t-a-e(w-3) TO w-4
            IF w-2 > w-4
                MOVE 1 TO f-3
            ELSE
                MOVE 0 TO f-3
            END-IF
            IF f-3 = 1
                MOVE v-i TO v-mx
            END-IF
            COMPUTE w-5 = v-i + 1
            MOVE w-5 TO v-i
        END-PERFORM
        COMPUTE w-6 = v-size - 1
        IF v-mx NOT = w-6
            MOVE 1 TO f-4
        ELSE
            MOVE 0 TO f-4
        END-IF
        IF f-4 = 1
            IF v-mx > 0
                MOVE 1 TO f-5
            ELSE
                MOVE 0 TO f-5
            END-IF
            IF f-5 = 1
                CALL "pancake-sort-x-flip" USING BY REFERENCE t-a BY VALUE v-mx
                END-CALL
            END-IF
            COMPUTE w-7 = v-size - 1
            CALL "pancake-sort-x-flip" USING BY REFERENCE t-a BY VALUE w-7
            END-CALL
        END-IF
        COMPUTE w-8 = v-size - 1
        MOVE w-8 TO v-size
    END-PERFORM
    GOBACK.
END PROGRAM pancake-sort.

