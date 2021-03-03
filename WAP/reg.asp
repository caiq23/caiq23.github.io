<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="inc/wap-fun.asp" -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="gb2312">
        
<title>注册用户 - <%=bbsset_sitename%></title>
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
    <div class="center">注册用户</div>
	<div class="right"><a href="login.asp">登录</a></div>
    <div class="clear_both"></div>
</div>
  
  <div class="login_title_logo"><%=bbsset_sitename%></div>
  <form name="login" method="post" action="../inc/chk_reg.asp?from_mobile=1">
    <div class="login_div">
        <li>
        	<div class="left">注册账号</div>
            <div class="left"><input name="user_num" placeholder="请输入账号" autocomplete="off" value=""></div>
            <div class="clear_both"></div>
        </li>
        <li>
        	<div class="left">用户昵称</div>
            <div class="left"><input type="text" placeholder="请输入昵称" value="" name="user_name"> </div>
            <div class="clear_both"></div>
        </li> 
        <li>
        	<div class="left">登录密码</div>
            <div class="left"><input type="password" placeholder="请输入密码" value="" name="user_password"> </div>
            <div class="clear_both"></div>
        </li> 
        <li>
        	<div class="left">确认密码</div>
            <div class="left"><input type="password" placeholder="请确认密码" value="" name="user_password2"> </div>
            <div class="clear_both"></div>
        </li>
    </div>
        <input type="submit" class="submit_wap" value="注 册">
            
            
</form>
    
         

        
        
        
	</body>

</html>