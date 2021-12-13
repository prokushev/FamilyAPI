;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief Family API implementation helpers
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;*/

@LOCALB		MACRO	NAME
DELTA		=	DELTA+1
NAME		CATSTR	<[BP->,%DELTA,<]>
		ENDM

@LOCALW		MACRO	NAME
DELTA		=	DELTA+2
NAME		CATSTR	<[BP->,%DELTA,<]>
		ENDM

@LOCALD		MACRO	NAME
DELTA		=	DELTA+4
NAME		CATSTR	<[BP->,%DELTA,<]>
		ENDM

@PROLOG		MACRO	NAME

		EXTERN	@INIT : NEAR
		EXTERN	@INIT_STACK : NEAR
		EXTERN	@DONE : NEAR
		INCLUDE	GLOBALSHARED.INC

		PUBLIC	NAME

DELTA		=	0

ARGS		STRUC
OLDBP		DW	?
RETADDR		DD	?
		ENDM

;----------------------------------------------------------------------

@START		MACRO	NAME, LSIZE
ARGS		ENDS

ARG_SIZE	EQU	(SIZE ARGS - 6)
IFB <LSIZE>
LOCSIZE		EQU	DELTA
ELSE
LOCSIZE		EQU	LSIZE
ENDIF

NAME		PROC	FAR
		IFB	<LSIZE>
		CALL	@INIT
		ELSE
		MOV	AX, LSIZE
		CALL	@INIT_STACK
		ENDIF
		CALL	GLOBALINIT

		ENDM

;------------------------------------------------------------

@EPILOG		MACRO	NAME
@NAME@_EXIT:
		CALL	@DONE
		RET	ARG_SIZE+LOCSIZE
NAME		ENDP
		ENDM

;------------------------------------------------------------VIO
@VIOPROLOG	MACRO	NAME

;		INCLUDE	GLOBALSHARED.INC

		PUBLIC	NAME

DELTA		=	0

VIOARGS		STRUC
		ENDM

;----------------------------------------------------------------------

@VIOSTART	MACRO	NAME
VIOARGS		ENDS

VIO_ARG_SIZE	EQU	(SIZE VIOARGS)

NAME		PROC	FAR
;		CALL	GLOBALINIT

		ENDM

;------------------------------------------------------------

@VIOEPILOG		MACRO	NAME
		RET	VIO_ARG_SIZE
NAME		ENDP
		ENDM

;------------------------------------------------------------KBD
@KBDPROLOG	MACRO	NAME


		PUBLIC	NAME

DELTA		=	0

KBDARGS		STRUC
		ENDM

;----------------------------------------------------------------------

@KBDSTART	MACRO	NAME
KBDARGS		ENDS

KBD_ARG_SIZE	EQU	(SIZE KBDARGS)

NAME		PROC	FAR

		ENDM

;------------------------------------------------------------

@KBDEPILOG		MACRO	NAME
		RET	KBD_ARG_SIZE
NAME		ENDP
		ENDM
;------------------------------------------------------------MOU
@MOUPROLOG	MACRO	NAME


		PUBLIC	NAME

DELTA		=	0

MOUARGS		STRUC
		ENDM

;----------------------------------------------------------------------

@MOUSTART	MACRO	NAME
MOUARGS		ENDS

MOU_ARG_SIZE	EQU	(SIZE MOUARGS)

NAME		PROC	NEAR

		ENDM

;------------------------------------------------------------

@MOUEPILOG		MACRO	NAME
		RET	MOU_ARG_SIZE
NAME		ENDP
		ENDM
		
;---------------------------------------------------------------BVS
@BVSPROLOG	MACRO	NAME

		EXTERN	@INIT : NEAR
		EXTERN	@INIT_STACK : NEAR
		EXTERN	@DONE : NEAR

		PUBLIC	NAME

DELTA		=	0

ARGS		STRUC
oldes		dw	?
oldsi		dw	?
OLDBP		DW	?		;tmp BP storage
RETADDR		DD	?		;BVSMAIN FAR Return address 
XOLDBP		DW	?		;tmp BP storage
VIOROUTIP       DW      ?               ;VIOROUT RETURN OFFSET
VIOROUTCS       DW      ?               ;VIOROUT RETURN SELECTOR
VIOROUTDS       DW      ?               ;VIOROUT DATA SELECTOR
VIOIP           DW      ?               ;VIOXXX RETURN OFFSET
VIOFUNC         DW      ?               ;VIOXXX FUNCTION CODE
USERIP          DW      ?               ;USER RETURN OFFSET
USERCS          DW      ?               ;USER RETURN SEGMENT
		ENDM

;----------------------------------------------------------------------

@BVSSTART	MACRO	NAME, LSIZE
ARGS		ENDS

ARG_SIZE	EQU	(SIZE ARGS - 26)
IFB <LSIZE>
LOCSIZE		EQU	DELTA
ELSE
LOCSIZE		EQU	LSIZE
ENDIF

NAME		PROC	FAR
		IFB	<LSIZE>
		CALL	@INIT
		ELSE
		MOV	AX, LSIZE
		CALL	@INIT_STACK
		ENDIF

		ENDM

;------------------------------------------------------------

@BVSEPILOG	MACRO	NAME
		CALL	@DONE
		RET	ARG_SIZE+LOCSIZE
NAME		ENDP
		ENDM


;---------------------------------------------------------------BKS
@BKSPROLOG	MACRO	NAME

		EXTERN	@INIT : NEAR
		EXTERN	@INIT_STACK : NEAR
		EXTERN	@DONE : NEAR

		PUBLIC	NAME

DELTA		=	0

ARGS		STRUC
oldes		dw	?
oldsi		dw	?
OLDBP		DW	?		;tmp BP storage
RETADDR		DD	?		;BKSMAIN FAR Return address 
XOLDBP		DW	?		;tmp BP storage
KBDROUTIP       DW      ?               ;KBDROUTE RETURN OFFSET
KBDROUTCS       DW      ?               ;KBDROUTE RETURN SELECTOR
KBDROUTDS       DW      ?               ;KBDROUTE DATA SELECTOR
KBDIP           DW      ?               ;KBDXXX RETURN OFFSET
KBDFUNC         DW      ?               ;KBDXXX FUNCTION CODE
USERIP          DW      ?               ;USER RETURN OFFSET
USERCS          DW      ?               ;USER RETURN SEGMENT
		ENDM

;----------------------------------------------------------------------

@BKSSTART	MACRO	NAME, LSIZE
ARGS		ENDS

ARG_SIZE	EQU	(SIZE ARGS - 26)
IFB <LSIZE>
LOCSIZE		EQU	DELTA
ELSE
LOCSIZE		EQU	LSIZE
ENDIF

NAME		PROC	FAR
		IFB	<LSIZE>
		CALL	@INIT
		ELSE
		MOV	AX, LSIZE
		CALL	@INIT_STACK
		ENDIF

		ENDM

;------------------------------------------------------------

@BKSEPILOG	MACRO	NAME
		CALL	@DONE
		RET	ARG_SIZE+LOCSIZE
NAME		ENDP
		ENDM

;---------------------------------------------------------------BMS
@BMSPROLOG	MACRO	NAME

		EXTERN	@INIT : NEAR
		EXTERN	@INIT_STACK : NEAR
		EXTERN	@DONE : NEAR

		PUBLIC	NAME

DELTA		=	0

ARGS		STRUC
oldes		dw	?
oldsi		dw	?
OLDBP		DW	?		;tmp BP storage
RETADDR		DD	?		;BMSMAIN FAR Return address 
XOLDBP		DW	?		;tmp BP storage
MOUROUTIP       DW      ?               ;MOUROUTE RETURN OFFSET
MOUROUTCS       DW      ?               ;MOUROUTE RETURN SELECTOR
MOUROUTDS       DW      ?               ;MOUROUTE DATA SELECTOR
MOUIP           DW      ?               ;MOUXXX RETURN OFFSET
MOUFUNC         DW      ?               ;MOUXXX FUNCTION CODE
USERIP          DW      ?               ;USER RETURN OFFSET
USERCS          DW      ?               ;USER RETURN SEGMENT
		ENDM

;----------------------------------------------------------------------

@BMSSTART	MACRO	NAME, LSIZE
ARGS		ENDS

ARG_SIZE	EQU	(SIZE ARGS - 26)
IFB <LSIZE>
LOCSIZE		EQU	DELTA
ELSE
LOCSIZE		EQU	LSIZE
ENDIF

NAME		PROC	FAR
		IFB	<LSIZE>
		CALL	@INIT
		ELSE
		MOV	AX, LSIZE
		CALL	@INIT_STACK
		ENDIF

		ENDM

;------------------------------------------------------------

@BMSEPILOG	MACRO	NAME
		CALL	@DONE
		RET	ARG_SIZE+LOCSIZE
NAME		ENDP
		ENDM

;-------------------------------------------------------------
@PUSHA	MACRO
		PUSH	AX
		PUSH	CX
		PUSH	DX
		PUSH	BX
		PUSH	SP
		PUSH	BP
		PUSH	SI
		PUSH	DI
		ENDM

@POPA	MACRO
		POP	DI
		POP	SI
		POP	BP
		POP	AX
		POP	BX
		POP	DX
		POP	CX
		POP	AX
		ENDM
;----------------------------------------------------------------


@TRACE	MACRO Name
		PUSHF
		@PUSHA
		MOV		AX, SEG @CATSTR(NAME, Msg)
		PUSH	AX
		MOV		AX, OFFSET @CATSTR(NAME, Msg)
		PUSH	AX
		MOV		AX, @CATSTR(NAME, MsgSize)
		PUSH	AX
		MOV		AX,0
		PUSH	AX
		CALL	VioWrtTTY
		@POPA
		POPF
		ENDM