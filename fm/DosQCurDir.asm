;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosQCurDir DOS wrapper
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

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC
		INCLUDE BSEERR.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSQCURDIR 
DRIVENUMBER	DW	?
DIRPATH		DD	?
DIRPATHLEN	DD	?
		@START	DOSQCURDIR, 68
		
		LDS	BX,[DS:BP].ARGS.DIRPATHLEN
		MOV	CX,[BX]			;GET SIZE OF BUFFER (MAY BE 0)
		MOV	AX,SS
		MOV	DS,AX
		MOV	DX, [DS:BP].ARGS.DRIVENUMBER
		GET_DIR  DL, [BP-68]
		JB	EXIT
@@:        
		LODSB
		AND AL,AL
		JNZ @B
		MOV AX,SI
		SUB AX,[BP-68]			;GET SIZE OF CURDIR (INCL TERM NULL)
		MOV SI,[BP-68]
		CMP CX,AX
		JB ERROR
		MOV CX,AX
		LES	DI,[DS:BP].ARGS.DIRPATH
		REP MOVSB
		XOR AX,AX
		JMP EXIT
ERROR:
		LDS	BX,[DS:BP].ARGS.DIRPATHLEN
		MOV	[BX],AX
		MOV	AX,ERROR_FILE_NOT_FOUND
EXIT:
		@EPILOG	DOSQCURDIR

_TEXT		ENDS

		END

