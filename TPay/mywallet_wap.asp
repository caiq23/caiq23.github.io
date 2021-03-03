<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../wap/inc/wap-fun.asp" -->
<!-- #include file="../wap/inc/wap_session.asp" -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="gb2312">
        
<title>个人帐户 - <%=bbsset_sitename%></title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
        
        <link rel="stylesheet" href="../wap/inc/wap_css.css">
        <style>
			.mywallet_wap{ height:200px;}
			.recharge_div_1{ color:#ddd; font-size:14px; padding-top:30px;}
			.recharge_div_2{ color:#fff; font-size:5em; padding-top:20px;font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif}
		</style>
	</head>
<body>
<%
sql="select * from BBS_User where user_id="& session_user_id &""
set rs=bbsconn.execute(sql)
if not rs.eof then
	user_num=rs("user_num")
	user_name=rs("user_name")
	user_id=rs("user_id")
	user_state=rs("user_state")
	login_times=rs("login_times")
	user_password=rs("user_password")
	user_addtime=rs("user_addtime")	
	lastlogin_time=rs("lastlogin_time")	
	user_img=rs("user_img")
	user_tel=rs("user_tel")
	user_qq=rs("user_qq")
	user_sign=rs("user_sign")
	qq_OpenID=rs("qq_OpenID")
	user_sex=chk_num(rs("user_sex"))
	bbs_account_cash=rs("bbs_account_cash")
end if
user_state=CHK_num(user_state)
user_sign=trim_fun_3(user_sign)
bbs_account_cash=CHK_num(bbs_account_cash)

%>
<%this_page="mywallet_wap"%>     
    <div class="info_top mywallet_wap">
    	<div class="recharge_div_1">
        	余额帐户（元）
        </div>
        <div class="recharge_div_2">
        	<%=chknum2(bbs_account_cash)%>
        </div>
    </div>
    
    <div class="info_div"> 
        <li onClick="window.location.href='recharge_wap.asp'">
            <div class="left">充值</div>
            <div class="right"><div class="more"></div></div>
        </li>
    </div>
    <div class="info_div"> 
        <li onClick="window.location.href='pay_log_wap.asp'">
            <div class="left">充值记录</div>
            <div class="right"><div class="more"></div></div>
        </li>
    </div>
    <!-- #include file="../wap/inc/end.asp" -->     
        
        
	</body>

</html>
