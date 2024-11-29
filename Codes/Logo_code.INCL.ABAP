*----------------------------------------------------------------------*
***INCLUDE ZJS_BILLING_SYSTEM_LOGO.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  LOGO  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE logo1000 OUTPUT.

  CONSTANTS : cntl_true  TYPE i VALUE 1,
              cntl_false TYPE i VALUE 0.

  DATA : h_picture       TYPE REF TO cl_gui_picture,
         h_pic_container TYPE REF TO cl_gui_custom_container.

  DATA : graphic_url(255),
         graphic_refresh(1),
         g_result LIKE cntl_true.

  DATA : BEGIN OF graphic_table OCCURS 0,
           line(255) TYPE x,
         END OF graphic_table.

  DATA : graphic_size TYPE i.

  DATA : l_graphic_xstr TYPE xstring,
         l_graphic_conv TYPE i,
         l_graphic_offs TYPE i.

  CALL METHOD cl_ssf_xsf_utilities=>get_bds_graphic_as_bmp
    EXPORTING
      p_object  = 'GRAPHICS'
      p_name    = 'BILLING SYSTEM LOGO' "IMAGE NAME - Image name from SE78
      p_id      = 'BMAP'
      p_btype   = 'BCOL'  "(BMON = black&white, BCOL = colour)
    RECEIVING
      p_bmp     = l_graphic_xstr
    EXCEPTIONS
      not_found = 1
      OTHERS    = 2.
  graphic_size = xstrlen( l_graphic_xstr ).
  l_graphic_conv = graphic_size.
  l_graphic_offs = 0.
  WHILE l_graphic_conv > 255.
    graphic_table-line = l_graphic_xstr+l_graphic_offs(255).
    APPEND graphic_table.
    l_graphic_offs = l_graphic_offs + 255.
    l_graphic_conv = l_graphic_conv - 255.
  ENDWHILE.
  graphic_table-line = l_graphic_xstr+l_graphic_offs(l_graphic_conv).
  APPEND graphic_table.
  CALL FUNCTION 'DP_CREATE_URL'
    EXPORTING
      type     = 'image'               "#EC NOTEXT
      subtype  = cndp_sap_tab_unknown " 'X-UNKNOWN'
      size     = graphic_size
      lifetime = cndp_lifetime_transaction  "'T'
    TABLES
      data     = graphic_table
    CHANGING
      url      = graphic_url
    EXCEPTIONS
      OTHERS   = 4.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    EXIT.
  ENDIF.
  CREATE OBJECT h_pic_container
    EXPORTING
      container_name = 'CONT1'.
  CREATE OBJECT h_picture EXPORTING parent = h_pic_container.
  CALL METHOD h_picture->load_picture_from_url
    EXPORTING
      url = graphic_url.
  CALL METHOD h_picture->set_display_mode
    EXPORTING
      display_mode = h_picture->display_mode_fit_center.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  LOGO2000  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE logo2000 OUTPUT.

  CONSTANTS : cntl_true1  TYPE i VALUE 1,
              cntl_false1 TYPE i VALUE 0.

  DATA : h_picture1       TYPE REF TO cl_gui_picture,
         h_pic_container1 TYPE REF TO cl_gui_custom_container.

  DATA : graphic_url1(255),
         graphic_refresh1(1),
         g_result1 LIKE cntl_true1.

  DATA : BEGIN OF graphic_table1 OCCURS 0,
           line1(255) TYPE x,
         END OF graphic_table1.

  DATA : graphic_size1 TYPE i.

  DATA : l_graphic_xstr1 TYPE xstring,
         l_graphic_conv1 TYPE i,
         l_graphic_offs1 TYPE i.

  CALL METHOD cl_ssf_xsf_utilities=>get_bds_graphic_as_bmp
    EXPORTING
      p_object  = 'GRAPHICS'
      p_name    = 'CUSTOMER MANAGEMENT IMAGE' "IMAGE NAME - Image name from SE78
      p_id      = 'BMAP'
      p_btype   = 'BCOL'  "(BMON = black&white, BCOL = colour)
    RECEIVING
      p_bmp     = l_graphic_xstr1
    EXCEPTIONS
      not_found = 1
      OTHERS    = 2.

  graphic_size1 = xstrlen( l_graphic_xstr1 ).
  l_graphic_conv1 = graphic_size1.
  l_graphic_offs1 = 0.

  WHILE l_graphic_conv1 > 255.
    graphic_table1-line1 = l_graphic_xstr1+l_graphic_offs1(255).
    APPEND graphic_table1.
    l_graphic_offs1 = l_graphic_offs1 + 255.
    l_graphic_conv1 = l_graphic_conv1 - 255.
  ENDWHILE.

  graphic_table1-line1 = l_graphic_xstr1+l_graphic_offs1(l_graphic_conv1).
  APPEND graphic_table1.

  CALL FUNCTION 'DP_CREATE_URL'
    EXPORTING
      type     = 'image'               "#EC NOTEXT
      subtype  = cndp_sap_tab_unknown " 'X-UNKNOWN'
      size     = graphic_size1
      lifetime = cndp_lifetime_transaction  "'T'
    TABLES
      data     = graphic_table1
    CHANGING
      url      = graphic_url1
    EXCEPTIONS
      OTHERS   = 4.

  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    EXIT.
  ENDIF.

  CREATE OBJECT h_pic_container1
    EXPORTING
      container_name = 'CONT4'.

  CREATE OBJECT h_picture1 EXPORTING parent = h_pic_container1.

  CALL METHOD h_picture1->load_picture_from_url
    EXPORTING
      url = graphic_url1.

  CALL METHOD h_picture1->set_display_mode
    EXPORTING
      display_mode = h_picture1->display_mode_fit_center.

****************************For 2nd Container ******************************
  CONSTANTS : cntl_true2  TYPE i VALUE 1,
              cntl_false2 TYPE i VALUE 0.

  DATA : h_picture2       TYPE REF TO cl_gui_picture,
         h_pic_container2 TYPE REF TO cl_gui_custom_container.

  DATA : graphic_url2(255),
         graphic_refresh2(1),
         g_result2 LIKE cntl_true2.

  DATA : BEGIN OF graphic_table2 OCCURS 0,
           line2(255) TYPE x,
         END OF graphic_table2.

  DATA : graphic_size2 TYPE i.

  DATA : l_graphic_xstr2 TYPE xstring,
         l_graphic_conv2 TYPE i,
         l_graphic_offs2 TYPE i.

  CALL METHOD cl_ssf_xsf_utilities=>get_bds_graphic_as_bmp
    EXPORTING
      p_object  = 'GRAPHICS'
      p_name    = 'PRODUCT AND SERVICES IMAGE' "IMAGE NAME - Image name from SE78
      p_id      = 'BMAP'
      p_btype   = 'BCOL'  "(BMON = black&white, BCOL = colour)
    RECEIVING
      p_bmp     = l_graphic_xstr2
    EXCEPTIONS
      not_found = 1
      OTHERS    = 2.

  graphic_size2 = xstrlen( l_graphic_xstr2 ).
  l_graphic_conv2 = graphic_size2.
  l_graphic_offs2 = 0.

  WHILE l_graphic_conv2 > 255.
    graphic_table2-line2 = l_graphic_xstr2+l_graphic_offs2(255).
    APPEND graphic_table2.
    l_graphic_offs2 = l_graphic_offs2 + 255.
    l_graphic_conv2 = l_graphic_conv2 - 255.
  ENDWHILE.

  graphic_table2-line2 = l_graphic_xstr2+l_graphic_offs2(l_graphic_conv2).
  APPEND graphic_table2.

  CALL FUNCTION 'DP_CREATE_URL'
    EXPORTING
      type     = 'image'               "#EC NOTEXT
      subtype  = cndp_sap_tab_unknown " 'X-UNKNOWN'
      size     = graphic_size2
      lifetime = cndp_lifetime_transaction  "'T'
    TABLES
      data     = graphic_table2
    CHANGING
      url      = graphic_url2
    EXCEPTIONS
      OTHERS   = 4.

  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    EXIT.
  ENDIF.

  CREATE OBJECT h_pic_container2
    EXPORTING
      container_name = 'CONT2'.

  CREATE OBJECT h_picture2 EXPORTING parent = h_pic_container2.

  CALL METHOD h_picture2->load_picture_from_url
    EXPORTING
      url = graphic_url2.

  CALL METHOD h_picture2->set_display_mode
    EXPORTING
      display_mode = h_picture2->display_mode_fit_center.

***************************For 3rd Container*************************************

  CONSTANTS : cntl_true3  TYPE i VALUE 1,
              cntl_false3 TYPE i VALUE 0.

  DATA : h_picture3       TYPE REF TO cl_gui_picture,
         h_pic_container3 TYPE REF TO cl_gui_custom_container.

  DATA : graphic_url3(255),
         graphic_refresh3(1),
         g_result3 LIKE cntl_true3.

  DATA : BEGIN OF graphic_table3 OCCURS 0,
           line3(255) TYPE x,
         END OF graphic_table3.

  DATA : graphic_size3 TYPE i.

  DATA : l_graphic_xstr3 TYPE xstring,
         l_graphic_conv3 TYPE i,
         l_graphic_offs3 TYPE i.

  CALL METHOD cl_ssf_xsf_utilities=>get_bds_graphic_as_bmp
    EXPORTING
      p_object  = 'GRAPHICS'
      p_name    = 'HISTORY AND TRASACTION IMAGE' "IMAGE NAME - Image name from SE78
      p_id      = 'BMAP'
      p_btype   = 'BCOL'  "(BMON = black&white, BCOL = colour)
    RECEIVING
      p_bmp     = l_graphic_xstr3
    EXCEPTIONS
      not_found = 1
      OTHERS    = 2.

  graphic_size3 = xstrlen( l_graphic_xstr3 ).
  l_graphic_conv3 = graphic_size3.
  l_graphic_offs3 = 0.

  WHILE l_graphic_conv3 > 255.
    graphic_table3-line3 = l_graphic_xstr3+l_graphic_offs3(255).
    APPEND graphic_table3.
    l_graphic_offs3 = l_graphic_offs3 + 255.
    l_graphic_conv3 = l_graphic_conv3 - 255.
  ENDWHILE.

  graphic_table3-line3 = l_graphic_xstr3+l_graphic_offs3(l_graphic_conv3).
  APPEND graphic_table3.

  CALL FUNCTION 'DP_CREATE_URL'
    EXPORTING
      type     = 'image'               "#EC NOTEXT
      subtype  = cndp_sap_tab_unknown " 'X-UNKNOWN'
      size     = graphic_size3
      lifetime = cndp_lifetime_transaction  "'T'
    TABLES
      data     = graphic_table3
    CHANGING
      url      = graphic_url3
    EXCEPTIONS
      OTHERS   = 4.

  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    EXIT.
  ENDIF.

  CREATE OBJECT h_pic_container3
    EXPORTING
      container_name = 'CONT3'.

  CREATE OBJECT h_picture3 EXPORTING parent = h_pic_container3.

  CALL METHOD h_picture3->load_picture_from_url
    EXPORTING
      url = graphic_url3.

  CALL METHOD h_picture3->set_display_mode
    EXPORTING
      display_mode = h_picture3->display_mode_fit_center.


ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  LOGO3000  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE logo3000 OUTPUT.
  CONSTANTS : cntl_true4  TYPE i VALUE 1,
              cntl_false4 TYPE i VALUE 0.

  DATA : h_picture4       TYPE REF TO cl_gui_picture,
         h_pic_container4 TYPE REF TO cl_gui_custom_container.

  DATA : graphic_url4(255),
         graphic_refresh4(1),
         g_result4 LIKE cntl_true4.

  DATA : BEGIN OF graphic_table4 OCCURS 0,
           line4(255) TYPE x,
         END OF graphic_table4.

  DATA : graphic_size4 TYPE i.

  DATA : l_graphic_xstr4 TYPE xstring,
         l_graphic_conv4 TYPE i,
         l_graphic_offs4 TYPE i.

  CALL METHOD cl_ssf_xsf_utilities=>get_bds_graphic_as_bmp
    EXPORTING
      p_object  = 'GRAPHICS'
      p_name    = 'SIGNUP' "IMAGE NAME - Image name from SE78
      p_id      = 'BMAP'
      p_btype   = 'BCOL'  "(BMON = black&white, BCOL = colour)
    RECEIVING
      p_bmp     = l_graphic_xstr4
    EXCEPTIONS
      not_found = 1
      OTHERS    = 2.

  graphic_size4 = xstrlen( l_graphic_xstr4 ).
  l_graphic_conv4 = graphic_size4.
  l_graphic_offs4 = 0.

  WHILE l_graphic_conv4 > 255.
    graphic_table4-line4 = l_graphic_xstr4+l_graphic_offs4(255).
    APPEND graphic_table4.
    l_graphic_offs4 = l_graphic_offs4 + 255.
    l_graphic_conv4 = l_graphic_conv4 - 255.
  ENDWHILE.

  graphic_table4-line4 = l_graphic_xstr4+l_graphic_offs4(l_graphic_conv4).
  APPEND graphic_table4.

  CALL FUNCTION 'DP_CREATE_URL'
    EXPORTING
      type     = 'image'               "#EC NOTEXT
      subtype  = cndp_sap_tab_unknown " 'X-UNKNOWN'
      size     = graphic_size4
      lifetime = cndp_lifetime_transaction  "'T'
    TABLES
      data     = graphic_table4
    CHANGING
      url      = graphic_url4
    EXCEPTIONS
      OTHERS   = 4.

  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    EXIT.
  ENDIF.

  CREATE OBJECT h_pic_container4
    EXPORTING
      container_name = 'CONT5'.

  CREATE OBJECT h_picture4 EXPORTING parent = h_pic_container4.

  CALL METHOD h_picture4->load_picture_from_url
    EXPORTING
      url = graphic_url4.

  CALL METHOD h_picture4->set_display_mode
    EXPORTING
      display_mode = h_picture4->display_mode_fit_center.


ENDMODULE.
