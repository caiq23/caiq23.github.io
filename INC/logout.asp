<!-- #include file="../inc/conn-bbs.asp" -->
<!doctype html>
<html>
<head>
<meta charset="gb2312">
<title>�˳�</title>
</head>

<body>
</body>
</html>

<%
from_mobile=chk_num(trim_fun(request("from_mobile")))
myurl=trim_fun(request("myurl"))
if len(myurl)>0 and myurl<>"g1.html" then
myurl=index_url&myurl
else
myurl=BBS_folder
end if
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


	if from_mobile=1 then
		call dperror(BBS_folder&"wap/",from_mobile,true,"�����˳�վ�㣬���ڽ����ο����ת����ҳ","")
	else
		call dperror("",from_mobile,true,"�����˳�վ�㣬���ڽ����ο����ת���˳�ǰҳ�棬���Ժ�......",myurl)
	end if
	
	
	response.End()
%>