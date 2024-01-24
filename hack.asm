HELD_BUTTONS        equ     $ff90
BIT_BUTTON_UP       equ     6
BIT_BUTTON_DOWN     equ     7

BIT_BUTTON_HEADS    equ     BIT_BUTTON_UP
BIT_BUTTON_TAILS    equ     BIT_BUTTON_DOWN

VALUE_HEADS         equ     $00
VALUE_TAILS         equ     $ff


SECTION "my_code", ROM0[$0061]
my_code::
        ; replace original instruction
        call    $0866

        push    de
        ld      d, a

        ldh     a, [HELD_BUTTONS]
.check_for_heads_button
        bit     BIT_BUTTON_HEADS, a
        jr      nz, .have_heads_button
.check_for_tails_button
        bit     BIT_BUTTON_TAILS, a
        jr      z, .do_nothing
.have_tails_button
        ld      a, VALUE_TAILS
        jr      .end
.have_heads_button
        ld      a, VALUE_HEADS
        jr      .end
.do_nothing
        ld      a, d
.end
        pop     de
        ret


SECTION "cointoss", ROMX[$65ba], BANK[9]
        call    my_code
