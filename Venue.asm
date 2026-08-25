JUMPS                    ; 自动处理 Jump out of range 报错
.MODEL SMALL
.STACK 200H

.DATA

; =========================================================
; Messages & UI Formatting
; =========================================================

welcomeMsg DB 13,10
           DB "========================================",13,10
           DB "        VENUE MASTER SDN. BHD.           ",13,10
           DB "           VENUE BOOKING SYSTEM          ",13,10
           DB "========================================",13,10
           DB 13,10
           DB "        Welcome to VenueMaster          ",13,10
           DB "         Venue Booking System           ",13,10
           DB 13,10
           DB "----------------------------------------",13,10
           DB "1. Login",13,10
           DB "2. Exit",13,10
           DB "----------------------------------------",13,10
           DB "Enter your choice: $"

usernameMsg DB 13,10,"Username: $"
passwordMsg DB 13,10,"Password: $"

loginSuccess DB 13,10,13,10
             DB "Login successful!",13,10
             DB "Welcome, Administrator.",13,10
             DB "$"

loginFailed DB 13,10
            DB "Invalid username or password!",13,10
            DB "$"

exitMsg DB 13,10,13,10
        DB "Thank you for using VenueMaster.",13,10
        DB "Goodbye!",13,10
        DB "$"

invalidChoice DB 13,10
              DB "Invalid choice! Please try again.",13,10
              DB "$"

pressKeyMsg DB 13,10,13,10
            DB "Press any key to continue...$"


; =========================================================
; Administrator Main Menu Messages
; =========================================================

mainMenuMsg DB 13,10,13,10
            DB "========================================",13,10
            DB "        ADMINISTRATOR MAIN MENU          ",13,10
            DB "========================================",13,10
            DB "1. Venue Booking                        ",13,10
            DB "2. Summary Reports                      ",13,10
            DB "3. View Invoice Records                 ",13,10
            DB "4. Settings                             ",13,10
            DB "5. Logout                               ",13,10
            DB "----------------------------------------",13,10
            DB "Select module option (1-5): $"

logoutConfirmMsg DB 13,10,13,10
                 DB "Are you sure to logout? (y/n): $"

logoutMsg DB 13,10,13,10
          DB "Logging out... Returning to Welcome Page.",13,10
          DB "$"


; =========================================================
; Submenu Messages (Venue Booking Page)
; =========================================================

venueSubMenuMsg DB 13,10,13,10
                DB "========================================",13,10
                DB "        VENUE BOOKING PAGE               ",13,10
                DB "========================================",13,10
                DB "1. Select Venue                         ",13,10
                DB "2. View Booking                         ",13,10
                DB "3. Add-on                               ",13,10
                DB "4. Back                                 ",13,10
                DB "----------------------------------------",13,10
                DB "Select option (1-4): $"

msgVenueBookingRecord DB 13,10,13,10,"[VENUE BOOKING] Venue booking records displayed here.",13,10,"$"

; =========================================================
; Summary Report Sub-Menu Messages & Data
; =========================================================
summaryMenuMsg  DB 13,10,13,10
                DB "========================================",13,10
                DB "         SUMMARY REPORTS MENU           ",13,10
                DB "========================================",13,10
                DB "1. Monthly Booking Report",13,10
                DB "2. Profit Report",13,10
                DB "3. Back to Main Menu",13,10
                DB "----------------------------------------",13,10
                DB "Enter your choice (1-3): $"

rptMonthlyMsg   DB 13,10,13,10
                DB "--- MONTHLY BOOKING REPORT ---",13,10
                DB "Total Bookings Completed : 12",13,10
                DB "Total Equipment Rentals  : 08",13,10
                DB "Most Popular Court       : Badminton Court A",13,10
                DB "Peak Hours               : 6:00 PM - 9:00 PM",13,10, "$"

rptProfitMsg    DB 13,10,13,10
                DB "--- PROFIT & FINANCIAL SUMMARY ---",13,10
                DB "Gross Court Booking Fees : RM 1,200.00",13,10
                DB "Equipment Rental Fees    : RM   250.00",13,10
                DB "Service Tax (SST 6%)     : RM    87.00",13,10
                DB "----------------------------------------",13,10
                DB "Net Total Profit         : RM 1,537.00",13,10, "$"

; =========================================================
; Settings Sub-Menu Messages & Data
; =========================================================
settingsMenuMsg DB 13,10,13,10
                DB "========================================",13,10
                DB "            SETTINGS PAGE               ",13,10
                DB "========================================",13,10
                DB "1. Change Username",13,10
                DB "2. Change Password",13,10
                DB "3. Back to Main Menu",13,10
                DB "----------------------------------------",13,10
                DB "Enter your choice (1-3): $"

newUsrPrompt    DB 13,10,"Enter New Username: $"
newPwdPrompt    DB 13,10,"Enter New Password: $"
usrUpdatedMsg   DB 13,10,"[SUCCESS] Username updated successfully!",13,10,"$"
pwdUpdatedMsg   DB 13,10,"[SUCCESS] Password updated successfully!",13,10,"$"
pressKeyReturn  DB 13,10,"Press any key to return...$"

newInputBuf     DB 20, 0, 20 DUP('$')
usrLength       DB 5
pwdLength       DB 4

; =========================================================
; Invoice Query & Receipt Messages
; =========================================================

statusTitle DB 13,10,13,10
            DB "========================================",13,10
            DB "          CHECK INVOICE STATUS          ",13,10
            DB "========================================",13,10,"$"

enterInvoiceID DB 13,10,"Enter Invoice ID (e.g. INV001 or 001): $"
invoiceFoundMsg DB 13,10,"[SUCCESS] Invoice Record Found!",13,10,"$"
invoiceNotFoundMsg DB 13,10,"[ERROR] Invoice ID not found! (No record)",13,10,"$"

recordMenuMsg DB 13,10,13,10
              DB "========================================",13,10
              DB "     INVOICE RECORDS & STATUS CHECK     ",13,10
              DB "========================================",13,10
              DB "1. View All Invoice Records             ",13,10
              DB "2. Check Invoice Status                 ",13,10
              DB "3. Back                                 ",13,10
              DB "----------------------------------------",13,10
              DB "Select option (1-3): $"

receiptTitle DB 13,10,13,10
             DB "========================================",13,10
             DB "             VENUE MASTER               ",13,10
             DB "            PAYMENT RECEIPT             ",13,10
             DB "========================================",13,10,"$"

receiptIDMsg DB "Receipt ID    : REC$"
bookingIDMsg DB "Invoice ID    : INV$"
customerMsg  DB "Customer      : $"
venueMsg     DB "Venue         : Grand Hall",13,10,"$"
courtMsg     DB "Court         : $"
dateMsg      DB "Event Date    : 25/09/2026",13,10,"$"
totalMsg     DB "Total Paid    : RM$"
paymentMsg   DB "Payment       : PAID",13,10,"$"
statusMsg    DB "Status        : CONFIRMED",13,10,"$"
receiptEnd   DB "========================================",13,10,"$"

BOOKING_INVOICE_HEADER DB 13,10,13,10
                       DB "=================================",13,10
                       DB "          CUSTOMER INVOICE       ",13,10
                       DB "=================================",13,10,"$"

INV_ID_MSG             DB "Invoice ID          : INV$"
BOOKING_ID_MSG         DB "Booking ID          : BK-$"
INV_SPORT_MSG          DB "Sport Type          : $"
INV_COURT_MSG          DB "Court               : Court $"
INV_DATE_MSG           DB "Date                : $"
INV_TIME_MSG           DB "Time                : $"
INV_BASE_MSG           DB "Base Fee            : RM $"
INV_DISCOUNT_MSG       DB "Discount            : -RM $"
INV_TAX_MSG            DB "Service Tax         : RM $"

INV_TOTAL_MSG          DB "---------------------------------",13,10
                       DB "GRAND TOTAL         : RM $"

BOOKING_INVOICE_FOOTER DB 13,10
                       DB "=====================================",13,10
                       DB "       Thank you for your business!",13,10
                       DB "=====================================",13,10,"$"

BOOKING_RECEIPT_HEADER DB 13,10,13,10
                       DB "===================================",13,10
                       DB "          BOOKING RECEIPT          ",13,10
                       DB "===================================",13,10,"$"

REC_ID_MSG             DB "Receipt ID          : REC$"
REC_BOOKING_ID_MSG     DB "Booking ID          : BK-$"
REC_SPORT_MSG          DB "Sport Type          : $"
REC_COURT_MSG          DB "Court               : Court $"
REC_DATE_MSG           DB "Date                : $"
REC_TIME_MSG           DB "Time                : $"
REC_AMOUNT_MSG         DB "Amount Paid         : RM $"
REC_STATUS_MSG         DB "Status              : PAID$"

REC_LINE               DB 13,10
                       DB "-------------------------------------------",13,10,"$"

REC_CONFIRMED_MSG      DB "           BOOKING CONFIRMED             ",13,10
                       DB "         Thank you for booking!           ",13,10
                       DB "===========================================",13,10
                       DB "Press any key to return to main menu...$"

; =========================================================
; Buffers
; =========================================================

usernameBuffer DB 20, 0, 20 DUP('$')
passwordBuffer DB 20, 0, 20 DUP('$')
invoiceBuffer  DB 10, 0, 10 DUP('$')
courtIDBuffer  DB 10, 0, 10 DUP('$')

serviceType    DB 0
selectedSport  DB 0
selectedItem   DB 0
selectedPrice  DB 0
selectedQuantity DB 0
selectedSubtotal DW 0
sessionTotal   DW 0

rentalCounter  DW 1
transIDStr     DB "000$"

custNameBuffer  DB 30, 0, 30 DUP('$')
custPhoneBuffer DB 20, 0, 20 DUP('$')

msgAskCheckout   DB 13,10,13,10,"Do you want to Checkout and Generate Invoice? (1. Yes / 2. No): $"
msgAskReceipt    DB 13,10,"Do you want to print Receipt? (1. Yes / 2. No): $"
msgAddMore       DB 13,10,"Do you want to add another equipment item? (1. Yes / 2. No): $"
msgEnterCustName DB 13,10,"Enter Customer Name: $"
msgEnterCustPhone DB 13,10,"Enter Customer Phone No: $"

itemNameStr DB 30 DUP('$')

MAX_CART_ITEMS EQU 5
CART_ITEM_SIZE EQU 36

cartCount DB 0
cartTable DB MAX_CART_ITEMS * CART_ITEM_SIZE DUP(0)


; =========================================================
; DATABASE (Max 10 Records)
; =========================================================

MAX_RECORDS EQU 10
RECORD_SIZE EQU 220    ; 加大空间存放完整的 Cart List

dbRecordCount DW 0
dbTable       DB MAX_RECORDS * RECORD_SIZE DUP(0)

msgNoRecords DB 13,10,13,10,"[DATABASE] No dynamic invoice records found!",13,10,"$"
msgViewHeader DB 13,10,13,10
              DB "==================================================",13,10
              DB "            DATABASE INVOICE RECORDS              ",13,10
              DB "==================================================",13,10
              DB "INVOICE ID | CUST NAME        | COURT | TOTAL (RM)",13,10
              DB "--------------------------------------------------",13,10,"$"


MAX_BOOKING_RECORDS EQU 10

BOOKING_RECORD_SIZE EQU 100

bookingRecordCount DW 0

bookingTable DB MAX_BOOKING_RECORDS * BOOKING_RECORD_SIZE DUP(0)

; =========================================================
; Prompts & Menus
; =========================================================


msgUnitPrice DB 13,10,"Unit Price : RM $"

msgQuantity DB 13,10
            DB "Enter quantity (1-9): $"

msgSubtotal DB 13,10
            DB "Subtotal   : RM $"

msgCartFull DB 13,10
            DB "[ERROR] Cart is full! Maximum 5 items.",13,10,"$"

msgCartTitle DB 13,10,13,10
             DB "========================================",13,10
             DB "                CART                    ",13,10
             DB "========================================",13,10,"$"

msgCartTotal DB 13,10
             DB "----------------------------------------",13,10
             DB "Cart Total : RM $"

msgEnterCourtID DB 13,10,"Enter Court ID: $"

msgCourtHeader DB 13,10,13,10
               DB "========================================",13,10
               DB "Court $"

msgCourtHeader2 DB " : Select service option",13,10
                DB "========================================",13,10
                DB "1. Rent equipment",13,10
                DB "2. Buy additional",13,10
                DB "3. Back to Add-on Menu",13,10
                DB "Select option (1-3): $"

msgTypesOfSports DB 13,10,13,10
                 DB "=========== SELECT VENUE ===========",13,10
                 DB "1. Badminton Court    RM10/hr",13,10
                 DB "2. Volleyball Court   RM20/hr",13,10
                 DB "3. Basketball Court   RM25/hr",13,10
                 DB "4. Futsal Court       RM40/hr",13,10
                 DB "5. Tennis Court       RM15/hr",13,10
                 DB "6. Table Tennis       RM8/hr",13,10
                 DB "7. Squash Court       RM12/hr",13,10
                 DB "8. Netball Court      RM20/hr",13,10
                 DB "9. Cancel",13,10
                 DB "-----------------------------------",13,10
                 DB "Select venue (1-9): $"

msgAddonSports DB 13,10,13,10
              DB "========== ADD-ON SPORT ==========",13,10
              DB "1. Badminton Court",13,10
              DB "2. Volleyball Court",13,10
              DB "3. Basketball Court",13,10
              DB "4. Futsal Court",13,10
              DB "5. Tennis Court",13,10
              DB "6. Table Tennis",13,10
              DB "7. Squash Court",13,10
              DB "8. Netball Court",13,10
              DB "----------------------------------",13,10
              DB "Select sport (1-8): $"

msgBadmintonEquip DB 13,10,13,10
                  DB "====== BADMINTON EQUIPMENT ======",13,10
                  DB "1. Badminton Racket   Rent RM10  Buy RM50",13,10
                  DB "2. Racket Grip        Rent RM5   Buy RM8",13,10
                  DB "3. Shuttlecock        Rent RM5   Buy RM12",13,10
                  DB "------------------------------------------",13,10
                  DB "Select item (1-3): $"

msgVolleyballEquip DB 13,10,13,10
                   DB "===== VOLLEYBALL EQUIPMENT =====",13,10
                   DB "1. Volleyball         Rent RM10  Buy RM50",13,10
                   DB "2. Knee Pad            Rent RM5   Buy RM20",13,10
                   DB "3. Ball Pump           Rent RM3   Buy RM8",13,10
                   DB "------------------------------------------",13,10
                   DB "Select item (1-3): $"

msgBasketballEquip DB 13,10,13,10
                   DB "====== BASKETBALL EQUIPMENT ======",13,10
                   DB "1. Basketball           Rent RM10  Buy RM60",13,10
                   DB "2. Sports Towel        Rent RM5   Buy RM10",13,10
                   DB "3. Air Pump            Rent RM3   Buy RM8",13,10
                   DB "------------------------------------------",13,10
                   DB "Select item (1-3): $"

msgFutsalEquip DB 13,10,13,10
               DB "====== FUTSAL EQUIPMENT ========",13,10
               DB "1. Futsal Ball         Rent RM10  Buy RM50",13,10
               DB "2. Shin Guard          Rent RM5   Buy RM20",13,10
               DB "3. Goalkeeper Gloves   Rent RM8   Buy RM40",13,10
               DB "------------------------------------------",13,10
               DB "Select item (1-3): $"

msgTennisEquip DB 13,10,13,10
               DB "======= TENNIS EQUIPMENT =======",13,10
               DB "1. Tennis Racket       Rent RM15  Buy RM80",13,10
               DB "2. Tennis Balls        Rent RM5   Buy RM15",13,10
               DB "3. Racket Grip         Rent RM5   Buy RM10",13,10
               DB "------------------------------------------",13,10
               DB "Select item (1-3): $"

msgTableTennisEquip DB 13,10,13,10
                    DB "===== TABLE TENNIS EQUIPMENT =====",13,10
                    DB "1. Table Tennis Paddle Rent RM10  Buy RM40",13,10
                    DB "2. Table Tennis Balls  Rent RM3   Buy RM10",13,10
                    DB "3. Paddle Grip         Rent RM3   Buy RM8",13,10
                    DB "------------------------------------------",13,10
                    DB "Select item (1-3): $"

msgSquashEquip DB 13,10,13,10
               DB "======= SQUASH EQUIPMENT =======",13,10
               DB "1. Squash Racket       Rent RM10  Buy RM60",13,10
               DB "2. Squash Balls        Rent RM5   Buy RM15",13,10
               DB "3. Racket Grip         Rent RM5   Buy RM10",13,10
               DB "------------------------------------------",13,10
               DB "Select item (1-3): $"
msgNetballEquip DB 13,10,13,10
                DB "======= NETBALL EQUIPMENT =======",13,10
                DB "1. Netball             Rent RM10  Buy RM45",13,10
                DB "2. Knee Support        Rent RM5   Buy RM20",13,10
                DB "3. Ball Pump            Rent RM3   Buy RM8",13,10
                DB "------------------------------------------",13,10
                DB "Select item (1-3): $"


msgRentSelected DB 13,10,"Service selected: RENT",13,10,"$"
msgBuySelected  DB 13,10,"Service selected: BUY",13,10,"$"
msgAddonSuccess DB 13,10,"[SUCCESS] Item added to order!",13,10,"$"

invoiceHeader DB 13,10,13,10
              DB "========================================",13,10
              DB "                INVOICE                 ",13,10
              DB "========================================",13,10,"$"

labelUnifiedInvoiceID DB "Invoice ID : INV$"

invCustName   DB 13,10,"Name       : $"
invCustPhone  DB 13,10,"Phone No   : $"
invCourtID    DB 13,10,"Court ID   : $"
invLine       DB 13,10,"----------------------------------------",13,10
              DB "Items Purchased / Rented:",13,10,"$"

invRentPrefix DB " (Rent - RM $"
invBuyPrefix  DB " (Buy - RM $"
invCloseParen DB ")$"

invTotalLabel DB 13,10,"----------------------------------------",13,10
              DB "Total      : RM $"

strBadminton1 DB "Badminton Racket$"
strBadminton2 DB "Racket Grip$"
strBadminton3 DB "Shuttlecock$"

strBasketball1 DB "Basketball$"
strBasketball2 DB "Sports Towel$"
strBasketball3 DB "Air Pump$"

strPickleball1 DB "Pickleball Paddle$"
strPickleball2 DB "Pickleball Balls$"
strPickleball3 DB "Paddle Grip$"

correctUsername DB "admin"
correctPassword DB "1234"

msgSummaryTitle DB 13,10,13,10,"=== BOOKING DETAILS ===",13,10,"$"
msgSumSport    DB "Sport Selected : $"
msgSumCourt    DB "Court Number   : $"
msgSumSlot     DB "Time Slot      : $"
msgSumRate     DB "Hourly Rate    : RM $"
msgSumBase     DB "Base Charge    : RM $"
msgSumTax      DB "SST (6%)       : RM $"
msgSumTotal    DB "Grand Total    : RM $"
SLOT_SHORT_TBL DW SL1,SL2,SL3,SL4,SL5,SL6,SL7,SL8,SL9,SL10

; =========================================================
; DO BOOKING (VENUE PRESERVATION) DATA STRUCTURES
; =========================================================
MAX_COURTS        EQU 6
SLOTS_PER_COURT   EQU 10
SPORT_BLOCK_SIZE  EQU 60
NUM_SPORTS        EQU 8

VAR_SPORT_TYPE        DB 0
VAR_COURT_CHOICE      DB 0
VAR_SLOT_CHOICE       DB 0
VAR_COURT_COUNT       DB 0
VAR_BOOKING_CANCELLED DB 0

TEMP_COURT_NUM        DB 0
TEMP_SLOT_NUM         DB 0
TEMP_BASE_INDEX       DW 0

VAL_PRICE_PER_H       DW 0
VAL_BASE_FEE          DW 0
VAL_DISCOUNT          DW 0
VAL_TAX               DW 0
VAL_GRAND_TOTAL       DW 0

; =========================================================
; UNIFIED ID COUNTERS
; =========================================================

; All invoices use this counter.
; Booking and Add-on will NEVER use the same Invoice ID.
INVOICE_COUNTER       DW 1

; Booking ID
BOOKING_COUNTER       DW 1001

; Receipt ID
RECEIPT_COUNTER       DW 1


; =========================================================
; CURRENT BOOKING DATA
; =========================================================

BOOKING_INVOICE_ID    DB "000$"
BOOKING_RECEIPT_ID    DB "000$"

BOOKING_ID_STR        DB "0000$"

BOOKING_DATE          DB "21/08/2026$"

BOOKING_STATUS        DB "AVAILABLE$"

; --- yh 风格 UI 界面与提示词 ---
CLR_SCREEN          DB 13,10,13,10,13,10,13,10,13,10,13,10,13,10,13,10,"$"

MSG_AV_TITLE        DB 13,10,"=== COURT AVAILABILITY GRID ===",13,10,"$"
MSG_COURT_CHOSEN_HDR DB 13,10,"--- Availability for Court $"
SLOT_BRACKET_OPEN   DB "  [ Slot $"
SLOT_BRACKET_CLOSE  DB " ] $"
TXT_AV              DB "[AVAILABLE]$"
TXT_BK              DB "[BOOKED]$"

msgSelectCourtPrompt DB 13,10,"Enter Court Number: $"
msgSelectSlotPrompt  DB 13,10,"Enter Time Slot (1-10): $"
msgInvalidCourt      DB 13,10,"Invalid court number for this sport!",13,10,"$"
msgInvalidSlot       DB 13,10,"Invalid slot! Please enter 1 to 10.",13,10,"$"
msgSlotTaken         DB 13,10,"Error: Slot already BOOKED! Choose another.",13,10,"$"
msgConfirmPrompt     DB 13,10,"Confirm Booking? (Y/N): $"
msgBookingSuccess    DB 13,10,"Booking Confirmed!",13,10,"$"
msgBookingCancel     DB 13,10,"Booking Cancelled.",13,10,"$"

; --- 发票 (Invoice) 模板 ---
INV_HEADER          DB 13,10,13,10,"==========================================",13,10
                    DB "             BOOKING INVOICE              ",13,10
                    DB "==========================================",13,10,"$"
INV_BOOKING_ID      DB "Invoice ID   : BK-$"
INV_BASE            DB 13,10,"Base Fee     : RM $"
INV_TAX             DB 13,10,"SST (6%)     : RM $"
INV_TOTAL           DB 13,10,"------------------------------------------",13,10
                    DB "Grand Total  : RM $"
INV_FOOTER          DB 13,10,"==========================================",13,10,"$"

; --- 收据 (Receipt) 模板与键盘触发 ---
PROMPT_RECEIPT      DB 13,10,13,10,"Press ENTER to generate receipt...$"
RECEIPT_HEADER      DB 13,10,13,10,"==========================================",13,10
                    DB "             OFFICIAL RECEIPT             ",13,10
                    DB "==========================================",13,10,"$"
REC_BOOKING_ID      DB "Receipt For  : BK-$"
REC_AMOUNT          DB 13,10,"Amount Paid  : RM $"
REC_STATUS          DB 13,10,"Status       : PAID (CONFIRMED)",13,10
                    DB "==========================================",13,10,"$"

; --- 运动项目与球场数据配置 ---
COURT_COUNT DB 6, 2, 2, 2, 3, 4, 2, 2

; 时间段文本指针表与字符串
SLOT_LONG_TBL DW SL1,SL2,SL3,SL4,SL5,SL6,SL7,SL8,SL9,SL10
SL1  DB "08:00 AM - 09:00 AM$",0
SL2  DB "09:00 AM - 10:00 AM$",0
SL3  DB "10:00 AM - 11:00 AM$",0
SL4  DB "11:00 AM - 12:00 PM$",0
SL5  DB "12:00 PM - 01:00 PM$",0
SL6  DB "01:00 PM - 02:00 PM$",0
SL7  DB "02:00 PM - 03:00 PM$",0
SL8  DB "03:00 PM - 04:00 PM$",0
SL9  DB "04:00 PM - 05:00 PM$",0
SL10 DB "05:00 PM - 06:00 PM$",0

SP1 DB "Badminton Court$",0
SP2 DB "Volleyball Court$",0
SP3 DB "Basketball Court$",0
SP4 DB "Futsal Court$",0
SP5 DB "Tennis Court$",0
SP6 DB "Table Tennis$",0
SP7 DB "Squash Court$",0
SP8 DB "Netball Court$",0

SPORT_NAME_TBL DW SP1,SP2,SP3,SP4,SP5,SP6,SP7,SP8

; 场地预订状态数据库 (0=Free, 1=Booked)
COURT_AVAIL DB 0,1,0,0,1,0,0,1,0,0
            DB 1,0,1,0,0,1,0,0,1,0
            DB 0,0,0,1,0,0,0,0,1,0
            DB 0,1,0,0,0,0,1,0,0,0
            DB 0,0,1,0,0,0,0,0,0,1
            DB 1,0,0,0,1,0,0,0,0,0
            
            DB 0,0,0,0,1,1,0,0,0,0
            DB 1,1,0,0,0,0,0,0,1,1
            
            DB 0,1,0,1,0,1,0,1,0,1
            DB 1,0,1,0,1,0,1,0,1,0
            
            DB 0,0,1,1,0,0,1,1,0,0
            DB 1,1,0,0,1,1,0,0,1,1
            
            DB 0,0,0,0,0,0,0,0,0,0
            DB 1,1,1,1,1,0,0,0,0,0
            DB 0,0,0,0,0,1,1,1,1,1
            
            DB 0,1,0,1,0,0,0,0,0,0
            DB 0,0,0,0,0,1,0,1,0,1
            DB 1,0,1,0,1,0,0,0,0,0
            DB 0,0,0,0,0,0,1,0,1,0
            
            DB 0,0,0,0,1,0,0,0,0,1
            DB 1,0,0,0,0,1,0,0,0,0
            
            DB 0,1,1,0,0,0,0,1,1,0
            DB 1,0,0,1,1,0,0,0,0,1

; =========================================================
; SELECTED BOOKING DISPLAY
; =========================================================

SELECTED_BOOKING_HEADER DB 13,10,13,10
                        DB "==============================",13,10
                        DB "        SELECTED BOOKING      ",13,10
                        DB "==============================",13,10,"$"

SEL_SPORT_MSG           DB "Sport Type: $"
SEL_COURT_MSG           DB "Court     : Court $"
SEL_DATE_MSG            DB "Date      : $"
SEL_TIME_MSG            DB "Time      : $"
SEL_STATUS_MSG          DB "Status    : $"

SEL_CONFIRM_MSG         DB 13,10
                        DB "Continue with booking? (Y/N): $"


;================================================================
.CODE
;==================================================================

; =========================================================
; MAIN PROCEDURE
; =========================================================

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

START:

    LEA DX, welcomeMsg
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    CMP AL, '1'
    JE LOGIN

    CMP AL, '2'
    JNE NOT_EXIT_MAIN
    JMP EXIT_PROGRAM

NOT_EXIT_MAIN:
    LEA DX, invalidChoice
    MOV AH, 09H
    INT 21H
    JMP START


; =========================================================
; LOGIN
; =========================================================

LOGIN:

    LEA DX, usernameMsg
    MOV AH, 09H
    INT 21H

    LEA DX, usernameBuffer
    MOV AH, 0AH
    INT 21H

    LEA DX, passwordMsg
    MOV AH, 09H
    INT 21H

    LEA DX, passwordBuffer
    MOV AH, 0AH
    INT 21H

    LEA SI, usernameBuffer + 2
    LEA DI, correctUsername
    MOV CL, usernameBuffer + 1
    MOV CH, 0

    CMP CX, 5
    JNE LOGIN_ERROR

COMPARE_USERNAME:
    MOV AL, [SI]
    CMP AL, [DI]
    JNE LOGIN_ERROR
    INC SI
    INC DI
    LOOP COMPARE_USERNAME

    LEA SI, passwordBuffer + 2
    LEA DI, correctPassword
    MOV CL, passwordBuffer + 1
    MOV CH, 0

    CMP CX, 4
    JNE LOGIN_ERROR

COMPARE_PASSWORD:
    MOV AL, [SI]
    CMP AL, [DI]
    JNE LOGIN_ERROR
    INC SI
    INC DI
    LOOP COMPARE_PASSWORD

LOGIN_SUCCESS:
    LEA DX, loginSuccess
    MOV AH, 09H
    INT 21H
    JMP ADMIN_MAIN_MENU

LOGIN_ERROR:
    LEA DX, loginFailed
    MOV AH, 09H
    INT 21H
    JMP START


; =========================================================
; ADMINISTRATOR MAIN MENU
; =========================================================

ADMIN_MAIN_MENU:

    LEA DX, mainMenuMsg
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    CMP AL, '1'
    JE ROUTE_VENUE_BOOKING

    CMP AL, '2'
    JE ROUTE_SUMMARY_REPORT

    CMP AL, '3'
    JE ROUTE_RENTAL_RECORDS

    CMP AL, '4'
    JE ROUTE_SETTINGS

    CMP AL, '5'
    JE CONFIRM_LOGOUT

    LEA DX, invalidChoice
    MOV AH, 09H
    INT 21H
    JMP ADMIN_MAIN_MENU


ROUTE_VENUE_BOOKING:
    CALL MODULE_VENUE_BOOKING
    JMP ADMIN_MAIN_MENU

ROUTE_SUMMARY_REPORT:
    CALL MODULE_SUMMARY_REPORT
    JMP ADMIN_MAIN_MENU

ROUTE_RENTAL_RECORDS:
    CALL MODULE_RECORDS_AND_STATUS
    JMP ADMIN_MAIN_MENU

ROUTE_SETTINGS:
    CALL MODULE_SETTINGS
    JMP ADMIN_MAIN_MENU

CONFIRM_LOGOUT:
    LEA DX, logoutConfirmMsg
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    CMP AL, 'y'
    JE LOGOUT_SYSTEM
    CMP AL, 'Y'
    JE LOGOUT_SYSTEM

    JMP ADMIN_MAIN_MENU

LOGOUT_SYSTEM:
    LEA DX, logoutMsg
    MOV AH, 09H
    INT 21H
    JMP START

EXIT_PROGRAM:
    LEA DX, exitMsg
    MOV AH, 09H
    INT 21H

    MOV AH, 4CH
    MOV AL, 00H
    INT 21H

MAIN ENDP


; =========================================================
; MODULE: INVOICE RECORDS & INVOICE LOOKUP
; =========================================================

MODULE_RECORDS_AND_STATUS PROC
    PUSH AX
    PUSH DX

REC_STATUS_LOOP:
    LEA DX, recordMenuMsg
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    CMP AL, '1'
    JE SHOW_DYNAMIC_DB

    CMP AL, '2'
    JE CHECK_RENTAL_STATUS

    CMP AL, '3'
    JE EXIT_REC_STATUS

    LEA DX, invalidChoice
    MOV AH, 09H
    INT 21H
    JMP REC_STATUS_LOOP

SHOW_DYNAMIC_DB:
    CALL DISPLAY_DATABASE_RECORDS
    JMP REC_STATUS_LOOP

CHECK_RENTAL_STATUS:
    CALL SEARCH_AND_VIEW_INVOICE
    JMP REC_STATUS_LOOP

EXIT_REC_STATUS:
    POP DX
    POP AX
    RET
MODULE_RECORDS_AND_STATUS ENDP


; =========================================================
; SEARCH & DISPLAY DYNAMIC INVOICE BY ID
; =========================================================

SEARCH_AND_VIEW_INVOICE PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI

    LEA DX, statusTitle
    MOV AH, 09H
    INT 21H

    CMP dbRecordCount, 0
    JNE DB_HAS_DATA
    LEA DX, invoiceNotFoundMsg
    MOV AH, 09H
    INT 21H
    JMP EXIT_SEARCH_INVOICE

DB_HAS_DATA:
    LEA DX, enterInvoiceID
    MOV AH, 09H
    INT 21H

    LEA DX, invoiceBuffer
    MOV AH, 0AH
    INT 21H

    LEA SI, invoiceBuffer + 2
    MOV CL, invoiceBuffer + 1
    MOV CH, 0

    CMP CX, 6
    JNE CHECK_SHORT_ID
    ADD SI, 3             ; 跳过 "INV" 前缀
    SUB CX, 3

CHECK_SHORT_ID:
    CMP CX, 3
    JNE INVOICE_NOT_FOUND

    MOV CX, dbRecordCount
    XOR BX, BX            ; Record Index

SEARCH_LOOP:
    PUSH CX
    PUSH SI

    MOV AX, BX
    MOV CX, RECORD_SIZE
    MUL CX
    LEA DI, dbTable
    ADD DI, AX
    ADD DI, 3             ; 指向 3 位数字

    MOV CX, 3
COMPARE_3_DIGITS:
    MOV AL, [SI]
    CMP AL, [DI]
    JNE MATCH_FAIL
    INC SI
    INC DI
    LOOP COMPARE_3_DIGITS

    POP SI
    POP CX
    JMP INVOICE_FOUND_MATCH

MATCH_FAIL:
    POP SI
    POP CX
    INC BX
    LOOP SEARCH_LOOP

INVOICE_NOT_FOUND:
    LEA DX, invoiceNotFoundMsg
    MOV AH, 09H
    INT 21H
    JMP EXIT_SEARCH_INVOICE

INVOICE_FOUND_MATCH:
    LEA DX, invoiceFoundMsg
    MOV AH, 09H
    INT 21H

    CALL PRINT_INVOICE_BY_INDEX

EXIT_SEARCH_INVOICE:
    LEA DX, pressKeyMsg
    MOV AH, 09H
    INT 21H
    MOV AH, 08H
    INT 21H

    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
SEARCH_AND_VIEW_INVOICE ENDP


; =========================================================
; HELPER: PRINT INVOICE FROM DATABASE BY RECORD INDEX
; =========================================================

PRINT_INVOICE_BY_INDEX PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

    MOV AX, BX
    MOV CX, RECORD_SIZE
    MUL CX
    LEA SI, dbTable
    ADD SI, AX

    LEA DX, invoiceHeader
    MOV AH, 09H
    INT 21H

    LEA DX, labelUnifiedInvoiceID
    MOV AH, 09H
    INT 21H

    LEA DX, [SI + 3]
    MOV AH, 09H
    INT 21H

    LEA DX, invCustName
    MOV AH, 09H
    INT 21H
    LEA DX, [SI + 10]     ; Customer Name
    MOV AH, 09H
    INT 21H

    LEA DX, invCustPhone
    MOV AH, 09H
    INT 21H
    LEA DX, [SI + 30]     ; Customer Phone
    MOV AH, 09H
    INT 21H

    LEA DX, invCourtID
    MOV AH, 09H
    INT 21H
    LEA DX, [SI + 45]     ; Court ID
    MOV AH, 09H
    INT 21H

    LEA DX, invLine
    MOV AH, 09H
    INT 21H

    ; 读取完整的 Cart List
    XOR CH, CH
    MOV CL, [SI + 55]     ; Cart Count
    CMP CL, 0
    JE DB_PRINT_TOTAL

    LEA DI, [SI + 56]     ; 指向 Saved Cart Buffer
    XOR BX, BX

DB_PRINT_CART_LOOP:
    PUSH CX
    PUSH BX

    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    
    POP BX
    PUSH BX
    MOV AX, BX
    INC AX
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H
    
    MOV DL, '.'
    INT 21H
    MOV DL, ' '
    INT 21H

    MOV DX, DI
    MOV AH, 09H
    INT 21H

    MOV AL, [DI + 25]     ; Service Type
    CMP AL, 1
    JE DB_CART_RENT

    LEA DX, invBuyPrefix
    MOV AH, 09H
    INT 21H
    JMP DB_CART_PRICE

DB_CART_RENT:
    LEA DX, invRentPrefix
    MOV AH, 09H
    INT 21H

DB_CART_PRICE:
    XOR AX, AX
    MOV AL, [DI + 26]     ; Item Price
    CALL PRINT_NUMBER

    LEA DX, invCloseParen
    MOV AH, 09H
    INT 21H

    MOV DL, 13
    MOV AH, 02H
    INT 21H
    MOV DL, 10
    INT 21H

    ADD DI, CART_ITEM_SIZE
    POP BX
    INC BX
    POP CX
    LOOP DB_PRINT_CART_LOOP

DB_PRINT_TOTAL:
    LEA DX, invTotalLabel
    MOV AH, 09H
    INT 21H

    MOV AX, [SI + 210]    ; Total Amount
    CALL PRINT_NUMBER
    MOV DL, 13
    MOV AH, 02H
    INT 21H
    MOV DL, 10
    INT 21H

    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_INVOICE_BY_INDEX ENDP


; =========================================================
; HELPER: PRINT RECEIPT DETAILS
; =========================================================

PRINT_RECEIPT_DETAILS PROC
    PUSH AX
    PUSH DX

    LEA DX, receiptTitle
    MOV AH, 09H
    INT 21H

    LEA DX, receiptIDMsg
    MOV AH, 09H
    INT 21H
    LEA DX, transIDStr
    MOV AH, 09H
    INT 21H
    MOV DL, 13
    MOV AH, 02H
    INT 21H
    MOV DL, 10
    INT 21H

    LEA DX, bookingIDMsg
    MOV AH, 09H
    INT 21H
    LEA DX, transIDStr
    MOV AH, 09H
    INT 21H
    MOV DL, 13
    MOV AH, 02H
    INT 21H
    MOV DL, 10
    INT 21H

    LEA DX, customerMsg
    MOV AH, 09H
    INT 21H
    LEA DX, custNameBuffer + 2
    MOV AH, 09H
    INT 21H
    MOV DL, 13
    MOV AH, 02H
    INT 21H
    MOV DL, 10
    INT 21H

    LEA DX, venueMsg
    MOV AH, 09H
    INT 21H

    LEA DX, courtMsg
    MOV AH, 09H
    INT 21H
    LEA DX, courtIDBuffer + 2
    MOV AH, 09H
    INT 21H
    MOV DL, 13
    MOV AH, 02H
    INT 21H
    MOV DL, 10
    INT 21H

    LEA DX, dateMsg
    MOV AH, 09H
    INT 21H

    LEA DX, totalMsg
    MOV AH, 09H
    INT 21H

    MOV AX, sessionTotal
    CALL PRINT_NUMBER
    MOV DL, 13
    MOV AH, 02H
    INT 21H
    MOV DL, 10
    INT 21H

    LEA DX, paymentMsg
    MOV AH, 09H
    INT 21H

    LEA DX, statusMsg
    MOV AH, 09H
    INT 21H

    LEA DX, receiptEnd
    MOV AH, 09H
    INT 21H

    POP DX
    POP AX
    RET
PRINT_RECEIPT_DETAILS ENDP


; =========================================================
; MODULE 1: VENUE BOOKING PAGE (主流程控制)
; =========================================================

MODULE_VENUE_BOOKING PROC
    PUSH AX
    PUSH DX

VENUE_SUBMENU_LOOP:
    LEA DX, venueSubMenuMsg
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    CMP AL, '1'
    JE SUB_SELECT_VENUE

    CMP AL, '2'
    JE SUB_VIEW_BOOKING

    CMP AL, '3'
    JE SUB_ADD_ON

    CMP AL, '4'
    JE EXIT_SUBMENU

    LEA DX, invalidChoice
    MOV AH, 09H
    INT 21H
    JMP VENUE_SUBMENU_LOOP

SUB_SELECT_VENUE:
    MOV VAR_BOOKING_CANCELLED, 0

    ; 1. 选择运动类型 (运动自带 VAR_COURT_COUNT 上限)
    CALL SELECT_SPORT_BOOKING
    CMP VAR_BOOKING_CANCELLED, 1
    JE EXIT_COURT_BOOKING_FLOW

    ; 2. 输入并验证 Court 编号 (1 ~ VAR_COURT_COUNT)
    CALL SELECT_COURT_BOOKING
    CMP VAR_BOOKING_CANCELLED, 1
    JE EXIT_COURT_BOOKING_FLOW

    ; 3. 展示该 Court 的 10 个 Slot 表格
    CALL SHOW_COURT_AVAILABILITY

    ; 4. 输入 Slot 编号 (1 ~ 10)
    CALL GET_SLOT_INPUT
    CMP VAR_BOOKING_CANCELLED, 1
    JE EXIT_COURT_BOOKING_FLOW

    ; 5. 算钱与确认
    CALL CALC_FEES
    CALL SHOW_SELECTED_BOOKING
    CALL CONFIRM_BOOKING

EXIT_COURT_BOOKING_FLOW:
    JMP VENUE_SUBMENU_LOOP

SUB_VIEW_BOOKING:
    LEA DX, msgVenueBookingRecord
    MOV AH, 09H
    INT 21H
    LEA DX, pressKeyMsg
    MOV AH, 09H
    INT 21H
    MOV AH, 08H
    INT 21H
    JMP VENUE_SUBMENU_LOOP

SUB_ADD_ON:
    CALL SUB_ADD_ON_PROC
    JMP VENUE_SUBMENU_LOOP

EXIT_SUBMENU:
    POP DX
    POP AX
    RET
MODULE_VENUE_BOOKING ENDP


; =========================================================
; EQUIPMENT ADD-ON & CHECKOUT INVOICE FLOW
; =========================================================

SUB_ADD_ON_PROC PROC

    PUSH AX
    PUSH DX
    PUSH SI
    PUSH CX

    MOV sessionTotal, 0
    MOV cartCount, 0

ASK_COURT_ID:
    LEA DX, msgEnterCourtID
    MOV AH, 09H
    INT 21H

    LEA DX, courtIDBuffer
    MOV AH, 0AH
    INT 21H

    LEA SI, courtIDBuffer + 2
    MOV CL, courtIDBuffer + 1
    MOV CH, 0
    ADD SI, CX
    MOV BYTE PTR [SI], '$'

SHOW_COURT_MENU:
    LEA DX, msgCourtHeader
    MOV AH, 09H
    INT 21H

    LEA DX, courtIDBuffer + 2
    MOV AH, 09H
    INT 21H

    LEA DX, msgCourtHeader2
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    CMP AL, '1'
    JE GO_RENT_EQUIPMENT

    CMP AL, '2'
    JE GO_BUY_ADDITIONAL

    CMP AL, '3'
    JE EXIT_ADD_ON_FLOW

    LEA DX, invalidChoice
    MOV AH, 09H
    INT 21H
    JMP SHOW_COURT_MENU

GO_RENT_EQUIPMENT:
    MOV serviceType, 1
    LEA DX, msgRentSelected
    MOV AH, 09H
    INT 21H
    JMP SELECT_SPORT_TYPE

GO_BUY_ADDITIONAL:
    MOV serviceType, 2
    LEA DX, msgBuySelected
    MOV AH, 09H
    INT 21H
    JMP SELECT_SPORT_TYPE

SELECT_SPORT_TYPE:

    LEA DX, msgAddonSports
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    CMP AL, '1'
    JE SHOW_BADMINTON_EQUIP

    CMP AL, '2'
    JE SHOW_VOLLEYBALL_EQUIP

    CMP AL, '3'
    JE SHOW_BASKETBALL_EQUIP

    CMP AL, '4'
    JE SHOW_FUTSAL_EQUIP

    CMP AL, '5'
    JE SHOW_TENNIS_EQUIP

    CMP AL, '6'
    JE SHOW_TABLE_TENNIS_EQUIP

    CMP AL, '7'
    JE SHOW_SQUASH_EQUIP

    CMP AL, '8'
    JE SHOW_NETBALL_EQUIP

    LEA DX, invalidChoice
    MOV AH, 09H
    INT 21H

    JMP SELECT_SPORT_TYPE

SHOW_BADMINTON_EQUIP:
    MOV selectedSport, 1
    LEA DX, msgBadmintonEquip
    JMP PRINT_AND_GET_ITEM

SHOW_VOLLEYBALL_EQUIP:
    MOV selectedSport, 2
    LEA DX, msgVolleyballEquip
    JMP PRINT_AND_GET_ITEM

SHOW_BASKETBALL_EQUIP:
    MOV selectedSport, 3
    LEA DX, msgBasketballEquip
    JMP PRINT_AND_GET_ITEM

SHOW_FUTSAL_EQUIP:
    MOV selectedSport, 4
    LEA DX, msgFutsalEquip
    JMP PRINT_AND_GET_ITEM

SHOW_TENNIS_EQUIP:
    MOV selectedSport, 5
    LEA DX, msgTennisEquip
    JMP PRINT_AND_GET_ITEM

SHOW_TABLE_TENNIS_EQUIP:
    MOV selectedSport, 6
    LEA DX, msgTableTennisEquip
    JMP PRINT_AND_GET_ITEM

SHOW_SQUASH_EQUIP:
    MOV selectedSport, 7
    LEA DX, msgSquashEquip
    JMP PRINT_AND_GET_ITEM

SHOW_NETBALL_EQUIP:
    MOV selectedSport, 8
    LEA DX, msgNetballEquip
    JMP PRINT_AND_GET_ITEM

PRINT_AND_GET_ITEM:
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    CMP AL, '1'
    JE ITEM_SELECTED
    CMP AL, '2'
    JE ITEM_SELECTED
    CMP AL, '3'
    JE ITEM_SELECTED

    LEA DX, invalidChoice
    MOV AH, 09H
    INT 21H
    JMP SELECT_SPORT_TYPE

ITEM_SELECTED:

    SUB AL, '0'
    MOV selectedItem, AL

    CALL PROCESS_ITEM_DATA

    ; Ask quantity
    LEA DX, msgQuantity
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    SUB AL, '0'

    CMP AL, 1
    JB INVALID_QUANTITY

    CMP AL, 9
    JA INVALID_QUANTITY

    MOV selectedQuantity, AL

    ; Calculate Price × Quantity
    CALL CALCULATE_ITEM_SUBTOTAL

    ; Save item into cart
    CALL ADD_TO_CART

    LEA DX, msgSubtotal
    MOV AH, 09H
    INT 21H

    MOV AX, selectedSubtotal
    CALL PRINT_NUMBER

    LEA DX, msgAddonSuccess
    MOV AH, 09H
    INT 21H

    JMP ASK_MORE_ITEMS


INVALID_QUANTITY:

    LEA DX, invalidChoice
    MOV AH, 09H
    INT 21H

    JMP SELECT_SPORT_TYPE

ASK_MORE_ITEMS:
    LEA DX, msgAddMore
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    CMP AL, '1'
    JE SHOW_COURT_MENU

    CMP AL, '2'
    JE CHECKOUT_PROMPT

    LEA DX, invalidChoice
    MOV AH, 09H
    INT 21H
    JMP ASK_MORE_ITEMS

CHECKOUT_PROMPT:
    LEA DX, msgAskCheckout
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    CMP AL, '1'
    JE DO_CHECKOUT
    CMP AL, '2'
    JE EXIT_ADD_ON_FLOW

    LEA DX, invalidChoice
    MOV AH, 09H
    INT 21H
    JMP CHECKOUT_PROMPT

DO_CHECKOUT:
    LEA DX, msgEnterCustName
    MOV AH, 09H
    INT 21H

    LEA DX, custNameBuffer
    MOV AH, 0AH
    INT 21H

    LEA SI, custNameBuffer + 2
    MOV CL, custNameBuffer + 1
    MOV CH, 0
    ADD SI, CX
    MOV BYTE PTR [SI], '$'

    LEA DX, msgEnterCustPhone
    MOV AH, 09H
    INT 21H

    LEA DX, custPhoneBuffer
    MOV AH, 0AH
    INT 21H

    LEA SI, custPhoneBuffer + 2
    MOV CL, custPhoneBuffer + 1
    MOV CH, 0
    ADD SI, CX
    MOV BYTE PTR [SI], '$'

    CALL GENERATE_UNIFIED_INVOICE_ID
    CALL SAVE_TO_DATABASE
    CALL DISPLAY_INVOICE

ASK_PRINT_RECEIPT:
    LEA DX, msgAskReceipt
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    CMP AL, '1'
    JE PRINT_NOW_RECEIPT
    CMP AL, '2'
    JE EXIT_ADD_ON_FLOW

    LEA DX, invalidChoice
    MOV AH, 09H
    INT 21H
    JMP ASK_PRINT_RECEIPT

PRINT_NOW_RECEIPT:
    CALL PRINT_RECEIPT_DETAILS
    LEA DX, pressKeyMsg
    MOV AH, 09H
    INT 21H
    MOV AH, 08H
    INT 21H

EXIT_ADD_ON_FLOW:
    POP CX
    POP SI
    POP DX
    POP AX
    RET

SUB_ADD_ON_PROC ENDP

; =========================================================
; HELPER: ADD ITEM TO CART BUFFER
; =========================================================

ADD_TO_CART PROC

    PUSH AX
    PUSH BX
    PUSH CX
    PUSH SI
    PUSH DI

    ; Check cart capacity
    MOV AL, cartCount
    CMP AL, MAX_CART_ITEMS
    JAE CART_FULL


    ; ---------------------------------------------
    ; Find current cart item address
    ; ---------------------------------------------

    XOR AH, AH

    MOV CL, CART_ITEM_SIZE
    MUL CL

    LEA DI, cartTable
    ADD DI, AX


    ; ---------------------------------------------
    ; Save item name
    ; ---------------------------------------------

    LEA SI, itemNameStr

COPY_NAME_CART:

    MOV AL, [SI]
    MOV [DI], AL

    INC SI
    INC DI

    CMP AL, '$'
    JNE COPY_NAME_CART


    ; ---------------------------------------------
    ; Recalculate current item address
    ; ---------------------------------------------

    MOV AL, cartCount
    XOR AH, AH

    MOV CL, CART_ITEM_SIZE
    MUL CL

    LEA DI, cartTable
    ADD DI, AX


    ; ---------------------------------------------
    ; Save Service Type
    ; Offset 25
    ; ---------------------------------------------

    MOV AL, serviceType
    MOV [DI + 25], AL


    ; ---------------------------------------------
    ; Save Unit Price
    ; Offset 26
    ; ---------------------------------------------

    MOV AL, selectedPrice
    MOV [DI + 26], AL


    ; ---------------------------------------------
    ; Save Quantity
    ; Offset 27
    ; ---------------------------------------------

    MOV AL, selectedQuantity
    MOV [DI + 27], AL


    ; ---------------------------------------------
    ; Save Subtotal
    ; Offset 28
    ; ---------------------------------------------

    MOV AX, selectedSubtotal
    MOV [DI + 28], AX


    ; Increase cart count
    INC cartCount

    JMP CART_DONE


CART_FULL:

    LEA DX, msgCartFull
    MOV AH, 09H
    INT 21H


CART_DONE:

    POP DI
    POP SI
    POP CX
    POP BX
    POP AX

    RET

ADD_TO_CART ENDP

CALCULATE_ITEM_SUBTOTAL PROC

    ; selectedPrice × selectedQuantity
    MOV AL, selectedPrice
    XOR AH, AH

    MOV BL, selectedQuantity
    XOR BH, BH

    MUL BL

    ; AX = selectedPrice × selectedQuantity
    MOV selectedSubtotal, AX

    ; Add subtotal to overall cart/session total
    ADD sessionTotal, AX

    RET

CALCULATE_ITEM_SUBTOTAL ENDP

; =========================================================
; HELPER: SAVE TO MEMORY DATABASE (Complete Cart)
; =========================================================

SAVE_TO_DATABASE PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH SI
    PUSH DI

    MOV AX, dbRecordCount
    CMP AX, MAX_RECORDS
    JGE DB_FULL

    MOV CX, RECORD_SIZE
    MUL CX
    LEA DI, dbTable
    ADD DI, AX

    ; 1. Save Invoice ID Prefix + ID
    MOV BYTE PTR [DI], 'I'
    MOV BYTE PTR [DI+1], 'N'
    MOV BYTE PTR [DI+2], 'V'
    ADD DI, 3

    LEA SI, transIDStr
COPY_ID_LOOP:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    CMP AL, '$'
    JNE COPY_ID_LOOP

    MOV AX, dbRecordCount
    MOV CX, RECORD_SIZE
    MUL CX
    LEA DI, dbTable
    ADD DI, AX

    ; 2. Save Name (+10)
    ADD DI, 10
    LEA SI, custNameBuffer + 2
COPY_NAME_DB:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    CMP AL, '$'
    JNE COPY_NAME_DB

    MOV AX, dbRecordCount
    MOV CX, RECORD_SIZE
    MUL CX
    LEA DI, dbTable
    ADD DI, AX

    ; 3. Save Phone (+30)
    ADD DI, 30
    LEA SI, custPhoneBuffer + 2
COPY_PHONE_DB:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    CMP AL, '$'
    JNE COPY_PHONE_DB

    MOV AX, dbRecordCount
    MOV CX, RECORD_SIZE
    MUL CX
    LEA DI, dbTable
    ADD DI, AX

    ; 4. Save Court (+45)
    ADD DI, 45
    LEA SI, courtIDBuffer + 2
COPY_COURT_DB:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    CMP AL, '$'
    JNE COPY_COURT_DB

    MOV AX, dbRecordCount
    MOV CX, RECORD_SIZE
    MUL CX
    LEA DI, dbTable
    ADD DI, AX

    ; 5. Save Cart Count (+55)
    MOV AL, cartCount
    MOV [DI + 55], AL

    ; 6. Copy Whole Cart Array (+56)
    ADD DI, 56
    LEA SI, cartTable
    XOR CH, CH
    MOV CL, cartCount
    MOV AL, CART_ITEM_SIZE
    MUL CL
    MOV CX, AX
    CMP CX, 0
    JE SAVE_TOTAL_VAL

COPY_CART_TO_DB:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    LOOP COPY_CART_TO_DB

SAVE_TOTAL_VAL:
    MOV AX, dbRecordCount
    MOV CX, RECORD_SIZE
    MUL CX
    LEA DI, dbTable
    ADD DI, AX

    ; 7. Save Total (+210)
    MOV AX, sessionTotal
    MOV [DI + 210], AX

    INC dbRecordCount

DB_FULL:
    POP DI
    POP SI
    POP CX
    POP BX
    POP AX
    RET
SAVE_TO_DATABASE ENDP


; =========================================================
; HELPER: DISPLAY DATABASE RECORDS
; =========================================================

DISPLAY_DATABASE_RECORDS PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

    CMP dbRecordCount, 0
    JNE HAS_RECORDS

    LEA DX, msgNoRecords
    MOV AH, 09H
    INT 21H
    JMP EXIT_VIEW_DB

HAS_RECORDS:
    LEA DX, msgViewHeader
    MOV AH, 09H
    INT 21H

    MOV CX, dbRecordCount
    XOR BX, BX

PRINT_RECORD_LOOP:
    PUSH CX

    MOV AX, BX
    MOV CX, RECORD_SIZE
    MUL CX
    LEA SI, dbTable
    ADD SI, AX

    MOV DX, SI
    MOV AH, 09H
    INT 21H

    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    MOV DL, '|'
    INT 21H
    MOV DL, ' '
    INT 21H

    LEA DX, [SI + 10]
    MOV AH, 09H
    INT 21H

    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    MOV DL, '|'
    INT 21H
    MOV DL, ' '
    INT 21H

    LEA DX, [SI + 45]
    MOV AH, 09H
    INT 21H

    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    MOV DL, '|'
    INT 21H
    MOV DL, ' '
    INT 21H

    MOV AX, [SI + 210]
    CALL PRINT_NUMBER

    MOV DL, 13
    MOV AH, 02H
    INT 21H
    MOV DL, 10
    INT 21H

    INC BX
    POP CX
    LOOP PRINT_RECORD_LOOP

EXIT_VIEW_DB:
    LEA DX, pressKeyMsg
    MOV AH, 09H
    INT 21H
    MOV AH, 08H
    INT 21H

    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DISPLAY_DATABASE_RECORDS ENDP


; =========================================================
; HELPER: PROCESS ITEM DATA
; =========================================================

PROCESS_ITEM_DATA PROC
    PUSH AX
    PUSH SI
    PUSH DI

    CMP selectedSport, 1
    JE PROC_BADMINTON
    CMP selectedSport, 2
    JE PROC_BASKETBALL
    JMP PROC_PICKLEBALL

PROC_BADMINTON:
    CMP selectedItem, 1
    JNE BAD_2
    LEA SI, strBadminton1
    MOV AL, 10
    MOV AH, 50
    JMP SET_PRICE
BAD_2:
    CMP selectedItem, 2
    JNE BAD_3
    LEA SI, strBadminton2
    MOV AL, 5
    MOV AH, 8
    JMP SET_PRICE
BAD_3:
    LEA SI, strBadminton3
    MOV AL, 5
    MOV AH, 12
    JMP SET_PRICE

PROC_BASKETBALL:
    CMP selectedItem, 1
    JNE BASK_2
    LEA SI, strBasketball1
    MOV AL, 10
    MOV AH, 60
    JMP SET_PRICE
BASK_2:
    CMP selectedItem, 2
    JNE BASK_3
    LEA SI, strBasketball2
    MOV AL, 5
    MOV AH, 10
    JMP SET_PRICE
BASK_3:
    LEA SI, strBasketball3
    MOV AL, 3
    MOV AH, 8
    JMP SET_PRICE

PROC_PICKLEBALL:
    CMP selectedItem, 1
    JNE PICK_2
    LEA SI, strPickleball1
    MOV AL, 10
    MOV AH, 45
    JMP SET_PRICE
PICK_2:
    CMP selectedItem, 2
    JNE PICK_3
    LEA SI, strPickleball2
    MOV AL, 5
    MOV AH, 15
    JMP SET_PRICE
PICK_3:
    LEA SI, strPickleball3
    MOV AL, 5
    MOV AH, 8

SET_PRICE:
    CMP serviceType, 1
    JE IS_RENT
    MOV AL, AH
IS_RENT:
    MOV selectedPrice, AL

    LEA DI, itemNameStr
COPY_NAME_LOOP:
    MOV AL, [SI]
    MOV [DI], AL
    CMP AL, '$'
    JE DONE_COPY
    INC SI
    INC DI
    JMP COPY_NAME_LOOP

DONE_COPY:
    POP DI
    POP SI
    POP AX
    RET
PROCESS_ITEM_DATA ENDP


; =========================================================
; HELPER: PRINT NUMBER
; =========================================================

PRINT_NUMBER PROC
    PUSH AX
    PUSH BX
    PUSH DX

    XOR AH, AH
    MOV BL, 10
    DIV BL

    PUSH AX

    CMP AL, 0
    JE SKIP_TENS
    MOV DL, AL
    ADD DL, '0'
    PUSH AX
    MOV AH, 02H
    INT 21H
    POP AX

SKIP_TENS:
    POP AX
    MOV DL, AH
    ADD DL, '0'
    MOV AH, 02H
    INT 21H

    POP DX
    POP BX
    POP AX
    RET
PRINT_NUMBER ENDP


; =========================================================
; HELPER: DISPLAY INVOICE PAGE
; =========================================================

DISPLAY_INVOICE PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

    LEA DX, invoiceHeader
    MOV AH, 09H
    INT 21H

    LEA DX, labelUnifiedInvoiceID
    MOV AH, 09H
    INT 21H

    LEA DX, transIDStr
    MOV AH, 09H
    INT 21H

    LEA DX, invCustName
    MOV AH, 09H
    INT 21H
    LEA DX, custNameBuffer + 2
    MOV AH, 09H
    INT 21H

    LEA DX, invCustPhone
    MOV AH, 09H
    INT 21H
    LEA DX, custPhoneBuffer + 2
    MOV AH, 09H
    INT 21H

    LEA DX, invCourtID
    MOV AH, 09H
    INT 21H
    LEA DX, courtIDBuffer + 2
    MOV AH, 09H
    INT 21H

    LEA DX, invLine
    MOV AH, 09H
    INT 21H

    XOR CH, CH
    MOV CL, cartCount
    CMP CL, 0
    JE PRINT_TOTAL_ONLY

    XOR BX, BX

PRINT_CART_LOOP:
    PUSH CX
    PUSH BX

    MOV AX, BX
    MOV DL, CART_ITEM_SIZE
    MUL DL
    LEA SI, cartTable
    ADD SI, AX

    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    
    POP BX
    PUSH BX
    MOV AX, BX
    INC AX
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H
    
    MOV DL, '.'
    INT 21H
    MOV DL, ' '
    INT 21H

    MOV DX, SI
    MOV AH, 09H
    INT 21H

    MOV AL, [SI + 25]
    CMP AL, 1
    JE PRINT_CART_RENT

    LEA DX, invBuyPrefix
    MOV AH, 09H
    INT 21H
    JMP PRINT_CART_PRICE

PRINT_CART_RENT:
    LEA DX, invRentPrefix
    MOV AH, 09H
    INT 21H

PRINT_CART_PRICE:
    XOR AX, AX
    MOV AL, [SI + 26]
    CALL PRINT_NUMBER

    LEA DX, invCloseParen
    MOV AH, 09H
    INT 21H

    MOV DL, 13
    MOV AH, 02H
    INT 21H
    MOV DL, 10
    INT 21H

    POP BX
    INC BX
    POP CX
    LOOP PRINT_CART_LOOP

PRINT_TOTAL_ONLY:
    LEA DX, invTotalLabel
    MOV AH, 09H
    INT 21H

    
    MOV AX, sessionTotal
    CALL PRINT_NUMBER
    MOV DL, 13
    MOV AH, 02H
    INT 21H
    MOV DL, 10
    INT 21H

    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DISPLAY_INVOICE ENDP


; =========================================================
; MODULE: SUMMARY REPORT
; =========================================================
MODULE_SUMMARY_REPORT PROC
    PUSH AX
    PUSH DX

SHOW_SUMMARY_MENU:
    LEA DX, summaryMenuMsg
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    CMP AL, '1'
    JE VIEW_MONTHLY_REPORT

    CMP AL, '2'
    JE VIEW_PROFIT_REPORT

    CMP AL, '3'
    JE EXIT_SUMMARY_MODULE

    LEA DX, invalidChoice
    MOV AH, 09H
    INT 21H
    JMP SHOW_SUMMARY_MENU

VIEW_MONTHLY_REPORT:
    LEA DX, rptMonthlyMsg
    MOV AH, 09H
    INT 21H

    LEA DX, pressKeyReturn
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    JMP SHOW_SUMMARY_MENU

VIEW_PROFIT_REPORT:
    LEA DX, rptProfitMsg
    MOV AH, 09H
    INT 21H

    LEA DX, pressKeyReturn
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    JMP SHOW_SUMMARY_MENU

EXIT_SUMMARY_MODULE:
    POP DX
    POP AX
    RET
MODULE_SUMMARY_REPORT ENDP


; =========================================================
; MODULE: SETTINGS
; =========================================================
MODULE_SETTINGS PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI

SHOW_SETTINGS_MENU:
    LEA DX, settingsMenuMsg
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    CMP AL, '1'
    JE CHANGE_USERNAME

    CMP AL, '2'
    JE CHANGE_PASSWORD

    CMP AL, '3'
    JE EXIT_SETTINGS_MODULE

    LEA DX, invalidChoice
    MOV AH, 09H
    INT 21H
    JMP SHOW_SETTINGS_MENU

CHANGE_USERNAME:
    LEA DX, newUsrPrompt
    MOV AH, 09H
    INT 21H

    LEA DX, newInputBuf
    MOV AH, 0AH
    INT 21H

    LEA SI, newInputBuf + 2
    LEA DI, correctUsername
    MOV CL, newInputBuf + 1
    MOV usrLength, CL
    MOV CH, 0

COPY_USR_LOOP:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    LOOP COPY_USR_LOOP

    LEA DX, usrUpdatedMsg
    MOV AH, 09H
    INT 21H

    LEA DX, pressKeyReturn
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    JMP SHOW_SETTINGS_MENU

CHANGE_PASSWORD:
    LEA DX, newPwdPrompt
    MOV AH, 09H
    INT 21H

    LEA DX, newInputBuf
    MOV AH, 0AH
    INT 21H

    LEA SI, newInputBuf + 2
    LEA DI, correctPassword
    MOV CL, newInputBuf + 1
    MOV pwdLength, CL
    MOV CH, 0

COPY_PWD_LOOP:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    LOOP COPY_PWD_LOOP

    LEA DX, pwdUpdatedMsg
    MOV AH, 09H
    INT 21H

    LEA DX, pressKeyReturn
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    JMP SHOW_SETTINGS_MENU

EXIT_SETTINGS_MODULE:
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
MODULE_SETTINGS ENDP

; =========================================================
; DO BOOKING FUNCTIONS (COMBINED MODULE)
; =========================================================

SELECT_SPORT_BOOKING PROC

SELECT_SPORT_RETRY:

    LEA DX, msgTypesOfSports
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    ; 9 = Cancel
    CMP AL, '9'
    JE CANCEL_SPORT

    ; Must be 1-8
    CMP AL, '1'
    JB INVALID_SPORT

    CMP AL, '8'
    JA INVALID_SPORT

    ; ASCII -> number
    SUB AL, '0'
    MOV VAR_SPORT_TYPE, AL

    ; -----------------------------------------------------
    ; Set price per hour
    ; -----------------------------------------------------

    CMP AL, 1
    JE PRICE_BADMINTON

    CMP AL, 2
    JE PRICE_VOLLEYBALL

    CMP AL, 3
    JE PRICE_BASKETBALL

    CMP AL, 4
    JE PRICE_FUTSAL

    CMP AL, 5
    JE PRICE_TENNIS

    CMP AL, 6
    JE PRICE_TABLE_TENNIS

    CMP AL, 7
    JE PRICE_SQUASH

    CMP AL, 8
    JE PRICE_NETBALL


; ---------------------------------------------------------
; Prices
; ---------------------------------------------------------

PRICE_BADMINTON:
    MOV VAL_PRICE_PER_H, 10
    JMP SAVE_COURT_COUNT


PRICE_VOLLEYBALL:
    MOV VAL_PRICE_PER_H, 20
    JMP SAVE_COURT_COUNT


PRICE_BASKETBALL:
    MOV VAL_PRICE_PER_H, 25
    JMP SAVE_COURT_COUNT


PRICE_FUTSAL:
    MOV VAL_PRICE_PER_H, 40
    JMP SAVE_COURT_COUNT


PRICE_TENNIS:
    MOV VAL_PRICE_PER_H, 15
    JMP SAVE_COURT_COUNT


PRICE_TABLE_TENNIS:
    MOV VAL_PRICE_PER_H, 8
    JMP SAVE_COURT_COUNT


PRICE_SQUASH:
    MOV VAL_PRICE_PER_H, 12
    JMP SAVE_COURT_COUNT


PRICE_NETBALL:
    MOV VAL_PRICE_PER_H, 20
    JMP SAVE_COURT_COUNT


; ---------------------------------------------------------
; Get number of courts for selected sport
; ---------------------------------------------------------

SAVE_COURT_COUNT:

    XOR BX, BX

    MOV BL, VAR_SPORT_TYPE
    DEC BL

    MOV AL, COURT_COUNT[BX]
    MOV VAR_COURT_COUNT, AL

    RET


; ---------------------------------------------------------
; Cancel
; ---------------------------------------------------------

CANCEL_SPORT:

    MOV VAR_BOOKING_CANCELLED, 1
    RET


; ---------------------------------------------------------
; Invalid input
; ---------------------------------------------------------

INVALID_SPORT:

    LEA DX, invalidChoice
    MOV AH, 09H
    INT 21H

    JMP SELECT_SPORT_RETRY

SELECT_SPORT_BOOKING ENDP


; =========================================================
; 选择球场 (提示最大 Court 数量)
; =========================================================

SELECT_COURT_BOOKING PROC
RETRY_COURT_INPUT:
    ; 提示信息：Enter Court Number (1 - X): 
    LEA DX, msgSelectCourtPrompt   ; "Enter Court Number: $"
    MOV AH, 09H
    INT 21H

    ; 提示当前 Sport 最多有多少个 Court 可选
    MOV DL, '('
    MOV AH, 02H
    INT 21H
    MOV DL, '1'
    INT 21H
    MOV DL, '-'
    INT 21H
    MOV DL, VAR_COURT_COUNT
    ADD DL, '0'
    INT 21H
    MOV DL, ')'
    INT 21H
    MOV DL, ':'
    INT 21H
    MOV DL, ' '
    INT 21H

    MOV AH, 01H
    INT 21H

    SUB AL, '0'
    CMP AL, 1
    JB INVALID_CRT
    CMP AL, VAR_COURT_COUNT
    JA INVALID_CRT

    MOV VAR_COURT_CHOICE, AL
    RET

INVALID_CRT:
    LEA DX, msgInvalidCourt
    MOV AH, 09H
    INT 21H
    JMP RETRY_COURT_INPUT
SELECT_COURT_BOOKING ENDP


; =========================================================
; 选择时间段 (修复 10 的两字符读取与输入判断)
; =========================================================

GET_SLOT_INPUT PROC
ASK_SLOT:
    LEA DX, msgSelectSlotPrompt
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    ; 判断是否输入的是 '1'
    CMP AL, '1'
    JNE CHECK_SINGLE_DIGIT
    
    ; 如果第一个数字是 '1'，尝试读第二个字符 (判断是不是 10)
    MOV AH, 01H
    INT 21H
    CMP AL, '0'
    JE IS_SLOT_10
    CMP AL, 13                  ; 如果直接按了 Enter
    JE IS_SLOT_1

    ; 输入了 1X (X != 0)，非法
    JMP INVALID_SLOT_ERR

IS_SLOT_1:
    MOV VAR_SLOT_CHOICE, 1
    JMP CHECK_AVAILABILITY

IS_SLOT_10:
    MOV VAR_SLOT_CHOICE, 10
    JMP CHECK_AVAILABILITY

CHECK_SINGLE_DIGIT:
    SUB AL, '0'
    CMP AL, 2
    JB INVALID_SLOT_ERR
    CMP AL, 9
    JA INVALID_SLOT_ERR
    MOV VAR_SLOT_CHOICE, AL

CHECK_AVAILABILITY:
    MOV AL, VAR_COURT_CHOICE
    MOV TEMP_COURT_NUM, AL
    MOV AL, VAR_SLOT_CHOICE
    MOV TEMP_SLOT_NUM, AL
    CALL CALC_AVAIL_INDEX

    MOV SI, TEMP_BASE_INDEX
    CMP COURT_AVAIL[SI], 0
    JE SLOT_OK

    LEA DX, msgSlotTaken
    MOV AH, 09H
    INT 21H
    JMP ASK_SLOT

SLOT_OK:
    RET

INVALID_SLOT_ERR:
    LEA DX, msgInvalidSlot
    MOV AH, 09H
    INT 21H
    JMP ASK_SLOT
GET_SLOT_INPUT ENDP


SHOW_COURT_AVAILABILITY PROC
    LEA DX, MSG_AV_TITLE
    MOV AH, 09H
    INT 21H

    LEA DX, MSG_COURT_CHOSEN_HDR
    MOV AH, 09H
    INT 21H

    MOV DL, VAR_COURT_CHOICE
    ADD DL, '0'
    MOV AH, 02H
    INT 21H

    ; --- 强制换行（修复 Slot 1 飞上去的问题）---
    MOV DL, 13
    MOV AH, 02H
    INT 21H
    MOV DL, 10
    INT 21H
    ; --------------------------------------

    MOV TEMP_SLOT_NUM, 1
SHOW_SLOTS_LOOP:
    MOV AL, TEMP_SLOT_NUM
    CMP AL, 10
    JA END_GRID

    LEA DX, SLOT_BRACKET_OPEN
    MOV AH, 09H
    INT 21H

    MOV AX, WORD PTR TEMP_SLOT_NUM
    CALL PRINT_NUMBER

    LEA DX, SLOT_BRACKET_CLOSE
    MOV AH, 09H
    INT 21H

    ; 输出时段文本 (SL1-SL10)
    XOR BX, BX
    MOV BL, TEMP_SLOT_NUM
    DEC BL
    SHL BX, 1
    MOV DX, SLOT_LONG_TBL[BX]
    MOV AH, 09H
    INT 21H

    MOV DL, ' '
    MOV AH, 02H
    INT 21H

    ; 计算 Slot 状态
    MOV AL, VAR_COURT_CHOICE
    MOV TEMP_COURT_NUM, AL
    CALL CALC_AVAIL_INDEX
    MOV SI, TEMP_BASE_INDEX

    CMP COURT_AVAIL[SI], 0
    JE DISP_FREE
    LEA DX, TXT_BK
    JMP DISP_STATUS
DISP_FREE:
    LEA DX, TXT_AV
DISP_STATUS:
    MOV AH, 09H
    INT 21H

    MOV DL, 13
    MOV AH, 02H
    INT 21H
    MOV DL, 10
    INT 21H

    INC TEMP_SLOT_NUM
    JMP SHOW_SLOTS_LOOP

END_GRID:
    RET
SHOW_COURT_AVAILABILITY ENDP


CALC_AVAIL_INDEX PROC
    XOR AX, AX
    MOV AL, VAR_SPORT_TYPE
    DEC AL
    MOV CX, 60
    MUL CX
    MOV BX, AX

    XOR AX, AX
    MOV AL, TEMP_COURT_NUM
    DEC AL
    MOV CX, 10
    MUL CX
    ADD BX, AX

    XOR AX, AX
    MOV AL, TEMP_SLOT_NUM
    DEC AL
    ADD BX, AX

    MOV TEMP_BASE_INDEX, BX
    RET
CALC_AVAIL_INDEX ENDP


CALC_FEES PROC

    ; ---------------------------------------------
    ; Price per hour is stored as RM
    ; Convert to cents
    ; Example: RM10 × 100 = 1000 cents
    ; ---------------------------------------------

    MOV AX, VAL_PRICE_PER_H

    MOV BX, 100
    MUL BX

    MOV VAL_BASE_FEE, AX


    ; ---------------------------------------------
    ; Service Tax = Base Fee × 6%
    ; ---------------------------------------------

    MOV AX, VAL_BASE_FEE

    MOV BX, 6
    MUL BX

    MOV BX, 100
    DIV BX

    MOV VAL_TAX, AX


    ; ---------------------------------------------
    ; Grand Total
    ; ---------------------------------------------

    MOV AX, VAL_BASE_FEE
    ADD AX, VAL_TAX

    MOV VAL_GRAND_TOTAL, AX

    RET

CALC_FEES ENDP

PRINT_MONEY PROC

    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    XOR DX, DX
    MOV BX, 100
    DIV BX

    ; AX = Ringgit
    ; DX = cents

    PUSH DX

    CALL PRINT_NUMBER

    MOV DL, '.'
    MOV AH, 02H
    INT 21H

    POP AX

    CMP AX, 10
    JAE PRINT_TWO_DIGIT_CENTS

    MOV DL, '0'
    MOV AH, 02H
    INT 21H

PRINT_TWO_DIGIT_CENTS:

    CALL PRINT_NUMBER

    POP DX
    POP CX
    POP BX
    POP AX

    RET

PRINT_MONEY ENDP

SHOW_SELECTED_BOOKING PROC

    PUSH AX
    PUSH BX
    PUSH DX


    ; =============================================
    ; Header
    ; =============================================

    LEA DX, SELECTED_BOOKING_HEADER
    MOV AH, 09H
    INT 21H


    ; =============================================
    ; Sport Type
    ; =============================================

    LEA DX, SEL_SPORT_MSG
    MOV AH, 09H
    INT 21H

    XOR BX, BX
    MOV BL, VAR_SPORT_TYPE
    DEC BL
    SHL BX, 1

    MOV DX, SPORT_NAME_TBL[BX]
    MOV AH, 09H
    INT 21H

    MOV DL, 13
    MOV AH, 02H
    INT 21H

    MOV DL, 10
    INT 21H


    ; =============================================
    ; Court
    ; =============================================

    LEA DX, SEL_COURT_MSG
    MOV AH, 09H
    INT 21H

    MOV DL, VAR_COURT_CHOICE
    ADD DL, '0'
    MOV AH, 02H
    INT 21H

    MOV DL, 13
    INT 21H

    MOV DL, 10
    INT 21H


    ; =============================================
    ; Date
    ; =============================================

    LEA DX, SEL_DATE_MSG
    MOV AH, 09H
    INT 21H

    LEA DX, BOOKING_DATE
    MOV AH, 09H
    INT 21H

    MOV DL, 13
    MOV AH, 02H
    INT 21H

    MOV DL, 10
    INT 21H


    ; =============================================
    ; Time
    ; =============================================

    LEA DX, SEL_TIME_MSG
    MOV AH, 09H
    INT 21H

    XOR BX, BX
    MOV BL, VAR_SLOT_CHOICE
    DEC BL
    SHL BX, 1

    MOV DX, SLOT_LONG_TBL[BX]
    MOV AH, 09H
    INT 21H

    MOV DL, 13
    MOV AH, 02H
    INT 21H

    MOV DL, 10
    INT 21H


    ; =============================================
    ; Status
    ; =============================================

    LEA DX, SEL_STATUS_MSG
    MOV AH, 09H
    INT 21H

    LEA DX, BOOKING_STATUS
    MOV AH, 09H
    INT 21H

    MOV DL, 13
    MOV AH, 02H
    INT 21H

    MOV DL, 10
    INT 21H


    POP DX
    POP BX
    POP AX

    RET

SHOW_SELECTED_BOOKING ENDP


CONFIRM_BOOKING PROC

ASK_CONFIRM:

    LEA DX, SEL_CONFIRM_MSG
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    AND AL, 0DFH

    CMP AL, 'Y'
    JE DO_CONFIRM

    CMP AL, 'N'
    JE DO_CANCEL

    JMP ASK_CONFIRM


DO_CANCEL:

    LEA DX, msgBookingCancel
    MOV AH, 09H
    INT 21H

    MOV VAR_BOOKING_CANCELLED, 1

    RET


DO_CONFIRM:

    MOV AL, VAR_COURT_CHOICE
    MOV TEMP_COURT_NUM, AL

    MOV AL, VAR_SLOT_CHOICE
    MOV TEMP_SLOT_NUM, AL

    CALL CALC_AVAIL_INDEX

    MOV SI, TEMP_BASE_INDEX
    MOV COURT_AVAIL[SI], 1

    CALL GENERATE_BOOKING_INVOICE_ID
    CALL GENERATE_BOOKING_ID

    CALL SAVE_BOOKING_RECORD

    CALL PRINT_BOOKING_INVOICE


    ; =============================================
    ; Wait for ENTER
    ; =============================================

    LEA DX, PROMPT_RECEIPT
    MOV AH, 09H
    INT 21H


WAIT_ENTER_KEY:

    MOV AH, 01H
    INT 21H

    CMP AL, 13
    JNE WAIT_ENTER_KEY


    ; =============================================
    ; Generate Receipt
    ; =============================================

    CALL GENERATE_RECEIPT_ID

    CALL PRINT_BOOKING_RECEIPT


    RET

CONFIRM_BOOKING ENDP

SAVE_BOOKING_RECORD PROC

    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI


    MOV AX, bookingRecordCount
    CMP AX, MAX_BOOKING_RECORDS
    JAE SAVE_BOOKING_DONE


    MOV CX, BOOKING_RECORD_SIZE
    MUL CX

    LEA DI, bookingTable
    ADD DI, AX


    ; ---------------------------------------------
    ; Invoice ID
    ; ---------------------------------------------

    LEA SI, BOOKING_INVOICE_ID

COPY_BINV_ID:

    MOV AL, [SI]
    MOV [DI], AL

    INC SI
    INC DI

    CMP AL, '$'
    JNE COPY_BINV_ID


    ; ---------------------------------------------
    ; Booking ID
    ; ---------------------------------------------

    MOV AX, bookingRecordCount
    MOV CX, BOOKING_RECORD_SIZE
    MUL CX

    LEA DI, bookingTable
    ADD DI, AX

    ADD DI, 10

    LEA SI, BOOKING_ID_STR

COPY_BK_ID:

    MOV AL, [SI]
    MOV [DI], AL

    INC SI
    INC DI

    CMP AL, '$'
    JNE COPY_BK_ID


    ; ---------------------------------------------
    ; Total
    ; ---------------------------------------------

    MOV AX, bookingRecordCount
    MOV CX, BOOKING_RECORD_SIZE
    MUL CX

    LEA DI, bookingTable
    ADD DI, AX

    MOV AX, VAL_GRAND_TOTAL
    MOV [DI + 90], AX


    INC bookingRecordCount


SAVE_BOOKING_DONE:

    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX

    RET

SAVE_BOOKING_RECORD ENDP

GENERATE_BOOKING_INVOICE_ID PROC

    PUSH AX
    PUSH BX
    PUSH DX

    MOV AX, INVOICE_COUNTER

    MOV BL, 100
    DIV BL

    ADD AL, '0'
    MOV BOOKING_INVOICE_ID, AL

    MOV AL, AH
    XOR AH, AH

    MOV BL, 10
    DIV BL

    ADD AL, '0'
    MOV BOOKING_INVOICE_ID + 1, AL

    ADD AH, '0'
    MOV BOOKING_INVOICE_ID + 2, AH

    INC INVOICE_COUNTER

    POP DX
    POP BX
    POP AX

    RET

GENERATE_BOOKING_INVOICE_ID ENDP

GENERATE_BOOKING_ID PROC

    PUSH AX
    PUSH BX
    PUSH DX

    MOV AX, BOOKING_COUNTER

    MOV BX, 1000
    XOR DX, DX
    DIV BX

    ADD AL, '0'
    MOV BOOKING_ID_STR, AL

    MOV AX, BOOKING_COUNTER
    MOV BX, 100
    XOR DX, DX
    DIV BX

    ADD AL, '0'
    MOV BOOKING_ID_STR + 1, AL

    MOV AX, BOOKING_COUNTER
    MOV BX, 10
    XOR DX, DX
    DIV BX

    ADD AL, '0'
    MOV BOOKING_ID_STR + 2, AL

    MOV AX, BOOKING_COUNTER
    MOV BX, 10
    XOR DX, DX
    DIV BX

    ADD DL, '0'
    MOV BOOKING_ID_STR + 3, DL

    MOV BYTE PTR BOOKING_ID_STR + 4, '$'

    INC BOOKING_COUNTER

    POP DX
    POP BX
    POP AX

    RET

GENERATE_BOOKING_ID ENDP

GENERATE_RECEIPT_ID PROC

    PUSH AX
    PUSH BX
    PUSH DX

    MOV AX, RECEIPT_COUNTER

    MOV BL, 100
    DIV BL

    ADD AL, '0'
    MOV BOOKING_RECEIPT_ID, AL

    MOV AL, AH
    XOR AH, AH

    MOV BL, 10
    DIV BL

    ADD AL, '0'
    MOV BOOKING_RECEIPT_ID + 1, AL

    ADD AH, '0'
    MOV BOOKING_RECEIPT_ID + 2, AH

    INC RECEIPT_COUNTER

    POP DX
    POP BX
    POP AX

    RET

GENERATE_RECEIPT_ID ENDP

GENERATE_UNIFIED_INVOICE_ID PROC

    PUSH AX
    PUSH BX
    PUSH DX

    MOV AX, INVOICE_COUNTER

    MOV BL, 100
    DIV BL

    ADD AL, '0'
    MOV transIDStr, AL

    MOV AL, AH
    XOR AH, AH

    MOV BL, 10
    DIV BL

    ADD AL, '0'
    MOV transIDStr + 1, AL

    ADD AH, '0'
    MOV transIDStr + 2, AH

    MOV BYTE PTR transIDStr + 3, '$'

    INC INVOICE_COUNTER

    POP DX
    POP BX
    POP AX

    RET

GENERATE_UNIFIED_INVOICE_ID ENDP

; =========================================================
; 补全 1: 打印预订发票
; =========================================================
PRINT_BOOKING_INVOICE PROC

    PUSH AX
    PUSH BX
    PUSH DX


    LEA DX, BOOKING_INVOICE_HEADER
    MOV AH, 09H
    INT 21H


    ; Invoice ID
    LEA DX, INV_ID_MSG
    MOV AH, 09H
    INT 21H

    LEA DX, BOOKING_INVOICE_ID
    MOV AH, 09H
    INT 21H

    CALL NEWLINE


    ; Booking ID
    LEA DX, BOOKING_ID_MSG
    MOV AH, 09H
    INT 21H

    LEA DX, BOOKING_ID_STR
    MOV AH, 09H
    INT 21H

    CALL NEWLINE


    ; Sport
    LEA DX, INV_SPORT_MSG
    MOV AH, 09H
    INT 21H

    XOR BX, BX
    MOV BL, VAR_SPORT_TYPE
    DEC BL
    SHL BX, 1

    MOV DX, SPORT_NAME_TBL[BX]
    MOV AH, 09H
    INT 21H

    CALL NEWLINE


    ; Court
    LEA DX, INV_COURT_MSG
    MOV AH, 09H
    INT 21H

    MOV DL, VAR_COURT_CHOICE
    ADD DL, '0'
    MOV AH, 02H
    INT 21H

    CALL NEWLINE


    ; Date
    LEA DX, INV_DATE_MSG
    MOV AH, 09H
    INT 21H

    LEA DX, BOOKING_DATE
    MOV AH, 09H
    INT 21H

    CALL NEWLINE


    ; Time
    LEA DX, INV_TIME_MSG
    MOV AH, 09H
    INT 21H

    XOR BX, BX
    MOV BL, VAR_SLOT_CHOICE
    DEC BL
    SHL BX, 1

    MOV DX, SLOT_LONG_TBL[BX]
    MOV AH, 09H
    INT 21H

    CALL NEWLINE


    ; Base Fee
    LEA DX, INV_BASE_MSG
    MOV AH, 09H
    INT 21H

    MOV AX, VAL_BASE_FEE
    CALL PRINT_MONEY

    CALL NEWLINE


    ; Discount
    LEA DX, INV_DISCOUNT_MSG
    MOV AH, 09H
    INT 21H

    MOV AX, VAL_DISCOUNT
    CALL PRINT_MONEY

    CALL NEWLINE


    ; Tax
    LEA DX, INV_TAX_MSG
    MOV AH, 09H
    INT 21H

    MOV AX, VAL_TAX
    CALL PRINT_MONEY

    CALL NEWLINE


    ; Grand Total
    LEA DX, INV_TOTAL_MSG
    MOV AH, 09H
    INT 21H

    MOV AX, VAL_GRAND_TOTAL
    CALL PRINT_MONEY

    CALL NEWLINE


    LEA DX, BOOKING_INVOICE_FOOTER
    MOV AH, 09H
    INT 21H


    POP DX
    POP BX
    POP AX

    RET

PRINT_BOOKING_INVOICE ENDP


; =========================================================
; 补全 2: 打印预订收据
; =========================================================
PRINT_BOOKING_RECEIPT PROC

    PUSH AX
    PUSH BX
    PUSH DX


    LEA DX, BOOKING_RECEIPT_HEADER
    MOV AH, 09H
    INT 21H


    ; Receipt ID
    LEA DX, REC_ID_MSG
    MOV AH, 09H
    INT 21H

    LEA DX, BOOKING_RECEIPT_ID
    MOV AH, 09H
    INT 21H

    CALL NEWLINE


    ; Booking ID
    LEA DX, REC_BOOKING_ID_MSG
    MOV AH, 09H
    INT 21H

    LEA DX, BOOKING_ID_STR
    MOV AH, 09H
    INT 21H

    CALL NEWLINE


    ; Sport
    LEA DX, REC_SPORT_MSG
    MOV AH, 09H
    INT 21H

    XOR BX, BX
    MOV BL, VAR_SPORT_TYPE
    DEC BL
    SHL BX, 1

    MOV DX, SPORT_NAME_TBL[BX]
    MOV AH, 09H
    INT 21H

    CALL NEWLINE


    ; Court
    LEA DX, REC_COURT_MSG
    MOV AH, 09H
    INT 21H

    MOV DL, VAR_COURT_CHOICE
    ADD DL, '0'
    MOV AH, 02H
    INT 21H

    CALL NEWLINE


    ; Date
    LEA DX, REC_DATE_MSG
    MOV AH, 09H
    INT 21H

    LEA DX, BOOKING_DATE
    MOV AH, 09H
    INT 21H

    CALL NEWLINE


    ; Time
    LEA DX, REC_TIME_MSG
    MOV AH, 09H
    INT 21H

    XOR BX, BX
    MOV BL, VAR_SLOT_CHOICE
    DEC BL
    SHL BX, 1

    MOV DX, SLOT_LONG_TBL[BX]
    MOV AH, 09H
    INT 21H

    CALL NEWLINE


    ; Amount
    LEA DX, REC_AMOUNT_MSG
    MOV AH, 09H
    INT 21H

    MOV AX, VAL_GRAND_TOTAL
    CALL PRINT_MONEY

    CALL NEWLINE


    LEA DX, REC_STATUS_MSG
    MOV AH, 09H
    INT 21H

    LEA DX, REC_LINE
    MOV AH, 09H
    INT 21H

    LEA DX, REC_CONFIRMED_MSG
    MOV AH, 09H
    INT 21H


    MOV AH, 08H
    INT 21H


    POP DX
    POP BX
    POP AX

    RET

PRINT_BOOKING_RECEIPT ENDP

NEWLINE PROC

    PUSH AX
    PUSH DX

    MOV DL, 13
    MOV AH, 02H
    INT 21H

    MOV DL, 10
    INT 21H

    POP DX
    POP AX

    RET

NEWLINE ENDP

END MAIN