;/*!
;   @file
;
;   @brief BvsGetConfig DOS wrapper
;
;   (c) osFree Project 2008-2022, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;  * 0 NO_ERROR
;  * 421 ERROR_VIO_INVALID_PARMS
;  * 436 ERROR_VIO_INVALID_HANDLE
;  * 438 ERROR_VIO_INVALID_LENGTH
;  * 465 ERROR_VIO_DETACHED
;
; @todo add vioconfiginfo length check
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC
		INCLUDE BIOS.INC
INCL_VIO	EQU	1
		INCLUDE BSEERR.INC
		INCLUDE BSESUB.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSGETCONFIG
VIOHANDLE	DW	?		;VIDEO HANDLE
VIOCONFIG	DD	?		;
VIOCONFIGID	DW	?		;
		@BVSSTART	BVSGETCONFIG

		EXTERN	VIOCHECKHANDLE: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		@GetMode	;GET MODE
		XOR     DX,DX
		CMP     AL,7	;80X25 MONO?
		JE      VGATEXT
		INC     DX
		CMP     AL,2	;80X25
		JE      VGATEXT
		CMP     AL,3	;80X25
		JE      VGATEXT
		MOV     DL,5
		CMP     AL,8	;
		JE      VGATEXT
		CMP     AL,0EH
		MOV     AX, ERROR_VIO_DETACHED
		JNE     EXIT
VGATEXT:
		XCHG    DH,DL
		MOV     AX,01A00H
		INT     10H
		CMP     AL,01AH
		JNE     TRYEGA
		CMP     BL,7
		JE      ISVGA
		CMP     BL,8
		JE      ISVGA
		CMP     BL,4
		JE      ISEGA
		CMP     BL,5
		JNE     ISMDACGA
ISEGA:
		MOV     DL,2
		JMP     SETRET
ISVGA:
		MOV     DL,3
		JMP     SETRET
TRYEGA:
		MOV     AH,12H
		MOV     BL,10H
		INT     10H
		CMP     BL,10H
		JNE     ISEGA
ISMDACGA:
		CMP     DH,1
		JNE     SETRET
		INC     DX
SETRET:
		LDS     BX,[BP+8]
		XOR     AH,AH
		MOV     AL,DL
		MOV     [DS:BX].VIOCONFIGINFO.VIOIN_ADAPTER,AX	;ADAPTER TYPE
		MOV     AL,DH
		MOV     [DS:BX].VIOCONFIGINFO.VIOIN_DISPLAY,AX	;DISPLAY TYPE
IF 0        
		MOV     AX,1
		MOV     [DS:BX].VIOCONFIGINFO.VIOIN_ADAPTER,AX	;SET CGA
		MOV     [DS:BX].VIOCONFIGINFO.VIOIN_DISPLAY,AX	;SET COLOR DISPLAY
ENDIF        
		XOR     AX,AX
EXIT:    
		@BVSEPILOG	BVSGETCONFIG
_TEXT		ENDS

		END

