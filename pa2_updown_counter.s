 .global _start

//BASE ADDRESSES //
        .equ HEX3_0_BASE, 0xFF200020
        .equ SW_BASE,     0xFF200040
        .equ KEY_BASE,    0xFF200050

// CONSTANTS //
        .equ TIMER_START, 400000

//START//
_start:
        LDR     SP, =0xFFFFFF00

        MOV     R0, #0              //counter 0–59 //
        MOV     R1, #0              //run flag //
        MOV     R7, #1              // last KEY0 state //
        LDR     R6, =TIMER_START

        BL      UPDATE_DISPLAY

//MAIN LOOP //
MAIN_LOOP:
//READ SWITCHES//
        LDR     R3, =SW_BASE
        LDR     R4, [R3]

  

        //READ KEY0 (START / STOP) //
        LDR     R3, =KEY_BASE
        LDR     R5, [R3]
        AND     R5, R5, #1

        CMP     R5, #0
        BNE     SAVE_KEY
        CMP     R7, #1
        BNE     SAVE_KEY
        EOR     R1, R1, #1           // toggle run//

SAVE_KEY:
        MOV     R7, R5

       //KEY1 RESET //
        LDR     R5, [R3]
        TST     R5, #2
        BEQ     CHECK_RUN
        MOV     R0, #0
        BL      UPDATE_DISPLAY

CHECK_RUN:
        CMP     R1, #0
        BEQ     MAIN_LOOP
        B       TIMER


// TIMER DELAY //
TIMER:
        SUBS    R6, R6, #1
        BNE     MAIN_LOOP
        LDR     R6, =TIMER_START

       // DIRECTION CONTROL //
        LDR     R3, =SW_BASE
        LDR     R4, [R3]

       //SW2 has priority //
        TST     R4, #4
        BNE     COUNT_DOWN

   //SW0 normal mode //
        TST     R4, #1
        BNE     COUNT_DOWN

COUNT_UP:
        ADD     R0, R0, #1
        CMP     R0, #60
        BLT     SHOW
        MOV     R0, #0
        B       SHOW

COUNT_DOWN:
        SUBS    R0, R0, #1
        BGE     SHOW
        MOV     R0, #59

SHOW:
        BL      UPDATE_DISPLAY
        B       MAIN_LOOP

//DISPLAY SUBROUTINE //
UPDATE_DISPLAY:
        PUSH    {R3-R5, R8-R10, LR}

        MOV     R3, R0
        MOV     R4, #0

DIV10:
        CMP     R3, #10
        BLT     DONE
        SUB     R3, R3, #10
        ADD     R4, R4, #1
        B       DIV10

DONE:
        MOV     R5, R3

        LDR     R8, =SEG
        LDR     R9, [R8, R4, LSL #2]
        LSL     R9, R9, #8
        LDR     R10, [R8, R5, LSL #2]
        ORR     R9, R9, R10

        LDR     R3, =HEX3_0_BASE
        STR     R9, [R3]

        POP     {R3-R5, R8-R10, PC}

//7-SEG TABLE //
        .align 2
SEG:
        .word 0x3F,0x06,0x5B,0x4F
        .word 0x66,0x6D,0x7D,0x07
        .word 0x7F,0x6F
