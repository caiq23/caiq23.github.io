<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="inc/wap-fun.asp" -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="gb2312">
        
<title>�û���¼ - <%=bbsset_sitename%></title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
        
        <link rel="stylesheet" href="inc/wap_css.css">
	</head>

	<body style="background-color:#fff;"> 
    <%this_page="login"%>   
	<!-- #include file="inc/top.asp" --> 
<div class="login_title_logo_top">
    <div class="left"><a href="../wap/"><img src="img/back_home.png"></a></div>
    <div class="center">�û���¼</div>
    <div class="right"></div>
    <div class="clear_both"></div>
</div>
<div class="login_title_logo"><%=bbsset_sitename%></div>

<form name="login" method="post" action="../inc/chk_login.asp?from_mobile=1">
    <div class="login_div">    	        	
        <li>
        	<div class="left">��¼�˺�</div>
            <div class="left"><input name="user_num" placeholder="�������˺�" autocomplete="off" value=""></div>
            <div class="clear_both"></div>
        </li>
        <li>
        	<div class="left">��¼����</div>
            <div class="left"><input type="password" placeholder="����������" value="" name="user_password"> </div>
            <div class="clear_both"></div>
        </li>          
    </div>
    
        <input type="submit" class="submit_wap" value="�� ¼">
            
            
</form>
    
    
	<div class="login_type">
    	������������˾ һ����ݵ�¼        
    </div>
    

    <div class="login_div_link">
         <%if bbsset_open_wxlogin=1 then%>
            <li><a href="<%=display_tlogin(2)%>"><img src="img/share/share_weixin_friend.png"><br>QQ</a></li>
        <%end if%>  
    
    	<%if bbsset_open_qqlogin=1 then%>
            <li><a href="<%=display_tlogin(1)%>"><img src="img/share/share_qq.png"><br>QQ</a></li>
        <%end if%>
       <div class=" clear_both"></div>
    </div>
         
         
         
    <div class="reg_link">
    	<a href="reg.asp">����ע��</a>
        <span>|</span>
    	<a href="../">���԰�</a>
        <div class=" clear_both"></div> 
    </div>
    
    <!-- #include file="inc/end.asp" -->     
        
        
	</body>

</html>