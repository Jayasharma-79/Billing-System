*&---------------------------------------------------------------------*
*&  Include           ZJS_BILLING_SYSTEM_DATA
*&---------------------------------------------------------------------*

DATA : lv_inv_num TYPE i.

DATA : search_prd_id TYPE char1,
       pro_cat       TYPE char1.

DATA : cashr, upir, creditr, netr.

DATA : custname   TYPE char50,
       addr       TYPE char100,
       cno        TYPE char10,
       emailid    TYPE char30,
       customerid TYPE char10.

DATA : zid TYPE char10.
DATA : id2011 TYPE char10.
DATA : zname TYPE char50.
DATA : zprid TYPE char10.

DATA : upiid  TYPE char20,
       bank   TYPE char30,
       cardno TYPE char30,
       userid TYPE char30.

DATA : payment TYPE zjs_pay_type.

DATA : ab_app TYPE TABLE OF tline.
DATA : wa_app TYPE tline.

DATA : lv_ques TYPE string,
       lv_ans  TYPE char1.

DATA : tot_price TYPE char10.
DATA : product_id TYPE  char10.
DATA : quantity TYPE zjs_lp.

DATA : wa1001 TYPE zjs_save_cust.
DATA : wa2011 TYPE zjs_save_cust.
DATA : wa2021 TYPE zjs_prod_det.
DATA : wa2022 TYPE zjs_prod_det.
DATA : wa2024 TYPE zjs_prod_det.
DATA : wa2026 TYPE zjs_prod_det.

DATA : lt_data  TYPE TABLE OF zjs_prod_det.
DATA : lwa_data TYPE zjs_prod_det.

DATA : lt_his TYPE TABLE OF zjs_order_his.
DATA : lwa_his TYPE zjs_order_his.

DATA : alv_cont1 TYPE REF TO cl_gui_custom_container,   "Container for header Data
       alv_grid1 TYPE REF TO cl_gui_alv_grid.

DATA : alv_con      TYPE REF TO cl_gui_custom_container,   "Container for order history Data
       alv_grid_his TYPE REF TO cl_gui_alv_grid.

TYPES : BEGIN OF ty_admin,
          admin_id   TYPE char10,
          pass_word	 TYPE char20,
          admin_name TYPE char50,
        END OF ty_admin.

DATA : lwa_admin TYPE ty_admin.
DATA : wa3000 TYPE ty_admin.

DATA : adm_id TYPE char20.

DATA : j_row  TYPE lvc_t_row,
       js_row TYPE lvc_s_row.

DATA : j_row1  TYPE lvc_t_row,
       js_row1 TYPE lvc_s_row.

DATA: lt_fieldcat TYPE lvc_t_fcat,
      ls_fieldcat TYPE lvc_s_fcat.

DATA: lt_fieldcat_prod TYPE lvc_t_fcat,
      ls_fieldcat_prod TYPE lvc_s_fcat.

DATA : lt_sf  TYPE STANDARD TABLE OF zjs_sf,
       lwa_sf TYPE zjs_sf.

DATA : order_id TYPE char10.
DATA : orderid TYPE char10.


TYPES : BEGIN OF ty_cust_det,
          cust_id    TYPE zjs_save_cust-cust_id,
          cust_name  TYPE zjs_save_cust-cust_name,
          address    TYPE zjs_save_cust-address,
          contact_no TYPE zjs_save_cust-contact_no,
          email_id   TYPE zjs_save_cust-email_id,
        END OF ty_cust_det.

TYPES : BEGIN OF ty_prod_det,
          prod_id   TYPE zjs_prod_det-prod_id,
          prod_name TYPE zjs_prod_det-prod_name,
        END OF ty_prod_det.

DATA : lv_cust_det TYPE ty_cust_det,
       lv_prod_det TYPE ty_prod_det.

DATA : lv_order_save TYPE zjs_order_his.
