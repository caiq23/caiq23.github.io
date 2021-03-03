<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/check_admin_session.asp" -->
<!-- #include file="../inc/fun-admin.asp" -->

<!doctype html>
<html>
<head>
<meta charset="gb2312">
<title>清除缓存</title>
</head>

<body>
<%
		call del_cache()
		call dperror_admin(true,"清除缓存成功","admin_cache.asp")
%>
</body>
</html>
