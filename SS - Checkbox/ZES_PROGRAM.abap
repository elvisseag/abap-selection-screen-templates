REPORT zes_program.

* {
" Mostrar u Ocultar segun selección de campo checkbox
* }

"-- SEL --------------------------------------------------------------------------

SELECTION-SCREEN: BEGIN OF BLOCK b_01 WITH FRAME TITLE text-t01.
"{
PARAMETERS: p_cmn TYPE c AS CHECKBOX USER-COMMAND rv.

SELECTION-SCREEN: BEGIN OF BLOCK b_02 WITH FRAME TITLE text-t02.
PARAMETERS: p_param1 TYPE char20 MODIF ID mo1,
            p_param2 TYPE char20 MODIF ID mo1,
            p_param3 TYPE char20 MODIF ID mo1.
SELECTION-SCREEN:END OF BLOCK b_02.

PARAMETERS: p_cmv TYPE c AS CHECKBOX USER-COMMAND rv.
SELECTION-SCREEN FUNCTION KEY 1.
SELECTION-SCREEN: BEGIN OF BLOCK b03 WITH FRAME TITLE text-t03.
PARAMETERS: p_param4 TYPE char20 MODIF ID mo2.
SELECTION-SCREEN: END OF BLOCK b03.
"}
SELECTION-SCREEN:END OF BLOCK b_01.

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.
    CASE screen-group1.
      WHEN 'MO1'.
        IF p_cmn EQ 'X'.
          MOVE 1 TO screen-active.
        ELSE.
          MOVE 0 TO screen-active.
        ENDIF.
      WHEN 'MO2'.
        IF p_cmv EQ 'X'.
          MOVE 1 TO screen-active.
        ELSE.
          MOVE 0 TO screen-active.
        ENDIF.
    ENDCASE.
    MODIFY SCREEN.
  ENDLOOP.