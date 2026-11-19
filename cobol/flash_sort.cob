      *> GENERATED from kernels/algos/flash_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. flash-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-mn USAGE BINARY-DOUBLE SIGNED.
01 v-mx USAGE BINARY-DOUBLE SIGNED.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 v-m USAGE BINARY-DOUBLE SIGNED.
01 v-rng USAGE BINARY-DOUBLE SIGNED.
01 v-s USAGE BINARY-DOUBLE SIGNED.
01 v-c USAGE BINARY-DOUBLE SIGNED.
01 v-b USAGE BINARY-DOUBLE SIGNED.
01 v-d USAGE BINARY-DOUBLE SIGNED.
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
01 w-61 USAGE BINARY-DOUBLE SIGNED.
01 w-62 USAGE BINARY-DOUBLE SIGNED.
01 w-63 USAGE BINARY-DOUBLE SIGNED.
01 w-64 USAGE BINARY-DOUBLE SIGNED.
01 w-65 USAGE BINARY-DOUBLE SIGNED.
01 w-66 USAGE BINARY-DOUBLE SIGNED.
01 w-67 USAGE BINARY-DOUBLE SIGNED.
01 w-68 USAGE BINARY-DOUBLE SIGNED.
01 w-69 USAGE BINARY-DOUBLE SIGNED.
01 w-70 USAGE BINARY-DOUBLE SIGNED.
01 w-71 USAGE BINARY-DOUBLE SIGNED.
01 w-72 USAGE BINARY-DOUBLE SIGNED.
01 w-73 USAGE BINARY-DOUBLE SIGNED.
01 w-74 USAGE BINARY-DOUBLE SIGNED.
01 w-75 USAGE BINARY-DOUBLE SIGNED.
01 w-76 USAGE BINARY-DOUBLE SIGNED.
01 w-77 USAGE BINARY-DOUBLE SIGNED.
01 w-78 USAGE BINARY-DOUBLE SIGNED.
01 w-79 USAGE BINARY-DOUBLE SIGNED.
01 w-80 USAGE BINARY-DOUBLE SIGNED.
01 w-81 USAGE BINARY-DOUBLE SIGNED.
01 w-82 USAGE BINARY-DOUBLE SIGNED.
01 w-83 USAGE BINARY-DOUBLE SIGNED.
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
01 f-5 USAGE BINARY-DOUBLE SIGNED.
01 f-6 USAGE BINARY-DOUBLE SIGNED.
01 f-7 USAGE BINARY-DOUBLE SIGNED.
01 t-count.
    05 t-count-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-starts.
    05 t-starts-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-nxt.
    05 t-nxt-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
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
    IF v-mn = v-mx
        MOVE 1 TO f-4
    ELSE
        MOVE 0 TO f-4
    END-IF
    IF f-4 = 1
        GOBACK
    END-IF
    COMPUTE w-14 = 43 * v-n
    COMPUTE w-15 = FUNCTION INTEGER-PART(w-14 / 100)
    IF 2 > w-15
        MOVE 2 TO w-16
    ELSE
        MOVE w-15 TO w-16
    END-IF
    MOVE w-16 TO v-m
    COMPUTE w-17 = v-mx - v-mn
    MOVE w-17 TO v-rng
    INITIALIZE t-count
    INITIALIZE t-starts
    INITIALIZE t-nxt
    MOVE 0 TO v-i
    MOVE v-n TO w-18
    PERFORM UNTIL 1 = 2
        IF v-i >= w-18
            EXIT PERFORM
        END-IF
        COMPUTE w-19 = v-i + 1
        MOVE t-a-e(w-19) TO w-20
        COMPUTE w-21 = w-20 - v-mn
        COMPUTE w-22 = v-m - 1
        COMPUTE w-23 = w-21 * w-22
        COMPUTE w-24 = FUNCTION INTEGER-PART(w-23 / v-rng)
        COMPUTE w-25 = w-24 + 1
        MOVE t-count-e(w-25) TO w-26
        COMPUTE w-27 = w-26 + 1
        COMPUTE w-28 = v-i + 1
        MOVE t-a-e(w-28) TO w-29
        COMPUTE w-30 = w-29 - v-mn
        COMPUTE w-31 = v-m - 1
        COMPUTE w-32 = w-30 * w-31
        COMPUTE w-33 = FUNCTION INTEGER-PART(w-32 / v-rng)
        COMPUTE w-34 = w-33 + 1
        MOVE w-27 TO t-count-e(w-34)
        ADD 1 TO v-i
    END-PERFORM
    MOVE 0 TO v-s
    MOVE 0 TO v-c
    MOVE v-m TO w-35
    PERFORM UNTIL 1 = 2
        IF v-c >= w-35
            EXIT PERFORM
        END-IF
        COMPUTE w-36 = v-c + 1
        MOVE v-s TO t-starts-e(w-36)
        COMPUTE w-37 = v-c + 1
        MOVE v-s TO t-nxt-e(w-37)
        COMPUTE w-38 = v-c + 1
        MOVE t-count-e(w-38) TO w-39
        COMPUTE w-40 = v-s + w-39
        MOVE w-40 TO v-s
        ADD 1 TO v-c
    END-PERFORM
    COMPUTE w-41 = v-m + 1
    MOVE v-s TO t-starts-e(w-41)
    MOVE 0 TO v-b
    MOVE v-m TO w-42
    PERFORM UNTIL 1 = 2
        IF v-b >= w-42
            EXIT PERFORM
        END-IF
        PERFORM UNTIL 1 = 2
            COMPUTE w-43 = v-b + 1
            MOVE t-nxt-e(w-43) TO w-44
            COMPUTE w-45 = v-b + 1
            COMPUTE w-46 = w-45 + 1
            MOVE t-starts-e(w-46) TO w-47
            IF w-44 < w-47
                MOVE 1 TO f-5
            ELSE
                MOVE 0 TO f-5
            END-IF
            IF f-5 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-48 = v-b + 1
            MOVE t-nxt-e(w-48) TO w-49
            COMPUTE w-50 = w-49 + 1
            MOVE t-a-e(w-50) TO w-51
            COMPUTE w-52 = w-51 - v-mn
            COMPUTE w-53 = v-m - 1
            COMPUTE w-54 = w-52 * w-53
            COMPUTE w-55 = FUNCTION INTEGER-PART(w-54 / v-rng)
            MOVE w-55 TO v-d
            IF v-d = v-b
                MOVE 1 TO f-6
            ELSE
                MOVE 0 TO f-6
            END-IF
            IF f-6 = 1
                COMPUTE w-56 = v-b + 1
                MOVE t-nxt-e(w-56) TO w-57
                COMPUTE w-58 = w-57 + 1
                COMPUTE w-59 = v-b + 1
                MOVE w-58 TO t-nxt-e(w-59)
            ELSE
                COMPUTE w-60 = v-b + 1
                MOVE t-nxt-e(w-60) TO w-61
                COMPUTE w-62 = v-d + 1
                MOVE t-nxt-e(w-62) TO w-63
                COMPUTE w-64 = w-61 + 1
                COMPUTE w-65 = w-63 + 1
                MOVE t-a-e(w-64) TO w-66
                MOVE t-a-e(w-65) TO t-a-e(w-64)
                MOVE w-66 TO t-a-e(w-65)
                COMPUTE w-67 = v-d + 1
                MOVE t-nxt-e(w-67) TO w-68
                COMPUTE w-69 = w-68 + 1
                COMPUTE w-70 = v-d + 1
                MOVE w-69 TO t-nxt-e(w-70)
            END-IF
        END-PERFORM
        ADD 1 TO v-b
    END-PERFORM
    MOVE 1 TO v-i
    MOVE v-n TO w-71
    PERFORM UNTIL 1 = 2
        IF v-i >= w-71
            EXIT PERFORM
        END-IF
        COMPUTE w-72 = v-i + 1
        MOVE t-a-e(w-72) TO w-73
        MOVE w-73 TO v-key
        COMPUTE w-74 = v-i - 1
        MOVE w-74 TO v-j
        PERFORM UNTIL 1 = 2
            IF v-j >= 0
                MOVE 1 TO f-7
            ELSE
                MOVE 0 TO f-7
            END-IF
            IF f-7 = 1
                COMPUTE w-75 = v-j + 1
                MOVE t-a-e(w-75) TO w-76
                IF w-76 > v-key
                    MOVE 1 TO f-7
                ELSE
                    MOVE 0 TO f-7
                END-IF
            END-IF
            IF f-7 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-77 = v-j + 1
            MOVE t-a-e(w-77) TO w-78
            COMPUTE w-79 = v-j + 1
            COMPUTE w-80 = w-79 + 1
            MOVE w-78 TO t-a-e(w-80)
            COMPUTE w-81 = v-j - 1
            MOVE w-81 TO v-j
        END-PERFORM
        COMPUTE w-82 = v-j + 1
        COMPUTE w-83 = w-82 + 1
        MOVE v-key TO t-a-e(w-83)
        ADD 1 TO v-i
    END-PERFORM
    GOBACK.
END PROGRAM flash-sort.

