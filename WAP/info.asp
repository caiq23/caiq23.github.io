<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="inc/wap-fun.asp" -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="gb2312">
        
<title>个人设置 - <%=bbsset_sitename%></title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
        
        <link rel="stylesheet" href="inc/wap_css.css">
	</head>

	<body id="iframe_body">
<%
'cookie_user_id=chk_num(Request.Cookies("xq_bbs")("user_id"))
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
	bbs_account_cash=rs("bbs_account_cash")
	user_sex=chk_num(rs("user_sex"))
end if
user_state=CHK_num(user_state)
user_sign=trim_fun_3(user_sign)
bbs_account_cash=CHK_num(bbs_account_cash)

my_alerts=0
sql="select count(id) from BBS_Alert where alert_num2="& session_user_id &" and alert_state=1"			
set rs=bbsconn.execute(sql)
if not rs.eof then my_alerts=chk_num(rs(0))
%>
    <%this_page="info"%>   
	<!-- #include file="inc/top.asp" --> 
    
    	<%if session_user_id>0 then%>
        <div class="info_top">
            <div class="left"><img class="user_img" <%=get_userimg(session_user_id)%> width="60" height="60" style=" margin-top:10px;"></div>
            <div class="left">
                
                <div class="content"><%=user_name%></div>
                <div class="title">登录帐号 : <%=user_num%></div>
            </div> 
            <div class="right">
            	<a href="edit_info.asp"><img src="img/set2.png"></a>
            </div>
        </div>
        <%else%>
        <div class="info_top" onClick="window.location.href='login.asp'">
            <div class="left"><img class="user_img" src="img/un_login_user.png" width="60" height="60" style=" margin-top:10px;"></div>
            <div class="left">
                
                <div class="content">登录/注册</div>
                <div class="title">登录后查看个人信息</div>
            </div> 
            <div class="right">
            	
            </div>
        </div>
        <%end if%>
           
          
   
    <div class="info_div">  
    	<li onClick="window.location.href='list.asp?order_type=10&see_userid=<%=session_user_id%>'">
            <div class="left"><img src="img/my_post.png ">我的帖子</div>
            <div class="right"><div class="more"></div></div>
        </li>
        <li onClick="window.location.href='list.asp?order_type=11&see_userid=<%=session_user_id%>'">
            <div class="left"><img src="img/edit.png ">参与</div>
            <div class="right"><div class="more"></div></div>
        </li>
    	<li onClick="window.location.href='list.asp?order_type=12&see_userid=<%=session_user_id%>'">
            <div class="left"><img src="img/alert.png ">回复</div>
            <div class="right"><div class="more"></div></div><%if my_alerts>0 then%><div class="alert_num"><%=my_alerts%></div><%end if%>
        </li>
        <li onClick="window.location.href='../tpay/mywallet_wap.asp'">
            <div class="left"><img src="img/wallet.png ">余额</div>
            <div class="right"><div class="more"></div><%if session_user_id>0 then%><div class="wallet_num"><%=chknum2(bbs_account_cash)%>元</div><%end if%></div>
        </li>
    </div>
    <div class="info_div"> 
    	<li onClick="window.location.href='edit_info.asp'">
            <div class="left"><img src="img/set.png ">修改资料</div>
            <div class="right"><div class="more"></div></div>
        </li>
    	<li onClick="window.location.href='../'">
            <div class="left"><img src="img/pc.png ">电脑版</div>
            <div class="right"><div class="more"></div></div>
        </li>
    </div>

<%if session_user_id>0 then%>
    <div class="info_div"> 
    	<li>
            <div class="left">登录</div>
            <div class="right"><%=login_times%>次</div>
        </li>
    	<li>
            <div class="left">注册</div>
            <div class="right"><%=howlong(user_addtime)%></div>
        </li>
    	<li>
            <div class="left">最后登录</div>
            <div class="right"><%=howlong(lastlogin_time)%></div>
        </li>
    </div>

    
    <div class="info_div" >
    <input type="button" class="logout_wap" onClick="wap_comfirm('是否退出？','退出','logout.asp')" value="退出当前账号">
    
    </div>
<%end if%>   



        
	</body>

</html> 
<script type="text/javascript" src="inc/iframe_js.js"></script>
<script>display_iframe(4);</script>