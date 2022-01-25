;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief KbdFlushBuffer DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:kbdflushbuffer
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE KBD.INC
		INCLUDE ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

EXTERN	PreKbdFlushBuffer: PROC
EXTERN	PostKbdFlushBuffer: PROC

		@KBDPROLOG	KBDFLUSHBUFFER
KBDHANDLE	DW	?		;KEYBOARD HANDLE
		@KBDSTART	KBDFLUSHBUFFER
		CALL	PreKbdFlushBuffer
		MOV	AX, KI_KBDFLUSHBUFFER
		PUSH	AX
		MOV	AX, WORD PTR KBDFUNCTIONMASK
		AND	AX, LOWWORD KR_KBDFLUSHBUFFER
		CMP	AX, LOWWORD KR_KBDFLUSHBUFFER
		CALL    KBDROUTE
		CALL	PreKbdFlushBuffer
		@KBDEPILOG	KBDFLUSHBUFFER

_TEXT		ENDS
		END
