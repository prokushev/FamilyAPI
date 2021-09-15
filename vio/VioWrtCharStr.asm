;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioWrtCharStr DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viowrtcharstr
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOWRTCHARSTR
VIOHANDLE	DW	?		;Video handle
COLUMN		DW	?		;Starting column position for output
ROW		DW	?		;Starting row position for output
SLENGTH		DW	?		;String length
CHARSTR		DD	?		;String to be written
		@VIOSTART	VIOWRTCHARSTR
	        MOV	AX, VI_VIOWRTCHARSTR
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK1
		AND	AX, LOWWORD VR_VIOWRTCHARSTR
		CMP	AX, LOWWORD VR_VIOWRTCHARSTR
	        CALL    VIOROUTE
		@VIOEPILOG	VIOWRTCHARSTR
_TEXT		ENDS

		END
