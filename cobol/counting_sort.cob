      *> GENERATED from kernels/algos/counting_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. csfdd-fallback IS RECURSIVE.
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
END PROGRAM csfdd-fallback.

IDENTIFICATION DIVISION.
PROGRAM-ID. counting-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-mn USAGE BINARY-DOUBLE SIGNED.
01 v-mx USAGE BINARY-DOUBLE SIGNED.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 v-rng USAGE BINARY-DOUBLE SIGNED.
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
01 w-53 USAGE BINARY-DOUBLE SIGNED.
01 w-54 USAGE BINARY-DOUBLE SIGNED.
01 w-55 USAGE BINARY-DOUBLE SIGNED.
01 w-56 USAGE BINARY-DOUBLE SIGNED.
01 w-57 USAGE BINARY-DOUBLE SIGNED.
01 w-58 USAGE BINARY-DOUBLE SIGNED.
01 w-59 USAGE BINARY-DOUBLE SIGNED.
01 w-60 USAGE BINARY-DOUBLE SIGNED.
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
01 t-count.
    05 t-count-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-out.
    05 t-out-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
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
        CALL "csfdd-fallback" USING BY REFERENCE t-a BY CONTENT v-n
        END-CALL
        GOBACK
    END-IF
    INITIALIZE t-count
    INITIALIZE t-out
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
        COMPUTE w-21 = w-20 + 1
        MOVE t-count-e(w-21) TO w-22
        COMPUTE w-23 = w-22 + 1
        COMPUTE w-24 = v-i + 1
        MOVE t-a-e(w-24) TO w-25
        COMPUTE w-26 = w-25 - v-mn
        COMPUTE w-27 = w-26 + 1
        COMPUTE w-28 = w-27 + 1
        MOVE w-23 TO t-count-e(w-28)
        ADD 1 TO v-i
    END-PERFORM
    COMPUTE w-29 = v-rng + 1
    MOVE 1 TO v-i
    MOVE w-29 TO w-30
    PERFORM UNTIL 1 = 2
        IF v-i >= w-30
            EXIT PERFORM
        END-IF
        COMPUTE w-31 = v-i + 1
        MOVE t-count-e(w-31) TO w-32
        COMPUTE w-33 = v-i - 1
        COMPUTE w-34 = w-33 + 1
        MOVE t-count-e(w-34) TO w-35
        COMPUTE w-36 = w-32 + w-35
        COMPUTE w-37 = v-i + 1
        MOVE w-36 TO t-count-e(w-37)
        ADD 1 TO v-i
    END-PERFORM
    MOVE 0 TO v-i
    MOVE v-n TO w-38
    PERFORM UNTIL 1 = 2
        IF v-i >= w-38
            EXIT PERFORM
        END-IF
        COMPUTE w-39 = v-i + 1
        MOVE t-a-e(w-39) TO w-40
        COMPUTE w-41 = v-i + 1
        MOVE t-a-e(w-41) TO w-42
        COMPUTE w-43 = w-42 - v-mn
        COMPUTE w-44 = w-43 + 1
        MOVE t-count-e(w-44) TO w-45
        COMPUTE w-46 = w-45 + 1
        MOVE w-40 TO t-out-e(w-46)
        COMPUTE w-47 = v-i + 1
        MOVE t-a-e(w-47) TO w-48
        COMPUTE w-49 = w-48 - v-mn
        COMPUTE w-50 = w-49 + 1
        MOVE t-count-e(w-50) TO w-51
        COMPUTE w-52 = w-51 + 1
        COMPUTE w-53 = v-i + 1
        MOVE t-a-e(w-53) TO w-54
        COMPUTE w-55 = w-54 - v-mn
        COMPUTE w-56 = w-55 + 1
        MOVE w-52 TO t-count-e(w-56)
        ADD 1 TO v-i
    END-PERFORM
    MOVE 0 TO v-i
    MOVE v-n TO w-57
    PERFORM UNTIL 1 = 2
        IF v-i >= w-57
            EXIT PERFORM
        END-IF
        COMPUTE w-58 = v-i + 1
        MOVE t-out-e(w-58) TO w-59
        COMPUTE w-60 = v-i + 1
        MOVE w-59 TO t-a-e(w-60)
        ADD 1 TO v-i
    END-PERFORM
    GOBACK.
END PROGRAM counting-sort.

