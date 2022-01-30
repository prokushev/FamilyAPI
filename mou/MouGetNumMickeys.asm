;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouGetNumMickeys router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:mougetnummickeys
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

EXTERN	PreMouGetNumMickeys: PROC
EXTERN	PostMouGetNumMickeys: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

@MOUPROC	MOUGETNUMMICKEYS, 0, MOUHANDLE DW ?, NUMBEROFMICKEYS DD ?

_TEXT		ENDS
		END
