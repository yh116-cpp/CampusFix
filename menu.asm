.MODEL SMALL
.STACK 200H

.DATA

; =========================================
; AVAILABILITY GRID CONSTANTS
; =========================================

MAX_COURTS        EQU 6
SLOTS_PER_COURT   EQU 10
SPORT_BLOCK_SIZE EQU 60
NUM_SPORTS        EQU 8
TOTAL_AVAIL_SIZE EQU 480

; =========================================
; GENERAL UI
; =========================================

CLR_SCREEN DB 13,10,13,10,13,10,13,10,"$"

DIVIDER DB "---------------------------------------",13,10,"$"

MSG_MAIN_MENU DB 13,10
DB "=======================================",13,10
DB "        SPORT VENUE BOOKING SYSTEM      ",13,10
DB "                 (ADMIN)                ",13,10
DB "=======================================",13,10
DB " [1] Book a Court / Venue",13,10
DB " [2] Exit System",13,10
DB "---------------------------------------",13,10
DB "Please press a key (1 or 2)... $"

; =========================================
; STEP 1 - SPORT / COURT TYPE
; =========================================

MSG_SELECT_TYPE DB 13,10
DB ">>> STEP 1: SELECT SPORT / COURT TYPE",13,10
DB "---------------------------------------",13,10
DB " [1] Badminton Court  (RM 10/hr)",13,10
DB " [2] Volleyball Court (RM 20/hr)",13,10
DB " [3] Basketball Court (RM 25/hr)",13,10
DB " [4] Futsal Court     (RM 40/hr)",13,10
DB " [5] Tennis Court     (RM 15/hr)",13,10
DB " [6] Table Tennis     (RM 8/hr)",13,10
DB " [7] Squash Court     (RM 12/hr)",13,10
DB " [8] Netball Court    (RM 20/hr)",13,10
DB "---------------------------------------",13,10
DB "Select [1-8]: $"

; =========================================
; STEP 2 - SELECT COURT
; =========================================

MSG_SELECT_COURT DB 13,10
DB "=======================================",13,10
DB "           SELECT COURT MENU           ",13,10
DB "=======================================",13,10,"$"

TXT_SPORT_LBL DB "Sport Type: $"

COURT_HDR_PREFIX DB 13,10,"["
COURT_HDR_MID DB "] $"

COURT_PROMPT_TEXT1 DB 13,10
DB "---------------------------------------",13,10
DB "Select Court [1-$"

COURT_PROMPT_TEXT2 DB "]: $"

ERR_COURT_RANGE DB 13,10
DB "[!] Invalid court number for this venue type.",13,10
DB "Please select a valid court.",13,10,"$"

; =========================================
; STEP 3 - SELECTED COURT TIME SLOTS
; =========================================

MSG_COURT_CHOSEN_HDR DB 13,10
DB "=======================================",13,10
DB "           SELECTED COURT               ",13,10
DB "=======================================",13,10
DB "Selected Court: $"

MSG_AV_TITLE DB 13,10
DB "---------------------------------------",13,10
DB "         TIME SLOT AVAILABILITY         ",13,10
DB "---------------------------------------",13,10,"$"

TXT_AV DB "AVAILABLE",13,10,"$"

TXT_BK DB "BOOKED",13,10,"$"

SLOT_BRACKET_OPEN DB " ["
SLOT_BRACKET_CLOSE DB "] $"

PROMPT_SLOT DB 13,10
DB "---------------------------------------",13,10
DB "Select an AVAILABLE time slot (1-10)",13,10
DB "[B] Back",13,10
DB "Enter choice: $"

ERR_ALREADY_BK DB 13,10
DB "[!] This time slot is already BOOKED.",13,10
DB "Please select another available time.",13,10,"$"

; =========================================
; TIME SLOT LABEL TABLES
; =========================================

SLOT_SHORT_TBL DW SS1,SS2,SS3,SS4,SS5,SS6,SS7,SS8,SS9,SS10
SLOT_LONG_TBL  DW SL1,SL2,SL3,SL4,SL5,SL6,SL7,SL8,SL9,SL10

SS1  DB "08-09  $"
SS2  DB "09-10  $"
SS3  DB "10-11  $"
SS4  DB "11-12  $"
SS5  DB "12-01  $"
SS6  DB "01-02  $"
SS7  DB "02-03  $"
SS8  DB "03-04  $"
SS9  DB "04-05  $"
SS10 DB "05-06  $"

SL1  DB "08:00 AM - 09:00 AM   $"
SL2  DB "09:00 AM - 10:00 AM   $"
SL3  DB "10:00 AM - 11:00 AM   $"
SL4  DB "11:00 AM - 12:00 PM   $"
SL5  DB "12:00 PM - 01:00 PM   $"
SL6  DB "01:00 PM - 02:00 PM   $"
SL7  DB "02:00 PM - 03:00 PM   $"
SL8  DB "03:00 PM - 04:00 PM   $"
SL9  DB "04:00 PM - 05:00 PM   $"
SL10 DB "05:00 PM - 06:00 PM   $"

; =========================================
; SELECTED BOOKING
; =========================================

MSG_SELECTED DB 13,10
DB "=======================================",13,10
DB "              SELECTED BOOKING          ",13,10
DB "=======================================",13,10,"$"

TXT_SPORT DB " Sport Type : $"
TXT_COURT DB " Court      : $"
TXT_DATE DB " Date       : 21/08/2026",13,10,"$"
TXT_TIME DB " Time       : $"
TXT_STATUS DB " Status     : AVAILABLE",13,10,"$"

PROMPT_CONFIRM DB 13,10
DB "Continue with booking? (Y/N): $"

; =========================================
; ERROR / SUCCESS
; =========================================

ERR_INVALID DB 13,10
DB "[!] Invalid key! Please re-enter...",13,10,"$"

MSG_SUCCESS DB 13,10
DB "[SUCCESS] Booking saved!",13,10,"$"

MSG_CANCEL DB 13,10
DB "[INFO] Booking cancelled.",13,10,"$"

; =========================================
; INVOICE
; =========================================

INV_HEADER DB 13,10
DB "=======================================",13,10
DB "           CUSTOMER INVOICE            ",13,10
DB "=======================================",13,10,"$"

INV_BOOKING_ID DB " Booking ID  : BK-$"

INV_SPORT DB " Sport Type  : $"

INV_COURT DB " Court       : $"

INV_DATE DB " Date        : 21/08/2026",13,10,"$"

INV_TIME DB " Time        : $"

INV_BASE DB " Base Fee    : RM $"

INV_DISC DB " Discount    : -RM $"

INV_TAX DB " Service Tax : RM $"

INV_TOTAL DB "---------------------------------------",13,10
DB " GRAND TOTAL : RM $"

INV_FOOTER DB 13,10
DB "=======================================",13,10
DB "        Thank you for your business!    ",13,10
DB "=======================================",13,10,"$"

PROMPT_RECEIPT DB 13,10
DB "Press ENTER to generate receipt...$"

; =========================================
; RECEIPT
; =========================================

RECEIPT_HEADER DB 13,10
DB "=======================================",13,10
DB "              BOOKING RECEIPT           ",13,10
DB "=======================================",13,10,"$"

REC_BOOKING_ID DB " Booking ID  : BK-$"

REC_SPORT DB " Sport Type  : $"

REC_COURT DB " Court       : $"

REC_DATE DB " Date        : 21/08/2026",13,10,"$"

REC_TIME DB " Time        : $"

REC_AMOUNT DB " Amount Paid : RM $"

REC_STATUS DB " Status      : PAID",13,10,"$"

RECEIPT_FOOTER DB "---------------------------------------",13,10
DB "        BOOKING CONFIRMED              ",13,10
DB "        Thank you for booking!          ",13,10
DB "=======================================",13,10,"$"

PROMPT_RETURN DB 13,10
DB "Press any key to return to main menu...$"

; =========================================
; SPORT STRINGS
; =========================================

STR_BADMINTON DB "Badminton Court",13,10,"$"
STR_VOLLEYBALL DB "Volleyball Court",13,10,"$"
STR_BASKETBALL DB "Basketball Court",13,10,"$"
STR_FUTSAL DB "Futsal Court",13,10,"$"
STR_TENNIS DB "Tennis Court",13,10,"$"
STR_TABLE_TENNIS DB "Table Tennis",13,10,"$"
STR_SQUASH DB "Squash Court",13,10,"$"
STR_NETBALL DB "Netball Court",13,10,"$"

STR_COURT_WORD DB "Court $"
STR_TABLE_WORD DB "Table $"

; =========================================
; COURT & TABLE NAMES (MOVED TO DATA SEGMENT)
; =========================================

COURT1_NAME DB "Court 1",13,10,"$"
COURT2_NAME DB "Court 2",13,10,"$"
COURT3_NAME DB "Court 3",13,10,"$"
COURT4_NAME DB "Court 4",13,10,"$"
COURT5_NAME DB "Court 5",13,10,"$"
COURT6_NAME DB "Court 6",13,10,"$"

TABLE1_TEXT DB "Table 1",13,10,"$"
TABLE2_TEXT DB "Table 2",13,10,"$"
TABLE3_TEXT DB "Table 3",13,10,"$"
TABLE4_TEXT DB "Table 4",13,10,"$"

; =========================================
; NEWLINE CONSTANT (MOVED TO DATA SEGMENT)
; =========================================

NL DB 13,10,"$"

; =========================================
; COURT COUNTS
; =========================================

COURT_COUNT DB 6,2,2,2,3,4,2,2

; =========================================
; BOOKING STATUS (0 = AVAILABLE, 1 = BOOKED)
; =========================================

COURT_AVAIL DB 0,1,0,0,1,0,0,1,0,0
            DB 1,0,1,0,0,1,0,0,1,0
            DB 0,0,0,1,0,0,0,0,1,0
            DB 0,1,0,0,0,0,1,0,0,0
            DB 0,0,1,0,0,0,0,0,0,1
            DB 1,0,0,0,1,0,0,0,0,0

            DB 0,0,1,0,0,0,0,1,0,0
            DB 1,0,0,0,1,0,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0

            DB 0,1,0,1,0,0,0,0,0,0
            DB 1,0,0,0,0,1,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0

            DB 0,0,1,0,1,0,0,0,0,0
            DB 0,1,0,0,0,0,1,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0

            DB 0,1,0,0,0,0,0,0,1,0
            DB 0,0,0,1,0,0,0,0,0,0
            DB 1,0,0,0,0,1,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0

            DB 0,0,0,0,1,0,0,0,0,0
            DB 0,1,0,0,0,0,0,1,0,0
            DB 0,0,1,0,0,0,0,0,0,0
            DB 0,0,0,0,0,1,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0

            DB 1,0,0,0,0,0,1,0,0,0
            DB 0,0,0,1,0,0,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0

            DB 0,0,1,0,0,0,0,0,1,0
            DB 0,0,0,0,1,0,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0
            DB 0,0,0,0,0,0,0,0,0,0

; =========================================
; VARIABLES
; =========================================

VAR_SPORT_TYPE DB 0
VAR_COURT_CHOICE DB 0
VAR_SLOT_CHOICE DB 0
VAR_COURT_COUNT DB 0
VAR_BOOKING_CANCELLED DB 0

TEMP_COURT_NUM DB 0
TEMP_SLOT_NUM DB 0
TEMP_BASE_INDEX DW 0

VAL_PRICE_PER_H DW 0
VAL_BASE_FEE DW 0
VAL_DISCOUNT DW 0
VAL_TAX DW 0
VAL_GRAND_TOTAL DW 0

BOOKING_COUNTER DW 1001

NUM_STR DB 7 DUP(0)

; =========================================
; CODE
; =========================================

.CODE

MAIN PROC

    MOV AX,@DATA
    MOV DS,AX

MAIN_MENU:

    MOV AH,09H
    LEA DX,CLR_SCREEN
    INT 21H

    MOV AH,09H
    LEA DX,MSG_MAIN_MENU
    INT 21H

    MOV AH,01H
    INT 21H

    CMP AL,'1'
    JE START_BOOKING

    CMP AL,'2'
    JE EXIT_PROGRAM

    MOV AH,09H
    LEA DX,ERR_INVALID
    INT 21H

    JMP MAIN_MENU

START_BOOKING:

    MOV VAR_BOOKING_CANCELLED,0

    CALL SELECT_SPORT

    CALL SELECT_COURT

    CALL GET_SLOT_INPUT

    CMP VAR_BOOKING_CANCELLED,1
    JE START_BOOKING_DONE

    CALL CALC_FEES

    MOV AH,09H
    LEA DX,CLR_SCREEN
    INT 21H

    CALL SHOW_SELECTED_BOOKING

    CALL CONFIRM_BOOKING

START_BOOKING_DONE:

    JMP MAIN_MENU

EXIT_PROGRAM:

    MOV AH,4CH
    INT 21H

MAIN ENDP

SELECT_SPORT PROC

    MOV AH,09H
    LEA DX,CLR_SCREEN
    INT 21H

PAGE_SELECT_SPORT:

    MOV AH,09H
    LEA DX,MSG_SELECT_TYPE
    INT 21H

    MOV AH,01H
    INT 21H

    CMP AL,'1'
    JE SET_BADMINTON

    CMP AL,'2'
    JE SET_VOLLEYBALL

    CMP AL,'3'
    JE SET_BASKETBALL

    CMP AL,'4'
    JE SET_FUTSAL

    CMP AL,'5'
    JE SET_TENNIS

    CMP AL,'6'
    JE SET_TABLE_TENNIS

    CMP AL,'7'
    JE SET_SQUASH

    CMP AL,'8'
    JE SET_NETBALL

    MOV AH,09H
    LEA DX,ERR_INVALID
    INT 21H

    JMP PAGE_SELECT_SPORT

SET_BADMINTON:
    MOV VAR_SPORT_TYPE,1
    MOV VAL_PRICE_PER_H,1000
    JMP SET_SPORT_COUNT

SET_VOLLEYBALL:
    MOV VAR_SPORT_TYPE,2
    MOV VAL_PRICE_PER_H,2000
    JMP SET_SPORT_COUNT

SET_BASKETBALL:
    MOV VAR_SPORT_TYPE,3
    MOV VAL_PRICE_PER_H,2500
    JMP SET_SPORT_COUNT

SET_FUTSAL:
    MOV VAR_SPORT_TYPE,4
    MOV VAL_PRICE_PER_H,4000
    JMP SET_SPORT_COUNT

SET_TENNIS:
    MOV VAR_SPORT_TYPE,5
    MOV VAL_PRICE_PER_H,1500
    JMP SET_SPORT_COUNT

SET_TABLE_TENNIS:
    MOV VAR_SPORT_TYPE,6
    MOV VAL_PRICE_PER_H,800
    JMP SET_SPORT_COUNT

SET_SQUASH:
    MOV VAR_SPORT_TYPE,7
    MOV VAL_PRICE_PER_H,1200
    JMP SET_SPORT_COUNT

SET_NETBALL:
    MOV VAR_SPORT_TYPE,8
    MOV VAL_PRICE_PER_H,2000
    JMP SET_SPORT_COUNT

SET_SPORT_COUNT:

    XOR BX,BX
    MOV BL,VAR_SPORT_TYPE
    DEC BL

    MOV AL,COURT_COUNT[BX]
    MOV VAR_COURT_COUNT,AL

    RET

SELECT_SPORT ENDP

SELECT_COURT PROC

PAGE_SELECT_COURT:

    MOV AH,09H
    LEA DX,CLR_SCREEN
    INT 21H

    MOV AH,09H
    LEA DX,MSG_SELECT_COURT
    INT 21H

    MOV AH,09H
    LEA DX,TXT_SPORT_LBL
    INT 21H

    CALL PRINT_CURRENT_SPORT

    MOV AH,09H
    LEA DX,DIVIDER
    INT 21H

    MOV TEMP_COURT_NUM,1

SC_MENU_LOOP:

    MOV AL,TEMP_COURT_NUM
    CMP AL,VAR_COURT_COUNT
    JA SC_MENU_DONE

    MOV AH,09H
    LEA DX,COURT_HDR_PREFIX
    INT 21H

    XOR AX,AX
    MOV AL,TEMP_COURT_NUM
    CALL PRINT_NUM

    MOV AH,09H
    LEA DX,COURT_HDR_MID
    INT 21H

    CMP VAR_SPORT_TYPE,6
    JNE SCM_COURT_WORD

    MOV AH,09H
    LEA DX,STR_TABLE_WORD
    INT 21H

    JMP SCM_PRINT_NUMBER

SCM_COURT_WORD:

    MOV AH,09H
    LEA DX,STR_COURT_WORD
    INT 21H

SCM_PRINT_NUMBER:

    XOR AX,AX
    MOV AL,TEMP_COURT_NUM
    CALL PRINT_NUM

    CALL PRINT_NL

    INC TEMP_COURT_NUM

    JMP SC_MENU_LOOP

SC_MENU_DONE:

    MOV AH,09H
    LEA DX,COURT_PROMPT_TEXT1
    INT 21H

    MOV AH,02H
    MOV DL,VAR_COURT_COUNT
    ADD DL,'0'
    INT 21H

    MOV AH,09H
    LEA DX,COURT_PROMPT_TEXT2
    INT 21H

    MOV AH,01H
    INT 21H

    CMP AL,'1'
    JB SC_INVALID_COURT

    CMP AL,'9'
    JA SC_INVALID_COURT

    SUB AL,'0'

    CMP AL,VAR_COURT_COUNT
    JA SC_INVALID_COURT_RANGE

    MOV VAR_COURT_CHOICE,AL

    RET

SC_INVALID_COURT:

    MOV AH,09H
    LEA DX,ERR_INVALID
    INT 21H

    JMP PAGE_SELECT_COURT

SC_INVALID_COURT_RANGE:

    MOV AH,09H
    LEA DX,ERR_COURT_RANGE
    INT 21H

    JMP PAGE_SELECT_COURT

SELECT_COURT ENDP

CALC_AVAIL_INDEX PROC

    PUSH CX
    PUSH DX

    XOR AX,AX
    MOV AL,VAR_SPORT_TYPE
    DEC AL

    MOV CL,SPORT_BLOCK_SIZE
    MUL CL

    MOV DX,AX

    XOR AX,AX
    MOV AL,BL
    DEC AL

    MOV CL,SLOTS_PER_COURT
    MUL CL

    ADD AX,DX

    POP DX
    POP CX

    RET

CALC_AVAIL_INDEX ENDP

SHOW_COURT_AVAILABILITY PROC

    MOV AH,09H
    LEA DX,CLR_SCREEN
    INT 21H

    MOV AH,09H
    LEA DX,MSG_COURT_CHOSEN_HDR
    INT 21H

    CALL PRINT_COURT_NAME

    MOV AH,09H
    LEA DX,MSG_AV_TITLE
    INT 21H

    MOV BL,VAR_COURT_CHOICE

    CALL CALC_AVAIL_INDEX

    MOV TEMP_BASE_INDEX,AX
    MOV TEMP_SLOT_NUM,1

SCA_LOOP:

    MOV AL,TEMP_SLOT_NUM
    CMP AL,SLOTS_PER_COURT
    JA SCA_DONE

    MOV AH,09H
    LEA DX,SLOT_BRACKET_OPEN
    INT 21H

    XOR AX,AX
    MOV AL,TEMP_SLOT_NUM
    CALL PRINT_NUM

    MOV AH,09H
    LEA DX,SLOT_BRACKET_CLOSE
    INT 21H

    XOR AX,AX
    MOV AL,TEMP_SLOT_NUM
    DEC AL

    SHL AX,1
    MOV SI,AX

    MOV DX,SLOT_LONG_TBL[SI]
    MOV AH,09H
    INT 21H

    MOV AX,TEMP_BASE_INDEX

    XOR BX,BX
    MOV BL,TEMP_SLOT_NUM
    DEC BL

    ADD AX,BX
    MOV SI,AX

    CMP COURT_AVAIL[SI],0
    JE SCA_AVAILABLE

    MOV AH,09H
    LEA DX,TXT_BK
    INT 21H

    JMP SCA_NEXT

SCA_AVAILABLE:

    MOV AH,09H
    LEA DX,TXT_AV
    INT 21H

SCA_NEXT:

    INC TEMP_SLOT_NUM
    JMP SCA_LOOP

SCA_DONE:

    MOV AH,09H
    LEA DX,DIVIDER
    INT 21H

    MOV AH,09H
    LEA DX,PROMPT_SLOT
    INT 21H

    RET

SHOW_COURT_AVAILABILITY ENDP

READ_SLOT_NUMBER PROC

    PUSH BX
    PUSH CX
    PUSH DX

    XOR BX,BX
    XOR CX,CX

RSN_LOOP:

    MOV AH,01H
    INT 21H

    CMP CX,0
    JNE RSN_NOT_FIRST

    CMP AL,'b'
    JE RSN_BACK

    CMP AL,'B'
    JE RSN_BACK

RSN_NOT_FIRST:

    CMP AL,13
    JE RSN_DONE

    CMP AL,'0'
    JB RSN_LOOP

    CMP AL,'9'
    JA RSN_LOOP

    CMP CX,2
    JAE RSN_LOOP

    SUB AL,'0'
    XOR AH,AH

    PUSH AX

    MOV AX,BX
    MOV DX,10
    MUL DX

    MOV BX,AX
    POP AX

    ADD BX,AX
    INC CX

    JMP RSN_LOOP

RSN_DONE:

    MOV AX,BX

    POP DX
    POP CX
    POP BX

    RET

RSN_BACK:

    MOV VAR_BOOKING_CANCELLED,1

    POP DX
    POP CX
    POP BX

    RET

READ_SLOT_NUMBER ENDP

GET_SLOT_INPUT PROC

GSI_LOOP:

    CALL SHOW_COURT_AVAILABILITY

    CALL READ_SLOT_NUMBER

    CMP VAR_BOOKING_CANCELLED,1
    JE GSI_DONE

    CMP AX,1
    JB GSI_INVALID

    CMP AX,SLOTS_PER_COURT
    JA GSI_INVALID

    MOV VAR_SLOT_CHOICE,AL
    MOV BL,VAR_COURT_CHOICE

    CALL CALC_AVAIL_INDEX

    XOR BX,BX
    MOV BL,VAR_SLOT_CHOICE
    DEC BL

    ADD AX,BX
    MOV SI,AX

    CMP COURT_AVAIL[SI],1
    JE GSI_TAKEN

    RET

GSI_INVALID:

    MOV AH,09H
    LEA DX,ERR_INVALID
    INT 21H

    JMP GSI_LOOP

GSI_TAKEN:

    MOV AH,09H
    LEA DX,ERR_ALREADY_BK
    INT 21H

    JMP GSI_LOOP

GSI_DONE:

    RET

GET_SLOT_INPUT ENDP

CALC_FEES PROC

    MOV AX,VAL_PRICE_PER_H
    MOV VAL_BASE_FEE,AX

    MOV VAL_DISCOUNT,0

    MOV AX,VAL_BASE_FEE
    MOV BX,6
    MUL BX

    MOV BX,100
    DIV BX

    MOV VAL_TAX,AX

    MOV AX,VAL_BASE_FEE
    SUB AX,VAL_DISCOUNT
    ADD AX,VAL_TAX

    MOV VAL_GRAND_TOTAL,AX

    RET

CALC_FEES ENDP

PRINT_CURRENT_SPORT PROC

    CMP VAR_SPORT_TYPE,1
    JE PCS1

    CMP VAR_SPORT_TYPE,2
    JE PCS2

    CMP VAR_SPORT_TYPE,3
    JE PCS3

    CMP VAR_SPORT_TYPE,4
    JE PCS4

    CMP VAR_SPORT_TYPE,5
    JE PCS5

    CMP VAR_SPORT_TYPE,6
    JE PCS6

    CMP VAR_SPORT_TYPE,7
    JE PCS7

    MOV AH,09H
    LEA DX,STR_NETBALL
    INT 21H

    JMP PCSDONE

PCS1:
    MOV AH,09H
    LEA DX,STR_BADMINTON
    INT 21H
    JMP PCSDONE

PCS2:
    MOV AH,09H
    LEA DX,STR_VOLLEYBALL
    INT 21H
    JMP PCSDONE

PCS3:
    MOV AH,09H
    LEA DX,STR_BASKETBALL
    INT 21H
    JMP PCSDONE

PCS4:
    MOV AH,09H
    LEA DX,STR_FUTSAL
    INT 21H
    JMP PCSDONE

PCS5:
    MOV AH,09H
    LEA DX,STR_TENNIS
    INT 21H
    JMP PCSDONE

PCS6:
    MOV AH,09H
    LEA DX,STR_TABLE_TENNIS
    INT 21H
    JMP PCSDONE

PCS7:
    MOV AH,09H
    LEA DX,STR_SQUASH
    INT 21H

PCSDONE:

    RET

PRINT_CURRENT_SPORT ENDP

PRINT_COURT_NAME PROC

    CMP VAR_SPORT_TYPE,6
    JE PRINT_TABLE

    CMP VAR_COURT_CHOICE,1
    JE PCN1

    CMP VAR_COURT_CHOICE,2
    JE PCN2

    CMP VAR_COURT_CHOICE,3
    JE PCN3

    CMP VAR_COURT_CHOICE,4
    JE PCN4

    CMP VAR_COURT_CHOICE,5
    JE PCN5

    JMP PCN6

PRINT_TABLE:

    CMP VAR_COURT_CHOICE,1
    JE PT1

    CMP VAR_COURT_CHOICE,2
    JE PT2

    CMP VAR_COURT_CHOICE,3
    JE PT3

    JMP PT4

PT1:
    MOV AH,09H
    LEA DX,TABLE1_TEXT
    INT 21H
    RET

PT2:
    MOV AH,09H
    LEA DX,TABLE2_TEXT
    INT 21H
    RET

PT3:
    MOV AH,09H
    LEA DX,TABLE3_TEXT
    INT 21H
    RET

PT4:
    MOV AH,09H
    LEA DX,TABLE4_TEXT
    INT 21H
    RET

PCN1:
    MOV AH,09H
    LEA DX,COURT1_NAME
    INT 21H
    RET

PCN2:
    MOV AH,09H
    LEA DX,COURT2_NAME
    INT 21H
    RET

PCN3:
    MOV AH,09H
    LEA DX,COURT3_NAME
    INT 21H
    RET

PCN4:
    MOV AH,09H
    LEA DX,COURT4_NAME
    INT 21H
    RET

PCN5:
    MOV AH,09H
    LEA DX,COURT5_NAME
    INT 21H
    RET

PCN6:
    MOV AH,09H
    LEA DX,COURT6_NAME
    INT 21H
    RET

PRINT_COURT_NAME ENDP

PRINT_SLOT_TIME PROC

    XOR AX,AX
    MOV AL,VAR_SLOT_CHOICE
    DEC AL

    SHL AX,1
    MOV SI,AX

    MOV DX,SLOT_LONG_TBL[SI]

    MOV AH,09H
    INT 21H

    CALL PRINT_NL

    RET

PRINT_SLOT_TIME ENDP

SHOW_SELECTED_BOOKING PROC

    MOV AH,09H
    LEA DX,MSG_SELECTED
    INT 21H

    MOV AH,09H
    LEA DX,TXT_SPORT
    INT 21H

    CALL PRINT_CURRENT_SPORT

    MOV AH,09H
    LEA DX,TXT_COURT
    INT 21H

    CALL PRINT_COURT_NAME

    MOV AH,09H
    LEA DX,TXT_DATE
    INT 21H

    MOV AH,09H
    LEA DX,TXT_TIME
    INT 21H

    CALL PRINT_SLOT_TIME

    MOV AH,09H
    LEA DX,TXT_STATUS
    INT 21H

    RET

SHOW_SELECTED_BOOKING ENDP

CONFIRM_BOOKING PROC

ASK_CONFIRM:

    MOV AH,09H
    LEA DX,PROMPT_CONFIRM
    INT 21H

    MOV AH,01H
    INT 21H

    AND AL,0DFH

    CMP AL,'Y'
    JE SAVE_BOOKING

    CMP AL,'N'
    JE CANCEL_BOOKING

    MOV AH,09H
    LEA DX,ERR_INVALID
    INT 21H

    JMP ASK_CONFIRM

SAVE_BOOKING:

    MOV BL,VAR_COURT_CHOICE

    CALL CALC_AVAIL_INDEX

    MOV BX,AX
    XOR AX,AX

    MOV AL,VAR_SLOT_CHOICE
    DEC AL

    ADD BX,AX
    MOV COURT_AVAIL[BX],1

    INC BOOKING_COUNTER

    MOV AH,09H
    LEA DX,MSG_SUCCESS
    INT 21H

    CALL PRINT_INVOICE

    RET

CANCEL_BOOKING:

    MOV AH,09H
    LEA DX,MSG_CANCEL
    INT 21H

    MOV AH,07H
    INT 21H

    RET

CONFIRM_BOOKING ENDP

PRINT_INVOICE PROC

    MOV AH,09H
    LEA DX,INV_HEADER
    INT 21H

    MOV AH,09H
    LEA DX,INV_BOOKING_ID
    INT 21H

    MOV AX,BOOKING_COUNTER
    CALL PRINT_NUM
    CALL PRINT_NL

    MOV AH,09H
    LEA DX,INV_SPORT
    INT 21H

    CALL PRINT_CURRENT_SPORT

    MOV AH,09H
    LEA DX,INV_COURT
    INT 21H

    CALL PRINT_COURT_NAME

    MOV AH,09H
    LEA DX,INV_DATE
    INT 21H

    MOV AH,09H
    LEA DX,INV_TIME
    INT 21H

    CALL PRINT_SLOT_TIME

    MOV AH,09H
    LEA DX,INV_BASE
    INT 21H

    MOV AX,VAL_BASE_FEE
    CALL PRINT_MONEY
    CALL PRINT_NL

    MOV AH,09H
    LEA DX,INV_DISC
    INT 21H

    MOV AX,VAL_DISCOUNT
    CALL PRINT_MONEY
    CALL PRINT_NL

    MOV AH,09H
    LEA DX,INV_TAX
    INT 21H

    MOV AX,VAL_TAX
    CALL PRINT_MONEY
    CALL PRINT_NL

    MOV AH,09H
    LEA DX,INV_TOTAL
    INT 21H

    MOV AX,VAL_GRAND_TOTAL
    CALL PRINT_MONEY
    CALL PRINT_NL

    MOV AH,09H
    LEA DX,INV_FOOTER
    INT 21H

WAIT_INVOICE_ENTER:

    MOV AH,09H
    LEA DX,PROMPT_RECEIPT
    INT 21H

    MOV AH,01H
    INT 21H

    CMP AL,13
    JNE WAIT_INVOICE_ENTER

    CALL PRINT_RECEIPT

    RET

PRINT_INVOICE ENDP

PRINT_RECEIPT PROC

    MOV AH,09H
    LEA DX,CLR_SCREEN
    INT 21H

    MOV AH,09H
    LEA DX,RECEIPT_HEADER
    INT 21H

    MOV AH,09H
    LEA DX,REC_BOOKING_ID
    INT 21H

    MOV AX,BOOKING_COUNTER
    CALL PRINT_NUM
    CALL PRINT_NL

    MOV AH,09H
    LEA DX,REC_SPORT
    INT 21H

    CALL PRINT_CURRENT_SPORT

    MOV AH,09H
    LEA DX,REC_COURT
    INT 21H

    CALL PRINT_COURT_NAME

    MOV AH,09H
    LEA DX,REC_DATE
    INT 21H

    MOV AH,09H
    LEA DX,REC_TIME
    INT 21H

    CALL PRINT_SLOT_TIME

    MOV AH,09H
    LEA DX,REC_AMOUNT
    INT 21H

    MOV AX,VAL_GRAND_TOTAL
    CALL PRINT_MONEY
    CALL PRINT_NL

    MOV AH,09H
    LEA DX,REC_STATUS
    INT 21H

    MOV AH,09H
    LEA DX,RECEIPT_FOOTER
    INT 21H

    MOV AH,09H
    LEA DX,PROMPT_RETURN
    INT 21H

    MOV AH,07H
    INT 21H

    RET

PRINT_RECEIPT ENDP

PRINT_NUM PROC

    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

    LEA SI,NUM_STR
    ADD SI,6

    MOV BYTE PTR [SI],'$'
    MOV BX,10

CONV_LOOP:

    XOR DX,DX
    DIV BX
    ADD DL,'0'

    DEC SI
    MOV [SI],DL

    CMP AX,0
    JNE CONV_LOOP

    MOV AH,09H
    MOV DX,SI
    INT 21H

    POP SI
    POP DX
    POP CX
    POP BX
    POP AX

    RET

PRINT_NUM ENDP

PRINT_MONEY PROC

    PUSH AX
    PUSH BX
    PUSH DX

    XOR DX,DX
    MOV BX,100
    DIV BX

    PUSH DX

    CALL PRINT_NUM

    MOV AH,02H
    MOV DL,'.'
    INT 21H

    POP AX

    CMP AX,10
    JAE PM_NO_PAD

    PUSH AX

    MOV AH,02H
    MOV DL,'0'
    INT 21H

    POP AX

PM_NO_PAD:

    CALL PRINT_NUM

    POP DX
    POP BX
    POP AX

    RET

PRINT_MONEY ENDP

PRINT_NL PROC

    PUSH AX
    PUSH DX

    MOV AH,09H
    LEA DX,NL
    INT 21H

    POP DX
    POP AX

    RET

PRINT_NL ENDP

END MAIN
