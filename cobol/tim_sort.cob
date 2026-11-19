      *> GENERATED from kernels/algos/tim_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. tse8d-insertion IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
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
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-lo USAGE BINARY-DOUBLE SIGNED.
01 v-hi USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING t-a v-lo v-hi.
    COMPUTE w-1 = v-lo + 1
    MOVE w-1 TO v-i
    MOVE v-hi TO w-2
    PERFORM UNTIL 1 = 2
        IF v-i >= w-2
            EXIT PERFORM
        END-IF
        COMPUTE w-3 = v-i + 1
        MOVE t-a-e(w-3) TO w-4
        MOVE w-4 TO v-key
        COMPUTE w-5 = v-i - 1
        MOVE w-5 TO v-j
        PERFORM UNTIL 1 = 2
            IF v-j >= v-lo
                MOVE 1 TO f-1
            ELSE
                MOVE 0 TO f-1
            END-IF
            IF f-1 = 1
                COMPUTE w-6 = v-j + 1
                MOVE t-a-e(w-6) TO w-7
                IF w-7 > v-key
                    MOVE 1 TO f-1
                ELSE
                    MOVE 0 TO f-1
                END-IF
            END-IF
            IF f-1 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-8 = v-j + 1
            MOVE t-a-e(w-8) TO w-9
            COMPUTE w-10 = v-j + 1
            COMPUTE w-11 = w-10 + 1
            MOVE w-9 TO t-a-e(w-11)
            COMPUTE w-12 = v-j - 1
            MOVE w-12 TO v-j
        END-PERFORM
        COMPUTE w-13 = v-j + 1
        COMPUTE w-14 = w-13 + 1
        MOVE v-key TO t-a-e(w-14)
        ADD 1 TO v-i
    END-PERFORM
    GOBACK.
END PROGRAM tse8d-insertion.

IDENTIFICATION DIVISION.
PROGRAM-ID. tse8d-merge-at IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-s1 USAGE BINARY-DOUBLE SIGNED.
01 v-l1 USAGE BINARY-DOUBLE SIGNED.
01 v-l2 USAGE BINARY-DOUBLE SIGNED.
01 v-x USAGE BINARY-DOUBLE SIGNED.
01 v-j USAGE BINARY-DOUBLE SIGNED.
01 v-k USAGE BINARY-DOUBLE SIGNED.
01 v-end USAGE BINARY-DOUBLE SIGNED.
01 v-t USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-tmp.
    05 t-tmp-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-rs.
    05 t-rs-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-rl.
    05 t-rl-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-cnt USAGE BINARY-DOUBLE SIGNED.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 r-val USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING t-a t-tmp t-rs t-rl v-cnt v-i r-val.
    COMPUTE w-1 = v-i + 1
    MOVE t-rs-e(w-1) TO w-2
    MOVE w-2 TO v-s1
    COMPUTE w-3 = v-i + 1
    MOVE t-rl-e(w-3) TO w-4
    MOVE w-4 TO v-l1
    COMPUTE w-5 = v-i + 1
    COMPUTE w-6 = w-5 + 1
    MOVE t-rl-e(w-6) TO w-7
    MOVE w-7 TO v-l2
    MOVE 0 TO v-x
    MOVE v-l1 TO w-8
    PERFORM UNTIL 1 = 2
        IF v-x >= w-8
            EXIT PERFORM
        END-IF
        COMPUTE w-9 = v-s1 + v-x
        COMPUTE w-10 = w-9 + 1
        MOVE t-a-e(w-10) TO w-11
        COMPUTE w-12 = v-x + 1
        MOVE w-11 TO t-tmp-e(w-12)
        ADD 1 TO v-x
    END-PERFORM
    MOVE 0 TO v-x
    COMPUTE w-13 = v-s1 + v-l1
    MOVE w-13 TO v-j
    MOVE v-s1 TO v-k
    COMPUTE w-14 = v-j + v-l2
    MOVE w-14 TO v-end
    PERFORM UNTIL 1 = 2
        IF v-x < v-l1
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 1
            IF v-j < v-end
                MOVE 1 TO f-1
            ELSE
                MOVE 0 TO f-1
            END-IF
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-15 = v-j + 1
        MOVE t-a-e(w-15) TO w-16
        COMPUTE w-17 = v-x + 1
        MOVE t-tmp-e(w-17) TO w-18
        IF w-16 < w-18
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 1
            COMPUTE w-19 = v-j + 1
            MOVE t-a-e(w-19) TO w-20
            COMPUTE w-21 = v-k + 1
            MOVE w-20 TO t-a-e(w-21)
            COMPUTE w-22 = v-j + 1
            MOVE w-22 TO v-j
        ELSE
            COMPUTE w-23 = v-x + 1
            MOVE t-tmp-e(w-23) TO w-24
            COMPUTE w-25 = v-k + 1
            MOVE w-24 TO t-a-e(w-25)
            COMPUTE w-26 = v-x + 1
            MOVE w-26 TO v-x
        END-IF
        COMPUTE w-27 = v-k + 1
        MOVE w-27 TO v-k
    END-PERFORM
    PERFORM UNTIL 1 = 2
        IF v-x < v-l1
            MOVE 1 TO f-3
        ELSE
            MOVE 0 TO f-3
        END-IF
        IF f-3 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-28 = v-x + 1
        MOVE t-tmp-e(w-28) TO w-29
        COMPUTE w-30 = v-k + 1
        MOVE w-29 TO t-a-e(w-30)
        COMPUTE w-31 = v-x + 1
        MOVE w-31 TO v-x
        COMPUTE w-32 = v-k + 1
        MOVE w-32 TO v-k
    END-PERFORM
    COMPUTE w-33 = v-l1 + v-l2
    COMPUTE w-34 = v-i + 1
    MOVE w-33 TO t-rl-e(w-34)
    COMPUTE w-35 = v-i + 1
    COMPUTE w-36 = v-cnt - 1
    MOVE w-35 TO v-t
    MOVE w-36 TO w-37
    PERFORM UNTIL 1 = 2
        IF v-t >= w-37
            EXIT PERFORM
        END-IF
        COMPUTE w-38 = v-t + 1
        COMPUTE w-39 = w-38 + 1
        MOVE t-rs-e(w-39) TO w-40
        COMPUTE w-41 = v-t + 1
        MOVE w-40 TO t-rs-e(w-41)
        COMPUTE w-42 = v-t + 1
        COMPUTE w-43 = w-42 + 1
        MOVE t-rl-e(w-43) TO w-44
        COMPUTE w-45 = v-t + 1
        MOVE w-44 TO t-rl-e(w-45)
        ADD 1 TO v-t
    END-PERFORM
    COMPUTE w-46 = v-cnt - 1
    MOVE w-46 TO r-val
    GOBACK
    GOBACK.
END PROGRAM tse8d-merge-at.

IDENTIFICATION DIVISION.
PROGRAM-ID. tse8d-collapse IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-going USAGE BINARY-DOUBLE SIGNED.
01 v-m USAGE BINARY-DOUBLE SIGNED.
01 v-need USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
01 f-5 USAGE BINARY-DOUBLE SIGNED.
01 f-6 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-tmp.
    05 t-tmp-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-rs.
    05 t-rs-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-rl.
    05 t-rl-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-cnt USAGE BINARY-DOUBLE SIGNED.
01 r-val USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING t-a t-tmp t-rs t-rl v-cnt r-val.
    MOVE 1 TO v-going
    PERFORM UNTIL 1 = 2
        IF v-going = 1
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 1
            IF v-cnt > 1
                MOVE 1 TO f-1
            ELSE
                MOVE 0 TO f-1
            END-IF
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-1 = v-cnt - 2
        MOVE w-1 TO v-m
        MOVE 0 TO v-need
        IF v-m > 0
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 1
            COMPUTE w-2 = v-m - 1
            COMPUTE w-3 = w-2 + 1
            MOVE t-rl-e(w-3) TO w-4
            COMPUTE w-5 = v-m + 1
            MOVE t-rl-e(w-5) TO w-6
            COMPUTE w-7 = v-m + 1
            COMPUTE w-8 = w-7 + 1
            MOVE t-rl-e(w-8) TO w-9
            COMPUTE w-10 = w-6 + w-9
            IF w-4 <= w-10
                MOVE 1 TO f-2
            ELSE
                MOVE 0 TO f-2
            END-IF
        END-IF
        IF f-2 = 1
            MOVE 1 TO v-need
        END-IF
        IF v-m > 1
            MOVE 1 TO f-3
        ELSE
            MOVE 0 TO f-3
        END-IF
        IF f-3 = 1
            COMPUTE w-11 = v-m - 2
            COMPUTE w-12 = w-11 + 1
            MOVE t-rl-e(w-12) TO w-13
            COMPUTE w-14 = v-m - 1
            COMPUTE w-15 = w-14 + 1
            MOVE t-rl-e(w-15) TO w-16
            COMPUTE w-17 = v-m + 1
            MOVE t-rl-e(w-17) TO w-18
            COMPUTE w-19 = w-16 + w-18
            IF w-13 <= w-19
                MOVE 1 TO f-3
            ELSE
                MOVE 0 TO f-3
            END-IF
        END-IF
        IF f-3 = 1
            MOVE 1 TO v-need
        END-IF
        IF v-need = 1
            MOVE 1 TO f-4
        ELSE
            MOVE 0 TO f-4
        END-IF
        IF f-4 = 1
            IF v-m > 0
                MOVE 1 TO f-5
            ELSE
                MOVE 0 TO f-5
            END-IF
            IF f-5 = 1
                COMPUTE w-20 = v-m - 1
                COMPUTE w-21 = w-20 + 1
                MOVE t-rl-e(w-21) TO w-22
                COMPUTE w-23 = v-m + 1
                COMPUTE w-24 = w-23 + 1
                MOVE t-rl-e(w-24) TO w-25
                IF w-22 < w-25
                    MOVE 1 TO f-5
                ELSE
                    MOVE 0 TO f-5
                END-IF
            END-IF
            IF f-5 = 1
                COMPUTE w-26 = v-m - 1
                MOVE w-26 TO v-m
            END-IF
            CALL "tse8d-merge-at" USING BY REFERENCE t-a BY REFERENCE t-tmp BY REFERENCE t-rs BY REFERENCE t-rl BY CONTENT v-cnt BY CONTENT v-m BY REFERENCE w-27
            END-CALL
            MOVE w-27 TO v-cnt
        ELSE
            COMPUTE w-28 = v-m + 1
            MOVE t-rl-e(w-28) TO w-29
            COMPUTE w-30 = v-m + 1
            COMPUTE w-31 = w-30 + 1
            MOVE t-rl-e(w-31) TO w-32
            IF w-29 <= w-32
                MOVE 1 TO f-6
            ELSE
                MOVE 0 TO f-6
            END-IF
            IF f-6 = 1
                CALL "tse8d-merge-at" USING BY REFERENCE t-a BY REFERENCE t-tmp BY REFERENCE t-rs BY REFERENCE t-rl BY CONTENT v-cnt BY CONTENT v-m BY REFERENCE w-33
                END-CALL
                MOVE w-33 TO v-cnt
            ELSE
                MOVE 0 TO v-going
            END-IF
        END-IF
    END-PERFORM
    MOVE v-cnt TO r-val
    GOBACK
    GOBACK.
END PROGRAM tse8d-collapse.

IDENTIFICATION DIVISION.
PROGRAM-ID. tim-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-r USAGE BINARY-DOUBLE SIGNED.
01 v-t USAGE BINARY-DOUBLE SIGNED.
01 v-minrun USAGE BINARY-DOUBLE SIGNED.
01 v-cnt USAGE BINARY-DOUBLE SIGNED.
01 v-lo USAGE BINARY-DOUBLE SIGNED.
01 v-e USAGE BINARY-DOUBLE SIGNED.
01 v-x USAGE BINARY-DOUBLE SIGNED.
01 v-y USAGE BINARY-DOUBLE SIGNED.
01 v-force USAGE BINARY-DOUBLE SIGNED.
01 v-m USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
01 f-5 USAGE BINARY-DOUBLE SIGNED.
01 f-6 USAGE BINARY-DOUBLE SIGNED.
01 f-7 USAGE BINARY-DOUBLE SIGNED.
01 f-8 USAGE BINARY-DOUBLE SIGNED.
01 f-9 USAGE BINARY-DOUBLE SIGNED.
01 f-10 USAGE BINARY-DOUBLE SIGNED.
01 f-11 USAGE BINARY-DOUBLE SIGNED.
01 f-12 USAGE BINARY-DOUBLE SIGNED.
01 t-tmp.
    05 t-tmp-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-rs.
    05 t-rs-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-rl.
    05 t-rl-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
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
    INITIALIZE t-tmp
    INITIALIZE t-rs
    INITIALIZE t-rl
    MOVE 0 TO v-r
    MOVE v-n TO v-t
    PERFORM UNTIL 1 = 2
        IF v-t >= 64
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-1 = FUNCTION MOD(v-t, 2)
        COMPUTE w-2 = v-r + w-1
        MOVE w-2 TO v-r
        IF v-r > 1
            MOVE 1 TO f-3
        ELSE
            MOVE 0 TO f-3
        END-IF
        IF f-3 = 1
            MOVE 1 TO v-r
        END-IF
        COMPUTE w-3 = FUNCTION INTEGER-PART(v-t / 2)
        MOVE w-3 TO v-t
    END-PERFORM
    COMPUTE w-4 = v-t + v-r
    MOVE w-4 TO v-minrun
    MOVE 0 TO v-cnt
    MOVE 0 TO v-lo
    PERFORM UNTIL 1 = 2
        IF v-lo < v-n
            MOVE 1 TO f-4
        ELSE
            MOVE 0 TO f-4
        END-IF
        IF f-4 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-5 = v-lo + 1
        MOVE w-5 TO v-e
        IF v-e < v-n
            MOVE 1 TO f-5
        ELSE
            MOVE 0 TO f-5
        END-IF
        IF f-5 = 1
            COMPUTE w-6 = v-e + 1
            MOVE t-a-e(w-6) TO w-7
            COMPUTE w-8 = v-e - 1
            COMPUTE w-9 = w-8 + 1
            MOVE t-a-e(w-9) TO w-10
            IF w-7 < w-10
                MOVE 1 TO f-6
            ELSE
                MOVE 0 TO f-6
            END-IF
            IF f-6 = 1
                PERFORM UNTIL 1 = 2
                    IF v-e < v-n
                        MOVE 1 TO f-7
                    ELSE
                        MOVE 0 TO f-7
                    END-IF
                    IF f-7 = 1
                        COMPUTE w-11 = v-e + 1
                        MOVE t-a-e(w-11) TO w-12
                        COMPUTE w-13 = v-e - 1
                        COMPUTE w-14 = w-13 + 1
                        MOVE t-a-e(w-14) TO w-15
                        IF w-12 < w-15
                            MOVE 1 TO f-7
                        ELSE
                            MOVE 0 TO f-7
                        END-IF
                    END-IF
                    IF f-7 = 0
                        EXIT PERFORM
                    END-IF
                    COMPUTE w-16 = v-e + 1
                    MOVE w-16 TO v-e
                END-PERFORM
                MOVE v-lo TO v-x
                COMPUTE w-17 = v-e - 1
                MOVE w-17 TO v-y
                PERFORM UNTIL 1 = 2
                    IF v-x < v-y
                        MOVE 1 TO f-8
                    ELSE
                        MOVE 0 TO f-8
                    END-IF
                    IF f-8 = 0
                        EXIT PERFORM
                    END-IF
                    COMPUTE w-18 = v-x + 1
                    COMPUTE w-19 = v-y + 1
                    MOVE t-a-e(w-18) TO w-20
                    MOVE t-a-e(w-19) TO t-a-e(w-18)
                    MOVE w-20 TO t-a-e(w-19)
                    COMPUTE w-21 = v-x + 1
                    MOVE w-21 TO v-x
                    COMPUTE w-22 = v-y - 1
                    MOVE w-22 TO v-y
                END-PERFORM
            ELSE
                PERFORM UNTIL 1 = 2
                    IF v-e < v-n
                        MOVE 1 TO f-9
                    ELSE
                        MOVE 0 TO f-9
                    END-IF
                    IF f-9 = 1
                        COMPUTE w-23 = v-e + 1
                        MOVE t-a-e(w-23) TO w-24
                        COMPUTE w-25 = v-e - 1
                        COMPUTE w-26 = w-25 + 1
                        MOVE t-a-e(w-26) TO w-27
                        IF w-24 >= w-27
                            MOVE 1 TO f-9
                        ELSE
                            MOVE 0 TO f-9
                        END-IF
                    END-IF
                    IF f-9 = 0
                        EXIT PERFORM
                    END-IF
                    COMPUTE w-28 = v-e + 1
                    MOVE w-28 TO v-e
                END-PERFORM
            END-IF
        END-IF
        COMPUTE w-29 = v-n - v-lo
        IF v-minrun < w-29
            MOVE v-minrun TO w-30
        ELSE
            MOVE w-29 TO w-30
        END-IF
        MOVE w-30 TO v-force
        COMPUTE w-31 = v-e - v-lo
        IF w-31 < v-force
            MOVE 1 TO f-10
        ELSE
            MOVE 0 TO f-10
        END-IF
        IF f-10 = 1
            COMPUTE w-32 = v-lo + v-force
            CALL "tse8d-insertion" USING BY REFERENCE t-a BY CONTENT v-lo BY CONTENT w-32
            END-CALL
            COMPUTE w-33 = v-lo + v-force
            MOVE w-33 TO v-e
        END-IF
        COMPUTE w-34 = v-cnt + 1
        MOVE v-lo TO t-rs-e(w-34)
        COMPUTE w-35 = v-e - v-lo
        COMPUTE w-36 = v-cnt + 1
        MOVE w-35 TO t-rl-e(w-36)
        COMPUTE w-37 = v-cnt + 1
        MOVE w-37 TO v-cnt
        CALL "tse8d-collapse" USING BY REFERENCE t-a BY REFERENCE t-tmp BY REFERENCE t-rs BY REFERENCE t-rl BY CONTENT v-cnt BY REFERENCE w-38
        END-CALL
        MOVE w-38 TO v-cnt
        MOVE v-e TO v-lo
    END-PERFORM
    PERFORM UNTIL 1 = 2
        IF v-cnt > 1
            MOVE 1 TO f-11
        ELSE
            MOVE 0 TO f-11
        END-IF
        IF f-11 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-39 = v-cnt - 2
        MOVE w-39 TO v-m
        IF v-m > 0
            MOVE 1 TO f-12
        ELSE
            MOVE 0 TO f-12
        END-IF
        IF f-12 = 1
            COMPUTE w-40 = v-m - 1
            COMPUTE w-41 = w-40 + 1
            MOVE t-rl-e(w-41) TO w-42
            COMPUTE w-43 = v-m + 1
            COMPUTE w-44 = w-43 + 1
            MOVE t-rl-e(w-44) TO w-45
            IF w-42 < w-45
                MOVE 1 TO f-12
            ELSE
                MOVE 0 TO f-12
            END-IF
        END-IF
        IF f-12 = 1
            COMPUTE w-46 = v-m - 1
            MOVE w-46 TO v-m
        END-IF
        CALL "tse8d-merge-at" USING BY REFERENCE t-a BY REFERENCE t-tmp BY REFERENCE t-rs BY REFERENCE t-rl BY CONTENT v-cnt BY CONTENT v-m BY REFERENCE w-47
        END-CALL
        MOVE w-47 TO v-cnt
    END-PERFORM
    GOBACK.
END PROGRAM tim-sort.

