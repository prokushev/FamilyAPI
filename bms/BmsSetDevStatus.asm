;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BmsSetDevStatus DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
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
		INCLUDE	helpers.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BMSPROLOG	BMSSETDEVSTATUS
MOUHANDLE	DW	?		;MOUSE HANDLE
DEVICESTATUS	DD	?		;STATUS OF DEVICE
		@BMSSTART	BMSSETDEVSTATUS
; code here
		@BMSEPILOG	BMSSETDEVSTATUS

_TEXT		ENDS

		END
