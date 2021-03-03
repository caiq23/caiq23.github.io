<!-- #include file="conn-bbs.asp" -->

<%
id=Request("id")
findcontent=Request("findcontent")
pageno=Request("pageno")
chk_type=trim(Request("chk_type"))
chk_value=trim(Request("chk_value"))
%>
<!Doctype html>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
</HEAD>
<BODY>
<%
select case chk_type
	case "hynumber"
		sql="select id from BBS_User where user_num='"& chk_value &"'"
		set rs=bbsconn.execute(sql)	
		chk_true=rs.eof
end select
if len(chk_value)>0 then
	if chk_true=false then
		chk_true="<font color=red>已被占用</font>"
	else
		chk_true="<font color=green>无重复</font>"
	end if
else
		chk_true="<font color=red>*</font>"
end if

%>

<script>
window.parent.document.getElementById("chk_<%=chk_type%>").innerHTML="<%=chk_true%>";
</script>
</BODY>
</HTML>