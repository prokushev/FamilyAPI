;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief KbdSetCp DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:kbdsetcp
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE KBD.INC
		INCLUDE ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@KBDPROLOG	KBDSETCP
KBDHANDLE	DW	?		;KEYBOARD HANDLE
CODEPAGEID	DD	?		;
RESERVED	DD	?		;
		@KBDSTART	KBDSETCP
	        MOV	AX, KI_KBDSETCP
		PUSH	AX
		MOV	AX, WORD PTR KBDFUNCTIONMASK
		AND	AX, LOWWORD KR_KBDSETCP
		CMP	AX, LOWWORD KR_KBDSETCP
	        CALL    KBDROUTE
		@KBDEPILOG	KBDSETCP

_TEXT		ENDS
		END
