*----------------------------------------------------------------------*
***INCLUDE ZJS_BILLING_SYSTEM_PAI.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1000  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_1000 INPUT.
  CASE sy-ucomm.
    WHEN 'WB_BACK'.
      LEAVE PROGRAM.
    WHEN 'SIGNUP'.
      CALL SCREEN '1001'.
    WHEN 'SIGNIN'.
      CALL SCREEN '1002'.
    WHEN 'ABOUT'.
      PERFORM about_app.
    WHEN 'ADMIN'.
      CALL SCREEN '3000'.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1002  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_1002 INPUT.
  CASE sy-ucomm.
    WHEN 'SIGNIN'.
      DATA(lv_login) = NEW zjs_cl_cust( ).
      CALL METHOD lv_login->login
        EXPORTING
          cust_id             = customerid
        IMPORTING
          zjname              = zname
        EXCEPTIONS
          invalid_customer_id = 1
          OTHERS              = 2.
      IF sy-subrc <> 0.
        MESSAGE e013(zjs_msg_cls) WITH customerid.
      ELSE.
        CALL SCREEN '2000'.
      ENDIF.
    WHEN 'WB_BACK'.
      CALL SCREEN '1000'.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_1001  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_1001 INPUT.
  CASE sy-ucomm.
    WHEN 'SIGNIN'.
      CALL SCREEN '1002'.
    WHEN 'WB_BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'SIGNUP'.
      DATA(lv_save) = NEW zjs_cl_cust( ).

      CALL METHOD lv_save->cust_save
        EXPORTING
          name            = wa1001-cust_name
          address         = wa1001-address
          contact_no      = wa1001-contact_no
          email_id        = wa1001-email_id
          date_of_birth   = wa1001-date_of_birth
          gender          = wa1001-gender
        IMPORTING
          custid          = customerid
        EXCEPTIONS
          error_in_saving = 1
          OTHERS          = 2.
      IF sy-subrc <> 0.
        MESSAGE e001(zjs_msg_cls).
      ELSE.
        MESSAGE i012(zjs_msg_cls) WITH customerid.
        CLEAR customerid.
        CLEAR wa1001.
      ENDIF.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2000  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2000 INPUT.
  CASE sy-ucomm.
    WHEN 'WB_BACK'.
      CALL SCREEN '1000'.
    WHEN 'CUST'.
      CALL SCREEN '2001'.
    WHEN 'PROD'.
      CALL SCREEN '2002'.
    WHEN 'INV'.
      CALL SCREEN '2003'.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2001  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2001 INPUT.
  CASE sy-ucomm.
    WHEN 'WB_BACK'.
      CALL SCREEN '2000'.
    WHEN 'UPDATE'.
      CALL SCREEN '2011'.
    WHEN 'GO'.
      CALL SCREEN '2000'.
    WHEN 'ADD'.
      CALL SCREEN '1001'.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2002  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2002 INPUT.
  CASE sy-ucomm.
    WHEN 'WB_BACK'.
      CALL SCREEN '2000'.
    WHEN 'SEARCH'.
      CALL SCREEN '2024'.
    WHEN 'GO'.
      CALL SCREEN '2000'.
    WHEN 'ADD'.
      SELECT SINGLE admin_id pass_word FROM zjs_admin_access
       INTO  lwa_admin
       WHERE admin_id = adm_id
       OR admin_id = customerid.
      IF sy-subrc <> 0.
        MESSAGE 'Only admins can update the product details.' TYPE 'E'.
      ENDIF.
      CALL SCREEN '2021'.
    WHEN 'UPDATE'.
      SELECT SINGLE admin_id pass_word FROM zjs_admin_access
             INTO  lwa_admin
             WHERE admin_id = adm_id
             OR admin_id = customerid.
      IF sy-subrc <> 0.
        MESSAGE 'Only admins can update the product details.' TYPE 'E'.
      ENDIF.
      CALL SCREEN '2022'.
    WHEN 'BUY'.
      CALL SCREEN '2026'.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2003  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2003 INPUT.
  CASE sy-ucomm.
    WHEN 'WB_BACK'.
      CALL SCREEN '2000'.
    WHEN 'CHECK'.
      SELECT * FROM zjs_order_his INTO TABLE lt_his WHERE cust_id = customerid.
      CALL SCREEN '2031'.
    WHEN 'PRINT'.
      CALL SCREEN '2033'.
    WHEN 'GO'.
      CALL SCREEN '2000'.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2011  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2011 INPUT.
  CASE sy-ucomm.
    WHEN 'UPDATE'.
      SELECT SINGLE * FROM zjs_save_cust INTO wa2011
        WHERE cust_id = customerid.
      IF sy-subrc <> 0.
        MESSAGE 'No data found' TYPE 'E'.
      ENDIF.
    WHEN 'BACK'.
      CALL SCREEN '2001'.
    WHEN 'WB_BACK'.
      CALL SCREEN '2001'.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2022  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2022 INPUT.
  CASE sy-ucomm.
    WHEN 'GET'.
      SELECT SINGLE * FROM zjs_prod_det INTO wa2022 WHERE prod_id = wa2022-prod_id.
    WHEN 'WB_BACK'.
      CALL SCREEN '2002'.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2023  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2023 INPUT.
  CASE 'SY-UCOMM'.
    WHEN 'GO'.
      CALL SCREEN '2002'.
    WHEN 'WB_BACK'.
      CALL SCREEN '2002'.
    WHEN 'UPDATE'.
      MODIFY zjs_prod_det FROM wa2022.
      IF sy-subrc = 0.
        MESSAGE i017(zjs_msg_cls).
      ELSE.
        MESSAGE e001(zjs_msg_cls).
      ENDIF.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2024  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2024 INPUT.
  CASE sy-ucomm.
    WHEN 'PR2'.
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


    WHEN 'BACK'.
      CALL SCREEN '2002'.
    WHEN 'WB_BACK'.
      CALL SCREEN '2002'.
    WHEN 'GET'.

      SELECT *
        FROM zjs_prod_det
        INTO TABLE lt_data
        WHERE prod_id = wa2024-prod_id
        OR  category = wa2024-category.

  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2025  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2025 INPUT.
  CASE sy-ucomm.
    WHEN 'WB_BACK'.
      CALL SCREEN '2000'.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2012  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2012 INPUT.
  CASE sy-ucomm.
    WHEN 'SAVE'.
      UPDATE zjs_save_cust FROM wa2011.
      IF sy-subrc = 0.
        MESSAGE i014(zjs_msg_cls).
        CLEAR wa2011.
      ENDIF.
    WHEN 'BACK'.
      CALL SCREEN '2001'.
    WHEN 'WB_BACK'.
      CALL SCREEN '2000'.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2021  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2021 INPUT.
  CASE sy-ucomm.
    WHEN 'ADD'.
*  UPDATE ZJS_PROD_DET from WA2021.
      DATA(lv_prod) = NEW zjs_cl_cust( ).
      CALL METHOD lv_prod->add_prod
        EXPORTING
          wa_prod = wa2021
        IMPORTING
          prod_id = zprid.
      MESSAGE i016(zjs_msg_cls) WITH zprid.
    WHEN 'BACK'.
      CALL SCREEN '2002'.
    WHEN 'WB_BACK'.
      CALL SCREEN '2002'.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2026  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2026 INPUT.
  CASE sy-ucomm.

    WHEN 'PAY'.
      IF cashr = 'X'.
        LOOP AT SCREEN.
          IF screen-group1 = 'GR1' OR screen-group1 = 'GR2' OR screen-group1 = 'GR3'.
            screen-input = 0.
            MODIFY SCREEN.
          ENDIF.
        ENDLOOP.
      ENDIF.

      IF upir = 'X'.
        LOOP AT SCREEN.
          IF screen-group1 = 'GR2' OR screen-group1 = 'GR3' OR screen-group1 = 'GR4'.
            screen-input = 0.
            MODIFY SCREEN.
          ENDIF.
        ENDLOOP.
      ENDIF.

      IF netr = 'X'.
        LOOP AT SCREEN.
          IF screen-group1 = 'GR1' OR screen-group1 = 'GR3' OR screen-group1 = 'GR4'.
            screen-input = 0.
            MODIFY SCREEN.
          ENDIF.
        ENDLOOP.
      ENDIF.

      IF creditr = 'X'.
        LOOP AT SCREEN.
          IF screen-group1 = 'GR1' OR screen-group1 = 'GR2' OR screen-group1 = 'GR4'.
            screen-input = 0.
            MODIFY SCREEN.
          ENDIF.
        ENDLOOP.
      ENDIF.

    WHEN 'GET'.
      PERFORM get_total_price.
    WHEN 'UPI'.
      IF product_id IS NOT INITIAL AND  quantity IS NOT INITIAL.
        IF upiid IS NOT INITIAL.
          IF tot_price IS INITIAL.
            PERFORM get_total_price.
          ENDIF.
          PERFORM authentication.

        ELSE.
          MESSAGE 'Enter UPI ID' TYPE 'I'.
        ENDIF.
      ENDIF.

    WHEN 'CARD'.
      IF product_id IS NOT INITIAL AND  quantity IS NOT INITIAL.
        IF cardno IS NOT INITIAL.
          IF tot_price IS INITIAL.
            PERFORM get_total_price.
          ENDIF.
          PERFORM authentication.
          PERFORM save_order_det.
        ELSE.
          MESSAGE 'Enter Card number' TYPE 'I'.
        ENDIF.
      ENDIF.

    WHEN 'NET'.
      IF product_id IS NOT INITIAL AND  quantity IS NOT INITIAL.
        IF bank IS NOT INITIAL AND userid IS NOT INITIAL.
          IF tot_price IS INITIAL.
            PERFORM get_total_price.
          ENDIF.
          PERFORM authentication.
          PERFORM save_order_det.
        ELSE.
          MESSAGE 'Enter Bank name and User ID' TYPE 'I'.
        ENDIF.
      ENDIF.

    WHEN 'CASH'.
      MESSAGE 'Order will be delivered on the saved address.' TYPE 'I'.
      PERFORM save_order_det.

    WHEN 'WB_BACK'.
      CALL SCREEN '2002'.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_3000  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_3000 INPUT.
  CASE sy-ucomm.
    WHEN 'PRO'.
      SELECT SINGLE admin_id pass_word admin_name
        FROM zjs_admin_access
        INTO lwa_admin
        WHERE admin_id = wa3000-admin_id
        AND pass_word  = wa3000-pass_word.
      IF sy-subrc = 0.
        adm_id = lwa_admin-admin_id.
        zname = lwa_admin-admin_name.
        CLEAR lwa_admin.
        CALL SCREEN '2000'.
      ELSE.
        MESSAGE 'admin_id or password is incorrect' TYPE 'E'.
      ENDIF.
    WHEN 'BACK'.
      CALL SCREEN '1000'.
    WHEN 'WB_BACK'.
      CALL SCREEN '1000'.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2031  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2031 INPUT.
  CASE sy-ucomm.
    WHEN 'WB_BACK'.
      CALL SCREEN '2003'.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2032  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2032 INPUT.
  CASE sy-ucomm.
    WHEN 'WB_BACK'.
      CALL SCREEN '2003'.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2033 INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2033 INPUT.
  CASE sy-ucomm.
    WHEN 'PRINT'.
      PERFORM print_invoice.
    WHEN 'WB_BACK'.
      CALL SCREEN '2003'.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Form  ABOUT_APP
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM about_app .

  CALL FUNCTION 'READ_TEXT'
    EXPORTING
      client                  = sy-mandt
      id                      = 'ST'
      language                = 'E'
      name                    = 'ZJS_ABOUT_APP'
      object                  = 'TEXT'
    TABLES
      lines                   = ab_app
    EXCEPTIONS
      id                      = 1
      language                = 2
      name                    = 3
      not_found               = 4
      object                  = 5
      reference_check         = 6
      wrong_access_to_archive = 7
      OTHERS                  = 8.
  IF sy-subrc <> 0.
    MESSAGE e001(zjs_msg_cls).
  ELSE.

    CALL FUNCTION 'ZJS_TABLE_POP_UP'
      EXPORTING
        endpos_col   = 100
        endpos_row   = 50
        startpos_col = 5
        startpos_row = 5
        titletext    = 'About Billing System'
* IMPORTING
*       CHOISE       =
      TABLES
        valuetab     = ab_app
      EXCEPTIONS
        break_off    = 1
        OTHERS       = 2.

    IF sy-subrc <> 0.
      MESSAGE e001(zjs_msg_cls).
    ENDIF.

  ENDIF.

ENDFORM.

FORM get_total_price.
  IF product_id IS NOT INITIAL AND  quantity IS NOT INITIAL.
    DATA(lv_price) = NEW zjs_cl_cust( ).
    CALL METHOD lv_price->cal_price
      EXPORTING
        orderid        = product_id
        quantity       = quantity
      IMPORTING
        lv_total_price = tot_price.
    CONCATENATE 'Rs.' tot_price 'will be deducted from your account. Do you want to place the order?'
INTO lv_ques SEPARATED BY ' '.
  ELSE.
    MESSAGE 'Enter product id and quantity' TYPE 'E'.
  ENDIF.
ENDFORM.

FORM authentication .
  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      titlebar       = 'Authentication'
      text_question  = lv_ques
      text_button_1  = 'YES'
      text_button_2  = 'NO'
    IMPORTING
      answer         = lv_ans
    EXCEPTIONS
      text_not_found = 1
      OTHERS         = 2.
  IF sy-subrc = 0.
    IF lv_ans = 1.
      PERFORM save_order_det.
      MESSAGE 'Order has been placed successfully and will be delivered to your address soon' TYPE 'I'.
      CALL SCREEN '2002'.
    ELSEIF lv_ans = 2.
      MESSAGE 'Trasaction failed' TYPE 'I'.
    ELSE.
      MESSAGE 'Payment cancelled' TYPE 'E'.
    ENDIF.
  ENDIF.
ENDFORM.

FORM save_order_det.
  DATA(lv_generate_orderid) = NEW zjs_cl_cust( ).

  lv_generate_orderid->generate_order_id(
    IMPORTING
      order_id = orderid ).

  SELECT SINGLE cust_id cust_name address contact_no email_id
    INTO lv_cust_det
    FROM zjs_save_cust
    WHERE cust_id = customerid.

  SELECT SINGLE prod_id prod_name
  INTO lv_prod_det
  FROM zjs_prod_det
  WHERE prod_id = product_id.

  lv_order_save-order_id = orderid.
  lv_order_save-cust_id = lv_cust_det-cust_id.
  lv_order_save-cust_name = lv_cust_det-cust_name.
  lv_order_save-address = lv_cust_det-address.
  lv_order_save-contact_no = lv_cust_det-contact_no.
  lv_order_save-email_id = lv_cust_det-email_id.
  lv_order_save-prod_id = lv_prod_det-prod_id.
  lv_order_save-prod_name = lv_prod_det-prod_name.
  lv_order_save-order_date = sy-datum.
  lv_order_save-order_time = sy-uzeit.
  lv_order_save-quantity = quantity.
  lv_order_save-amount_paid = tot_price.
  lv_order_save-pay_mode = payment.
  lv_order_save-status = 'Placed'.

  MODIFY zjs_order_his FROM lv_order_save.

  IF sy-subrc <> 0.
    MESSAGE 'Error occured while saving the order details.' TYPE 'E'.
  ENDIF.

  CLEAR : lv_order_save,lv_cust_det, lv_prod_det, lv_ans,
          lv_ques, tot_price, product_id, quantity, upiid,
          bank, cardno, userid, payment.

ENDFORM.

FORM print_invoice.

  DATA : lv_inv      TYPE char10,
         unit_price  TYPE zjs_int,
         fm_name     TYPE rs38l_fnam,
         lv_inv_num1 TYPE char5.

  CONSTANTS : js_form TYPE tdsfname VALUE 'ZJS_ORDER_HIS'.

  SELECT SINGLE cust_id
                cust_name
                address
                contact_no
                prod_id
                prod_name
                quantity
                amount_paid
                order_date
                pay_mode
           FROM zjs_order_his
           INTO lwa_sf
           WHERE order_id = order_id.

  IF sy-subrc = 0.
    unit_price = lwa_sf-total_price / lwa_sf-quantity.
  ENDIF.

  CALL FUNCTION 'QF05_RANDOM_INTEGER'
    EXPORTING
      ran_int_max   = 99999
      ran_int_min   = 10000
    IMPORTING
      ran_int       = lv_inv_num
    EXCEPTIONS
      invalid_input = 1
      OTHERS        = 2.

  IF sy-subrc = 0.
    lv_inv_num1 = lv_inv_num.
    CONCATENATE 'INV' lv_inv_num1 INTO lv_inv.
  ENDIF.

  CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
    EXPORTING
      formname           = js_form
    IMPORTING
      fm_name            = fm_name
    EXCEPTIONS
      no_form            = 1
      no_function_module = 2
      OTHERS             = 3.

  IF sy-subrc = 0.
    CALL FUNCTION fm_name
      EXPORTING
        lwa_sf           = lwa_sf
        lv_inv           = lv_inv
        unit_price       = unit_price
      EXCEPTIONS
        formatting_error = 1
        internal_error   = 2
        send_error       = 3
        user_canceled    = 4
        OTHERS           = 5.
    IF sy-subrc <> 0.
      MESSAGE 'Error Occured' TYPE 'E'.
    ENDIF.
  ENDIF.
ENDFORM.
