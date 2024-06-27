CLASS zcl_input_data DEFINITION
  PUBLIC

  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES: if_oo_adt_classrun.

  PROTECTED SECTION.

  PRIVATE SECTION.

    data: t_tablename  type table of ztablename,
          ls_tablename type ztablename.

ENDCLASS.

CLASS zcl_input_data IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.

    "DELETE FROM ztablename.

    DATA: lv_count TYPE i,
          lv_num   TYPE string,
          lv_name  TYPE string,
          lv_fullname TYPE string.

    lv_name = 'name'.

    SELECT MAX( id ) FROM ztablename into @lv_count.
    lv_num = lv_count.

    DO 10 TIMES.
      lv_count = lv_count + 1.
      lv_num = lv_count.
      CONCATENATE lv_name lv_num INTO lv_fullname separated by ' '.

      ls_tablename-id = lv_count.
      ls_tablename-name = lv_fullname.

      APPEND ls_tablename TO t_tablename.
    ENDDO.

    MODIFY ztablename FROM TABLE @t_tablename.

    IF sy-subrc = 0.
      COMMIT WORK.
      out->write( 'Data inserted into ZTABLENAME successfully.' ).
    ELSE.
      out->write(  'Error inserting data into ZTABLENAME.' ) .
    ENDIF.
  ENDMETHOD.
ENDCLASS.
