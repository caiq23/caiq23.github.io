<!-- #include file="../inc/conn-bbs.asp" -->
<!doctype html>
<html>
<head>
<meta charset="gb2312">
<title>退出</title>
</head>

<body>
</body>
</html>

<%
from_mobile=1

session("user_num")=""
session("user_name")=""
session("user_id")=""
session("admin_num")=""
session("admin_id")=""
session("user_state")=""
session("qq_OpenID")=""
session("wx_openid")=""
session("reg_my_do")=""
session("qq_UserName")=""


		Response.Cookies("xq_bbs")("user_id")=""
		Response.Cookies("xq_bbs")("user_name")=""
		Response.Cookies("xq_bbs")("user_num")=""
		Response.Cookies("xq_bbs")("user_state")=""
		Response.Cookies("xq_bbs")("admin_id")=""

	call dperror(BBS_folder&"wap/",from_mobile,true,"您已退出站点，现在将以游客身份转入首页","")
	
	
	response.End()
%>