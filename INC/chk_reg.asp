<!-- #include file="conn-bbs.asp" -->
<!-- #include file="md5.asp" -->
<!Doctype html>
<html><head>
<meta charset="gb2312">
<title>ע���Ա</title>
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
	call dperror("",from_mobile,rs.eof,"��¼�����û������������",BBS_folder&"?r.html")
	
	user_state=chk_num(rs("user_state"))
	user_name=rs("user_name")
	call dperror("",from_mobile,user_state=3,"��¼��������Ȩ�޵�¼���ѱ�����",BBS_folder&"?r.html")
	call dperror("",from_mobile,len(rs("wx_OpenID"))>0,"�󶨴��󣺸��û��Ѿ�����΢�ŵ�¼��������û�",BBS_folder&"?r.html")
	
	rs("wx_OpenID")=wx_OpenID
	rs.update
	
	call dperror("",from_mobile,true,"��ϲ��΢�ſ�ݵ�¼�ɹ������ڽ��� "& user_name &" ����ݵ�¼","inc/chk_login.asp?user_num="&user_num&"&user_password="&user_password)
case "qq_login"

	user_password=md5(user_password)
	
	sql="select * from BBS_User where user_num='"& user_num &"' and user_password='"& user_password &"'"
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror("",from_mobile,rs.eof,"��¼�����û������������",BBS_folder&"?r.html")
	
	user_state=chk_num(rs("user_state"))
	user_name=rs("user_name")
	call dperror("",from_mobile,user_state=3,"��¼��������Ȩ�޵�¼���ѱ�����",BBS_folder&"?r.html")
	call dperror("",from_mobile,len(rs("qq_OpenID"))>0,"�󶨴��󣺸��û��Ѿ�����QQ��¼��������û�",BBS_folder&"?r.html")
	
	rs("qq_OpenID")=qq_OpenID
	rs.update
	
	call dperror("",from_mobile,true,"��ϲ��QQ��ݵ�¼�ɹ������ڽ��� "& user_name &" ����ݵ�¼","inc/chk_login.asp?user_num="&user_num&"&user_password="&user_password)
	
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
				'�������6λ��
				Randomize Timer 
				user_id = Int(899999 * Rnd + 100000)
				sql="select id from BBS_User where user_id="& user_id &""
				set rs=bbsconn.execute(sql)
				if rs.eof then exit for
				call dperror("",from_mobile,i>=100,"ϵͳ�����û�ID�������Ժ�������",index_url&"r.html")
			next
		end if
	
		if len(user_tel)>0 then call dperror("",from_mobile,not isNumeric(user_tel),"�绰�������������",index_url&"r.html")
		if len(user_qq)>0 then call dperror("",from_mobile,not isNumeric(user_qq),"QQ�������������",index_url&"r.html")
		
	call dperror("",from_mobile,len(user_num)=0 or isnull(user_num),"�������»�Ա��¼�ʺ�",index_url&"r.html")
	user_num=LCase(user_num)
	call dperror("",from_mobile,user_num="admin","��Ա��¼�ʺŲ���Ϊadmin",index_url&"r.html")
	call dperror("",from_mobile,len(user_num)<4 or len(user_num)>12,"��Ա��¼�ʺű������4λС��12λ֮��",index_url&"r.html")
	
	call dperror("",from_mobile,len(user_name)=0 or isnull(user_name),"�������»�Ա�ǳ�",index_url&"r.html")
	call dperror("",from_mobile,len(user_password)=0 or isnull(user_password),"�������»�Ա����",index_url&"r.html")
	call dperror("",from_mobile,user_password<>user_password2,"�������벻һ��",index_url&"r.html")
	
	
	sql="select id from BBS_User where user_id="& user_id &""
	set rs=bbsconn.execute(sql)
	call dperror("",from_mobile,not rs.eof,"�û�ID�ظ������Ժ�������",index_url&"r.html")
	
	
	sql="select * from BBS_User where user_name='"& user_name &"'"
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,1
	call dperror("",from_mobile,not rs.eof,"�ظ��Ļ�Ա�ǳ�",index_url&"r.html")
	
	sql="select * from BBS_User where user_num='"& user_num &"'"
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror("",from_mobile,not rs.eof,"�ظ��Ļ�Ա�ʺ�",index_url&"r.html")
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

	call dperror("",0,true,"��ϲע��ɹ������ڽ��� "& user_name &" ����ݵ�¼","inc/chk_login.asp?from_mobile="& from_mobile &"&user_num="&user_num&"&user_password="&user_password)
	
	
	
end select
	response.End()


%>

</body>
</html>