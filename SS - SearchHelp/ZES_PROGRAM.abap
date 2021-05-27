REPORT zes_program.

*{ 
" Mostrar Ayuda de busqueda a lado de campo
" Selección de ficheros
*}

PARAMETERS: p_arch TYPE rlgrap-filename MODIF ID mo2 DEFAULT 'C:\'.
  
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_arch.
  CALL FUNCTION 'KD_GET_FILENAME_ON_F4'
    EXPORTING
      mask      = '*.*,*.xls'
    CHANGING
      file_name = p_arch.
