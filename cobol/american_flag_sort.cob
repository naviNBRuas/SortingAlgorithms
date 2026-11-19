      *> GENERATED from kernels/algos/american_flag_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. american-flag-sort-x-rec IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 v-s USAGE BINARY-DOUBLE SIGNED.
01 v-d USAGE BINARY-DOUBLE SIGNED.
01 v-b USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 t-count.
    05 t-count-e USAGE BINARY-LONG SIGNED OCCURS 10 TIMES.
01 t-starts.
    05 t-starts-e USAGE BINARY-LONG SIGNED OCCURS 11 TIMES.
01 t-nxt.
    05 t-nxt-e USAGE BINARY-LONG SIGNED OCCURS 10 TIMES.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-mn USAGE BINARY-DOUBLE SIGNED.
01 v-lo USAGE BINARY-DOUBLE SIGNED.
01 v-hi USAGE BINARY-DOUBLE SIGNED.
01 v-exp USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-a BY VALUE v-mn BY VALUE v-lo BY VALUE v-hi BY VALUE v-exp.
    COMPUTE w-1 = v-hi - v-lo
    IF w-1 < 2
        MOVE 1 TO f-1
    ELSE
        MOVE 0 TO f-1
    END-IF
    IF f-1 = 0
        IF v-exp = 0
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
    END-IF
    IF f-1 = 1
        GOBACK
    END-IF
    INITIALIZE t-count
    INITIALIZE t-starts
    INITIALIZE t-nxt
    MOVE v-lo TO v-i
    MOVE v-hi TO w-2
    PERFORM UNTIL 1 = 2
        IF v-i >= w-2
            EXIT PERFORM
        END-IF
        COMPUTE w-3 = v-i + 1
        MOVE t-a-e(w-3) TO w-4
        COMPUTE w-5 = w-4 - v-mn
        COMPUTE w-6 = FUNCTION INTEGER-PART(w-5 / v-exp)
        COMPUTE w-7 = FUNCTION MOD(w-6, 10)
        COMPUTE w-8 = w-7 + 1
        MOVE t-count-e(w-8) TO w-9
        COMPUTE w-10 = w-9 + 1
        COMPUTE w-11 = v-i + 1
        MOVE t-a-e(w-11) TO w-12
        COMPUTE w-13 = w-12 - v-mn
        COMPUTE w-14 = FUNCTION INTEGER-PART(w-13 / v-exp)
        COMPUTE w-15 = FUNCTION MOD(w-14, 10)
        COMPUTE w-16 = w-15 + 1
        MOVE w-10 TO t-count-e(w-16)
        ADD 1 TO v-i
    END-PERFORM
    MOVE v-lo TO v-s
    MOVE 0 TO v-d
    MOVE 10 TO w-17
    PERFORM UNTIL 1 = 2
        IF v-d >= w-17
            EXIT PERFORM
        END-IF
        COMPUTE w-18 = v-d + 1
        MOVE v-s TO t-starts-e(w-18)
        COMPUTE w-19 = v-d + 1
        MOVE v-s TO t-nxt-e(w-19)
        COMPUTE w-20 = v-d + 1
        MOVE t-count-e(w-20) TO w-21
        COMPUTE w-22 = v-s + w-21
        MOVE w-22 TO v-s
        ADD 1 TO v-d
    END-PERFORM
    COMPUTE w-23 = 10 + 1
    MOVE v-s TO t-starts-e(w-23)
    MOVE 0 TO v-b
    MOVE 10 TO w-24
    PERFORM UNTIL 1 = 2
        IF v-b >= w-24
            EXIT PERFORM
        END-IF
        PERFORM UNTIL 1 = 2
            COMPUTE w-25 = v-b + 1
            MOVE t-nxt-e(w-25) TO w-26
            COMPUTE w-27 = v-b + 1
            COMPUTE w-28 = w-27 + 1
            MOVE t-starts-e(w-28) TO w-29
            IF w-26 < w-29
                MOVE 1 TO f-2
            ELSE
                MOVE 0 TO f-2
            END-IF
            IF f-2 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-30 = v-b + 1
            MOVE t-nxt-e(w-30) TO w-31
            COMPUTE w-32 = w-31 + 1
            MOVE t-a-e(w-32) TO w-33
            COMPUTE w-34 = w-33 - v-mn
            COMPUTE w-35 = FUNCTION INTEGER-PART(w-34 / v-exp)
            COMPUTE w-36 = FUNCTION MOD(w-35, 10)
            MOVE w-36 TO v-d
            IF v-d = v-b
                MOVE 1 TO f-3
            ELSE
                MOVE 0 TO f-3
            END-IF
            IF f-3 = 1
                COMPUTE w-37 = v-b + 1
                MOVE t-nxt-e(w-37) TO w-38
                COMPUTE w-39 = w-38 + 1
                COMPUTE w-40 = v-b + 1
                MOVE w-39 TO t-nxt-e(w-40)
            ELSE
                COMPUTE w-41 = v-b + 1
                MOVE t-nxt-e(w-41) TO w-42
                COMPUTE w-43 = v-d + 1
                MOVE t-nxt-e(w-43) TO w-44
                COMPUTE w-45 = w-42 + 1
                COMPUTE w-46 = w-44 + 1
                MOVE t-a-e(w-45) TO w-47
                MOVE t-a-e(w-46) TO t-a-e(w-45)
                MOVE w-47 TO t-a-e(w-46)
                COMPUTE w-48 = v-d + 1
                MOVE t-nxt-e(w-48) TO w-49
                COMPUTE w-50 = w-49 + 1
                COMPUTE w-51 = v-d + 1
                MOVE w-50 TO t-nxt-e(w-51)
            END-IF
        END-PERFORM
        ADD 1 TO v-b
    END-PERFORM
    MOVE 0 TO v-b
    MOVE 10 TO w-52
    PERFORM UNTIL 1 = 2
        IF v-b >= w-52
            EXIT PERFORM
        END-IF
        COMPUTE w-53 = v-b + 1
        MOVE t-starts-e(w-53) TO w-54
        COMPUTE w-55 = v-b + 1
        COMPUTE w-56 = w-55 + 1
        MOVE t-starts-e(w-56) TO w-57
        COMPUTE w-58 = FUNCTION INTEGER-PART(v-exp / 10)
        CALL "american-flag-sort-x-rec" USING BY REFERENCE t-a BY VALUE v-mn BY VALUE w-54 BY VALUE w-57 BY VALUE w-58
        END-CALL
        ADD 1 TO v-b
    END-PERFORM
    GOBACK.
END PROGRAM american-flag-sort-x-rec.

IDENTIFICATION DIVISION.
PROGRAM-ID. american-flag-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-mn USAGE BINARY-DOUBLE SIGNED.
01 v-mx USAGE BINARY-DOUBLE SIGNED.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 v-top USAGE BINARY-DOUBLE SIGNED.
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
    MOVE 1 TO v-top
    PERFORM UNTIL 1 = 2
        COMPUTE w-14 = v-mx - v-mn
        COMPUTE w-15 = FUNCTION INTEGER-PART(w-14 / v-top)
        IF w-15 >= 10
            MOVE 1 TO f-4
        ELSE
            MOVE 0 TO f-4
        END-IF
        IF f-4 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-16 = v-top * 10
        MOVE w-16 TO v-top
    END-PERFORM
    CALL "american-flag-sort-x-rec" USING BY REFERENCE t-a BY VALUE v-mn BY VALUE 0 BY VALUE v-n BY VALUE v-top
    END-CALL
    GOBACK.
END PROGRAM american-flag-sort.

