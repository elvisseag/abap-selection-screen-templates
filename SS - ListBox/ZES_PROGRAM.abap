REPORT zes_program.

* ZES_PROGRAM_TOP ------------------------------------------------------------

TYPE-POOLS: vrm .

TYPES: BEGIN OF gty_materials,
         matnr TYPE mara-matnr,
         maktx TYPE makt-maktx,
       END OF gty_materials.

DATA: gtd_materials TYPE STANDARD TABLE OF gty_materials,
      gwa_materials TYPE gty_materials,
      gtd_values    TYPE vrm_values,
      gs_id         TYPE vrm_id,
      gwa_value     LIKE LINE OF gtd_values.


* ZES_PROGRAM_F01 ------------------------------------------------------------

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
PARAMETERS:   p_lista TYPE c LENGTH 30 AS LISTBOX VISIBLE LENGTH 30.
SELECTION-SCREEN END OF BLOCK b1.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_lista.
  PERFORM build_listbox.

* ZES_PROGRAM_F01 ------------------------------------------------------------

FORM build_listbox.

  REFRESH gtd_values.
  gs_id = 'p_lista'.

  SELECT a~matnr b~maktx UP TO 20 ROWS
    INTO TABLE gtd_materials
    FROM mara AS a
    INNER JOIN makt AS b ON a~matnr = b~matnr
    WHERE b~spras EQ 'S'. "sy-langu

  LOOP AT gtd_materials INTO gwa_materials.

  CLEAR: gwa_value.
  gwa_value-key  = gwa_materials-matnr.
  gwa_value-text = gwa_materials-maktx.
  APPEND gwa_value TO gtd_values.

  ENDLOOP.

*  CLEAR: gwa_value.
*  gwa_value-key  = '1'.
*  gwa_value-text = 'Lunes'.
*  APPEND gwa_value TO gtd_values.
*
*  CLEAR: gwa_value.
*  gwa_value-key  = '2'.
*  gwa_value-text = 'Martes'.
*  APPEND gwa_value TO gtd_values.
*
*  CLEAR: gwa_value.
*  gwa_value-key  = '3'.
*  gwa_value-text = 'Miercoles'.
*  APPEND gwa_value TO gtd_values.
*
*  CLEAR: gwa_value.
*  gwa_value-key  = '4'.
*  gwa_value-text = 'Jueves'.
*  APPEND gwa_value TO gtd_values.
*
*  CLEAR: gwa_value.
*  gwa_value-key  = '5'.
*  gwa_value-text = 'Viernes'.
*  APPEND gwa_value TO gtd_values.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      ID     = gs_id
      VALUES = gtd_values.

ENDFORM.