<!-- #include file="../inc/conn-bbs.asp" -->
<!Doctype html>
<html>
<%
	user_num=trim_fun(trim(request("user_num")))
	user_pw=trim_fun(trim(request("user_pw")))
	user_rzm=trim_fun(trim(request("user_rzm")))
	user_rzm_2=trim(session("validateCode"))
	call dperror_admin(len(user_num)=0 or isnull(user_num),"�������û���","")
	call dperror_admin(len(user_pw)=0 or isnull(user_pw),"����������","")

	call dperror_admin(user_rzm<>user_rzm_2,"��֤�����벻��ȷ","")
	sql="select * from bbs_admin where admin_num='"& user_num &"' and admin_pw='"& user_pw &"'"
	set rs=bbsconn.execute(sql)
	call dperror_admin(rs.eof,"�û������������","")
	
	session("admin_num")=rs("admin_num")
	'��ջ�Ա��¼��Ϣ
	
	Response.Cookies("xq_bbs")("user_id")=""
	Response.Cookies("xq_bbs")("user_name")=""
	Response.Cookies("xq_bbs")("user_num")=""
	Response.Cookies("xq_bbs")("user_state")=""
	Response.Cookies("xq_bbs")("admin_id")=""

	
	response.Redirect("main.asp")
	response.End()
	

%>
<head>
<meta charset="gb2312">
<title>��¼���</title>
</head>
<body>

</body>
</html>