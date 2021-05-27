REPORT zes_program.

* {
" Boton en pantalla de selección
* }

"-- TOP --------------------------------------------------------------------------
TABLES: sscrfields.

DATA: gwa_dyntxt TYPE smp_dyntxt,
      gs_message TYPE string.

"-- SEL --------------------------------------------------------------------------
SELECTION-SCREEN: FUNCTION KEY 1. "Muestra botón en parte superior

PARAMETERS: p_opc TYPE c AS CHECKBOX."Solo para habilitar salida de pantalla

INITIALIZATION.
  " Botón agregar manualmente
  gwa_dyntxt-text        = 'Mostrar mensaje'.
  gwa_dyntxt-icon_id     = '@0Y@'.
  gwa_dyntxt-quickinfo   = 'Mostrar mensaje'.
  gwa_dyntxt-icon_text   = 'Mostrar mensaje'.
  sscrfields-functxt_01  = gwa_dyntxt.

AT SELECTION-SCREEN.
  "IF sscrfields-ucomm = 'FC01'.
  IF sy-ucomm = 'FC01'.
    CONCATENATE 'Botón presionado. Value (' p_opc ')' INTO gs_message.
    MESSAGE gs_message TYPE 'S'.
  ENDIF.
