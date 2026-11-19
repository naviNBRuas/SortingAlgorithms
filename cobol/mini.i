#line 1 "/tmp/claude-1000/-home-navinbruas-Projects-The-Company-Repositories-naviNBRuas-Research-SortingAlgorithms/d479c959-e6ad-49d7-88e4-5369b0328cef/scratchpad/cb/mini.cob"

IDENTIFICATION DIVISION.
PROGRAM-ID. mini.
DATA DIVISION.
WORKING-STORAGE SECTION.
01 ws-tbl.
 05 ws-tbl-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 ws-n USAGE BINARY-DOUBLE SIGNED VALUE 3.
PROCEDURE DIVISION.
 MOVE 5 TO ws-tbl-e(1) MOVE 2 TO ws-tbl-e(2) MOVE 9 TO ws-tbl-e(3)
 CALL "american-flag-sort" USING BY REFERENCE ws-tbl BY CONTENT ws-n
 DISPLAY ws-tbl-e(1) " " ws-tbl-e(2) " " ws-tbl-e(3)
 STOP RUN.
