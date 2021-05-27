REPORT zes_program.


"-- TOP --------------------------------------------------------------------------

DATA: gtd_bdcdata TYPE STANDARD TABLE OF bdcdata,
      gw_bdcdata  LIKE LINE OF gtd_bdcdata.

DATA: gs_opc    TYPE i VALUE 1,
      gs_file   TYPE localfile,
      gc_ruta   TYPE dxfields-longpath VALUE '/tmp', "/usr/sap/dsm/dvebmgs00/work'.
      gs_filter TYPE dxfields-filemask VALUE '*.txt*'. " '(*.txt)|*.txt*'. " '*.txt'.


"-- SEL --------------------------------------------------------------------------

" Para selección del archivo local
DATA: ltd_file TYPE filetable,
      li_rc    TYPE i,
      lw_file  TYPE file_table.
" Para selección del archivo de servidor
DATA: ltd_host        TYPE STANDARD TABLE OF msxxlist,
      lw_host         TYPE msxxlist,
      lc_path         TYPE dxfields-longpath,
      lc_ubicacion(1) TYPE c,
      lc_abend        TYPE c.

CONSTANTS: lc_p TYPE c VALUE 'P',
           lc_a TYPE dxfields-location VALUE 'A'.
* Sección de selección
SELECTION-SCREEN BEGIN OF BLOCK b_2 WITH FRAME TITLE text-001.
SELECTION-SCREEN BEGIN OF LINE.
"Carga
PARAMETERS: p_ope1 RADIOBUTTON GROUP rb0 USER-COMMAND r DEFAULT 'X'.
SELECTION-SCREEN COMMENT 2(10) FOR FIELD p_ope1.
"Descarga
PARAMETERS: p_ope2 RADIOBUTTON GROUP rb0.
SELECTION-SCREEN COMMENT 14(8) FOR FIELD p_ope2.

SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b_2.

SELECTION-SCREEN BEGIN OF BLOCK b_1 WITH FRAME. "TITLE text-002.

PARAMETERS: p_floca TYPE localfile DEFAULT '' MODIF ID g1. "Cargar
PARAMETERS: p_fserv TYPE localfile DEFAULT '' MODIF ID g2. "Descargar

SELECTION-SCREEN END OF BLOCK b_1.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_floca.
  CALL METHOD cl_gui_frontend_services=>file_open_dialog
    EXPORTING
      window_title = 'Seleccionar archivo'
*     file_filter  = '(*.xls,*.xlsx)|*.xls*'
    CHANGING
      file_table   = ltd_file
      rc           = li_rc.
  IF sy-subrc EQ 0.
    READ TABLE ltd_file INTO lw_file INDEX 1.
    p_floca = lw_file-filename.
  ENDIF.
  "

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_fserv.
  CALL FUNCTION 'RFC_GET_LOCAL_SERVERS'
    TABLES
      hosts         = ltd_host
    EXCEPTIONS
      not_available = 1
      OTHERS        = 2.

  IF sy-subrc = 0.
*-Nombre del servidor a la estructura
    CLEAR lw_host.
    READ TABLE ltd_host INTO lw_host INDEX 1.
*-Obtengo el path
    CALL FUNCTION 'F4_DXFILENAME_TOPRECURSION'
      EXPORTING
        i_location_flag = lc_a
        i_server        = lw_host-name
        i_path          = gc_ruta
        filemask        = gs_filter  "'*.txt'
      IMPORTING
        o_location_flag = lc_ubicacion
        o_path          = lc_path
        abend_flag      = lc_abend
      EXCEPTIONS
        rfc_error       = 1
        error_with_gui  = 2
        OTHERS          = 3.
*-Si se obtiene un path
    IF sy-subrc    IS INITIAL AND
       NOT lc_path IS INITIAL AND
       lc_abend    IS INITIAL.
      "Devuelvo ruta al parametro de selección
      p_fserv = lc_path.
    ENDIF.

  ENDIF.

AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    IF screen-group1 = 'G1'.
*      IF p_oppc IS NOT INITIAL.
      IF p_ope1 IS NOT INITIAL.
        "SCREEN-REQUIRED = 1.
        screen-active = 1.
        gs_opc = 1.
      ELSE.
        "SCREEN-REQUIRED = 0.
        screen-active = 0.
      ENDIF.
      MODIFY SCREEN.
    ENDIF.
    IF screen-group1 = 'G2'.
*      IF p_opse IS NOT INITIAL.
      IF p_ope2 IS NOT INITIAL.
        screen-active = 1.
        gs_opc = 2.
      ELSE.
        screen-active = 0.
      ENDIF.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.