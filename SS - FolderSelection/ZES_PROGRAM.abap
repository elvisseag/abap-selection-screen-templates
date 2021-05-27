REPORT zes_program.

* {
* Seleccionar ruta de carpeta/directorio
* }

DATA: ls_dir_name   TYPE pfeflnamel,
      ltd_file_list TYPE TABLE OF sdokpath,
      ltd_dir_list  TYPE TABLE OF sdokpath.

"-- SEL --------------------------------------------------------------------------

SELECTION-SCREEN BEGIN OF BLOCK b_1 WITH FRAME TITLE text-001.
PARAMETERS: p_dir TYPE c LENGTH 400 DEFAULT ''.
SELECTION-SCREEN END OF BLOCK b_1.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_dir.
  CALL FUNCTION 'TMP_GUI_BROWSE_FOR_FOLDER'
    EXPORTING
      window_title    = 'Seleccionar ruta de descarga de archivo'
*     initial_folder  = ''
    IMPORTING
      selected_folder = p_dir
    EXCEPTIONS
      cntl_error      = 1
      OTHERS          = 2.
  IF sy-subrc <> 0.
  ENDIF.

START-OF-SELECTION.

  ls_dir_name = p_dir.

* Obtener cóntenido de directorio seleccionado
  CALL FUNCTION 'TMP_GUI_DIRECTORY_LIST_FILES'
  EXPORTING
    directory  = ls_dir_name
*    filter     = '*.bmp'
* IMPORTING
*     FILE_COUNT =
*     DIR_COUNT  =
  TABLES
    file_table = ltd_file_list
    dir_table  = ltd_dir_list
  EXCEPTIONS
    cntl_error = 1
    OTHERS     = 2.