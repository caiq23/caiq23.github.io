<!-- #include file="conn-bbs.asp" -->
<!-- #include file="../inc/chk_session.asp" -->
<!Doctype html>
<html>

    
<%
	sql="delete * from BBS_Alert where alert_num2="& session_user_id &""
	set rs=bbsconn.execute(sql)	
	
	call dperror("",0,true,"ɾ���ɹ�",index_url&"a"& session_user_id &".html")
	response.End()


%>
<head>
<meta charset="gb2312">
<title>ע���Ա</title>
</head>
<body>
</body>
</html>