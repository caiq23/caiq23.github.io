<!--#include file="../inc/conn.asp"-->
<%
If IsUser<>1 then
%>
document.writeln("		<form action=\"<%=SitePath%>User\/Userlogin.asp?action=login\" method=\"post\" name=loginForm>");
document.writeln("		<div class=\"loginForm\">用户名：<input name=\"Username\" class=\"borderall\" type=\"text\" size=\"15\" style=\"width:80px;height:15px;\">");
document.writeln("		密码：<input name=\"PassWord\" class=\"borderall\" type=\"password\" maxlength=\"16\" size=\"15\" style=\"width:80px;height:15px;\">");
document.writeln("		<input type=\"checkbox\" name=\"CookieDate\" id=\"CookieDate\" style=\"border:0;\"\/>保存<\/div>");
document.writeln("		<div class=\"loginSelect\"><input id=\"loginBtn\" type=\"submit\" value=\"登录\">");

//如果不需要QQ登录功能，请在下面一行的最前面加上双斜杠，即：//即可
document.writeln("		<a id=\"loginQq\" href=\"<%=SitePath%>api\/qq\/redirect_to_login.asp\">用qq登录<\/a>");

document.writeln("		<input id=\"loginBtn\" type=\"button\" value=\"注册\" onClick=\"window.location.href=\'<%=SitePath%>User\/userreg.asp\'\"><\/div>");
document.writeln("		<\/form>");
<%else%>
document.writeln("<div style=\"margin-left:10px;line-height:20px;\">欢迎你：<%=username%>，<%=moneyname%>：<b><%=mymoney%><\/b>　等级：<%=UserGroupInfo(LaoYdengji,0)%>　<a href=\"<%=SitePath%>User\/UserAdd.asp?action=useredit\">修改资料<\/a>　<a href=\"<%=SitePath%>User\/UserAdd.asp?action=add\">发表文章<\/a>　<a href=\"<%=SitePath%>User\/UserLogin.asp?action=logout\">退出<\/a><\/div>");
<%end if%>