<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/md5.asp" -->
<!-- #include file="../inc/chk_session.asp" -->
<!Doctype html>
<html>
<head>
<meta charset="gb2312">
<title>�޸�����</title>
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
		
		
		call dperror("",from_mobile,modid<=0,"��ȡ��Ա��Ϣ���������µ�¼������",goto_url)
		
select case mydo
case "cancel_wx"
	'���΢�ſ�ݵ�¼
	sql="update BBS_User set wx_OpenID='' where user_id="& modid &""		
	set rs=bbsconn.execute(sql)
	if from_mobile=1 then
		call dperror(BBS_folder&"wap/info.asp",from_mobile,true,"�����΢�ſ�ݵ�¼�ɹ�","")
	else
		call dperror("",from_mobile,true,"�����΢�ſ�ݵ�¼�ɹ�",goto_url)
	end if
case "cancel_qq"
	'���QQ��ݵ�¼
	sql="update BBS_User set qq_OpenID='' where user_id="& modid &""		
	set rs=bbsconn.execute(sql)
	if from_mobile=1 then
		call dperror(BBS_folder&"wap/info.asp",from_mobile,true,"�����QQ��ݵ�¼�ɹ�","")
	else
		call dperror("",from_mobile,true,"�����QQ��ݵ�¼�ɹ�",goto_url)
	end if
	
case "modok"
		if len(user_tel)>0 then call dperror("",from_mobile,not isNumeric(user_tel),"�绰�������������",goto_url)
		if len(user_qq)>0 then call dperror("",from_mobile,not isNumeric(user_qq),"QQ�������������",goto_url)
		
		call dperror("",from_mobile,len(user_name)=0 or isnull(user_name),"����д�ǳ�",goto_url)
		user_name=left(user_name,12)
		call dperror("",from_mobile,len(user_password)=0 or isnull(user_password),"����д����",goto_url)
		call dperror("",from_mobile,len(user_password2)=0 or isnull(user_password2),"����дȷ������",goto_url)
		call dperror("",from_mobile,user_password<>user_password2,"�����������벻һ��",goto_url)
		
	user_name=replace_filter(user_name,bbsset_Filter_word)	
	sql="select * from BBS_User where user_name='"& user_name &"' and  user_id<>"& modid &""
	
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,1
	call dperror("",from_mobile,not rs.eof,"�ظ��Ļ�Ա�ǳ�",goto_url)
		
		
	if user_password<>user_password_old then user_password=md5(user_password)
	
	user_sign=replace_filter(user_sign,bbsset_Filter_word)
		

	
	'�޸Ļ�Ա����
	sql="update BBS_User set msg_open="& msg_open &",user_tel='"& user_tel &"',user_qq='"& user_qq &"',user_sign='"& user_sign &"',user_sex="& user_sex &",user_name='"& user_name &"',user_password='"& user_password &"' where user_id="& modid &""
		
	set rs=bbsconn.execute(sql)
	
	if from_mobile=1 then
		call dperror(BBS_folder&"wap/index.asp?bt_show=4",from_mobile,true,"�޸ĳɹ�","")
	else
		call dperror("",from_mobile,true,"��ϲ��!�޸����ϳɹ�",goto_url)
	end if	
	
end select

%>


</body>
</html>