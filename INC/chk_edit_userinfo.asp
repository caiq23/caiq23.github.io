<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/md5.asp" -->
<!-- #include file="../inc/chk_session.asp" -->
<!Doctype html>
<html>
<head>
<meta charset="gb2312">
<title>修改资料</title>
</head>
<body>
<%

		modid=session_user_id

		mydo=trim_fun(request("mydo"))
		user_name=trim_fun(request("user_name"))
		user_password=trim_fun(request("user_password"))
		user_password2=trim_fun(request("user_password2"))
		user_password_old=trim_fun(request("user_password_old"))
		user_tel=trim_fun(request("user_tel"))
		user_qq=trim_fun(request("user_qq"))
		user_sign=trim_fun_2(request("user_sign"))
		user_sign=left(user_sign,120)		
		user_sex=chk_num(trim_fun(request("user_sex")))
		goto_url=index_url&"e1.html"
		from_mobile=chk_num(trim_fun(request("from_mobile")))
		msg_open=chk_num(trim_fun(request("msg_open")))
		
		
		call dperror("",from_mobile,modid<=0,"读取会员信息出错，请重新登录后重试",goto_url)
		
select case mydo
case "cancel_wx"
	'解除微信快捷登录
	sql="update BBS_User set wx_OpenID='' where user_id="& modid &""		
	set rs=bbsconn.execute(sql)
	if from_mobile=1 then
		call dperror(BBS_folder&"wap/info.asp",from_mobile,true,"解除绑定微信快捷登录成功","")
	else
		call dperror("",from_mobile,true,"解除绑定微信快捷登录成功",goto_url)
	end if
case "cancel_qq"
	'解除QQ快捷登录
	sql="update BBS_User set qq_OpenID='' where user_id="& modid &""		
	set rs=bbsconn.execute(sql)
	if from_mobile=1 then
		call dperror(BBS_folder&"wap/info.asp",from_mobile,true,"解除绑定QQ快捷登录成功","")
	else
		call dperror("",from_mobile,true,"解除绑定QQ快捷登录成功",goto_url)
	end if
	
case "modok"
		if len(user_tel)>0 then call dperror("",from_mobile,not isNumeric(user_tel),"电话号码必须是数字",goto_url)
		if len(user_qq)>0 then call dperror("",from_mobile,not isNumeric(user_qq),"QQ号码必须是数字",goto_url)
		
		call dperror("",from_mobile,len(user_name)=0 or isnull(user_name),"请填写昵称",goto_url)
		user_name=left(user_name,12)
		call dperror("",from_mobile,len(user_password)=0 or isnull(user_password),"请填写密码",goto_url)
		call dperror("",from_mobile,len(user_password2)=0 or isnull(user_password2),"请填写确认密码",goto_url)
		call dperror("",from_mobile,user_password<>user_password2,"两次密码输入不一致",goto_url)
		
	user_name=replace_filter(user_name,bbsset_Filter_word)	
	sql="select * from BBS_User where user_name='"& user_name &"' and  user_id<>"& modid &""
	
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,1
	call dperror("",from_mobile,not rs.eof,"重复的会员昵称",goto_url)
		
		
	if user_password<>user_password_old then user_password=md5(user_password)
	
	user_sign=replace_filter(user_sign,bbsset_Filter_word)
		

	
	'修改会员资料
	sql="update BBS_User set msg_open="& msg_open &",user_tel='"& user_tel &"',user_qq='"& user_qq &"',user_sign='"& user_sign &"',user_sex="& user_sex &",user_name='"& user_name &"',user_password='"& user_password &"' where user_id="& modid &""
		
	set rs=bbsconn.execute(sql)
	
	if from_mobile=1 then
		call dperror(BBS_folder&"wap/index.asp?bt_show=4",from_mobile,true,"修改成功","")
	else
		call dperror("",from_mobile,true,"恭喜您!修改资料成功",goto_url)
	end if	
	
end select

%>


</body>
</html>