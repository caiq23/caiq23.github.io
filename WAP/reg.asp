<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="inc/wap-fun.asp" -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="gb2312">
        
<title>ע���û� - <%=bbsset_sitename%></title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
        
        <link rel="stylesheet" href="inc/wap_css.css">
	</head>

	<body style="background-color:#fff;"> 
    <%this_page="reg"%>   
	<!-- #include file="inc/top.asp" --> 
<div class="login_title_logo_top">
    <div class="left"><a href="../wap/"><img src="img/back_home.png"></a></div>
    <div class="center">ע���û�</div>
	<div class="right"><a href="login.asp">��¼</a></div>
    <div class="clear_both"></div>
</div>
  
  <div class="login_title_logo"><%=bbsset_sitename%></div>
  <form name="login" method="post" action="../inc/chk_reg.asp?from_mobile=1">
    <div class="login_div">
        <li>
        	<div class="left">ע���˺�</div>
            <div class="left"><input name="user_num" placeholder="�������˺�" autocomplete="off" value=""></div>
            <div class="clear_both"></div>
        </li>
        <li>
        	<div class="left">�û��ǳ�</div>
            <div class="left"><input type="text" placeholder="�������ǳ�" value="" name="user_name"> </div>
            <div class="clear_both"></div>
        </li> 
        <li>
        	<div class="left">��¼����</div>
            <div class="left"><input type="password" placeholder="����������" value="" name="user_password"> </div>
            <div class="clear_both"></div>
        </li> 
        <li>
        	<div class="left">ȷ������</div>
            <div class="left"><input type="password" placeholder="��ȷ������" value="" name="user_password2"> </div>
            <div class="clear_both"></div>
        </li>
    </div>
        <input type="submit" class="submit_wap" value="ע ��">
            
            
</form>
    
         

        
        
        
	</body>

</html>