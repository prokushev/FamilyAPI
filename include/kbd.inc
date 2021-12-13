;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief Family API implementation
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

KR_KBDCHARIN	EQU	00000001H
KR_KBDPEEK	EQU	00000002H
KR_KBDFLUSHBUFFER	EQU	00000004H
KR_KBDGETSTATUS	EQU	00000008H
KR_KBDSETSTATUS	EQU	00000010H
KR_KBDSTRINGIN	EQU	00000020H
KR_KBDOPEN	EQU	00000040H
KR_KBDCLOSE	EQU	00000080H
KR_KBDGETFOCUS	EQU	00000100H
KR_KBDFREEFOCUS	EQU	00000200H
KR_KBDGETCP	EQU	00000400H
KR_KBDSETCP	EQU	00000800H
KR_KBDXLATE	EQU	00001000H
KR_KBDSETCUSTXT	EQU	00002000H
KR_KBDGETHWID	EQU	00004000H

KI_KBDCHARIN	EQU	00H
KI_KBDPEEK	EQU	01H
KI_KBDFLUSHBUFFER	EQU	02H
KI_KBDGETSTATUS	EQU	03H
KI_KBDSETSTATUS	EQU	04H
KI_KBDSTRINGIN	EQU	05H
KI_KBDOPEN	EQU	06H
KI_KBDCLOSE	EQU	07H
KI_KBDGETFOCUS	EQU	08H
KI_KBDFREEFOCUS	EQU	09H
KI_KBDGETCP	EQU	0AH
KI_KBDSETCP	EQU	0BH
KI_KBDXLATE	EQU	0CH
KI_KBDSETCUSTXT	EQU	0DH
KI_KBDGETHWID	EQU	0EH

KBDKEYINFO STRUC
  KBCI_CHCHAR    DB  ? ;ASCII CHARACTER CODE
  KBCI_CHSCAN    DB  ? ;SCAN CODE
  KBCI_FBSTATUS  DB  ? ;STATE OF THE CHARACTER
  KBCI_BNLSSHIFT DB  ? ;RESERVED (SET TO ZERO)
  KBCI_FSSTATE   DW  ? ;STATE OF THE SHIFT KEYS
  KBCI_TIME      DD  ? ;TIME STAMP OF KEYSTROKE (MS SINCE IPL)
KBDKEYINFO ENDS

KBDINFO STRUC
  KBST_CB           DW  ? ;LENGTH IN BYTES OF THIS STRUCTURE
  KBST_FSMASK       DW  ? ;BIT MASK OF FUNCTIONS TO BE ALTERED
  KBST_CHTURNAROUND DW  ? ;DEFINE TURNAROUND CHARACTER
  KBST_FSINTERIM    DW  ? ;INTERIM CHARACTER FLAGS
  KBST_FSSTATE      DW  ? ;SHIFT STATES
KBDINFO ENDS