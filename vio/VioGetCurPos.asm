;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioGetCurPos DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viogetcurpos
;
;* 0          NO_ERROR 
;* 355        ERROR_VIO_MODE 
;* 436        ERROR_VIO_INVALID_HANDLE 
;* 465        ERROR_VIO_DETACHED
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOGETCURPOS
VIOHANDLE	DW	?		;Video handle
COLUMN		DD	?		;Starting column position for output
ROW		DD	?		;Starting row position for output
		@VIOSTART	VIOGETCURPOS
	        MOV	AX, VI_VIOGETCURPOS
		PUSH	AX
		MOV	AX, WORD PTR VIOFUNCTIONMASK1
		AND	AX, LOWWORD VR_VIOGETCURPOS
		CMP	AX, LOWWORD VR_VIOGETCURPOS
	        CALL    VIOROUTE
		@VIOEPILOG	VIOGETCURPOS

_TEXT		ENDS
		END