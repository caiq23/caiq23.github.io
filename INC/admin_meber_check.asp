<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/check_admin_session.asp" -->
<!-- #include file="../inc/fun-admin.asp" -->
<!Doctype html>
<html>
<head>
<meta charset="gb2312">
<title><%=this_title%>��Ա</title>
</head>
<body>
<%
		page_no=chk_num(trim_fun(request("page_no")))
		modid=chk_num(trim_fun(request("modid")))
		mydo=trim_fun(request("mydo"))
		call dperror_admin(len(modid)=0 or isnull(modid),"��ȡ�û�ID�������˳���¼���²���","")

  select case mydo
  
	  case "del_user_img"
	  	'ɾ����ԱͼƬ
		sql="select * from BBS_User where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then
			user_img=rs("user_img")
			call del_userimg(user_img)
		end if
		temp_i=del_user_all_postimg(modid)		
		call dperror_referrer(temp_i)
  	  case "vip"
	  	'VIP��Ա	  	
		sql="update BBS_User set user_state=4 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("����vip�ɹ�")
	  case "unvip"
	  	'���VIP��Ա	  	
		sql="update BBS_User set user_state=1 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("���VIP�ɹ�")
  	  case "pass"
	  	'��������	  	
		sql="update BBS_User set user_state=5 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("�������������ɹ�")
	  case "unpass"
	  	'�����������	  	
		sql="update BBS_User set user_state=1 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("������������ɹ�")
	  case "gag"
	  	'���Ի�Ա	  	
		sql="update BBS_User set user_state=2 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("���Գɹ�")
	  case "ungag"
	  	'�������	  	
		sql="update BBS_User set user_state=1 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("������Գɹ�")
	  case "lock"
	  	'������Ա	  	
		sql="update BBS_User set user_state=3 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("�����ɹ�")
	  case "unlock"
	  	'������Ա
		sql="update BBS_User set user_state=1 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("�����ɹ�")
	  case "del_user_post"
	  	'ɾ����Ա	
		call del_user_post(modid)
		
		call dperror_referrer("ɾ���������ӳɹ�")
	  case "del_user"
	  	'ɾ����Ա
		sql="select * from BBS_User where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then
			user_img=rs("user_img")
			call del_userimg(user_img)
		end if			
		call del_user(modid)
		call dperror_referrer("ɾ����Ա�ɹ�")
  end select


%>

</body>
</html>