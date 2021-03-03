<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/check_admin_session.asp" -->

<!-- #include file="../inc/md5.asp" -->
<!Doctype html>
<html>
<%

		modid=CHK_num(trim(request("modid")))
		user_state=CHK_num(trim(request("user_state")))
		mydo=trim(request("mydo"))
		user_name=trim(request("user_name"))
		user_password=trim(request("user_password"))
		user_password_old=trim(request("user_password_old"))
		
		call dperror_admin(modid=0,"读取会员信息出错，请重新登录后重试","")
		call dperror_admin(user_state<1,"请选择会员状态","")
		call dperror_admin(len(user_name)=0 or isnull(user_name),"请填写昵称","")
		call dperror_admin(len(user_password)=0 or isnull(user_password),"请填写密码","")
		if user_password<>user_password_old then user_password=md5(user_password)
		

	
	'修改会员资料
	sql="update BBS_User set user_name='"& user_name &"',user_password='"& user_password &"',user_state="& user_state &" where user_id="& modid &""
	set rs=bbsconn.execute(sql)
	
	call dperror_admin(true,"修改成功","")

%>
<head>
<meta charset="gb2312">
<title>修改资料</title>
</head>
<body>

</body>
</html>