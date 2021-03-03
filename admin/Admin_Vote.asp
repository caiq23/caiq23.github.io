<!--#include file="../Inc/conn.asp"-->
<!--#include file="../Inc/Function_Page.asp"-->
<!--#include file="Admin_check.asp"-->
<%
Call chkAdmin(9)
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>无标题文档</title>
<link href="images/Admin_css.css" type=text/css rel=stylesheet>

<script src="js/admin.js"></script>
</head>

<body>
<%
	if request("action") = "add" then 
		call add()
	elseif request("action")="edit" then
		call edit()
	elseif request("action")="savenew" then
		call savenew()
	elseif request("action")="savedit" then
		call savedit()
	elseif request("action")="delAll" then
		call delAll()
	elseif request("action")="show" then
		call show()
	else
		call List()
	end if

sub list
%>
<form name="myform" method="POST" action="Admin_Vote.asp?action=delAll">
<table border="0"  align="center" cellpadding="3" cellspacing="2" bgcolor="#FFFFFF" class="admintable">
<tr> 
  <td colspan="8" align=left class="admintitle">所有投票　[<a href="?action=add">添加</a>]</td>
</tr>
  <tr align="center"> 
    <td colspan="2" class="ButtonList">投票标题</td>
    <td width="9%" class="ButtonList">ID号</td>
    <td width="21%" class="ButtonList">投票时间</td>
    <td width="11%" class="ButtonList">状态</td>
    <td width="5%" class="ButtonList">排序</td>
    <td width="17%" class="ButtonList">操 作</td>
  </tr>
<%
page=request("page")
Set mypage=new xdownpage
mypage.getconn=conn
mysql="select * from "&tbname&"_Vote order by id desc"
mypage.getsql=mysql
mypage.pagesize=14
set rs=mypage.getrs()
for i=1 to mypage.pagesize
    if not rs.eof then
%>
    <tr bgcolor="#f1f3f5" onMouseOver="this.style.backgroundColor='#EAFCD5';this.style.color='red'" onMouseOut="this.style.backgroundColor='';this.style.color=''">
    <td width="5%" height="25" align="center"><input type="checkbox" value="<%=rs("ID")%>" name="ID" onClick="unselectall(this.form)" style="border:0;"></td>
    <td width="30%" class="tdleft"><%=rs("Title")%></td>
    <td height="25" align="center"><%=rs("ID")%></td>
    <td height="25" align="center"><%=FormatDate(rs("StartTime"),11,1)%>至<%=FormatDate(rs("EndTime"),11,1)%></td>
    <td height="25" align="center"><%=IIF(rs("yn")=1,"正常","<font color=red>隐藏</font>")%></td>
    <td height="25" align="center"><%=rs("Px")%></td>
    <td align="center"><a href="?action=edit&id=<%=rs("ID")%>">编辑</a> <a href="?action=show&id=<%=rs("ID")%>">查看结果</a></td>
    </tr>
<%
        rs.movenext
    else
         exit for
    end if
next
%>
<tr>
  <td align=center bgcolor="#F2F9E8"><input name="Action" type="hidden"  value="Del"><input name="chkAll" type="checkbox" id="chkAll" onClick=CheckAll(this.form) value="checkbox" style="border:0"></td>
  <td align=center class=b1_1><input name="Del" type="submit" class="bnt" id="Del" value="隐藏">
    <input name="Del" type="submit" class="bnt" id="Del" value="显示">
    <input name="Del" type="submit" class="bnt" id="Del" value="删除"></td>
  <td colspan="6" align=center class=b1_1>调用代码：&lt;%Call ShowVote(ID号)%&gt;</td>
  </tr>
<tr>
  <td colspan=8 align=center class=b1_1><div id="page">
    <ul style="text-align:left;">
      <%=mypage.showpage()%>
    </ul>
  </div></td>
</tr>
</table>
</form>
<%
	rs.close
	set rs=nothing
end sub

Sub add()
%>
  <table width="95%" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#f7f7f7" class="admintable">
  <form name="add" method="post" action="?action=savenew">
    <tr>
      <td colspan="2" align="center" class="admintitle">添加新投票</td>
    </tr>
    <tr>
      <td width="15%" align="center" bgcolor="#FFFFFF">投票名称：      </td>
      <td width="85%" bgcolor="#FFFFFF"><input name="t0" type="text" class="input" id="t0" size="50" maxlength="50"></td>
    </tr>
    <tr>
      <td align="center" bgcolor="#FFFFFF">投票选项：      </td>
      <td bgcolor="#FFFFFF"><input name='t1' type='radio' class="noborder" value='1'  checked />单选 <input  name='t1' type='radio' class="noborder" value='0' />多选</td>
    </tr>
    <tr>
      <td align="center" bgcolor="#FFFFFF">项目内容：<br><br>
      <font class="note">格式：<br><br>项目标题|票数</font></td>
      <td bgcolor="#FFFFFF">
      <textarea name="votes" id="votes" cols="50" rows="10">投票选项一|0
投票选项二|0</textarea></td>
    </tr>
    <tr>
      <td align="center" bgcolor="#FFFFFF">投票时间：</td>
      <td bgcolor="#FFFFFF"><input name="StartTime" type="text" class="input" value="<%=Now%>" size="20">
        -
        <input name="EndTime" type="text" class="input" value="<%=Now+30%>" size="20"></td>
    </tr>
    <tr>
      <td align="center" bgcolor="#FFFFFF">排序：</td>
      <td bgcolor="#FFFFFF"><input name="Px" type="text" id="Px" value="1" size="6" maxlength="5">
      <span class="note">数字小的排在前面</span></td>
    </tr>
 
    <tr>
	  <td bgcolor="#FFFFFF">&nbsp;</td>
      <td bgcolor="#FFFFFF"><input name="Submit" type="submit" class="bnt" value="添 加">
        <input name="Submit23" type="button" class="bnt" onClick="history.go(-1)" value="返 回"></td>
    </tr>
	</form>
  </table>
<%
end sub

sub edit
id=request("id")
set rs = server.CreateObject ("adodb.recordset")
sql="select id,title,stype,vote,result,StartTime,EndTime,Px from "&tbname&"_Vote where id="& id &""
rs.open sql,conn,1,1
%>
  <table width="95%" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#f7f7f7" class="admintable">
  <form name="add" method="post" action="?action=savedit&id=<%=id%>">
  <tr>
      <td colspan="2" align="center" class="admintitle">修改投票</td>
    </tr>
    <tr>
      <td width="15%" align="center" bgcolor="#FFFFFF">投票名称：      </td>
      <td width="85%" bgcolor="#FFFFFF"><input name="t0" type="text" class="input" id="t0" value="<%=rs(1)%>" size="50" maxlength="50"></td>
    </tr>
    <tr>
      <td align="center" bgcolor="#FFFFFF">投票选项：      </td>
      <td bgcolor="#FFFFFF"><input name='t1' type='radio' class="noborder" value='1' <%If rs(2)=1 then Response.Write("checked") end if%>/>
      单选 <input  name='t1' type='radio' class="noborder" value='0' <%If rs(2)=0 then Response.Write("checked") end if%> />
      多选</td>
    </tr>
    <tr>
      <td align="center" bgcolor="#FFFFFF">项目内容：</td>
      <td bgcolor="#FFFFFF">
      <textarea name="votes" id="votes" cols="50" rows="10"><%
result=split(rs(4),"|")
	for i=0 to ubound(result)
next
vote=split(rs(3),"|")
for i=0 to ubound(vote)-1
	Response.Write CHR(10)&""&vote(i)&"|"&result(i)&""
next
%></textarea></td>
    </tr>
    <tr>
      <td align="center" bgcolor="#FFFFFF">投票时间：</td>
      <td bgcolor="#FFFFFF"><input name="StartTime" type="text" class="input" value="<%=rs(5)%>" size="20">
        -
        <input name="EndTime" type="text" class="input" value="<%=rs(6)%>" size="20"></td>
    </tr>
    <tr>
      <td align="center" bgcolor="#FFFFFF">排序：</td>
      <td bgcolor="#FFFFFF"><input name="Px" type="text" id="Px" value="<%=rs(7)%>" size="6" maxlength="5">
        <span class="note">数字小的排在前面</span></td>
    </tr>
	 
    <tr>
	  <td bgcolor="#FFFFFF">&nbsp;</td>
      <td bgcolor="#FFFFFF"><input name="Submit" type="submit" class="bnt" value="保 存">
        <input name="Submit22" type="button" class="bnt" onClick="history.go(-1)" value="返 回"></td>
    </tr>
	</form>
  </table>
<%
rs.close
set rs=nothing
end sub

Sub savenew()

t0			=trim(request("t0"))
t1			=trim(request("t1"))
votes		=trim(request("votes"))
StartTime	=trim(request("StartTime"))
EndTime		=trim(request("EndTime"))
Px			=trim(request("Px"))

If votes="" then
Call Alert ("项目内容不能为空!",-1)
End if
 
votes=split(votes,CHR(10))
for i=0 to ubound(votes)
if not instr(trim(votes(i)),"|")>0 then
Call Alert ("投票选项"&i+1&"有错误!",-1)
end if
 somevote=split(trim(votes(i)),"|")
   for j=0 to ubound(somevote)
   s=trim(somevote(0))
   s1=trim(somevote(1))
   if not isnumeric(s1) then
   Call Alert ("投票选项"&i+1&"有错误!",-1)
   end if
   next  
   vote=vote&s&"|"
   result=result&s1&"|"
next

	set rs = server.CreateObject ("adodb.recordset")
	sql="Select * from "&tbname&"_Vote where Title='"& Title &"'"
	rs.open sql,conn,1,3
	if rs.eof and rs.bof then
		rs.AddNew 
		rs("Title")			=t0
		rs("vote")			=vote
		rs("result")		=result
		rs("stype")			=t1
		rs("StartTime")		=StartTime
		rs("EndTime")		=EndTime
		rs("Px")			=Px
		rs("yn")			=1
		rs.update
		Call Alert("恭喜,添加成功！","Admin_Vote.asp")
	else
		Call Alert("添加失败，该投票已经存在！",-1)
	end if
	rs.close
	set rs=nothing
End sub

Sub savedit()

t0=trim(request("t0"))
t1=trim(request("t1"))
votes=trim(request("votes"))
ID=trim(request("id"))
StartTime	=trim(request("StartTime"))
EndTime		=trim(request("EndTime"))
Px			=trim(request("Px"))

If votes="" then
Call Alert ("项目内容不能为空!",-1)
End if

votes=split(votes,CHR(10))
for i=0 to ubound(votes)
	if not instr(trim(votes(i)),"|")>0 then
	Call Alert ("投票选项"&i+1&"有错误!",-1)
	end if
	somevote=split(trim(votes(i)),"|")
	for j=0 to ubound(somevote)
	s=trim(somevote(0))
	s1=trim(somevote(1))
		if not isnumeric(s1) then
		Call Alert ("投票选项"&i+1&"有错误!",-1)
		end if
	next  
	vote=vote&s&"|"
	result=result&s1&"|"
next

	set rs = server.CreateObject ("adodb.recordset")
	sql="Select * from "&tbname&"_Vote where ID="& ID &""
	rs.open sql,conn,1,3
		rs("Title")			=t0
		rs("vote")			=vote
		rs("result")		=result
		rs("stype")			=t1
		rs("StartTime")		=StartTime
		rs("EndTime")		=EndTime
		rs("Px")			=Px
		rs("yn")			=1
		rs.update
		Call Alert("恭喜,修改成功！","Admin_Vote.asp")
	rs.close
	set rs=nothing
End sub

sub show
id=request("id")
set rs=conn.execute("select id,title,vote,result from "&tbname&"_vote where id="&id&"")
if rs.eof then
Call Alert ("错误!",-1)
else
vote=rs(2)
result=rs(3)
total_vote=0
vote=split(vote,"|")
result=split(result,"|")
for i=0 to ubound(result)
if not result(i)="" then total_vote=result(i)+total_vote
next
end if
%>
<table width="95%" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#f7f7f7" class="admintable">
<tr>
      <td width="45%" align="center" class="admintitle" >选项      </td>
      <td width="45%" class="admintitle" >比例 </td>
      <td width="10%" class="admintitle" >票数</td>
    </tr>
<%for i=0 to (ubound(vote)-1)%>
    <tr>
	  <td height="25" bgcolor="#FFFFFF"><%Response.Write ""&i+1&". "&vote(i)&""%></td>
      <td bgcolor="#FFFFFF"><div style='border:1px solid #ccc;'>
<%Response.Write "<div style='width:"
if result(i)=0 then
Response.Write "0"
else
Response.Write ""&Formatpercent(result(i)/total_vote,0)&""
end if
Response.Write ";background:#f00;'>"
Response.Write "</div>"
Response.Write "</div>"
%></td>
      <td align="center" bgcolor="#FFFFFF"><%Response.Write ""&result(i)&" ("
if total_vote<>0 then
Response.Write ""&Formatpercent(result(i)/total_vote,0)&""
else
Response.Write "0"
end if%>)</td>
    </tr>
<%next%>
<tr>
    <td colspan="3" align="center" bgcolor="#FFFFFF" ><input name="Submit2" type="button" class="bnt" onClick="history.go(-1)" value="返 回"></td>
  </tr>
</table>
<%
End Sub

Sub delAll
ID=Trim(Request("ID"))
page=request("page")
If ID="" Then
	  Call Alert("请选择记录!",-1)
ElseIf Request("Del")="隐藏" Then
   set rs=conn.execute("Update "&tbname&"_Vote set yn = 0 where ID In(" & ID & ")")
   Call Alert ("操作成功！","Admin_Vote.asp")
ElseIf Request("Del")="显示" Then
   set rs=conn.execute("Update "&tbname&"_Vote set yn = 1 where ID In(" & ID & ")")
   Call Alert ("操作成功！","Admin_Vote.asp")
ElseIf Request("Del")="删除" Then
	set rs=conn.execute("delete from "&tbname&"_Vote where ID In(" & ID & ")")
	Call Alert ("操作成功！","Admin_Vote.asp")
End If
End Sub
%>
<!--#include file="Admin_copy.asp"-->
</body>
</html>