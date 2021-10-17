;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief Global vars of DOS wrappers
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

PUBLIC	API_INITED
PUBLIC	DOS2API
PUBLIC	DOS3API
PUBLIC	DOS33API
PUBLIC	DOS7API
PUBLIC	DOS10API
PUBLIC	DOS1020API
PUBLIC	LFNAPI
PUBLIC	DPMI
PUBLIC	main_buffer
PUBLIC	wMDSta
PUBLIC	wLdrDS
PUBLIC	MAXPATHLEN
PUBLIC	SHARE

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

API_INITED		DW	0       ; IS FAMILY API INITIALIZED?

DOS2API			DW	0	; DOS 2.X API SUPPORTED
DOS3API			DW	0	; DOS 3.0 API SUPPORTED
DOS33API		DW	0	; DOS 3.3 API SUPPORTED
DOS7API			DW	0	; DOS 7.0 API SUPPORTED
DOS10API		DW	0	; DOS 10.00 API SUPPORTED
DOS1020API		DW	0	; DOS 10.20 API SUPPORTED
LFNAPI			DW	0	; LFN API SUPPORTED
DPMI			DW	0	; DPMI SUPPORTED
DPMI1			DW	0	; DPMI 1.0 SUPPORTED
TRUEDPMI		DW	0	; TRUE DPMI SUPPORTED
SHARE			DW	0	; SHARE.EXE LOADED

DISPLAY_PAGE		DW	0	; DISPLAY PAGE
VIOFUNCTIONMASK1	DD	0	; VIO FUNCTIONS REDIRECTION MASK 1
VIOFUNCTIONMASK2	DD	0 	; VIO FUNCTIONS REDIRECTION MASK 2

LONG_BUFFER_SIZE    EQU 261
GETCWD_LONG_SIZE    EQU LONG_BUFFER_SIZE
MAIN_BUFFER_SIZE    EQU GETCWD_LONG_SIZE
main_buffer db MAIN_BUFFER_SIZE dup (?)

MAXPATHLEN	DW	80		; SFN, For LFN - 260

;!!!! @todo Rework loader to use LINFOSEG!!!
wMDSta	 dw 0			;segment of 1. element of 16bit MD table
wLdrDS	dw ?			; DATA segment of application (or kernel???)

_DATA		ENDS


LINFOSEG struc
  lis_pidCurrent      dw  ? ;current process id
  lis_pidParent       dw  ? ;process id of parent
  lis_prtyCurrent     dw  ? ;priority of current thread
  lis_tidCurrent      dw  ? ;thread ID of current thread
  lis_sgCurrent       dw  ? ;session
  lis_rfProcStatus    db  ? ;process status
  lis_dummy1          db  ? ;
  lis_fForeground     dw  ? ;current process has keyboard focus
  lis_typeProcess     db  ? ;process type
  lis_dummy2          db  ? ;
  lis_selEnvironment  dw  ? ;environment selector
  lis_offCmdLine      dw  ? ;command line offset
  lis_cbDataSegment   dw  ? ;length of data segment
  lis_cbStack         dw  ? ;stack size
  lis_cbHeap          dw  ? ;heap size
  lis_hmod            dw  ? ;module handle of the application
  lis_selDS           dw  ? ;data segment handle of the application
LINFOSEG ends


		END
