      *> GENERATED from kernels/algos/quick_sort_dual_pivot.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. qsdp6a2-qs IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-p USAGE BINARY-DOUBLE SIGNED.
01 v-q USAGE BINARY-DOUBLE SIGNED.
01 v-lt USAGE BINARY-DOUBLE SIGNED.
01 v-gt USAGE BINARY-DOUBLE SIGNED.
01 v-k USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
01 f-5 USAGE BINARY-DOUBLE SIGNED.
01 f-6 USAGE BINARY-DOUBLE SIGNED.
01 f-7 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-lo USAGE BINARY-DOUBLE SIGNED.
01 v-hi USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING t-a v-lo v-hi.
    PERFORM UNTIL 1 = 2
        IF v-lo < v-hi
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-1 = v-lo + 1
        MOVE t-a-e(w-1) TO w-2
        COMPUTE w-3 = v-hi + 1
        MOVE t-a-e(w-3) TO w-4
        IF w-2 > w-4
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 1
            COMPUTE w-5 = v-lo + 1
            COMPUTE w-6 = v-hi + 1
            MOVE t-a-e(w-5) TO w-7
            MOVE t-a-e(w-6) TO t-a-e(w-5)
            MOVE w-7 TO t-a-e(w-6)
        END-IF
        COMPUTE w-8 = v-lo + 1
        MOVE t-a-e(w-8) TO w-9
        MOVE w-9 TO v-p
        COMPUTE w-10 = v-hi + 1
        MOVE t-a-e(w-10) TO w-11
        MOVE w-11 TO v-q
        COMPUTE w-12 = v-lo + 1
        MOVE w-12 TO v-lt
        COMPUTE w-13 = v-hi - 1
        MOVE w-13 TO v-gt
        COMPUTE w-14 = v-lo + 1
        MOVE w-14 TO v-k
        PERFORM UNTIL 1 = 2
            IF v-k <= v-gt
                MOVE 1 TO f-3
            ELSE
                MOVE 0 TO f-3
            END-IF
            IF f-3 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-15 = v-k + 1
            MOVE t-a-e(w-15) TO w-16
            IF w-16 < v-p
                MOVE 1 TO f-4
            ELSE
                MOVE 0 TO f-4
            END-IF
            IF f-4 = 1
                COMPUTE w-17 = v-k + 1
                COMPUTE w-18 = v-lt + 1
                MOVE t-a-e(w-17) TO w-19
                MOVE t-a-e(w-18) TO t-a-e(w-17)
                MOVE w-19 TO t-a-e(w-18)
                COMPUTE w-20 = v-lt + 1
                MOVE w-20 TO v-lt
            ELSE
                COMPUTE w-21 = v-k + 1
                MOVE t-a-e(w-21) TO w-22
                IF w-22 > v-q
                    MOVE 1 TO f-5
                ELSE
                    MOVE 0 TO f-5
                END-IF
                IF f-5 = 1
                    PERFORM UNTIL 1 = 2
                        IF v-k < v-gt
                            MOVE 1 TO f-6
                        ELSE
                            MOVE 0 TO f-6
                        END-IF
                        IF f-6 = 1
                            COMPUTE w-23 = v-gt + 1
                            MOVE t-a-e(w-23) TO w-24
                            IF w-24 > v-q
                                MOVE 1 TO f-6
                            ELSE
                                MOVE 0 TO f-6
                            END-IF
                        END-IF
                        IF f-6 = 0
                            EXIT PERFORM
                        END-IF
                        COMPUTE w-25 = v-gt - 1
                        MOVE w-25 TO v-gt
                    END-PERFORM
                    COMPUTE w-26 = v-k + 1
                    COMPUTE w-27 = v-gt + 1
                    MOVE t-a-e(w-26) TO w-28
                    MOVE t-a-e(w-27) TO t-a-e(w-26)
                    MOVE w-28 TO t-a-e(w-27)
                    COMPUTE w-29 = v-gt - 1
                    MOVE w-29 TO v-gt
                    COMPUTE w-30 = v-k + 1
                    MOVE t-a-e(w-30) TO w-31
                    IF w-31 < v-p
                        MOVE 1 TO f-7
                    ELSE
                        MOVE 0 TO f-7
                    END-IF
                    IF f-7 = 1
                        COMPUTE w-32 = v-k + 1
                        COMPUTE w-33 = v-lt + 1
                        MOVE t-a-e(w-32) TO w-34
                        MOVE t-a-e(w-33) TO t-a-e(w-32)
                        MOVE w-34 TO t-a-e(w-33)
                        COMPUTE w-35 = v-lt + 1
                        MOVE w-35 TO v-lt
                    END-IF
                END-IF
            END-IF
            COMPUTE w-36 = v-k + 1
            MOVE w-36 TO v-k
        END-PERFORM
        COMPUTE w-37 = v-lt - 1
        MOVE w-37 TO v-lt
        COMPUTE w-38 = v-gt + 1
        MOVE w-38 TO v-gt
        COMPUTE w-39 = v-lo + 1
        COMPUTE w-40 = v-lt + 1
        MOVE t-a-e(w-39) TO w-41
        MOVE t-a-e(w-40) TO t-a-e(w-39)
        MOVE w-41 TO t-a-e(w-40)
        COMPUTE w-42 = v-hi + 1
        COMPUTE w-43 = v-gt + 1
        MOVE t-a-e(w-42) TO w-44
        MOVE t-a-e(w-43) TO t-a-e(w-42)
        MOVE w-44 TO t-a-e(w-43)
        COMPUTE w-45 = v-lt - 1
        CALL "qsdp6a2-qs" USING BY REFERENCE t-a BY CONTENT v-lo BY CONTENT w-45
        END-CALL
        COMPUTE w-46 = v-gt + 1
        CALL "qsdp6a2-qs" USING BY REFERENCE t-a BY CONTENT w-46 BY CONTENT v-hi
        END-CALL
        COMPUTE w-47 = v-lt + 1
        MOVE w-47 TO v-lo
        COMPUTE w-48 = v-gt - 1
        MOVE w-48 TO v-hi
    END-PERFORM
    GOBACK.
END PROGRAM qsdp6a2-qs.

IDENTIFICATION DIVISION.
PROGRAM-ID. quick-sort-dual-pivot IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 w-1 USAGE BINARY-DOUBLE SIGNED.
01 w-2 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-n USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING t-a v-n.
    MOVE 0 TO w-1
    COMPUTE w-2 = v-n - 1
    CALL "qsdp6a2-qs" USING BY REFERENCE t-a BY CONTENT w-1 BY CONTENT w-2
    END-CALL
    GOBACK.
END PROGRAM quick-sort-dual-pivot.

