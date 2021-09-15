;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosAllocHuge DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;0 NO_ERROR
;8 ERROR_NOT_ENOUGH_MEMORY
;87 ERROR_INVALID_PARAMETER
;212 ERROR_LOCKED
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSALLOCHUGE
ALLOCFLAGS	DW	?
MAXNUMSEG	DW	?
SELECTOR	DD	?
WSIZE		DW	?
NUMSEG		DW	?
		@START	DOSALLOCHUGE

		; Check arguments
		MOV	BX,[DS:BP].ARGS.NUMSEG
		TEST	BX,0FFF0H
		JNZ	ERROREXIT		; Maximun number of 64kb segments is 16 (1024kb memory in real mode)

		MOV	AX, ERROR_INVALID_PARAMETER
		AND     [DS:BP].ARGS.ALLOCFLAGS, 07FFFH
		CMP	[DS:BP].ARGS.ALLOCFLAGS, 0
		JNE     EXIT			; Only Movable flag is accepted. No shareable memory supported.

		; Move numseg to high
		ROR	BX,1
		ROR	BX,1
		ROR	BX,1
		ROR	BX,1

		; Check, is we need to round up to paragraph?
		MOV	AX,[DS:BP].ARGS.WSIZE
		TEST	AX,0FH
		JZ	ALLOC1			; No

		INC	BX                      ; Add extra paragraph

		; Convert to paragraphs
ALLOC1:		
		SHR	AX,1
		SHR	AX,1
		SHR	AX,1
		SHR	AX,1
		ADD	BX,AX
		JC	ERROREXIT		; Memory overflow

		MOV	AH,48H
		INT	21H
		JC	EXIT			; Exit, if error

		LDS	BX,[DS:BP].ARGS.SELECTOR
		MOV	DS:[BX],AX
		XOR	AX,AX
		JMP	EXIT

ERROREXIT:
		MOV	AX,ERROR_NOT_ENOUGH_MEMORY
EXIT:
		@EPILOG	DOSALLOCHUGE

_TEXT		ENDS

		END
