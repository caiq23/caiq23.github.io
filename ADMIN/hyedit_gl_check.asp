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
		
		call dperror_admin(modid=0,"��ȡ��Ա��Ϣ���������µ�¼������","")
		call dperror_admin(user_state<1,"��ѡ���Ա״̬","")
		call dperror_admin(len(user_name)=0 or isnull(user_name),"����д�ǳ�","")
		call dperror_admin(len(user_password)=0 or isnull(user_password),"����д����","")
		if user_password<>user_password_old then user_password=md5(user_password)
		

	
	'�޸Ļ�Ա����
	sql="update BBS_User set user_name='"& user_name &"',user_password='"& user_password &"',user_state="& user_state &" where user_id="& modid &""
	set rs=bbsconn.execute(sql)
	
	call dperror_admin(true,"�޸ĳɹ�","")

%>
<head>
<meta charset="gb2312">
<title>�޸�����</title>
</head>
<body>

</body>
</html>