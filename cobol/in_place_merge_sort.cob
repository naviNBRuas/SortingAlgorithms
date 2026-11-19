      *> GENERATED from kernels/algos/in_place_merge_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
>>SOURCE FORMAT FREE

IDENTIFICATION DIVISION.
PROGRAM-ID. ipms433-reverse IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 w-1 USAGE BINARY-DOUBLE SIGNED.
01 w-2 USAGE BINARY-DOUBLE SIGNED.
01 w-3 USAGE BINARY-DOUBLE SIGNED.
01 w-4 USAGE BINARY-DOUBLE SIGNED.
01 w-5 USAGE BINARY-DOUBLE SIGNED.
01 w-6 USAGE BINARY-DOUBLE SIGNED.
01 f-1 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 v-j USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING t-a v-i v-j.
    COMPUTE w-1 = v-j - 1
    MOVE w-1 TO v-j
    PERFORM UNTIL 1 = 2
        IF v-i < v-j
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
        IF f-1 = 0
            EXIT PERFORM
        END-IF
        COMPUTE w-2 = v-i + 1
        COMPUTE w-3 = v-j + 1
        MOVE t-a-e(w-2) TO w-4
        MOVE t-a-e(w-3) TO t-a-e(w-2)
        MOVE w-4 TO t-a-e(w-3)
        COMPUTE w-5 = v-i + 1
        MOVE w-5 TO v-i
        COMPUTE w-6 = v-j - 1
        MOVE w-6 TO v-j
    END-PERFORM
    GOBACK.
END PROGRAM ipms433-reverse.

IDENTIFICATION DIVISION.
PROGRAM-ID. ipms433-rotate IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 v-m USAGE BINARY-DOUBLE SIGNED.
01 v-j USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING t-a v-i v-m v-j.
    CALL "ipms433-reverse" USING BY REFERENCE t-a BY CONTENT v-i BY CONTENT v-m
    END-CALL
    CALL "ipms433-reverse" USING BY REFERENCE t-a BY CONTENT v-m BY CONTENT v-j
    END-CALL
    CALL "ipms433-reverse" USING BY REFERENCE t-a BY CONTENT v-i BY CONTENT v-j
    END-CALL
    GOBACK.
END PROGRAM ipms433-rotate.

IDENTIFICATION DIVISION.
PROGRAM-ID. ipms433-merge IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-i USAGE BINARY-DOUBLE SIGNED.
01 v-pivot USAGE BINARY-DOUBLE SIGNED.
01 v-l USAGE BINARY-DOUBLE SIGNED.
01 v-h USAGE BINARY-DOUBLE SIGNED.
01 v-m USAGE BINARY-DOUBLE SIGNED.
01 v-j USAGE BINARY-DOUBLE SIGNED.
01 v-nm USAGE BINARY-DOUBLE SIGNED.
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
01 f-1 USAGE BINARY-DOUBLE SIGNED.
01 f-2 USAGE BINARY-DOUBLE SIGNED.
01 f-3 USAGE BINARY-DOUBLE SIGNED.
01 f-4 USAGE BINARY-DOUBLE SIGNED.
01 f-5 USAGE BINARY-DOUBLE SIGNED.
01 f-6 USAGE BINARY-DOUBLE SIGNED.
01 f-7 USAGE BINARY-DOUBLE SIGNED.
01 f-8 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-lo USAGE BINARY-DOUBLE SIGNED.
01 v-mid USAGE BINARY-DOUBLE SIGNED.
01 v-hi USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING t-a v-lo v-mid v-hi.
    IF v-lo >= v-mid
        MOVE 1 TO f-1
    ELSE
        MOVE 0 TO f-1
    END-IF
    IF f-1 = 0
        IF v-mid >= v-hi
            MOVE 1 TO f-1
        ELSE
            MOVE 0 TO f-1
        END-IF
    END-IF
    IF f-1 = 1
        GOBACK
    END-IF
    COMPUTE w-1 = v-hi - v-lo
    IF w-1 = 2
        MOVE 1 TO f-2
    ELSE
        MOVE 0 TO f-2
    END-IF
    IF f-2 = 1
        COMPUTE w-2 = v-mid + 1
        MOVE t-a-e(w-2) TO w-3
        COMPUTE w-4 = v-lo + 1
        MOVE t-a-e(w-4) TO w-5
        IF w-3 < w-5
            MOVE 1 TO f-3
        ELSE
            MOVE 0 TO f-3
        END-IF
        IF f-3 = 1
            COMPUTE w-6 = v-lo + 1
            COMPUTE w-7 = v-mid + 1
            MOVE t-a-e(w-6) TO w-8
            MOVE t-a-e(w-7) TO t-a-e(w-6)
            MOVE w-8 TO t-a-e(w-7)
        END-IF
        GOBACK
    END-IF
    COMPUTE w-9 = v-mid - v-lo
    COMPUTE w-10 = v-hi - v-mid
    IF w-9 >= w-10
        MOVE 1 TO f-4
    ELSE
        MOVE 0 TO f-4
    END-IF
    IF f-4 = 1
        COMPUTE w-11 = v-lo + v-mid
        COMPUTE w-12 = FUNCTION INTEGER-PART(w-11 / 2)
        MOVE w-12 TO v-i
        COMPUTE w-13 = v-i + 1
        MOVE t-a-e(w-13) TO w-14
        MOVE w-14 TO v-pivot
        MOVE v-mid TO v-l
        MOVE v-hi TO v-h
        PERFORM UNTIL 1 = 2
            IF v-l < v-h
                MOVE 1 TO f-5
            ELSE
                MOVE 0 TO f-5
            END-IF
            IF f-5 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-15 = v-l + v-h
            COMPUTE w-16 = FUNCTION INTEGER-PART(w-15 / 2)
            MOVE w-16 TO v-m
            COMPUTE w-17 = v-m + 1
            MOVE t-a-e(w-17) TO w-18
            IF w-18 < v-pivot
                MOVE 1 TO f-6
            ELSE
                MOVE 0 TO f-6
            END-IF
            IF f-6 = 1
                COMPUTE w-19 = v-m + 1
                MOVE w-19 TO v-l
            ELSE
                MOVE v-m TO v-h
            END-IF
        END-PERFORM
        MOVE v-l TO v-j
        CALL "ipms433-rotate" USING BY REFERENCE t-a BY CONTENT v-i BY CONTENT v-mid BY CONTENT v-j
        END-CALL
        COMPUTE w-20 = v-j - v-mid
        COMPUTE w-21 = v-i + w-20
        MOVE w-21 TO v-nm
        CALL "ipms433-merge" USING BY REFERENCE t-a BY CONTENT v-lo BY CONTENT v-i BY CONTENT v-nm
        END-CALL
        COMPUTE w-22 = v-nm + 1
        CALL "ipms433-merge" USING BY REFERENCE t-a BY CONTENT w-22 BY CONTENT v-j BY CONTENT v-hi
        END-CALL
    ELSE
        COMPUTE w-23 = v-mid + v-hi
        COMPUTE w-24 = FUNCTION INTEGER-PART(w-23 / 2)
        MOVE w-24 TO v-j
        COMPUTE w-25 = v-j + 1
        MOVE t-a-e(w-25) TO w-26
        MOVE w-26 TO v-pivot
        MOVE v-lo TO v-l
        MOVE v-mid TO v-h
        PERFORM UNTIL 1 = 2
            IF v-l < v-h
                MOVE 1 TO f-7
            ELSE
                MOVE 0 TO f-7
            END-IF
            IF f-7 = 0
                EXIT PERFORM
            END-IF
            COMPUTE w-27 = v-l + v-h
            COMPUTE w-28 = FUNCTION INTEGER-PART(w-27 / 2)
            MOVE w-28 TO v-m
            COMPUTE w-29 = v-m + 1
            MOVE t-a-e(w-29) TO w-30
            IF v-pivot < w-30
                MOVE 1 TO f-8
            ELSE
                MOVE 0 TO f-8
            END-IF
            IF f-8 = 1
                MOVE v-m TO v-h
            ELSE
                COMPUTE w-31 = v-m + 1
                MOVE w-31 TO v-l
            END-IF
        END-PERFORM
        MOVE v-l TO v-i
        COMPUTE w-32 = v-j + 1
        CALL "ipms433-rotate" USING BY REFERENCE t-a BY CONTENT v-i BY CONTENT v-mid BY CONTENT w-32
        END-CALL
        COMPUTE w-33 = v-j + 1
        COMPUTE w-34 = w-33 - v-mid
        COMPUTE w-35 = v-i + w-34
        MOVE w-35 TO v-nm
        COMPUTE w-36 = v-nm - 1
        CALL "ipms433-merge" USING BY REFERENCE t-a BY CONTENT v-lo BY CONTENT v-i BY CONTENT w-36
        END-CALL
        COMPUTE w-37 = v-j + 1
        CALL "ipms433-merge" USING BY REFERENCE t-a BY CONTENT v-nm BY CONTENT w-37 BY CONTENT v-hi
        END-CALL
    END-IF
    GOBACK.
END PROGRAM ipms433-merge.

IDENTIFICATION DIVISION.
PROGRAM-ID. ipms433-rec IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 v-mid USAGE BINARY-DOUBLE SIGNED.
01 w-1 USAGE BINARY-DOUBLE SIGNED.
01 w-2 USAGE BINARY-DOUBLE SIGNED.
01 w-3 USAGE BINARY-DOUBLE SIGNED.
01 f-1 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-lo USAGE BINARY-DOUBLE SIGNED.
01 v-hi USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING t-a v-lo v-hi.
    COMPUTE w-1 = v-hi - v-lo
    IF w-1 < 2
        MOVE 1 TO f-1
    ELSE
        MOVE 0 TO f-1
    END-IF
    IF f-1 = 1
        GOBACK
    END-IF
    COMPUTE w-2 = v-lo + v-hi
    COMPUTE w-3 = FUNCTION INTEGER-PART(w-2 / 2)
    MOVE w-3 TO v-mid
    CALL "ipms433-rec" USING BY REFERENCE t-a BY CONTENT v-lo BY CONTENT v-mid
    END-CALL
    CALL "ipms433-rec" USING BY REFERENCE t-a BY CONTENT v-mid BY CONTENT v-hi
    END-CALL
    CALL "ipms433-merge" USING BY REFERENCE t-a BY CONTENT v-lo BY CONTENT v-mid BY CONTENT v-hi
    END-CALL
    GOBACK.
END PROGRAM ipms433-rec.

IDENTIFICATION DIVISION.
PROGRAM-ID. in-place-merge-sort IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 w-1 USAGE BINARY-DOUBLE SIGNED.
LINKAGE SECTION.
01 t-a.
    05 t-a-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 v-n USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION USING t-a v-n.
    MOVE 0 TO w-1
    CALL "ipms433-rec" USING BY REFERENCE t-a BY CONTENT w-1 BY CONTENT v-n
    END-CALL
    GOBACK.
END PROGRAM in-place-merge-sort.

