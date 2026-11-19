      *> GENERATED from kernels/algos/heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. hsa1a-sift IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-going USAGE BINARY-DOUBLE SIGNED.
01 v-child USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-root USAGE BINARY-DOUBLE SIGNED.
01 v-size USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING t-a v-root v-size.
    MOVE 1 TO v-going
    PERFORM UNTIL 1 = 2
        IF v-going = 1
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-1 = 2 * v-root
        COMPUTE w-2 = w-1 + 1
        MOVE w-2 TO v-child
        IF v-child >= v-size
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 1
            MOVE 0 TO v-going
        ELSE
            COMPUTE w-3 = v-child + 1
            IF w-3 < v-size
                MOVE 1 TO f-3
            ELSE
                MOVE 0 TO f-3
            END-IF
            IF f-3 = 1
                COMPUTE w-4 = v-child + 1
                MOVE t-a-e(w-4) TO w-5
                COMPUTE w-6 = v-child + 1
                COMPUTE w-7 = w-6 + 1
                MOVE t-a-e(w-7) TO w-8
                IF w-5 < w-8
                    MOVE 1 TO f-3
                ELSE
                    MOVE 0 TO f-3
                END-IF
            END-IF
            IF f-3 = 1
                COMPUTE w-9 = v-child + 1
                MOVE w-9 TO v-child
            END-IF
            COMPUTE w-10 = v-root + 1
            MOVE t-a-e(w-10) TO w-11
            COMPUTE w-12 = v-child + 1
            MOVE t-a-e(w-12) TO w-13
            IF w-11 < w-13
                MOVE 1 TO f-4
            ELSE
                MOVE 0 TO f-4
            END-IF
            IF f-4 = 1
                COMPUTE w-14 = v-root + 1
                COMPUTE w-15 = v-child + 1
                MOVE t-a-e(w-14) TO w-16
                MOVE t-a-e(w-15) TO t-a-e(w-14)
                MOVE w-16 TO t-a-e(w-15)
                MOVE v-child TO v-root
            ELSE
                MOVE 0 TO v-going
            END-IF
        END-IF
    END-PERFORM
    GOBACK.
END PROGRAM hsa1a-sift.

IDENTIFICATION DIVISION.
PROGRAM-ID. heap-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-s USAGE BINARY-DOUBLE SIGNED.
01 v-end USAGE BINARY-DOUBLE SIGNED.
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
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-n USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING t-a v-n.
    COMPUTE w-1 = FUNCTION INTEGER-PART(v-n / 2)
    MOVE w-1 TO v-s
    PERFORM UNTIL 1 = 2
        IF v-s > 0
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-2 = v-s - 1
        MOVE w-2 TO v-s
        CALL "hsa1a-sift" USING BY REFERENCE t-a BY CONTENT v-s BY CONTENT v-n
        END-CALL
    END-PERFORM
    COMPUTE w-3 = v-n - 1
    MOVE w-3 TO v-end
    PERFORM UNTIL 1 = 2
        IF v-end > 0
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-4 = 0 + 1
        COMPUTE w-5 = v-end + 1
        MOVE t-a-e(w-4) TO w-6
        MOVE t-a-e(w-5) TO t-a-e(w-4)
        MOVE w-6 TO t-a-e(w-5)
        MOVE 0 TO w-7
        CALL "hsa1a-sift" USING BY REFERENCE t-a BY CONTENT w-7 BY CONTENT v-end
        END-CALL
        COMPUTE w-8 = v-end - 1
        MOVE w-8 TO v-end
    END-PERFORM
    GOBACK.
END PROGRAM heap-sort.

