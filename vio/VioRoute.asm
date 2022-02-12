;/*!
;   @file
;
;   @brief Vio Router
;
;   (c) osFree Project 2018-2022, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;*/

.8086

		EXTERN	DOSLOADMODULE: FAR
		EXTERN	DOSGETPROCADDR: FAR
		EXTERN	DOSFREEMODULE: FAR
		EXTERN	@INIT_STACK : NEAR
		EXTERN	@DONE : NEAR

		PUBLIC	VIOREGISTER

		EXTERN	BVSMAIN: FAR		; SUBJECT TO MOVE TO DLL

		INCLUDE	HELPERS.INC
		INCL_VIO	EQU	1
		include bsesub.inc

@VIOROUTE	MACRO	FUNC, MASK, OFF
			MOV	AX, @CATSTR(FC_, FUNC)
			PUSH	AX
			MOV		AX, _DATA
			MOV		ES, AX
			MOV	AX, WORD PTR ES:@CATSTR(VIOFUNCTIONMASK, MASK)+OFF
			IF	OFF EQ 0
			AND	AX, LOWWORD @CATSTR(VR_, FUNC)
			CMP	AX, LOWWORD @CATSTR(VR_, FUNC)
			ELSE
			AND	AX, HIGHWORD @CATSTR(VR_, FUNC)
			CMP	AX, HIGHWORD @CATSTR(VR_, FUNC)
			ENDIF
			CALL    VIOROUTE
			ENDM

@VIOPROC	MACRO	NAME, MASK, OFF, ARGS: VARARG

		@VIOPROLOG	NAME
		FOR ARG, <ARGS>
			ARG
		ENDM
		@VIOSTART	NAME
		@VIOROUTE	NAME, MASK, OFF
		@VIOEPILOG	NAME

			ENDM

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

AVSMAIN			DD	?	; AVSMAIN far address
AVSHANDLE		DW	?	; AVSHANDLE module handle
VIOFUNCTIONMASK1	DD	0	; VIO FUNCTIONS REDIRECTION MASK 1
VIOFUNCTIONMASK2	DD	0 	; VIO FUNCTIONS REDIRECTION MASK 2

_DATA		ENDS

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

@VIOPROC	VIOENDPOPUP, 1, 2, VIOHANDLE DW ?
@VIOPROC	VIOGETANSI, 1, 2, VIOHANDLE DW ?, INDICATOR DD ?
@VIOPROC	VIOGETBUF, 1, 0, VIOHANDLE DW ?, SLength DD ?, LVBPtr DD ?
@VIOPROC	VIOGETCONFIG, 2, 0, VIOHANDLE DW ?, VIOCONFIG DD ?, VIOCONFIGID DW ?
@VIOPROC	VIOGETCP, 2, 0, VIOHANDLE DW ?, CODEPAGEID DD ?, RESERVED DW ?
@VIOPROC	VIOGETCURPOS, 1, 0, VIOHANDLE DW ?, COLUMN DD ?, ROW DD ?
@VIOPROC	VIOGETCURTYPE, 1, 0, VIOHANDLE DW ?, CURINFO DD ?
@VIOPROC	VIOGETFONT, 2, 0, VIOHANDLE DW ?, REQUESTBLOCK DD ?
@VIOPROC	VIOGETMODE, 1, 0, VIOHANDLE DW ?, MODEINFO DD ?
@VIOPROC	VIOGETPHYSBUF, 1, 0, RESERVED DW ?, DISPLAYBUF DD ?
@VIOPROC	VIOGETSTATE, 2, 0, VIOHANDLE DW ?, RequestBlock DD ?
@VIOPROC	VIOMODEUNDO, 2, 0, RESERVED DW ?, KILLINDIC DW ?, OWNERINDIC DW ?
@VIOPROC	VIOMODEWAIT, 2, 0, RESERVED DW ?, NOTIFYTYPE DD ?, REQUESTTYPE DW ?
@VIOPROC	VIOPOPUP, 1, 2, VIOHANDLE DW ?, OPTIONS DD ?
@VIOPROC	VIOPRTSC, 1, 2, VIOHANDLE DW ?
@VIOPROC	VIOPRTSCTOGGLE, 1, 2, VIOHANDLE DW ?
@VIOPROC	VIOREADCELLSTR, 1, 0, VIOHANDLE DW ?, COLUMN DW ?, ROW DW ?, SLENGTH DD ?, CELLSTR DD ?
@VIOPROC	VIOREADCHARSTR, 1, 0, VIOHANDLE DW ?, COLUMN DW ?, ROW DW ?, SLENGTH DD ?, CHARSTR DD ?
@VIOPROC	VIOSAVREDRAWUNDO, 1, 2, VIOHANDLE DW ?, KILLINDIC DW ?, OWNERINDIC DW ?
@VIOPROC	VIOSAVREDRAWWAIT, 1, 2, VIOHANDLE DW ?, NOTIFYTYPE DD ?, SAVREDRAWINDIC DW ?
@VIOPROC	VIOSCRLOCK, 1, 2, VIOHANDLE DW ?, STATUS DD ?, WAITFLAG DW ?
@VIOPROC	VIOSCROLLDN, 1, 2, VIOHANDLE DW ?, CELL DD ?, LINES DW ?, RIGHTCOL DW ?, BOTROW DW ?, LEFTCOL DW ?, TOPROW DW ?
@VIOPROC	VIOSCROLLLF, 1, 2, VIOHANDLE DW ?, CELL DD ?, LINES DW ?, RIGHTCOL DW ?, BOTROW DW ?, LEFTCOL DW ?, TOPROW DW ?
@VIOPROC	VIOSCROLLRT, 1, 2, VIOHANDLE DW ?, CELL DD ?, LINES DW ?, RIGHTCOL DW ?, BOTROW DW ?, LEFTCOL DW ?, TOPROW DW ?
@VIOPROC	VIOSCROLLUP, 1, 2, VIOHANDLE DW ?, CELL DD ?, LINES DW ?, RIGHTCOL DW ?, BOTROW DW ?, LEFTCOL DW ?, TOPROW DW ?
@VIOPROC	VIOSCRUNLOCK, 1, 2, VIOHANDLE DW ?
@VIOPROC	VIOSETANSI, 1, 2, VIOHANDLE DW ?, INDICATOR DW ?
@VIOPROC	VIOSETCP, 2, 0, VIOHANDLE DW ?, CODEPAGEID DW ?, RESERVED DW ?
@VIOPROC	VIOSETCURPOS, 1, 0, VIOHANDLE DW ?, COLUMN DW ?, ROW DW ?
@VIOPROC	VIOSETCURTYPE, 1, 0, VIOHANDLE DW ?, CURINFO DD ?
@VIOPROC	VIOSETFONT, 2, 0, VIOHANDLE DW ?, REQUESTBLOCK DD ?
@VIOPROC	VIOSETMODE, 1, 0, VIOHANDLE DW ?, MODEDATA DD ?
@VIOPROC	VIOSETSTATE, 2, 0, VIOHANDLE DW ?, REQUESTBLOCK DD ?
@VIOPROC	VIOSHOWBUF, 1, 0, VioHandle DW ?, SLength DW ?, SOffset DW ?
@VIOPROC	VIOWRTCELLSTR, 1, 2, VIOHANDLE DW ?, COLUMN DW ?, ROW DW ?, SLENGTH DW ?, CELLSTR DD ?
@VIOPROC	VIOWRTCHARSTR, 1, 0, VIOHANDLE DW ?, COLUMN DW ?, ROW DW ?, SLENGTH DW ?, CHARSTR DD ?
@VIOPROC	VIOWRTCHARSTRATT, 1, 2, VIOHANDLE DW ?, ATTR DD ?, COLUMN DW ?, ROW DW ?, SLENGTH DW ?, CHARSTR DD ?
@VIOPROC	VIOWRTNATTR, 1, 0, VIOHANDLE DW ?, COLUMN DW ?, ROW DW ?, CTIMES DW ?, ATTR DD ?
@VIOPROC	VIOWRTNCELL, 1, 0, VIOHANDLE DW ?, COLUMN DW ?, ROW DW ?, CTIMES DW ?, CELL DD ?
@VIOPROC	VIOWRTNCHAR, 1, 0, VIOHANDLE DW ?, COLUMN DW ?, ROW DW ?, CTIMES DW ?, CHAR DD ?
@VIOPROC	VIOWRTTTY, 1, 0, VIOHANDLE DW ?, SLENGTH DW ?, CHARSTR DD ?

VIOROUTE	PROC	NEAR
		JNZ	BVS		; Skip if AVS not registered
;Call alternate video subsystem if function routed
		PUSH	DS		; caller data segment
		XOR	AX,AX
		MOV	AX, SEG _DATA
		MOV	ES, AX
		CALL	[ES:AVSMAIN]
		POP	DS
; Return code = 0 
;           No error.  Do not invoke the corresponding Base Video Subsystem 
;           routine.  Return to caller with Return code = 0. 
; Return code = -1 
;           No error.  Invoke the corresponding Base Video Subsystem 
;           routine. Return to caller with Return code = return code from 
;           Base Video Subsystem. 
; Return code = error (not 0 or -1) 
;           Do not invoke the corresponding Base Video Subsystem routine. 
;           Return to caller with Return code = error. 
		CMP	AX, 0
		JZ	@F
		CMP	AX, -1
		JNZ	@F
BVS:
		PUSH	DS		; caller data segment
		XOR	AX,AX
		CALL	FAR PTR BVSMAIN
		POP	DS
@@:
		RET	2
VIOROUTE	ENDP

ARGS		STRUC
OLDBP		DW	?		;place to store old BP
RETADDR		DD	?               ;Return address
FUNCTIONMASK2 	DD	?		;FUNCTION MASK 2
FUNCTIONMASK1	DD	?		;FUNCTION MASK 1
ENTRYPOINT	DD	?		;ENTRY POINT NAME
MODULENAME	DD	?		;MODULE NAME
ARGS		ENDS

OBJNAMEBUFL	EQU	255		; Object name buffer size

ARG_SIZE	EQU	(SIZE ARGS - 6)

VIOREGISTER		PROC	FAR
		MOV	AX, OBJNAMEBUFL
		CALL	@INIT_STACK

		LES	SI, [DS:BP]-OBJNAMEBUFL	;Object name buffer (returned)
		PUSH	ES
		PUSH	SI
		MOV	AX, OBJNAMEBUFL		;Length of object name buffer
		PUSH	AX

		LES	SI, [DS:BP].ARGS.MODULENAME		;Module name string
		PUSH	ES
		PUSH	SI
		PUSH	DS
		MOV		AX, _DATA
		MOV		DS, AX
		LES	SI, DWORD PTR DS:AVSHANDLE		;Module handle (returned)
		POP		DS
		PUSH	ES
		PUSH	SI
		CALL	DOSLOADMODULE
		JNZ	ERROREXIT

		PUSH	DS
		MOV		AX, _DATA
		MOV		DS, AX
		MOV	AX, DS:AVSHANDLE		;Module handle
		POP		DS
		PUSH	AX
		LES	SI, [DS:BP].ARGS.ENTRYPOINT		;Procedure name string
		PUSH	ES
		PUSH	SI
		PUSH	DS
		MOV		AX, _DATA
		MOV		DS, AX
		LES		SI, DS:AVSMAIN		;Procedure address (returned)
		POP		DS
		PUSH	ES
		PUSH	SI
		CALL	DOSGETPROCADDR
		JNZ	ERROREXIT

		MOV	AX, _DATA
		MOV ES, AX
		MOV	AX, WORD PTR [DS:BP].ARGS.FUNCTIONMASK1
		MOV	WORD PTR ES:VIOFUNCTIONMASK1, AX
		MOV	AX, WORD PTR [DS:BP].ARGS.FUNCTIONMASK1+2
		MOV	WORD PTR ES:VIOFUNCTIONMASK1+2, AX
		MOV	AX, WORD PTR [DS:BP].ARGS.FUNCTIONMASK2
		MOV	WORD PTR ES:VIOFUNCTIONMASK2, AX
		MOV	AX, WORD PTR [DS:BP].ARGS.FUNCTIONMASK2+2
		MOV	WORD PTR ES:VIOFUNCTIONMASK2+2, AX
		XOR	AX, AX
		JMP	EXIT
ERROREXIT:
		MOV	AX, 426			; ERROR_VIO_REGISTER
EXIT:
		CALL	@DONE
		RET	ARG_SIZE+OBJNAMEBUFL
VIOREGISTER	ENDP

		PUBLIC	VIODEREGISTER
VIODEREGISTER	PROC	FAR
		PUSH	DS
		MOV		AX, _DATA
		MOV		DS, AX
		MOV		AX, DS:AVSHANDLE		;Module handle
		POP		DS
		PUSH	AX
		CALL	DOSFREEMODULE
		MOV	AX, 404
		JNZ	@F
		MOV	AX, _DATA
		MOV	ES, AX
		XOR	AX, AX
		MOV	WORD PTR ES:VIOFUNCTIONMASK1, AX
		MOV	WORD PTR ES:VIOFUNCTIONMASK1+2, AX
		MOV	WORD PTR ES:VIOFUNCTIONMASK2, AX
		MOV	WORD PTR ES:VIOFUNCTIONMASK2+2, AX
@@:
		RETF
VIODEREGISTER	ENDP

_TEXT		ENDS
		END
