<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/check_admin_session.asp" -->
<%


%>
<html>
<head>
<title>��ҳ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">




   <link href="../inc/wdiii/common.css" rel="stylesheet">
   <link href="../inc/wdiii/table.css" rel="stylesheet">
   <link href="../inc/wdiii/main.css" rel="stylesheet">
   <script src="../inc/wdiii/index.js" type="text/javascript"></script>

     <script>
   function dis_menu(menu_num){
	window.document.getElementById("menu_1").style.display='none';
	window.document.getElementById("menu_2").style.display='none';
	window.document.getElementById("menu_3").style.display='none';
	window.document.getElementById("menu_"+menu_num).style.display='block';
	
	window.document.getElementById("focus_this_menu_1").style.background='none';
	window.document.getElementById("focus_this_menu_2").style.background='none';
	window.document.getElementById("focus_this_menu_3").style.background='none';
	window.document.getElementById("focus_this_menu_"+menu_num).style.backgroundColor='#c7000b';
	
	}
   </script> 

</head>

<body>

<div class="top_logo">
    <div class="top_logo_left">
        <%=bbsset_sitename%><span> | ����Ա��̨</span>
    </div>
    <div class="top_logo_right">
        <ul>
            <li><a href="../" target="_blank">��̳��ҳ</a></li>
            <li><a href="Setting_other.asp" target="right"><img src="../inc/wdiii/ico/top-icon-4.png">����</a></li>
            <li><a href="logout.asp">�˳�</a></li>
        </ul>
    </div>
</div>

<div class="top_menu_1_div">
    <div class="top_menu_1">
    	<ul>
        	<li onClick="dis_menu(1)" onMouseOver="dis_menu(1)"><a href="javascript:void(0);" id="focus_this_menu_1" style="background-color:#c7000b;">��Ա����</a></li>
            <li onClick="dis_menu(2)" onMouseOver="dis_menu(2)"><a href="javascript:void(0);" id="focus_this_menu_2">���ݹ���</a></li>
            <li onClick="dis_menu(3)" onMouseOver="dis_menu(3)"><a href="javascript:void(0);" id="focus_this_menu_3">ϵͳ����</a></li>
        </ul>
    </div>
</div>
<div class="top_menu_2_div">	
    <div class="top_menu_2">
    	<ul id="menu_1" style="display:block;">           
        	
             
            <li><a href="../?r.html" target="_blank"><img src="../inc/wdiii/ico/PBL200745_v.png"><br>ע���»�Ա</a></li>
            <li><a href="admin_meber.asp?see_type=1" target="right"><img src="../inc/wdiii/ico/PBL200745_v.png"><br>��Ա�б�</a></li>
            
            
        </ul>
    	<ul id="menu_2">
        	<li><a href="board_class.asp" target="right"><img src="../inc/wdiii/ico/PBL201131_v.png"><br>������</a></li>
        	<li><a href="admin_post.asp?see_type=2" target="right"><img src="../inc/wdiii/ico/PBL201131_v.png"><br>���ӹ���</a></li>
            <li><a href="admin_replay.asp?see_type=2" target="right"><img src="../inc/wdiii/ico/PBL201131_v.png"><br>�ظ�����</a></li>
            <li><a href="admin_search_word.asp" target="right"><img src="../inc/wdiii/ico/PBL201131_v.png"><br>�����ʹ���</a></li>
            <li><a href="admin_link.asp" target="right"><img src="../inc/wdiii/ico/PBL201131_v.png"><br>���ӹ���</a></li>
            
        </ul>
    	<ul id="menu_3">
        	<li><a href="Setting_other.asp" target="right"><img src="../inc/wdiii/ico/PBL201428_r.png"><br>��������</a></li>          
            <li><a href="db_backup.asp" target="right"><img src="../inc/wdiii/ico/PBL201428_r.png"><br>���ݿⱸ��</a></li>          
            <li><a href="system_open.asp" target="right"><img src="../inc/wdiii/ico/PBL201428_r.png"><br>��̳����</a></li>          
            <li><a href="admin_cache.asp" target="right"><img src="../inc/wdiii/ico/PBL201428_r.png"><br>�������</a></li> 
            <li><a href="gl_man.asp" target="right"><img src="../inc/wdiii/ico/PBL200745_v.png"><br>����Ա�б�</a></li>
            
            
        </ul>
    	
    </div>	
</div>

	<div class="main_right_div">
        <div class="main_right" id="main_right">
        	
            <iFRAME name="right" id="rightFrame" src="admin_meber.asp?see_type=1" class="rightFrame" noResize scrolling=no onLoad="iFrameHeight()" /></iFRAME>
 
         </div>
    </div>
    
<div class="end_info_div">
    <div class="end_info">
        <div class="end_left">
            ��ӭ��¼
        </div>
        <div class="end_right">
            <ul>
                
            </ul>
        </div>
    </div>
</div>

</body>
</html>
