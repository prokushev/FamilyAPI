@DEFINE		MACRO	CALLNAME
			IFNDEF	CALLNAME
				EXTERN	CALLNAME: FAR
			ENDIF
			ENDM

@PUSHW		MACRO	ARG
			MOV		AX,ARG
			PUSH	AX
			ENDM

@PUSHS		MACRO	ARG
			.ERRB	<ARG>
			MOV		AX,SEG ARG
			PUSH	AX
			LEA		AX,ARG
			PUSH	AX
			ENDM

@PUSHD		MACRO	ARG
			.ERRB	<ARG>
			IF(OPATTR(ARG) EQ 35h)	; Immediate and defined
				MOV	AX, LOWWORD ARG
				PUSH	AX
				MOV	AX, HIGHWORD ARG
				PUSH	AX
			ELSE
			PUSH	DS		;SAVE DATA SEGMENT
			PUSH	BX		;SAVE CURRENT BX VALUE
			MOV	AX, SEG ARG
			MOV	DS, AX
			MOV	BX, OFFSET ARG	;LOAD BX WITH OFFSET VALUE
			PUSH	WORD PTR [BX]	;PUSH LOW-ORDER OF 32 BIT VAL STACK
			MOV	AX,[BX+2]	;PUT HIGH ORDER 32-BIT VALUE IN AX
			PUSH	BP		;SAVE REGISTER
			MOV	BP,SP
			XCHG	[BP+6],AX	;
			POP	BP		;RESTORE
			MOV	DS,AX		;RESTORE DS TO SAVED VALUE.
			POP	AX		;POP OFF LOW ORDER 32 BIT VAL
			POP	BX		;RESTORE BX TO SAVED VALUE.
			PUSH	AX		;PUT LOW ORDER 32 BIT VALUE ON STACK
			ENDIF
			ENDM