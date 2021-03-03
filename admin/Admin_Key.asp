<!--#include file="../Inc/conn.asp"-->
<!--#include file="../Inc/Function_Page.asp"-->
<!--#include file="Admin_check.asp"-->
<%
Call chkAdmin(10)
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>网站后台管理</title>
<link href="images/Admin_css.css" type=text/css rel=stylesheet>

<script src="js/admin.js"></script>
</head>

<body>
<table width="95%" border="0" cellspacing="2" cellpadding="3"  align=center class="admintable" style="margin-bottom:5px;">
    <tr><form name="form1" method="get" action="Admin_key.asp">
      <td height="25" bgcolor="f7f7f7">
        <a href="?hits=1"></a>
        <input name="keyword" type="text" id="keyword" value="<%=request("keyword")%>">
        <input type="submit" name="Submit2" value="搜索">      </td>
      </form>
    </tr>
</table>
<%
page=request("page")
	if request("action") = "add" then 
		call add()
	elseif request("action")="edit" then
		call edit()
	elseif request("action")="savenew" then
		call savenew()
	elseif request("action")="savedit" then
		call savedit()
	elseif request("action")="yn1" then
		call yn1()
	elseif request("action")="yn2" then
		call yn2()
	elseif request("action")="del" then
		call del()
	elseif request("action")="delAll" then
		call delAll()
	else
		call List()
	end if

sub List()
%>
<form name="myform" method="POST" action="Admin_key.asp?action=delAll">
<table width="95%" border="0"  align=center cellpadding="3" cellspacing="2" bgcolor="#FFFFFF" class="admintable">
<tr> 
  <td colspan="5" align=left class="admintitle">关键字列表　[<a href="?action=add">添加</a>]</td>
</tr>
<tr bgcolor="#f1f3f5" style="font-weight:bold;">
	<td width="3%" height="30" align="center" class="ButtonList">&nbsp;</td>
    <td width="23%" height="30" align="center" class="ButtonList">关键字名称</td>
    <td width="56%" align="center" class="ButtonList">链接地址</td>
    <td width="6%" height="25" align="center" bgcolor="#f1f3f5" class="ButtonList">优先级</td>
    <td width="12%" height="25" align="center" bgcolor="#f1f3f5" class="ButtonList">管理</td>    
  </tr>
<%
keyword=request("keyword")
NOI=0
Set mypage=new xdownpage
mypage.getconn=conn
mysql="select * from "&tbname&"_Key"
	if keyword<>"" then
	mysql=mysql&" Where Title like '%"&keyword&"%' or Url like '%"&keyword&"%'"
	End if
mysql=mysql&" order by ID desc"
mypage.getsql=mysql
mypage.pagesize=15
set rs=mypage.getrs()
for i=1 to mypage.pagesize
    if not rs.eof then
NOI=NOI+1
%>
    <tr bgcolor="#f1f3f5" onMouseOver="this.style.backgroundColor='#EAFCD5';this.style.color='red'" onMouseOut="this.style.backgroundColor='';this.style.color=''">
    <td height="25" align="CENTER"><input type="checkbox" value="<%=rs("ID")%>" name="ID" onClick="unselectall(this.form)" style="border:0;">
      <input name="KeyID" type="hidden" id="KeyID" value="<%=rs("ID")%>"></td>
    <td height="25"><%=NOI%>.<%=rs("Title")%></td>
    <td height="25" align="center"><input name="Url" type="text" id="Url" value="<%=rs("Url")%>" size="60" maxlength="250"></td>
    <td height="25" align="center"><input name="Num" type="text" id="Num" value="<%=rs("Num")%>" size="6" maxlength="6" onKeyDown="myKeyDown()"></td>
    <td align="center"><a href="?action=edit&id=<%=rs("ID")%>&page=<%=page%>">编辑</a></td>    
  </tr>
<%
        rs.movenext
    else
         exit for
    end if
next
%>
	<tr bgcolor="#f1f3f5" onMouseOver="this.style.backgroundColor='#EAFCD5';this.style.color='red'" onMouseOut="this.style.backgroundColor='';this.style.color=''">
    <td height="25" align="center" bgcolor="#f1f3f5"><input name="Action" type="hidden"  value="Del">
      <input name="chkAll" type="checkbox" id="chkAll" onClick=CheckAll(this.form) value="checkbox" style="border:0"></td>
    <td height="25" colspan="4" bgcolor="#f1f3f5"><input name="Del" type="submit" class="bnt" id="Del"  onClick="JavaScript:return confirm('删除吗？')" value="删除">
      <input name="Del" type="submit" class="bnt" id="Del" value="编辑"></td>
    </tr>
  <tr><td bgcolor="f7f7f7" colspan="5" align="left"><div id="page">
	<ul style="text-align:left;">
    <%=mypage.showpage()%>
    </ul>
</div>
</td></tr>
</table>
</form>
<%
rs.close
set rs=nothing
end sub

sub add()
%>
<table width="95%" border="0"  align=center cellpadding="3" cellspacing="2" bgcolor="#FFFFFF" class="admintable">
<form action="?action=savenew" name="myform" method=post>
<tr> 
    <td colspan="3" align=left class="admintitle">添加关键字 [<a href="Admin_key.asp">关键字列表</a>]</td>
</tr>
<tr> 
<td width="20%" class="b1_1">关键字</td>
<td width="80%" colspan="2" class="b1_1"><input name="Title" type="text" id="Title" size="40" maxlength="50"></td>
</tr>
<tr>
  <td class="b1_1">链接地址</td>
  <td colspan="2" class="b1_1"><input name="Url" type="text" id="Url" value="http://" size="40" maxlength="50"></td>
</tr>
<tr>
  <td class="b1_1">优先级</td>
  <td colspan="2" class="b1_1"><input name="Num" type="text" id="Num" value="0" size="8" maxlength="5" onKeyDown="myKeyDown()"> <font class="note">数字越大越优先</font></td>
</tr>
<tr>
  <td class="b1_1">替换次数</td>
  <td colspan="2" class="b1_1"><input name="Replace" type="text" id="Replace" value="0" size="8" maxlength="5" onKeyDown="myKeyDown()"> <font class="note">一页中此关键字替换的次数,0表示不限</font></td>
</tr>
<tr> 
<td width="20%" class="b1_1"></td>
<td colspan="2" class="b1_1"><input name="Submit" type="submit" class="bnt" value="添 加"></td>
</tr>
</form>
</table>
<%
end sub

sub savenew()
	Title			=trim(request.form("Title"))
	Url				=trim(request.form("Url"))
	Num				=LaoYRequest(request.form("Num"))
	YReplace			=LaoYRequest(request.form("Replace"))
	
	if Title="" or Url="" then
		Call Alert ("请填写完整","-1")
	end if
	If Num="" Then Num=0
	If Url="http://" Then Url="http://"&SiteUrl&SitePath&"Search.asp?KeyWord="&Server.UrlEncode(Title)
	set rs = server.CreateObject ("adodb.recordset")
	sql="select * from "&tbname&"_Key Where Title='"&Title&"'"
	rs.open sql,conn,1,3
	if rs.eof and rs.bof then
		rs.AddNew 
		rs("Title")				=Title
		rs("Url")				=Url	
		rs("Num")				=Num
		rs("Replace")			=YReplace
		rs.update
		Call Alert ("添加成功!","Admin_key.asp")
	Else
		Call Alert ("该关键字已经存在",-1)
	End if
	rs.close
	set rs=nothing
end sub

sub edit()
id=LaoYRequest(request("id"))
set rs = server.CreateObject ("adodb.recordset")
sql="select * from "&tbname&"_Key where id="& id &""
rs.open sql,conn,1,1
%>
<table width="95%" border="0"  align=center cellpadding="3" cellspacing="2" bgcolor="#FFFFFF" class="admintable">
<form action="?action=savedit" name="myform" method=post>
<tr> 
    <td colspan="3" align=left class="admintitle">修改关键字</td>
</tr>
<tr> 
  <td width="20%" class="b1_1">关键字</td>
  <td width="80%" colspan="2" class="b1_1"><input name="Title" type="text" id="Title" value="<%=rs("Title")%>" size="40" maxlength="50"></td>
</tr>
<tr>
  <td class="b1_1">链接地址</td>
  <td colspan="2" class="b1_1"><input name="Url" type="text" id="Url" value="<%=rs("Url")%>" size="40" maxlength="50"></td>
</tr>
<tr>
  <td class="b1_1">优先级</td>
  <td colspan="2" class="b1_1"><input name="Num" type="text" id="Num" value="<%=rs("Num")%>" size="8" maxlength="5" onKeyDown="myKeyDown()">
    <font class="note">数字越大越优先</font></td>
</tr>
<tr>
  <td class="b1_1">替换次数</td>
  <td colspan="2" class="b1_1"><input name="Replace" type="text" id="Replace" value="<%=rs("Replace")%>" size="8" maxlength="5" onKeyDown="myKeyDown()">
    <font class="note">一页中此关键字替换的次数,0表示不限</font></td>
</tr>
<tr> 
  <td width="20%" class="b1_1"><input name="ID" type="hidden" id="ID" value="<%=rs("ID")%>">
    <input name="page" type="hidden" id="page" value="<%=page%>"></td>
  <td colspan="2" class="b1_1"><input name="Submit" type="submit" class="bnt" value="修 改"></td>
</tr>
</form>
</table>
<%
rs.close
set rs=nothing
end sub

sub savedit()
	page			=trim(request.form("page"))
	ID				=trim(request.form("ID"))
	Title			=trim(request.form("Title"))
	Url				=trim(request.form("Url"))
	Num				=LaoYRequest(request.form("Num"))
	YReplace			=LaoYRequest(request.form("Replace"))
	
	if Title="" or Url="" then
		Call Alert ("请填写完整","-1")
	end if
	If Num="" Then Num=0
	If Url="http://" Then Url="http://"&SiteUrl&SitePath&"Search.asp?KeyWord="&Server.UrlEncode(Title)
	set rs = server.CreateObject ("adodb.recordset")
	sql="select * from "&tbname&"_Key where ID="&id&""
	rs.open sql,conn,1,3
	if not(rs.eof and rs.bof) then
	
		rs("Title")				=Title
		rs("Url")				=Url	
		rs("Num")				=Num
		rs("Replace")			=YReplace
		
		rs.update
		Call Alert ("修改成功","Admin_Key.asp?page="&page&"")
	else
		Call Alert ("修改错误",-2)
	end if
	rs.close
	set rs=nothing
end sub

Sub delAll
ID=Trim(Request("ID"))
If ID="" And Request("Del")<>"编辑" Then
	  Call Alert ("请选择记录!","-1")
ElseIf Request("Del")="删除" Then
	set rs=conn.execute("delete from "&tbname&"_Key where ID In(" & ID & ")")
    Call Alert ("操作成功",request.servervariables("http_referer")) 
ElseIf Request("Del")="编辑" Then
	Server.ScriptTimeout=99999999
	Dim Num,AddTimes,LastTime,qq
	For i=1 to request.form("KeyID").count
		KeyID=replace(request.form("KeyID")(i),"'","")
		Num=replace(request.form("Num")(i),"'","")
		Url=replace(request.form("Url")(i),"'","")
		set rs=conn.Execute("select * from "&tbname&"_Key where ID="&KeyID)
		conn.Execute("Update "&tbname&"_Key set Num="&Num&",Url='"&Url&"' where ID="&KeyID)
	next
    Call Alert ("操作成功",request.servervariables("http_referer"))  
End If
End Sub
%>
<!--#include file="Admin_copy.asp"-->
</body>
</html>