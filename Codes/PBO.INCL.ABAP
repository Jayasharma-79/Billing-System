*----------------------------------------------------------------------*
***INCLUDE ZJS_BILLING_SYSTEM_PBO.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_1000  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
CLASS cl_buy DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS handle FOR EVENT double_click OF cl_gui_alv_grid.
ENDCLASS.

CLASS cl_buy IMPLEMENTATION.
  METHOD handle.
    CALL METHOD alv_grid1->get_selected_rows
      IMPORTING
        et_index_rows = j_row.

    READ TABLE j_row INTO js_row INDEX 1.
    READ TABLE lt_data INTO lwa_data INDEX js_row-index.
    product_id = lwa_data-prod_id.
    CALL SCREEN '2026'.
  ENDMETHOD.
ENDCLASS.

CLASS cl_print DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS handle_print FOR EVENT double_click OF cl_gui_alv_grid.
ENDCLASS.

CLASS cl_print IMPLEMENTATION.
  METHOD handle_print.
    CALL METHOD alv_grid_his->get_selected_rows
      IMPORTING
        et_index_rows = j_row1.

    READ TABLE j_row1 INTO js_row1 INDEX 1.
    READ TABLE lt_his INTO lwa_his INDEX js_row1-index.
    order_id = lwa_his-order_id.
    CALL SCREEN '2033'.
  ENDMETHOD.
ENDCLASS.

MODULE status_1000 OUTPUT.
  SET PF-STATUS 'BILL_PF'.
  SET TITLEBAR 'BILL_TIT'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_1002  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_1002 OUTPUT.
  SET PF-STATUS 'BILL_PF'.
  SET TITLEBAR 'TIT_1002'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_1001  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_1001 OUTPUT.
  SET PF-STATUS 'BILL_PF'.
  SET TITLEBAR 'TIT_1001'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_2000  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_2000 OUTPUT.
  SET PF-STATUS 'BILL_PF'.
  SET TITLEBAR 'TIT_2000'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_2001  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_2001 OUTPUT.
  SET PF-STATUS 'BILL_PF'.
  SET TITLEBAR 'TIT_2001'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_2002  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_2002 OUTPUT.
  SET PF-STATUS 'BILL_PF'.
  SET TITLEBAR 'TIT_2002'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_2003  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_2003 OUTPUT.
  SET PF-STATUS 'BILL_PF'.
  SET TITLEBAR 'TIT_2003'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_2011  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_2011 OUTPUT.
  SET PF-STATUS 'BILL_PF'.
  SET TITLEBAR 'TIT_2011'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_2022  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_2022 OUTPUT.
  SET PF-STATUS 'BILL_PF'.
  SET TITLEBAR 'TIT_2022'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_2024  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_2024 OUTPUT.
  SET PF-STATUS 'BILL_PF'.
  SET TITLEBAR 'TIT_2024'.

  IF search_prd_id = 'X'.
    LOOP AT SCREEN.
      IF screen-group1 = 'PR2'.
        screen-input = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ENDIF.

  IF pro_cat = 'X'.
    LOOP AT SCREEN.
      IF screen-group1 = 'PR1'.
        screen-input = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ENDIF.


  IF alv_cont1 IS NOT BOUND.
    CREATE OBJECT alv_cont1
      EXPORTING
        container_name = 'ALV_CONT1'.
  ENDIF.

  IF alv_grid1 IS NOT BOUND.
    CREATE OBJECT alv_grid1
      EXPORTING
        i_parent = alv_cont1.
  ENDIF.

  PERFORM prod_det_fieldcat.

  alv_grid1->set_table_for_first_display(
    CHANGING
      it_outtab                     =   lt_data               " Output Table
      it_fieldcatalog               =   lt_fieldcat_prod              " Field Catalog
    EXCEPTIONS
      invalid_parameter_combination = 1                " Wrong Parameter
      program_error                 = 2                " Program Errors
      too_many_lines                = 3                " Too many Rows in Ready for Input Grid
      OTHERS                        = 4
  ).
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  alv_grid1->check_changed_data( ).

  CALL METHOD alv_grid1->refresh_table_display
    EXCEPTIONS
      finished = 1
      OTHERS   = 2.

  DATA : lo_object TYPE REF TO cl_buy.
  CREATE OBJECT lo_object.
  SET HANDLER lo_object->handle FOR alv_grid1.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  STATUS_2021  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_2021 OUTPUT.
  SET PF-STATUS 'BILL_PF'.
  SET TITLEBAR 'TIT_2021'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_2025  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_2025 OUTPUT.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_2026  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_2026 OUTPUT.
  SET PF-STATUS 'BILL_PF'.
  SET TITLEBAR 'TIT2026'.

  IF cashr = 'X'.
    LOOP AT SCREEN.
      IF screen-group1 = 'GR1' OR screen-group1 = 'GR2' OR screen-group1 = 'GR3'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ENDIF.

  IF upir = 'X'.
    LOOP AT SCREEN.
      IF screen-group1 = 'GR2' OR screen-group1 = 'GR3' OR screen-group1 = 'GR4'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ENDIF.

  IF netr = 'X'.
    LOOP AT SCREEN.
      IF screen-group1 = 'GR1' OR screen-group1 = 'GR3' OR screen-group1 = 'GR4'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ENDIF.

  IF creditr = 'X'.
    LOOP AT SCREEN.
      IF screen-group1 = 'GR1' OR screen-group1 = 'GR2' OR screen-group1 = 'GR4'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_3000  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_3000 OUTPUT.
  SET PF-STATUS 'BILL_PF'.
  SET TITLEBAR 'TIT_3000'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_2031  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_2031 OUTPUT.
  SET PF-STATUS 'BILL_PF'.
  SET TITLEBAR 'TIT_2031'.

  SELECT * FROM zjs_order_his INTO TABLE lt_his WHERE cust_id = customerid.

  IF sy-subrc = 0.

    IF alv_con IS NOT BOUND.
      CREATE OBJECT alv_con
        EXPORTING
          container_name = 'CONT_J'.
    ENDIF.

    IF alv_grid_his IS NOT BOUND.
      CREATE OBJECT alv_grid_his
        EXPORTING
          i_parent = alv_con.
    ENDIF.

    PERFORM order_his_fieldcat.

    alv_grid_his->set_table_for_first_display(
      CHANGING
        it_outtab                     =   lt_his               " Output Table
        it_fieldcatalog               =   lt_fieldcat              " Field Catalog
      EXCEPTIONS
        invalid_parameter_combination = 1                " Wrong Parameter
        program_error                 = 2                " Program Errors
        too_many_lines                = 3                " Too many Rows in Ready for Input Grid
        OTHERS                        = 4
    ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    DATA : lo_object1 TYPE REF TO cl_print.
    CREATE OBJECT lo_object1.
    SET HANDLER lo_object1->handle_print FOR alv_grid_his.

  ELSE.
    MESSAGE 'No orders has been placed yet.' TYPE 'E'.
  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_2032  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_2033 OUTPUT.
  SET PF-STATUS 'BILL_PF'.
  SET TITLEBAR 'TIT_2033'.
ENDMODULE.

FORM prod_det_fieldcat.
  REFRESH : lt_fieldcat_prod.

* Field: PROD_ID
  CLEAR ls_fieldcat_prod.
  ls_fieldcat_prod-fieldname = 'PROD_ID'.
  ls_fieldcat_prod-scrtext_m = 'Product ID'.
  ls_fieldcat_prod-reptext   = 'Product ID'.
  ls_fieldcat_prod-outputlen = 10. " Column width optimized
  APPEND ls_fieldcat_prod TO lt_fieldcat_prod.

* Field: PROD_NAME
  CLEAR ls_fieldcat_prod.
  ls_fieldcat_prod-fieldname = 'PROD_NAME'.
  ls_fieldcat_prod-scrtext_m = 'Product Name'.
  ls_fieldcat_prod-reptext   = 'Product Name'.
  ls_fieldcat_prod-outputlen = 12. " Adjusted for better column fit
  APPEND ls_fieldcat_prod TO lt_fieldcat_prod.

* Field: CATEGORY
  CLEAR ls_fieldcat_prod.
  ls_fieldcat_prod-fieldname = 'CATEGORY'.
  ls_fieldcat_prod-scrtext_m = 'Category'.
  ls_fieldcat_prod-reptext   = 'Category'.
  ls_fieldcat_prod-outputlen = 12. " Adjusted for better column fit
  APPEND ls_fieldcat_prod TO lt_fieldcat_prod.

* Field: PRICE
  CLEAR ls_fieldcat_prod.
  ls_fieldcat_prod-fieldname = 'PRICE'.
  ls_fieldcat_prod-scrtext_m = 'Price'.
  ls_fieldcat_prod-reptext   = 'Price'.
  ls_fieldcat_prod-outputlen = 8. " Optimized for large amounts
  APPEND ls_fieldcat_prod TO lt_fieldcat_prod.

* Field: STOCK_QUANTITY
  CLEAR ls_fieldcat_prod.
  ls_fieldcat_prod-fieldname = 'STOCK_QUANTITY'.
  ls_fieldcat_prod-scrtext_m = 'Stock Quantity'.
  ls_fieldcat_prod-reptext   = 'Stock Quantity'.
  ls_fieldcat_prod-outputlen = 8. " Adjusted to fit numeric stock quantity
  APPEND ls_fieldcat_prod TO lt_fieldcat_prod.

* Field: SUPPLIER_ID
  CLEAR ls_fieldcat_prod.
  ls_fieldcat_prod-fieldname = 'SUPPLIER_ID'.
  ls_fieldcat_prod-scrtext_m = 'Supplier ID'.
  ls_fieldcat_prod-reptext   = 'Supplier ID'.
  ls_fieldcat_prod-outputlen = 10. " Adjusted for Supplier ID
  APPEND ls_fieldcat_prod TO lt_fieldcat_prod.

* Field: MANUFACTURER
  CLEAR ls_fieldcat_prod.
  ls_fieldcat_prod-fieldname = 'MANUFACTURER'.
  ls_fieldcat_prod-scrtext_m = 'Manufacturer'.
  ls_fieldcat_prod-reptext   = 'Manufacturer'.
  ls_fieldcat_prod-outputlen = 12. " Adjusted for longer manufacturer names
  APPEND ls_fieldcat_prod TO lt_fieldcat_prod.

* Field: WEIGHT
  CLEAR ls_fieldcat_prod.
  ls_fieldcat_prod-fieldname = 'WEIGHT'.
  ls_fieldcat_prod-scrtext_m = 'Weight'.
  ls_fieldcat_prod-reptext   = 'Weight (Kg)'.
  ls_fieldcat_prod-outputlen = 8. " Decimal field
  APPEND ls_fieldcat_prod TO lt_fieldcat_prod.

* Field: DESCRIPTION
  CLEAR ls_fieldcat_prod.
  ls_fieldcat_prod-fieldname = 'DESCRIPTION'.
  ls_fieldcat_prod-scrtext_m = 'Description'.
  ls_fieldcat_prod-reptext   = 'Description'.
  ls_fieldcat_prod-outputlen = 12. " Description usually longer, wider column
  APPEND ls_fieldcat_prod TO lt_fieldcat_prod.

* Field: CREATION_DATE
  CLEAR ls_fieldcat_prod.
  ls_fieldcat_prod-fieldname = 'CREATION_DATE'.
  ls_fieldcat_prod-scrtext_m = 'Creation Date'.
  ls_fieldcat_prod-reptext   = 'Creation Date'.
  ls_fieldcat_prod-outputlen = 10. " Adjusted to fit date field
  APPEND ls_fieldcat_prod TO lt_fieldcat_prod.

ENDFORM.


FORM order_his_fieldcat .
  REFRESH : lt_fieldcat.

* Field: ORDER_ID
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'ORDER_ID'.
  ls_fieldcat-scrtext_m = 'Order ID'.
  ls_fieldcat-reptext   = 'Order ID'.
  ls_fieldcat-outputlen = 8.
  APPEND ls_fieldcat TO lt_fieldcat.

* Field: CUST_ID
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'CUST_ID'.
  ls_fieldcat-scrtext_m = 'Customer ID'.
  ls_fieldcat-reptext   = 'Customer ID'.
  ls_fieldcat-outputlen = 8.
  APPEND ls_fieldcat TO lt_fieldcat.

* Field: CUST_NAME
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'CUST_NAME'.
  ls_fieldcat-scrtext_m = 'Customer Name'.
  ls_fieldcat-reptext   = 'Customer Name'.
  ls_fieldcat-outputlen = 8.
  APPEND ls_fieldcat TO lt_fieldcat.

* Field: ADDRESS
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'ADDRESS'.
  ls_fieldcat-scrtext_m = 'Address'.
  ls_fieldcat-reptext   = 'Address'.
  ls_fieldcat-outputlen = 12.
  APPEND ls_fieldcat TO lt_fieldcat.

* Field: CONTACT_NO
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'CONTACT_NO'.
  ls_fieldcat-scrtext_m = 'Contact No'.
  ls_fieldcat-reptext   = 'Contact No'.
  ls_fieldcat-outputlen = 10.
  APPEND ls_fieldcat TO lt_fieldcat.

* Field: EMAIL_ID
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'EMAIL_ID'.
  ls_fieldcat-scrtext_m = 'Email ID'.
  ls_fieldcat-reptext   = 'Email ID'.
  ls_fieldcat-outputlen = 12.
  APPEND ls_fieldcat TO lt_fieldcat.

* Field: PROD_ID
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'PROD_ID'.
  ls_fieldcat-scrtext_m = 'Product ID'.
  ls_fieldcat-reptext   = 'Product ID'.
  ls_fieldcat-outputlen = 10.
  APPEND ls_fieldcat TO lt_fieldcat.

* Field: PROD_NAME
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'PROD_NAME'.
  ls_fieldcat-scrtext_m = 'Product Name'.
  ls_fieldcat-reptext   = 'Product Name'.
  ls_fieldcat-outputlen = 10.
  APPEND ls_fieldcat TO lt_fieldcat.

* Field: ORDER_DATE
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'ORDER_DATE'.
  ls_fieldcat-scrtext_m = 'Order Date'.
  ls_fieldcat-reptext   = 'Order Date'.
  ls_fieldcat-outputlen = 8.
  APPEND ls_fieldcat TO lt_fieldcat.

* Field: ORDER_TIME
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'ORDER_TIME'.
  ls_fieldcat-scrtext_m = 'Order Time'.
  ls_fieldcat-reptext   = 'Order Time'.
  ls_fieldcat-outputlen = 6.
  APPEND ls_fieldcat TO lt_fieldcat.

* Field: QUANTITY
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'QUANTITY'.
  ls_fieldcat-scrtext_m = 'Quantity'.
  ls_fieldcat-reptext   = 'Quantity'.
  ls_fieldcat-outputlen = 4.
  APPEND ls_fieldcat TO lt_fieldcat.

* Field: AMOUNT_PAID
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'AMOUNT_PAID'.
  ls_fieldcat-scrtext_m = 'Amount Paid'.
  ls_fieldcat-reptext   = 'Amount Paid'.
  ls_fieldcat-outputlen = 10.
  APPEND ls_fieldcat TO lt_fieldcat.

* Field: PAY_MODE
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'PAY_MODE'.
  ls_fieldcat-scrtext_m = 'Payment Mode'.
  ls_fieldcat-reptext   = 'Payment Mode'.
  ls_fieldcat-outputlen = 10.
  APPEND ls_fieldcat TO lt_fieldcat.

* Field: STATUS
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'STATUS'.
  ls_fieldcat-scrtext_m = 'Status'.
  ls_fieldcat-reptext   = 'Status'.
  ls_fieldcat-outputlen = 10.
  APPEND ls_fieldcat TO lt_fieldcat.

ENDFORM.
