<!--#include file="../Inc/conn.asp"-->
<!--#include file="../Inc/md5.asp"-->
<!--#include file="admin_check.asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>网站后台管理</title>
<LINK href="images/Admin_css.css" type=text/css rel=stylesheet>
<script src="js/admin.js"></script>
</head>

<body>
<%
Call chkAdmin(11)
		if request("action")="save" then
		call savegrade()
		elseif request("action")="add" then
		call add()
		elseif request("action")="savenew" then
		call savenew()
		elseif request("action")="del" then
		call del()
		else
		call gradeinfo()
		end if
sub gradeinfo()
%>
<form method="POST" action=admin_group.asp?action=save>
<table width="95%" border="0"  align=center cellpadding="3" cellspacing="2" bgcolor="#FFFFFF" class="admintable">
<tr> 
<th height="23" colspan="8" class="admintitle" >用户等级设定[<a href="?action=add">添加</a>]</th>
</tr>
<tr> 
<td width="20%" height="30" align="center" bgcolor="#f7f7f7" class="ButtonList"><B>等级名称</B></td>
<td width="20%" bgcolor="#f7f7f7" class="ButtonList">前台发表文章免审</td>
<td width="10%" bgcolor="#f7f7f7" class="ButtonList">上传图片</td>
<td width="30%" bgcolor="#f7f7f7" class="ButtonList"><B>图片</B></td>
<td width="20%" bgcolor="#f7f7f7" class="ButtonList"><B>操作</B></td>
</tr>
<%
set rs=conn.Execute("select * from "&tbname&"_UserGroup order by UserPowers asc")
do while not rs.eof
	%>
	<input type=hidden value="<%=rs("UserGroupID")%>" name="GroupNameid">
	<tr> 
	<td align="center" bgcolor="#f7f7f7" class=Forumrow><input size=15 value="<%=rs("GroupName")%>" name="GroupName" type="text">
	</td>
	<td align="center" bgcolor="#f7f7f7" class=Forumrow>
	  <select name="postyn" id="postyn">
	    <option value="0"<%If rs("postyn")=0 then Echo " selected=""selected""" end if%> style="color:#F00">是</option>
	    <option value="1"<%If rs("postyn")=1 then Echo " selected=""selected""" end if%>>否</option>
      </select></td>
	<td align="center" bgcolor="#f7f7f7" class=Forumrow><select name="uploadyn" id="uploadyn">
	  <option value="1"<%If rs("uploadyn")=1 then Echo " selected=""selected""" end if%> style="color:#F00">是</option>
	  <option value="0"<%If rs("uploadyn")=0 then Echo " selected=""selected""" end if%>>否</option>
    </select></td>
	<td bgcolor="#f7f7f7" class=Forumrow><input size=15 value="<%=rs("grouppic")%>" name="dengjipic" type=text><img src="../images/level/<%=rs("GroupPic")%>"></td>
	<td align="center" bgcolor="#f7f7f7" class=Forumrow><a href="Admin_User.asp?usergroupid=<%=rs("UserGroupID")%>">列出用户</a> <%If Rs("UserGroupID")>2 Then%><a href="?action=del&id=<%=rs("UserGroupID")%>">删除</a><%End If%></td>
	</tr>
	<%
	rs.movenext
	loop
rs.close
set rs=nothing
%>
<tr> 
<td colspan=8 align="center" bgcolor="#f7f7f7" class=Forumrow> 
<input name="Submit" type="submit" class="bnt" value=" 编 辑 "></td>
</tr>
</table>
</form>
<%
end sub

Sub savegrade()
	Server.ScriptTimeout=99999999
	Dim GroupNameid,iuserclass,GroupName,UserPowers,dengjipic,groupid
	For i=1 to request.form("GroupNameid").count
		GroupNameid=replace(request.form("GroupNameid")(i),"'","")
		GroupName=replace(request.form("GroupName")(i),"'","")
		dengjipic=replace(request.form("dengjipic")(i),"'","")
		postyn=request.form("postyn")(i)
		uploadyn=request.form("uploadyn")(i)
		if isnumeric(GroupNameid) and isnumeric(iuserclass) and GroupName<>"" and isnumeric(UserPowers) and dengjipic<>"" and isnumeric(groupID) then
		conn.Execute("Update "&tbname&"_UserGroup set GroupName='"&GroupName&"',grouppic='"&dengjipic&"',postyn="&postyn&",uploadyn="&uploadyn&" where usergroupid="&GroupNameID)
		end if
	next
	Call Alert ("设置成功!","admin_group.asp")
	set rs=nothing
End Sub

sub add()
%>
<form method="POST" action=admin_group.asp?action=savenew>
<table width="95%" border="0"  align=center cellpadding="3" cellspacing="1" bgcolor="#F7f7f7" class="admintable">
<tr> 
<th colspan="2" class="admintitle">添加新的用户等级</th>
</tr>
<tr>
<td width="10%" align="center" bgcolor="#FFFFFF" class=forumrow><B>等级名称</B></td>
<td bgcolor="#FFFFFF" class=forumrow><input size=30 name="GroupName" type=text></td>
</tr>
<tr>
  <td align="center" bgcolor="#FFFFFF" class=forumrow><B>等级图片</B></td>
  <td bgcolor="#FFFFFF" class=forumrow><input name="dengjipic" type=text value="01.gif" size=30>&nbsp;</td>
</tr>
<tr> 
<td colspan=2 class=forumrow> 
  <input name="Submit" type="submit" class="bnt" value="提 交"></td>
</tr>
</table>
</form>
<%
end sub
sub savenew()
GroupName=request.form("GroupName")
dengjipic=request.form("dengjipic")
If GroupName="" then Call Alert ("等级名称不能为空!",-1)
Dim GroupTitle,GroupPic
set rs = server.CreateObject ("Adodb.recordset")
sql="select * from "&tbname&"_UserGroup where GroupName='"&GroupName&"'"
rs.open sql,conn,1,3
if rs.eof and rs.bof then
rs.addnew
rs("GroupName")=GroupName
rs("grouppic")=dengjipic
rs("postyn")=1
rs("uploadyn")=0
rs.update
else
	Call Alert ("该等级名称已经存在!","-1")
	exit sub
end if
rs.close
set rs=nothing
Call Alert ("添加成功!","Admin_Group.Asp")
end sub

sub del()
Server.ScriptTimeout=99999999
dim UserPowers,minuserclass
if isnumeric(request("id")) then
if CLng(request("id"))<3 then
	Call Alert ("系统默认等级不能删除!","-1")
	exit sub
end if
Conn.Execute("Update ["&tbname&"_User] set usergroupid=1 where usergroupid="&request("id")&"")
Conn.Execute("delete from "&tbname&"_UserGroup where usergroupid="&request("id")&"")
Call Alert ("删除成功!","admin_group.asp")
set rs=nothing
End If
End Sub
%>
<!--#include file="Admin_copy.asp"-->
</body>
</html>