REPORT zes_program LINE-SIZE 1023.

TABLES: sscrfields.

SELECTION-SCREEN FUNCTION KEY 1.

SELECTION-SCREEN BEGIN OF BLOCK block1 WITH FRAME TITLE text-b01.

PARAMETERS: p_param1 RADIOBUTTON GROUP crud USER-COMMAND r DEFAULT 'X',
            p_param2 RADIOBUTTON GROUP crud,
            p_param3 RADIOBUTTON GROUP crud,
            p_param4 RADIOBUTTON GROUP crud,
            p_param5 RADIOBUTTON GROUP crud.

SELECTION-SCREEN SKIP. "Linea en blanco

PARAMETERS: p_field1 TYPE CHAR20 MODIF ID g1.

SELECTION-SCREEN SKIP.

PARAMETERS: p_field2 TYPE CHAR20 MODIF ID g2,
            p_field3 TYPE CHAR20 MODIF ID g3.

SELECTION-SCREEN SKIP.

PARAMETERS: p_field4 TYPE dats DEFAULT sy-datum MODIF ID g4,
            p_field5 TYPE CHAR20 MODIF ID g5.


SELECTION-SCREEN END OF BLOCK block1.

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.
    CASE abap_true.
      WHEN p_param1.
        PERFORM all_screen_visible USING 1 0 0 0 0.
      WHEN p_param2.
        PERFORM all_screen_visible USING 1 1 0 0 0.
      WHEN p_param3.
        PERFORM all_screen_visible USING 1 1 1 0 0.
      WHEN p_param4.
        PERFORM all_screen_visible USING 1 1 1 1 0.
      WHEN p_param5.
        PERFORM all_screen_visible USING 1 1 1 1 1.
      WHEN OTHERS.
        PERFORM all_screen_visible USING 1 1 1 1 1.
    ENDCASE.
  ENDLOOP.


FORM all_screen_visible USING p1 p2 p3 p4 p5.

  IF screen-group1 = 'G1'.
    screen-active = p1.
    MODIFY SCREEN.
  ENDIF.
  IF screen-group1 = 'G2'.
    screen-active = p2.
    MODIFY SCREEN.
  ENDIF.
  IF screen-group1 = 'G3'.
    screen-active = p3.
    MODIFY SCREEN.
  ENDIF.
   IF screen-group1 = 'G4'.
     screen-active = p4.
     screen-input = '0'. "Campo no editable
     MODIFY SCREEN.
   ENDIF.
  IF screen-group1 = 'G5'.
    screen-active = p5.
    MODIFY SCREEN.
  ENDIF.

ENDFORM.
