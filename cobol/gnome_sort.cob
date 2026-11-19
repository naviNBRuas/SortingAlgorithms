      *> GENERATED from kernels/algos/gnome_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. gnome-sort IS RECURSIVE.
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
01 w-8 USAGE BINARY-DOUBLE SIGNED.
01 w-9 USAGE BINARY-DOUBLE SIGNED.
01 w-10 USAGE BINARY-DOUBLE SIGNED.
01 w-11 USAGE BINARY-DOUBLE SIGNED.
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-n USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-a BY VALUE v-n.
    MOVE 0 TO v-i
    PERFORM UNTIL 1 = 2
        IF v-i < v-n
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        IF v-i = 0
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 0
            COMPUTE w-1 = v-i - 1
            COMPUTE w-2 = w-1 + 1
            MOVE t-a-e(w-2) TO w-3
            COMPUTE w-4 = v-i + 1
            MOVE t-a-e(w-4) TO w-5
            IF w-3 <= w-5
                MOVE 1 TO f-2
            ELSE
                MOVE 0 TO f-2
            END-IF
        END-IF
        IF f-2 = 1
            COMPUTE w-6 = v-i + 1
            MOVE w-6 TO v-i
        ELSE
            COMPUTE w-7 = v-i - 1
            COMPUTE w-8 = w-7 + 1
            COMPUTE w-9 = v-i + 1
            MOVE t-a-e(w-8) TO w-10
            MOVE t-a-e(w-9) TO t-a-e(w-8)
            MOVE w-10 TO t-a-e(w-9)
            COMPUTE w-11 = v-i - 1
            MOVE w-11 TO v-i
        END-IF
    END-PERFORM
    GOBACK.
END PROGRAM gnome-sort.

