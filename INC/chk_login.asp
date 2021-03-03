<!-- #include file="conn-bbs.asp" -->
<!-- #include file="md5.asp" -->
<!Doctype html>
<html>
<head>
<meta charset="gb2312">
<%
	user_num=trim_fun(request("user_num"))
	user_password=trim_fun(trim(request("user_password")))
	re_myurl=trim_fun(request("re_myurl"))
	from_mobile=chk_num(trim_fun(request("from_mobile")))
	
	if InStr(LCase(Request.ServerVariables("HTTP_USER_AGENT")),"mobile")>0 then
		from_mobile=1
	else
		from_mobile=0
	end if
	
	
	call dperror("",from_mobile,len(user_num)=0 or isnull(user_num),"登录错误：请输入用户名",index_url&re_myurl)
	call dperror("",from_mobile,len(user_password)=0 or isnull(user_password),"登录错误：请输入密码",index_url&re_myurl)

	'call dperror("",from_mobile,user_rzm<>user_rzm_2,"验证码输入不正确","")
	
	
	sql="select * from BBS_Switch"
	set rs=bbsconn.execute(sql)
	if not rs.eof then
		BBS_Switch=rs("BBS_Switch")
		close_tips=rs("close_tips")
	end if
	BBS_Switch=chk_num(BBS_Switch)
	call dperror("",from_mobile,BBS_Switch>1,"登录失败！\n"&close_tips,index_url&re_myurl)
	
	
	
	
	sql="select * from BBS_User where user_num='"& user_num &"' and (user_password='"& user_password &"' or user_password='"& md5(user_password) &"')"
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror("",from_mobile,rs.eof,"登录错误：用户名或密码错误",index_url&re_myurl)
	
	user_id=rs("user_id")
	user_name=rs("user_name")
	user_num=rs("user_num")
	user_state=chk_num(rs("user_state"))
	
	call dperror("",from_mobile,user_state=3,"登录错误：您无权限登录，已被锁定",index_url&re_myurl)
	
	rs("lastlogin_time")=thistime
	rs("login_times")=chk_num(rs("login_times"))+1
	
	rs.update
	
	
	
	Response.Cookies("xq_bbs")("user_id")=user_id
	Response.Cookies("xq_bbs")("user_name")=user_name
	Response.Cookies("xq_bbs")("user_num")=user_num
	Response.Cookies("xq_bbs")("user_state")=user_state
	
		'检查会员是否是管理员
		sql="select id from BBS_Admin where user_id="& user_id &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then Response.Cookies("xq_bbs")("admin_id")=user_id
		
	Response.Cookies("xq_bbs").Expires= (now()+365)
	
	if from_mobile=1 then
		call dperror(BBS_folder&"wap/",from_mobile,true,"欢迎您回来，"& user_name &"，现在将转入首页","")
	else				
		call dperror("",from_mobile,true,"欢迎您回来，"& user_name &"，现在将转入登录前页面",index_url&re_myurl)
	end if	
	
	
	
	response.End()
	

%>

<title>登录检查</title>
</head>
<body>

</body>
</html>