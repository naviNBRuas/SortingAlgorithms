      *> GENERATED from kernels/algos/smooth_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. smooth-sort-x-tz IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-c USAGE BINARY-DOUBLE SIGNED.
01 w-1 USAGE BINARY-DOUBLE SIGNED.
01 w-2 USAGE BINARY-DOUBLE SIGNED.
01 w-3 USAGE BINARY-DOUBLE SIGNED.
01 f-1 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 v-x USAGE BINARY-DOUBLE SIGNED.
01 r-val USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY VALUE v-x RETURNING r-val.
    MOVE 0 TO v-c
    PERFORM UNTIL 1 = 2
        COMPUTE w-1 = FUNCTION MOD(v-x, 2)
        IF w-1 = 0
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-2 = FUNCTION INTEGER-PART(v-x / 2)
        MOVE w-2 TO v-x
        COMPUTE w-3 = v-c + 1
        MOVE w-3 TO v-c
    END-PERFORM
    MOVE v-c TO r-val
    GOBACK
    GOBACK.
END PROGRAM smooth-sort-x-tz.

IDENTIFICATION DIVISION.
PROGRAM-ID. smooth-sort-x-pow2 IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-r USAGE BINARY-DOUBLE SIGNED.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 w-1 USAGE BINARY-DOUBLE SIGNED.
01 w-2 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 v-k USAGE BINARY-DOUBLE SIGNED.
01 r-val USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY VALUE v-k RETURNING r-val.
    MOVE 1 TO v-r
    MOVE 0 TO v-i
    MOVE v-k TO w-1
    PERFORM UNTIL 1 = 2
        IF v-i >= w-1
            EXIT PERFORM
        END-IF
        COMPUTE w-2 = v-r * 2
        MOVE w-2 TO v-r
        ADD 1 TO v-i
    END-PERFORM
    MOVE v-r TO r-val
    GOBACK
    GOBACK.
END PROGRAM smooth-sort-x-pow2.

IDENTIFICATION DIVISION.
PROGRAM-ID. smooth-sort-x-sift IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-val USAGE BINARY-DOUBLE SIGNED.
01 v-going USAGE BINARY-DOUBLE SIGNED.
01 v-rt USAGE BINARY-DOUBLE SIGNED.
01 v-lf USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-lp.
    05 t-lp-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-head USAGE BINARY-DOUBLE SIGNED.
01 v-pshift USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-a BY REFERENCE t-lp BY VALUE v-head BY VALUE v-pshift.
    COMPUTE w-1 = v-head + 1
    MOVE t-a-e(w-1) TO w-2
    MOVE w-2 TO v-val
    MOVE 1 TO v-going
    PERFORM UNTIL 1 = 2
        IF v-pshift > 1
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 1
            IF v-going = 1
                MOVE 1 TO f-1
            ELSE
                MOVE 0 TO f-1
            END-IF
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-3 = v-head - 1
        MOVE w-3 TO v-rt
        COMPUTE w-4 = v-head - 1
        COMPUTE w-5 = v-pshift - 2
        COMPUTE w-6 = w-5 + 1
        MOVE t-lp-e(w-6) TO w-7
        COMPUTE w-8 = w-4 - w-7
        MOVE w-8 TO v-lf
        COMPUTE w-9 = v-lf + 1
        MOVE t-a-e(w-9) TO w-10
        IF v-val >= w-10
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 1
            COMPUTE w-11 = v-rt + 1
            MOVE t-a-e(w-11) TO w-12
            IF v-val >= w-12
                MOVE 1 TO f-2
            ELSE
                MOVE 0 TO f-2
            END-IF
        END-IF
        IF f-2 = 1
            MOVE 0 TO v-going
        ELSE
            COMPUTE w-13 = v-lf + 1
            MOVE t-a-e(w-13) TO w-14
            COMPUTE w-15 = v-rt + 1
            MOVE t-a-e(w-15) TO w-16
            IF w-14 >= w-16
                MOVE 1 TO f-3
            ELSE
                MOVE 0 TO f-3
            END-IF
            IF f-3 = 1
                COMPUTE w-17 = v-lf + 1
                MOVE t-a-e(w-17) TO w-18
                COMPUTE w-19 = v-head + 1
                MOVE w-18 TO t-a-e(w-19)
                MOVE v-lf TO v-head
                COMPUTE w-20 = v-pshift - 1
                MOVE w-20 TO v-pshift
            ELSE
                COMPUTE w-21 = v-rt + 1
                MOVE t-a-e(w-21) TO w-22
                COMPUTE w-23 = v-head + 1
                MOVE w-22 TO t-a-e(w-23)
                MOVE v-rt TO v-head
                COMPUTE w-24 = v-pshift - 2
                MOVE w-24 TO v-pshift
            END-IF
        END-IF
    END-PERFORM
    COMPUTE w-25 = v-head + 1
    MOVE v-val TO t-a-e(w-25)
    GOBACK.
END PROGRAM smooth-sort-x-sift.

IDENTIFICATION DIVISION.
PROGRAM-ID. smooth-sort-x-trinkle IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-val USAGE BINARY-DOUBLE SIGNED.
01 v-going USAGE BINARY-DOUBLE SIGNED.
01 v-stepson USAGE BINARY-DOUBLE SIGNED.
01 v-stop USAGE BINARY-DOUBLE SIGNED.
01 v-rt USAGE BINARY-DOUBLE SIGNED.
01 v-lf USAGE BINARY-DOUBLE SIGNED.
01 v-trail USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
01 f-5 USAGE BINARY-DOUBLE SIGNED.
01 f-6 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 t-lp.
    05 t-lp-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-head USAGE BINARY-DOUBLE SIGNED.
01 v-p USAGE BINARY-DOUBLE SIGNED.
01 v-pshift USAGE BINARY-DOUBLE SIGNED.
01 v-trusty USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING BY REFERENCE t-a BY REFERENCE t-lp BY VALUE v-head BY VALUE v-p BY VALUE v-pshift BY VALUE v-trusty.
    COMPUTE w-1 = v-head + 1
    MOVE t-a-e(w-1) TO w-2
    MOVE w-2 TO v-val
    MOVE 1 TO v-going
    PERFORM UNTIL 1 = 2
        IF v-p NOT = 1
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 1
            IF v-going = 1
                MOVE 1 TO f-1
            ELSE
                MOVE 0 TO f-1
            END-IF
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-3 = v-pshift + 1
        MOVE t-lp-e(w-3) TO w-4
        COMPUTE w-5 = v-head - w-4
        MOVE w-5 TO v-stepson
        COMPUTE w-6 = v-stepson + 1
        MOVE t-a-e(w-6) TO w-7
        IF w-7 <= v-val
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 1
            MOVE 0 TO v-going
        ELSE
            MOVE 0 TO v-stop
            IF v-trusty = 0
                MOVE 1 TO f-3
            ELSE
                MOVE 0 TO f-3
            END-IF
            IF f-3 = 1
                IF v-pshift > 1
                    MOVE 1 TO f-3
                ELSE
                    MOVE 0 TO f-3
                END-IF
            END-IF
            IF f-3 = 1
                COMPUTE w-8 = v-head - 1
                MOVE w-8 TO v-rt
                COMPUTE w-9 = v-head - 1
                COMPUTE w-10 = v-pshift - 2
                COMPUTE w-11 = w-10 + 1
                MOVE t-lp-e(w-11) TO w-12
                COMPUTE w-13 = w-9 - w-12
                MOVE w-13 TO v-lf
                COMPUTE w-14 = v-rt + 1
                MOVE t-a-e(w-14) TO w-15
                COMPUTE w-16 = v-stepson + 1
                MOVE t-a-e(w-16) TO w-17
                IF w-15 >= w-17
                    MOVE 1 TO f-4
                ELSE
                    MOVE 0 TO f-4
                END-IF
                IF f-4 = 0
                    COMPUTE w-18 = v-lf + 1
                    MOVE t-a-e(w-18) TO w-19
                    COMPUTE w-20 = v-stepson + 1
                    MOVE t-a-e(w-20) TO w-21
                    IF w-19 >= w-21
                        MOVE 1 TO f-4
                    ELSE
                        MOVE 0 TO f-4
                    END-IF
                END-IF
                IF f-4 = 1
                    MOVE 1 TO v-stop
                END-IF
            END-IF
            IF v-stop = 1
                MOVE 1 TO f-5
            ELSE
                MOVE 0 TO f-5
            END-IF
            IF f-5 = 1
                MOVE 0 TO v-going
            ELSE
                COMPUTE w-22 = v-stepson + 1
                MOVE t-a-e(w-22) TO w-23
                COMPUTE w-24 = v-head + 1
                MOVE w-23 TO t-a-e(w-24)
                MOVE v-stepson TO v-head
                COMPUTE w-25 = FUNCTION MOD(v-p, 2)
                COMPUTE w-26 = v-p - w-25
                CALL "smooth-sort-x-tz" USING BY VALUE w-26 RETURNING w-27
                END-CALL
                MOVE w-27 TO v-trail
                CALL "smooth-sort-x-pow2" USING BY VALUE v-trail RETURNING w-28
                END-CALL
                COMPUTE w-29 = FUNCTION INTEGER-PART(v-p / w-28)
                MOVE w-29 TO v-p
                COMPUTE w-30 = v-pshift + v-trail
                MOVE w-30 TO v-pshift
                MOVE 0 TO v-trusty
            END-IF
        END-IF
    END-PERFORM
    IF v-trusty = 0
        MOVE 1 TO f-6
    ELSE
        MOVE 0 TO f-6
    END-IF
    IF f-6 = 1
        COMPUTE w-31 = v-head + 1
        MOVE v-val TO t-a-e(w-31)
        CALL "smooth-sort-x-sift" USING BY REFERENCE t-a BY REFERENCE t-lp BY VALUE v-head BY VALUE v-pshift
        END-CALL
    END-IF
    GOBACK.
END PROGRAM smooth-sort-x-trinkle.

IDENTIFICATION DIVISION.
PROGRAM-ID. smooth-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 v-hi USAGE BINARY-DOUBLE SIGNED.
01 v-head USAGE BINARY-DOUBLE SIGNED.
01 v-p USAGE BINARY-DOUBLE SIGNED.
01 v-pshift USAGE BINARY-DOUBLE SIGNED.
01 v-trail USAGE BINARY-DOUBLE SIGNED.
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
01 f-8 USAGE BINARY-DOUBLE SIGNED.
01 t-lp.
    05 t-lp-e USAGE BINARY-LONG SIGNED OCCURS 64 TIMES.
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
    INITIALIZE t-lp
    COMPUTE w-1 = 0 + 1
    MOVE 1 TO t-lp-e(w-1)
    COMPUTE w-2 = 1 + 1
    MOVE 1 TO t-lp-e(w-2)
    MOVE 2 TO v-i
    MOVE 64 TO w-3
    PERFORM UNTIL 1 = 2
        IF v-i >= w-3
            EXIT PERFORM
        END-IF
        COMPUTE w-4 = v-i - 1
        COMPUTE w-5 = w-4 + 1
        MOVE t-lp-e(w-5) TO w-6
        COMPUTE w-7 = v-i - 2
        COMPUTE w-8 = w-7 + 1
        MOVE t-lp-e(w-8) TO w-9
        COMPUTE w-10 = w-6 + w-9
        COMPUTE w-11 = w-10 + 1
        COMPUTE w-12 = v-i + 1
        MOVE w-11 TO t-lp-e(w-12)
        ADD 1 TO v-i
    END-PERFORM
    COMPUTE w-13 = v-n - 1
    MOVE w-13 TO v-hi
    MOVE 0 TO v-head
    MOVE 1 TO v-p
    MOVE 1 TO v-pshift
    PERFORM UNTIL 1 = 2
        IF v-head < v-hi
            MOVE 1 TO f-2
        ELSE
            MOVE 0 TO f-2
        END-IF
        IF f-2 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-14 = FUNCTION MOD(v-p, 4)
        IF w-14 = 3
            MOVE 1 TO f-3
        ELSE
            MOVE 0 TO f-3
        END-IF
        IF f-3 = 1
            CALL "smooth-sort-x-sift" USING BY REFERENCE t-a BY REFERENCE t-lp BY VALUE v-head BY VALUE v-pshift
            END-CALL
            COMPUTE w-15 = FUNCTION INTEGER-PART(v-p / 4)
            MOVE w-15 TO v-p
            COMPUTE w-16 = v-pshift + 2
            MOVE w-16 TO v-pshift
        ELSE
            COMPUTE w-17 = v-pshift - 1
            COMPUTE w-18 = w-17 + 1
            MOVE t-lp-e(w-18) TO w-19
            COMPUTE w-20 = v-hi - v-head
            IF w-19 >= w-20
                MOVE 1 TO f-4
            ELSE
                MOVE 0 TO f-4
            END-IF
            IF f-4 = 1
                CALL "smooth-sort-x-trinkle" USING BY REFERENCE t-a BY REFERENCE t-lp BY VALUE v-head BY VALUE v-p BY VALUE v-pshift BY VALUE 0
                END-CALL
            ELSE
                CALL "smooth-sort-x-sift" USING BY REFERENCE t-a BY REFERENCE t-lp BY VALUE v-head BY VALUE v-pshift
                END-CALL
            END-IF
            IF v-pshift = 1
                MOVE 1 TO f-5
            ELSE
                MOVE 0 TO f-5
            END-IF
            IF f-5 = 1
                COMPUTE w-21 = v-p * 2
                MOVE w-21 TO v-p
                MOVE 0 TO v-pshift
            ELSE
                COMPUTE w-22 = v-pshift - 1
                CALL "smooth-sort-x-pow2" USING BY VALUE w-22 RETURNING w-23
                END-CALL
                COMPUTE w-24 = v-p * w-23
                MOVE w-24 TO v-p
                MOVE 1 TO v-pshift
            END-IF
        END-IF
        COMPUTE w-25 = v-p + 1
        COMPUTE w-26 = FUNCTION MOD(v-p, 2)
        COMPUTE w-27 = w-25 - w-26
        MOVE w-27 TO v-p
        COMPUTE w-28 = v-head + 1
        MOVE w-28 TO v-head
    END-PERFORM
    CALL "smooth-sort-x-trinkle" USING BY REFERENCE t-a BY REFERENCE t-lp BY VALUE v-head BY VALUE v-p BY VALUE v-pshift BY VALUE 0
    END-CALL
    PERFORM UNTIL 1 = 2
        IF v-pshift NOT = 1
            MOVE 1 TO f-6
        ELSE
            MOVE 0 TO f-6
        END-IF
        IF f-6 = 0
            IF v-p NOT = 1
                MOVE 1 TO f-6
            ELSE
                MOVE 0 TO f-6
            END-IF
        END-IF
        IF f-6 = 0
            EXIT PERFORM
        END-IF
        IF v-pshift <= 1
            MOVE 1 TO f-7
        ELSE
            MOVE 0 TO f-7
        END-IF
        IF f-7 = 1
            COMPUTE w-29 = FUNCTION MOD(v-p, 2)
            COMPUTE w-30 = v-p - w-29
            CALL "smooth-sort-x-tz" USING BY VALUE w-30 RETURNING w-31
            END-CALL
            MOVE w-31 TO v-trail
            CALL "smooth-sort-x-pow2" USING BY VALUE v-trail RETURNING w-32
            END-CALL
            COMPUTE w-33 = FUNCTION INTEGER-PART(v-p / w-32)
            MOVE w-33 TO v-p
            COMPUTE w-34 = v-pshift + v-trail
            MOVE w-34 TO v-pshift
        ELSE
            COMPUTE w-35 = v-p * 4
            MOVE w-35 TO v-p
            COMPUTE w-36 = FUNCTION INTEGER-PART(v-p / 4)
            COMPUTE w-37 = FUNCTION MOD(w-36, 2)
            IF w-37 = 0
                MOVE 1 TO f-8
            ELSE
                MOVE 0 TO f-8
            END-IF
            IF f-8 = 1
                COMPUTE w-38 = v-p + 7
                MOVE w-38 TO v-p
            ELSE
                COMPUTE w-39 = v-p - 1
                MOVE w-39 TO v-p
            END-IF
            COMPUTE w-40 = v-pshift - 2
            MOVE w-40 TO v-pshift
            COMPUTE w-41 = v-pshift + 1
            MOVE t-lp-e(w-41) TO w-42
            COMPUTE w-43 = v-head - w-42
            COMPUTE w-44 = w-43 - 1
            COMPUTE w-45 = FUNCTION INTEGER-PART(v-p / 2)
            COMPUTE w-46 = v-pshift + 1
            CALL "smooth-sort-x-trinkle" USING BY REFERENCE t-a BY REFERENCE t-lp BY VALUE w-44 BY VALUE w-45 BY VALUE w-46 BY VALUE 1
            END-CALL
            COMPUTE w-47 = v-head - 1
            CALL "smooth-sort-x-trinkle" USING BY REFERENCE t-a BY REFERENCE t-lp BY VALUE w-47 BY VALUE v-p BY VALUE v-pshift BY VALUE 1
            END-CALL
        END-IF
        COMPUTE w-48 = v-head - 1
        MOVE w-48 TO v-head
    END-PERFORM
    GOBACK.
END PROGRAM smooth-sort.

