<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../TPay/fun-tpay.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>通路网登陆</title>

</head>
<body>
<%
	tlogin_idcode=trim_fun(request.QueryString("tlogin_idcode"))
	call dperror("",0,len(tlogin_idcode)<>14 or isnull(tlogin_log_reopenid),"登录失败！\n返回的tlogin_idcode不是14位数",goto_url)
	

	'返回通路网查询登录的信息
	chk_url="http://www.tlu5.com/tlu5/api/tlogin/chk_loginstatus.asp?tlogin_idcode="&tlogin_idcode
	json_html=read_xmlhttp(chk_url,"gb2312")
	call dperror("",0,len(json_html)=0 or isnull(json_html),"读取查询的XML内容出错",error_url)
	tlogin_log_reopenid=read_json("tlogin_log_reopenid",json_html)
	tlogin_log_nickname=read_json("tlogin_log_nickname",json_html)
	tlogin_log_sex=read_json("tlogin_log_sex",json_html)
	tlogin_log_icon=read_json("tlogin_log_icon",json_html)
	tlogin_log_type=read_json("tlogin_log_type",json_html)
	tlogin_log_type=chk_num(tlogin_log_type)
	
	call dperror("",0,len(tlogin_log_reopenid)=0 or isnull(tlogin_log_reopenid),"登录失败！\n返回的openid为空","/")
	
	tlogin_log_reopenid=lcase(tlogin_log_reopenid)



	sql="select * from BBS_Switch"
	set rs=bbsconn.execute(sql)
	if not rs.eof then
		BBS_Switch=rs("BBS_Switch")
		close_tips=rs("close_tips")
	end if
	BBS_Switch=chk_num(BBS_Switch)
	call dperror("",0,BBS_Switch>1,"登录失败！\n"&close_tips,BBS_folder&"?"&re_myurl)
	
	
	
session("wx_OpenID")=""
session("qq_OpenID")=""
select case tlogin_log_type
	case 1
		call dperror("",0,bbsset_open_qqlogin=2,"登录失败！\n本站已关闭QQ登录",BBS_folder&"?"&re_myurl)		
		session("qq_openid")=tlogin_log_reopenid
		sql="qq_OpenID"
	case 2
		call dperror("",0,bbsset_open_wxlogin=2,"登录失败！\n本站已关闭微信登录",BBS_folder&"?"&re_myurl)
		session("wx_openid")=tlogin_log_reopenid
		sql="wx_openid"
	case else
		call dperror("",0,true,"登录失败！登录类型出错，请重试",BBS_folder&"?"&re_myurl)
end select


'读取是否已经注册
sql="select * from [BBS_User] where ["& sql &"]='"& tlogin_log_reopenid &"'"
set rs=bbsconn.execute(sql)
if not rs.eof then
	user_num=rs("user_num")
	user_password=rs("user_password")
	goto_url="../inc/chk_login.asp?user_num="&user_num&"&user_password="&user_password	

else
	goto_url="../?r1.html"
end if	
Response.Redirect(goto_url)
response.end

%>
</body>
</html>

