      *> GENERATED from kernels/algos/ford_johnson_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. fjse46-fj IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-h USAGE BINARY-DOUBLE SIGNED.
01 v-k USAGE BINARY-DOUBLE SIGNED.
01 v-x USAGE BINARY-DOUBLE SIGNED.
01 v-y USAGE BINARY-DOUBLE SIGNED.
01 v-total USAGE BINARY-DOUBLE SIGNED.
01 v-size USAGE BINARY-DOUBLE SIGNED.
01 v-prev USAGE BINARY-DOUBLE SIGNED.
01 v-kk USAGE BINARY-DOUBLE SIGNED.
01 v-t USAGE BINARY-DOUBLE SIGNED.
01 v-pw USAGE BINARY-DOUBLE SIGNED.
01 v-c USAGE BINARY-DOUBLE SIGNED.
01 v-top USAGE BINARY-DOUBLE SIGNED.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 v-bound USAGE BINARY-DOUBLE SIGNED.
01 v-lo USAGE BINARY-DOUBLE SIGNED.
01 v-hi USAGE BINARY-DOUBLE SIGNED.
01 v-mid USAGE BINARY-DOUBLE SIGNED.
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
01 w-84 USAGE BINARY-DOUBLE SIGNED.
01 w-85 USAGE BINARY-DOUBLE SIGNED.
01 w-86 USAGE BINARY-DOUBLE SIGNED.
01 w-87 USAGE BINARY-DOUBLE SIGNED.
01 w-88 USAGE BINARY-DOUBLE SIGNED.
01 w-89 USAGE BINARY-DOUBLE SIGNED.
01 w-90 USAGE BINARY-DOUBLE SIGNED.
01 w-91 USAGE BINARY-DOUBLE SIGNED.
01 w-92 USAGE BINARY-DOUBLE SIGNED.
01 w-93 USAGE BINARY-DOUBLE SIGNED.
01 w-94 USAGE BINARY-DOUBLE SIGNED.
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
01 f-13 USAGE BINARY-DOUBLE SIGNED.
01 t-small.
    05 t-small-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-big.
    05 t-big-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-bk.
    05 t-bk-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-order.
    05 t-order-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-chain.
    05 t-chain-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-bs.
    05 t-bs-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
LINKAGE SECTION.
01 t-key.
    05 t-key-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-ids.
    05 t-ids-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-m USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING t-key t-ids v-m.
    IF v-m < 2
        MOVE 1 TO f-1
    ELSE
        MOVE 0 TO f-1
    END-IF
    IF f-1 = 1
        GOBACK
    END-IF
    COMPUTE w-1 = FUNCTION INTEGER-PART(v-m / 2)
    MOVE w-1 TO v-h
    INITIALIZE t-small
    INITIALIZE t-big
    MOVE 0 TO v-k
    MOVE v-h TO w-2
    PERFORM UNTIL 1 = 2
        IF v-k >= w-2
            EXIT PERFORM
        END-IF
        COMPUTE w-3 = 2 * v-k
        COMPUTE w-4 = w-3 + 1
        MOVE t-ids-e(w-4) TO w-5
        MOVE w-5 TO v-x
        COMPUTE w-6 = 2 * v-k
        COMPUTE w-7 = w-6 + 1
        COMPUTE w-8 = w-7 + 1
        MOVE t-ids-e(w-8) TO w-9
        MOVE w-9 TO v-y
        COMPUTE w-10 = v-y + 1
        MOVE t-key-e(w-10) TO w-11
        COMPUTE w-12 = v-x + 1
        MOVE t-key-e(w-12) TO w-13
        IF w-11 < w-13
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 1
            COMPUTE w-14 = v-k + 1
            MOVE v-y TO t-small-e(w-14)
            COMPUTE w-15 = v-k + 1
            MOVE v-x TO t-big-e(w-15)
        ELSE
            COMPUTE w-16 = v-k + 1
            MOVE v-x TO t-small-e(w-16)
            COMPUTE w-17 = v-k + 1
            MOVE v-y TO t-big-e(w-17)
        END-IF
        ADD 1 TO v-k
    END-PERFORM
    INITIALIZE t-bk
    INITIALIZE t-order
    MOVE 0 TO v-k
    MOVE v-h TO w-18
    PERFORM UNTIL 1 = 2
        IF v-k >= w-18
            EXIT PERFORM
        END-IF
        COMPUTE w-19 = v-k + 1
        MOVE t-big-e(w-19) TO w-20
        COMPUTE w-21 = w-20 + 1
        MOVE t-key-e(w-21) TO w-22
        COMPUTE w-23 = v-k + 1
        MOVE w-22 TO t-bk-e(w-23)
        COMPUTE w-24 = v-k + 1
        MOVE v-k TO t-order-e(w-24)
        ADD 1 TO v-k
    END-PERFORM
    CALL "fjse46-fj" USING BY REFERENCE t-bk BY REFERENCE t-order BY CONTENT v-h
    END-CALL
    MOVE v-h TO v-total
    COMPUTE w-25 = FUNCTION MOD(v-m, 2)
    IF w-25 = 1
        MOVE 1 TO f-3
    ELSE
        MOVE 0 TO f-3
    END-IF
    IF f-3 = 1
        COMPUTE w-26 = v-h + 1
        MOVE w-26 TO v-total
    END-IF
    INITIALIZE t-chain
    INITIALIZE t-bs
    COMPUTE w-27 = 0 + 1
    MOVE t-order-e(w-27) TO w-28
    COMPUTE w-29 = w-28 + 1
    MOVE t-small-e(w-29) TO w-30
    COMPUTE w-31 = 0 + 1
    MOVE w-30 TO t-chain-e(w-31)
    MOVE 0 TO v-k
    MOVE v-h TO w-32
    PERFORM UNTIL 1 = 2
        IF v-k >= w-32
            EXIT PERFORM
        END-IF
        COMPUTE w-33 = v-k + 1
        MOVE t-order-e(w-33) TO w-34
        COMPUTE w-35 = w-34 + 1
        MOVE t-big-e(w-35) TO w-36
        COMPUTE w-37 = v-k + 1
        COMPUTE w-38 = w-37 + 1
        MOVE w-36 TO t-chain-e(w-38)
        COMPUTE w-39 = v-k + 1
        MOVE t-order-e(w-39) TO w-40
        COMPUTE w-41 = w-40 + 1
        MOVE t-small-e(w-41) TO w-42
        COMPUTE w-43 = v-k + 1
        COMPUTE w-44 = w-43 + 1
        MOVE w-42 TO t-bs-e(w-44)
        ADD 1 TO v-k
    END-PERFORM
    COMPUTE w-45 = v-h + 1
    MOVE w-45 TO v-size
    COMPUTE w-46 = FUNCTION MOD(v-m, 2)
    IF w-46 = 1
        MOVE 1 TO f-4
    ELSE
        MOVE 0 TO f-4
    END-IF
    IF f-4 = 1
        COMPUTE w-47 = v-m - 1
        COMPUTE w-48 = w-47 + 1
        MOVE t-ids-e(w-48) TO w-49
        COMPUTE w-50 = v-h + 1
        COMPUTE w-51 = w-50 + 1
        MOVE w-49 TO t-bs-e(w-51)
    END-IF
    MOVE 1 TO v-prev
    MOVE 2 TO v-kk
    PERFORM UNTIL 1 = 2
        IF v-prev < v-total
            MOVE 1 TO f-5
        ELSE
            MOVE 0 TO f-5
        END-IF
        IF f-5 = 0
            EXIT PERFORM
        END-IF
        MOVE 1 TO v-t
        MOVE 1 TO v-pw
        MOVE 0 TO v-c
        PERFORM UNTIL 1 = 2
            COMPUTE w-52 = v-kk + 1
            IF v-c < w-52
                MOVE 1 TO f-6
            ELSE
                MOVE 0 TO f-6
            END-IF
            IF f-6 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-53 = v-pw * 2
            MOVE w-53 TO v-pw
            COMPUTE w-54 = v-c + 1
            MOVE w-54 TO v-c
        END-PERFORM
        COMPUTE w-55 = FUNCTION MOD(v-kk, 2)
        IF w-55 = 0
            MOVE 1 TO f-7
        ELSE
            MOVE 0 TO f-7
        END-IF
        IF f-7 = 1
            COMPUTE w-56 = v-pw + 1
            COMPUTE w-57 = FUNCTION INTEGER-PART(w-56 / 3)
            MOVE w-57 TO v-t
        ELSE
            COMPUTE w-58 = v-pw - 1
            COMPUTE w-59 = FUNCTION INTEGER-PART(w-58 / 3)
            MOVE w-59 TO v-t
        END-IF
        IF v-t < v-total
            MOVE v-t TO w-60
        ELSE
            MOVE v-total TO w-60
        END-IF
        MOVE w-60 TO v-top
        MOVE v-top TO v-i
        PERFORM UNTIL 1 = 2
            IF v-i > v-prev
                MOVE 1 TO f-8
            ELSE
                MOVE 0 TO f-8
            END-IF
            IF f-8 = 0
                EXIT PERFORM
            END-IF
            MOVE v-size TO v-bound
            IF v-i <= v-h
                MOVE 1 TO f-9
            ELSE
                MOVE 0 TO f-9
            END-IF
            IF f-9 = 1
                MOVE 0 TO v-bound
                PERFORM UNTIL 1 = 2
                    COMPUTE w-61 = v-bound + 1
                    MOVE t-chain-e(w-61) TO w-62
                    COMPUTE w-63 = v-i - 1
                    COMPUTE w-64 = w-63 + 1
                    MOVE t-order-e(w-64) TO w-65
                    COMPUTE w-66 = w-65 + 1
                    MOVE t-big-e(w-66) TO w-67
                    IF w-62 NOT = w-67
                        MOVE 1 TO f-10
                    ELSE
                        MOVE 0 TO f-10
                    END-IF
                    IF f-10 = 0
                        EXIT PERFORM
                    END-IF
                    COMPUTE w-68 = v-bound + 1
                    MOVE w-68 TO v-bound
                END-PERFORM
            END-IF
            MOVE 0 TO v-lo
            MOVE v-bound TO v-hi
            PERFORM UNTIL 1 = 2
                IF v-lo < v-hi
                    MOVE 1 TO f-11
                ELSE
                    MOVE 0 TO f-11
                END-IF
                IF f-11 = 0
                    EXIT PERFORM
                END-IF
                COMPUTE w-69 = v-lo + v-hi
                COMPUTE w-70 = FUNCTION INTEGER-PART(w-69 / 2)
                MOVE w-70 TO v-mid
                COMPUTE w-71 = v-i + 1
                MOVE t-bs-e(w-71) TO w-72
                COMPUTE w-73 = w-72 + 1
                MOVE t-key-e(w-73) TO w-74
                COMPUTE w-75 = v-mid + 1
                MOVE t-chain-e(w-75) TO w-76
                COMPUTE w-77 = w-76 + 1
                MOVE t-key-e(w-77) TO w-78
                IF w-74 < w-78
                    MOVE 1 TO f-12
                ELSE
                    MOVE 0 TO f-12
                END-IF
                IF f-12 = 1
                    MOVE v-mid TO v-hi
                ELSE
                    COMPUTE w-79 = v-mid + 1
                    MOVE w-79 TO v-lo
                END-IF
            END-PERFORM
            MOVE v-size TO v-j
            PERFORM UNTIL 1 = 2
                IF v-j > v-lo
                    MOVE 1 TO f-13
                ELSE
                    MOVE 0 TO f-13
                END-IF
                IF f-13 = 0
                    EXIT PERFORM
                END-IF
                COMPUTE w-80 = v-j - 1
                COMPUTE w-81 = w-80 + 1
                MOVE t-chain-e(w-81) TO w-82
                COMPUTE w-83 = v-j + 1
                MOVE w-82 TO t-chain-e(w-83)
                COMPUTE w-84 = v-j - 1
                MOVE w-84 TO v-j
            END-PERFORM
            COMPUTE w-85 = v-i + 1
            MOVE t-bs-e(w-85) TO w-86
            COMPUTE w-87 = v-lo + 1
            MOVE w-86 TO t-chain-e(w-87)
            COMPUTE w-88 = v-size + 1
            MOVE w-88 TO v-size
            COMPUTE w-89 = v-i - 1
            MOVE w-89 TO v-i
        END-PERFORM
        MOVE v-top TO v-prev
        COMPUTE w-90 = v-kk + 1
        MOVE w-90 TO v-kk
    END-PERFORM
    MOVE 0 TO v-k
    MOVE v-m TO w-91
    PERFORM UNTIL 1 = 2
        IF v-k >= w-91
            EXIT PERFORM
        END-IF
        COMPUTE w-92 = v-k + 1
        MOVE t-chain-e(w-92) TO w-93
        COMPUTE w-94 = v-k + 1
        MOVE w-93 TO t-ids-e(w-94)
        ADD 1 TO v-k
    END-PERFORM
    GOBACK.
END PROGRAM fjse46-fj.

IDENTIFICATION DIVISION.
PROGRAM-ID. ford-johnson-sort IS RECURSIVE.
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
01 t-key.
    05 t-key-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-ids.
    05 t-ids-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
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
    INITIALIZE t-key
    INITIALIZE t-ids
    MOVE 0 TO v-i
    MOVE v-n TO w-1
    PERFORM UNTIL 1 = 2
        IF v-i >= w-1
            EXIT PERFORM
        END-IF
        COMPUTE w-2 = v-i + 1
        MOVE t-a-e(w-2) TO w-3
        COMPUTE w-4 = v-i + 1
        MOVE w-3 TO t-key-e(w-4)
        COMPUTE w-5 = v-i + 1
        MOVE v-i TO t-ids-e(w-5)
        ADD 1 TO v-i
    END-PERFORM
    CALL "fjse46-fj" USING BY REFERENCE t-key BY REFERENCE t-ids BY CONTENT v-n
    END-CALL
    MOVE 0 TO v-i
    MOVE v-n TO w-6
    PERFORM UNTIL 1 = 2
        IF v-i >= w-6
            EXIT PERFORM
        END-IF
        COMPUTE w-7 = v-i + 1
        MOVE t-ids-e(w-7) TO w-8
        COMPUTE w-9 = w-8 + 1
        MOVE t-key-e(w-9) TO w-10
        COMPUTE w-11 = v-i + 1
        MOVE w-10 TO t-a-e(w-11)
        ADD 1 TO v-i
    END-PERFORM
    GOBACK.
END PROGRAM ford-johnson-sort.

