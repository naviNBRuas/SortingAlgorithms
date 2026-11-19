#line 1 "test.cob"


IDENTIFICATION DIVISION.
PROGRAM-ID. cobol-sort-tests.
DATA DIVISION.
WORKING-STORAGE SECTION.
01 ws-tbl.
 05 ws-tbl-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 ws-ref.
 05 ws-ref-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 ws-algo USAGE BINARY-DOUBLE SIGNED.
01 ws-sz USAGE BINARY-DOUBLE SIGNED.
01 ws-mode USAGE BINARY-DOUBLE SIGNED.
01 ws-nsz USAGE BINARY-DOUBLE SIGNED.
01 ws-cap USAGE BINARY-DOUBLE SIGNED.
01 ws-i USAGE BINARY-DOUBLE SIGNED.
01 ws-j USAGE BINARY-DOUBLE SIGNED.
01 ws-state USAGE BINARY-DOUBLE SIGNED VALUE 12345.
01 ws-r USAGE BINARY-DOUBLE SIGNED.
01 ws-key USAGE BINARY-DOUBLE SIGNED.
01 ws-fails USAGE BINARY-DOUBLE SIGNED VALUE 0.
01 ws-extra USAGE BINARY-DOUBLE SIGNED VALUE 5000000.
01 ws-bad USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION.
main-para.
 PERFORM VARYING ws-algo FROM 1 BY 1 UNTIL ws-algo > 56
 PERFORM set-cap
 PERFORM VARYING ws-sz FROM 1 BY 1 UNTIL ws-sz > 14
 PERFORM set-size
 IF ws-cap = 0 OR ws-nsz <= ws-cap
 PERFORM VARYING ws-mode FROM 0 BY 1 UNTIL ws-mode > 4
 PERFORM run-case
 END-PERFORM
 END-IF
 END-PERFORM
 END-PERFORM
 IF ws-fails = 0
 DISPLAY "all COBOL sorts ok"
 ELSE
 DISPLAY ws-fails " failures"
 END-IF
 STOP RUN.

set-cap.
 EVALUATE ws-algo
 WHEN 1 MOVE 0 TO ws-cap
 WHEN 2 MOVE 0 TO ws-cap
 WHEN 3 MOVE 0 TO ws-cap
 WHEN 4 MOVE 0 TO ws-cap
 WHEN 5 MOVE 0 TO ws-cap
 WHEN 6 MOVE 0 TO ws-cap
 WHEN 7 MOVE 5 TO ws-cap
 WHEN 8 MOVE 0 TO ws-cap
 WHEN 9 MOVE 5 TO ws-cap
 WHEN 10 MOVE 0 TO ws-cap
 WHEN 11 MOVE 0 TO ws-cap
 WHEN 12 MOVE 0 TO ws-cap
 WHEN 13 MOVE 0 TO ws-cap
 WHEN 14 MOVE 0 TO ws-cap
 WHEN 15 MOVE 0 TO ws-cap
 WHEN 16 MOVE 0 TO ws-cap
 WHEN 17 MOVE 0 TO ws-cap
 WHEN 18 MOVE 0 TO ws-cap
 WHEN 19 MOVE 0 TO ws-cap
 WHEN 20 MOVE 0 TO ws-cap
 WHEN 21 MOVE 0 TO ws-cap
 WHEN 22 MOVE 0 TO ws-cap
 WHEN 23 MOVE 0 TO ws-cap
 WHEN 24 MOVE 0 TO ws-cap
 WHEN 25 MOVE 0 TO ws-cap
 WHEN 26 MOVE 0 TO ws-cap
 WHEN 27 MOVE 0 TO ws-cap
 WHEN 28 MOVE 0 TO ws-cap
 WHEN 29 MOVE 0 TO ws-cap
 WHEN 30 MOVE 0 TO ws-cap
 WHEN 31 MOVE 0 TO ws-cap
 WHEN 32 MOVE 0 TO ws-cap
 WHEN 33 MOVE 0 TO ws-cap
 WHEN 34 MOVE 0 TO ws-cap
 WHEN 35 MOVE 0 TO ws-cap
 WHEN 36 MOVE 6 TO ws-cap
 WHEN 37 MOVE 0 TO ws-cap
 WHEN 38 MOVE 0 TO ws-cap
 WHEN 39 MOVE 0 TO ws-cap
 WHEN 40 MOVE 0 TO ws-cap
 WHEN 41 MOVE 0 TO ws-cap
 WHEN 42 MOVE 0 TO ws-cap
 WHEN 43 MOVE 0 TO ws-cap
 WHEN 44 MOVE 0 TO ws-cap
 WHEN 45 MOVE 0 TO ws-cap
 WHEN 46 MOVE 0 TO ws-cap
 WHEN 47 MOVE 0 TO ws-cap
 WHEN 48 MOVE 12 TO ws-cap
 WHEN 49 MOVE 0 TO ws-cap
 WHEN 50 MOVE 40 TO ws-cap
 WHEN 51 MOVE 0 TO ws-cap
 WHEN 52 MOVE 0 TO ws-cap
 WHEN 53 MOVE 0 TO ws-cap
 WHEN 54 MOVE 0 TO ws-cap
 WHEN 55 MOVE 0 TO ws-cap
 WHEN 56 MOVE 0 TO ws-cap
 END-EVALUATE.

set-size.
 EVALUATE ws-sz
 WHEN 1 MOVE 0 TO ws-nsz
 WHEN 2 MOVE 1 TO ws-nsz
 WHEN 3 MOVE 2 TO ws-nsz
 WHEN 4 MOVE 3 TO ws-nsz
 WHEN 5 MOVE 4 TO ws-nsz
 WHEN 6 MOVE 5 TO ws-nsz
 WHEN 7 MOVE 6 TO ws-nsz
 WHEN 8 MOVE 9 TO ws-nsz
 WHEN 9 MOVE 12 TO ws-nsz
 WHEN 10 MOVE 17 TO ws-nsz
 WHEN 11 MOVE 30 TO ws-nsz
 WHEN 12 MOVE 64 TO ws-nsz
 WHEN 13 MOVE 100 TO ws-nsz
 WHEN 14 MOVE 257 TO ws-nsz
 END-EVALUATE.

next-random.
 COMPUTE ws-state = FUNCTION MOD(ws-state * 1103515245 + 12345, 2147483648)
 COMPUTE ws-r = FUNCTION INTEGER-PART(ws-state / 16).

run-case.
 PERFORM VARYING ws-i FROM 1 BY 1 UNTIL ws-i > ws-nsz
 EVALUATE ws-mode
 WHEN 0
 PERFORM next-random
 COMPUTE ws-tbl-e(ws-i) = FUNCTION MOD(ws-r, 21) - 10
 WHEN 1
 PERFORM next-random
 COMPUTE ws-tbl-e(ws-i) = FUNCTION MOD(ws-r, 2000001) - 1000000
 WHEN 2
 COMPUTE ws-tbl-e(ws-i) = ws-i - 1
 WHEN 3
 COMPUTE ws-tbl-e(ws-i) = ws-nsz - ws-i + 1
 WHEN OTHER
 MOVE 7 TO ws-tbl-e(ws-i)
 END-EVALUATE
 MOVE ws-tbl-e(ws-i) TO ws-ref-e(ws-i)
 END-PERFORM
 PERFORM VARYING ws-i FROM 2 BY 1 UNTIL ws-i > ws-nsz
 MOVE ws-ref-e(ws-i) TO ws-key
 COMPUTE ws-j = ws-i - 1
 PERFORM UNTIL ws-j < 1
 IF ws-ref-e(ws-j) > ws-key
 MOVE ws-ref-e(ws-j) TO ws-ref-e(ws-j + 1)
 COMPUTE ws-j = ws-j - 1
 ELSE
 EXIT PERFORM
 END-IF
 END-PERFORM
 MOVE ws-key TO ws-ref-e(ws-j + 1)
 END-PERFORM
 PERFORM call-algo
 MOVE 0 TO ws-bad
 PERFORM VARYING ws-i FROM 1 BY 1 UNTIL ws-i > ws-nsz
 IF ws-tbl-e(ws-i) NOT = ws-ref-e(ws-i)
 MOVE 1 TO ws-bad
 END-IF
 END-PERFORM
 IF ws-bad = 1
 ADD 1 TO ws-fails
 DISPLAY "FAIL algorithm " ws-algo " n=" ws-nsz
 END-IF.

call-algo.
 EVALUATE ws-algo
 WHEN 1
 CALL "american-flag-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 2
 CALL "avl-tree-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 3
 CALL "bead-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 4
 CALL "binary-insertion-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 5
 CALL "bingo-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 6
 CALL "bitonic-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 7
 CALL "bogo-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz BY CONTENT ws-extra
 WHEN 8
 CALL "bottom-up-heap-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 9
 CALL "bozo-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz BY CONTENT ws-extra
 WHEN 10
 CALL "bubble-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 11
 CALL "bucket-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 12
 CALL "cartesian-tree-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 13
 CALL "circle-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 14
 CALL "cocktail-shaker-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 15
 CALL "comb-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 16
 CALL "counting-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 17
 CALL "cycle-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 18
 CALL "double-selection-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 19
 CALL "enumeration-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 20
 CALL "exchange-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 21
 CALL "flash-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 22
 CALL "ford-johnson-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 23
 CALL "gnome-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 24
 CALL "heap-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 25
 CALL "in-place-merge-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 26
 CALL "insertion-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 27
 CALL "intro-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 28
 CALL "library-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 29
 CALL "merge-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 30
 CALL "merge-sort-bottom-up" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 31
 CALL "odd-even-merge-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 32
 CALL "odd-even-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 33
 CALL "pairwise-sorting-network" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 34
 CALL "pancake-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 35
 CALL "patience-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 36
 CALL "permutation-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 37
 CALL "pigeonhole-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 38
 CALL "quick-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 39
 CALL "quick-sort-3way" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 40
 CALL "quick-sort-dual-pivot" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 41
 CALL "quick-sort-hoare" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 42
 CALL "radix-sort-lsd" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 43
 CALL "radix-sort-msd" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 44
 CALL "selection-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 45
 CALL "shell-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 46
 CALL "shell-sort-ciura" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 47
 CALL "sleep-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 48
 CALL "slow-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 49
 CALL "smooth-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 50
 CALL "stooge-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 51
 CALL "strand-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 52
 CALL "ternary-heap-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 53
 CALL "tim-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 54
 CALL "tournament-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 55
 CALL "tree-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 WHEN 56
 CALL "weak-heap-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz
 END-EVALUATE.

END PROGRAM cobol-sort-tests.
