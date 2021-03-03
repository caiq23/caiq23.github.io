<!-- #include file="conn-bbs.asp" -->
<!-- #include file="md5.asp" -->
<!Doctype html>
<html><head>
<meta charset="gb2312">
<title>注册会员</title>
</head>
<body>
<%
	user_num=trim_fun(request("user_num"))	
	mydo=trim_fun(request("mydo"))
	user_password=trim_fun(request("user_password"))
	qq_OpenID=session("qq_OpenID")
	wx_OpenID=session("wx_OpenID")	
	qq_UserName=session("qq_UserName")
	reg_my_do=session("reg_my_do")
	from_mobile=chk_num(trim_fun(request("from_mobile")))
	
	
	
	

select case reg_my_do
case "wx_login"

	user_password=md5(user_password)
	
	sql="select * from BBS_User where user_num='"& user_num &"' and user_password='"& user_password &"'"
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror("",from_mobile,rs.eof,"登录错误：用户名或密码错误",BBS_folder&"?r.html")
	
	user_state=chk_num(rs("user_state"))
	user_name=rs("user_name")
	call dperror("",from_mobile,user_state=3,"登录错误：您无权限登录，已被锁定",BBS_folder&"?r.html")
	call dperror("",from_mobile,len(rs("wx_OpenID"))>0,"绑定错误：该用户已经绑定有微信登录，请更改用户",BBS_folder&"?r.html")
	
	rs("wx_OpenID")=wx_OpenID
	rs.update
	
	call dperror("",from_mobile,true,"恭喜绑定微信快捷登录成功：现在将以 "& user_name &" 的身份登录","inc/chk_login.asp?user_num="&user_num&"&user_password="&user_password)
case "qq_login"

	user_password=md5(user_password)
	
	sql="select * from BBS_User where user_num='"& user_num &"' and user_password='"& user_password &"'"
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror("",from_mobile,rs.eof,"登录错误：用户名或密码错误",BBS_folder&"?r.html")
	
	user_state=chk_num(rs("user_state"))
	user_name=rs("user_name")
	call dperror("",from_mobile,user_state=3,"登录错误：您无权限登录，已被锁定",BBS_folder&"?r.html")
	call dperror("",from_mobile,len(rs("qq_OpenID"))>0,"绑定错误：该用户已经绑定有QQ登录，请更改用户",BBS_folder&"?r.html")
	
	rs("qq_OpenID")=qq_OpenID
	rs.update
	
	call dperror("",from_mobile,true,"恭喜绑定QQ快捷登录成功：现在将以 "& user_name &" 的身份登录","inc/chk_login.asp?user_num="&user_num&"&user_password="&user_password)
	
case else
	
	
	
		user_password2=trim_fun(request("user_password2"))
		user_name=trim_fun(request("user_name"))
		user_name=replace_filter(user_name,bbsset_Filter_word)
		user_tel=trim_fun(request("user_tel"))
		user_qq=trim_fun(request("user_qq"))
		user_sign=trim_fun(request("user_sign"))		
		user_sign=left(user_sign,120)
		user_sign=replace_filter(user_sign,bbsset_Filter_word)
		user_sex=chk_num(trim_fun(request("user_sex")))
		user_id=chk_num(trim_fun(request.form("user_id")))
		
		if user_id=0 then
			for i=1 to 100
				'随机生成6位数
				Randomize Timer 
				user_id = Int(899999 * Rnd + 100000)
				sql="select id from BBS_User where user_id="& user_id &""
				set rs=bbsconn.execute(sql)
				if rs.eof then exit for
				call dperror("",from_mobile,i>=100,"系统分配用户ID出错，请稍候再重试",index_url&"r.html")
			next
		end if
	
		if len(user_tel)>0 then call dperror("",from_mobile,not isNumeric(user_tel),"电话号码必须是数字",index_url&"r.html")
		if len(user_qq)>0 then call dperror("",from_mobile,not isNumeric(user_qq),"QQ号码必须是数字",index_url&"r.html")
		
	call dperror("",from_mobile,len(user_num)=0 or isnull(user_num),"请输入新会员登录帐号",index_url&"r.html")
	user_num=LCase(user_num)
	call dperror("",from_mobile,user_num="admin","会员登录帐号不能为admin",index_url&"r.html")
	call dperror("",from_mobile,len(user_num)<4 or len(user_num)>12,"会员登录帐号必须大于4位小于12位之间",index_url&"r.html")
	
	call dperror("",from_mobile,len(user_name)=0 or isnull(user_name),"请输入新会员昵称",index_url&"r.html")
	call dperror("",from_mobile,len(user_password)=0 or isnull(user_password),"请输入新会员密码",index_url&"r.html")
	call dperror("",from_mobile,user_password<>user_password2,"两次密码不一致",index_url&"r.html")
	
	
	sql="select id from BBS_User where user_id="& user_id &""
	set rs=bbsconn.execute(sql)
	call dperror("",from_mobile,not rs.eof,"用户ID重复，请稍候再重试",index_url&"r.html")
	
	
	sql="select * from BBS_User where user_name='"& user_name &"'"
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,1
	call dperror("",from_mobile,not rs.eof,"重复的会员昵称",index_url&"r.html")
	
	sql="select * from BBS_User where user_num='"& user_num &"'"
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror("",from_mobile,not rs.eof,"重复的会员帐号",index_url&"r.html")
	rs.addnew
		rs("user_id")=user_id
		rs("user_num")=user_num
		rs("user_password")=md5(user_password)
		rs("user_name")=user_name
		rs("user_addtime")=thistime	
		rs("user_state")=1	
		rs("user_tel")=user_tel	
		rs("user_qq")=user_qq	
		rs("user_sign")=user_sign	
		rs("user_sex")=user_sex	
			
	rs.update

	call dperror("",0,true,"恭喜注册成功：现在将以 "& user_name &" 的身份登录","inc/chk_login.asp?from_mobile="& from_mobile &"&user_num="&user_num&"&user_password="&user_password)
	
	
	
end select
	response.End()


%>

</body>
</html>