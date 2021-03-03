<!--#include file="../Inc/conn.asp"-->
<!--#include file="../Inc/Function_Page.asp"-->
<!--#include file="admin_check.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>无标题文档</title>
<link href="images/Admin_css.css" type=text/css rel=stylesheet>
<script language="JavaScript" src="../js/Jquery.js"></script>
<script charset="utf-8" src="../KindEditor/kindeditor-min.js"></script>
<script charset="utf-8" src="../KindEditor/lang/zh_CN.js"></script>
		<script>
			$(function() {
				$('input[name=load]').click(function() {
						KindEditor.create('textarea[name="Content"]',{
					allowPreviewEmoticons : false,
					allowImageUpload : false,
					items : [
						'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
						'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
						'insertunorderedlist', '|', 'emoticons', 'image', 'link']
						});
				});
				$('input[name=remove]').click(function() {
					KindEditor.remove('textarea[name="Content"]');
				});
			});
		</script>
<script src="js/admin.js"></script>
</head>
<body>
<%
	if request("action") = "add" then
		If yaoadmintype<>1 then
		Call Info("没有权限!")
		End if
		call add()
	elseif request("action")="edit" then
		call edit()
	elseif request("action")="savenew" then
		If yaoadmintype<>1 then
		Call Info("没有权限!")
		End if
		call savenew()
	elseif request("action")="del" then
		call del()
	elseif request("action")="savedit" then
		call savedit()
	elseif request("action")="delAll" then
		call delAll()
	else
		call List()
	end if
 
sub List()
%>
<form name="myform" method="POST" action="Admin_Ad.asp?action=delAll">
<table border="0"  align="center" cellpadding="3" cellspacing="2" bgcolor="#FFFFFF" class="admintable">
<tr> 
  <td colspan="7" align=left class="admintitle">广告列表　[<a href="?action=add">添加</a>]</td>
</tr>
  <tr align="center"> 
    <td colspan="2" class="ButtonList">广告名称</td>
    <td width="38%" class="ButtonList">说明</td>
    <td width="18%" class="ButtonList">最后修改时间</td>
    <td width="10%" class="ButtonList">状态</td>
    <td width="14%" class="ButtonList">操 作</td>
  </tr>
<%
page=request("page")
Set mypage=new xdownpage
mypage.getconn=conn
mysql="select * from "&tbname&"_AD"
If yaoadmintype<>1 then
mysql=mysql&" Where ID in ("&yaoadpower&")"
End if
mysql=mysql&" order by id desc "
mypage.getsql=mysql
mypage.pagesize=20
set rs=mypage.getrs()
for i=1 to mypage.pagesize
    if not rs.eof then
%>
    <tr bgcolor="#f1f3f5" onMouseOver="this.style.backgroundColor='#EAFCD5';this.style.color='red'" onMouseOut="this.style.backgroundColor='';this.style.color=''">
    <td width="4%" height="25" align="center"><input type="checkbox" value="<%=rs("ID")%>" name="ID" onClick="unselectall(this.form)" style="border:0;"></td>
    <td width="16%" class="tdleft"><%=rs("Title")%></td>
    <td height="25" align="center"><%=rs("Note")%></td>
    <td height="25" align="center"><%=rs("DateAndTime")%></td>
    <td height="25" align="center"><%=IIF(rs("yn")=1,"正常","<font color=red>隐藏</font>")%></td>
    <td align="center"><a href="?action=edit&id=<%=rs("ID")%>">编辑</a>|<a href="?action=del&id=<%=rs("ID")%>" onClick="JavaScript:return confirm('确认删除吗？')">删除</a></td>
    </tr>
<%
        rs.movenext
    else
         exit for
    end if
next
%>
<tr>
  <td align=center><input name="Action" type="hidden"  value="Del"><input name="chkAll" type="checkbox" id="chkAll" onClick=CheckAll(this.form) value="checkbox" style="border:0"></td>
  <td align=center class=b1_1><input name="Del" type="submit" class="bnt" id="Del" value="隐藏">
    <input name="Del" type="submit" class="bnt" id="Del" value="显示"></td>
  <td colspan="5" align=center class=b1_1>广告调用：在需要调用的地方插入 &lt;%Echo ShowAD(&quot;广告名称&quot;)%&gt; 即可。</td>
  </tr>
<tr>
  <td colspan=7 align=center class=b1_1><div id="page">
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

sub add()
%>
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="2" bgcolor="#FFFFFF" class="admintable">
<tr> 
  <td colspan="5" class="admintitle">添加广告</th></tr>
<form action="?action=savenew" method=post name="myform">
<tr>
<td width="20%" class=b1_1><p>广告名称</p>
  <p>（英文，勿重复！）</p></td>
<td colspan=4 class=b1_1><input name="Title" type="text" id="Title" size="40" maxlength="20" onKeyUp="value=value.replace(/[\W]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"></td>
</tr>
<tr>
  <td class=b1_1>图片上传</td>
  <td colspan=4 class=b1_1><iframe src="upload.asp?action=ad" width="400" height="25" frameborder="0" scrolling="no"></iframe></td>
</tr>
<tr> 
<td width="20%" class=b1_1>广告代码</td>
<td colspan=4 class=b1_1><textarea name="Content" cols="50" rows="8" id="Content" style="width:100%;height:200px;"></textarea></td>
</tr>
<tr>
  <td class=b1_1>广告说明</td>
  <td colspan=4 class=b1_1><input name="Note" type="text" id="Note" value="" size="40"></td>
</tr>
<tr> 
<td width="20%" class=b1_1></td>
<td class=b1_1 colspan=4><input name="Submit" type="submit" class="bnt" value="添 加"></td>
</tr></form>
</table>
<%
end sub

sub savenew()
	if trim(request.form("Title"))="" or request.form("Content")="" then
		Call Alert ("请填写广告名称及广告代码!",-1)
	end if
	Title		=trim(request.form("Title"))
	Content		=trim(request.form("Content"))
	Note		=trim(request.form("Note"))
	set rs = server.CreateObject ("adodb.recordset")
	sql="select * from "&tbname&"_AD where Title='"& Title &"'"
	rs.open sql,conn,1,3
	if rs.eof and rs.bof then
		rs.AddNew 
		rs("Title")			=Title
		rs("Content")		=Content
		rs("Note")			=Note
		rs("yn")			=1
		rs.update
		Call Alert("恭喜,添加成功！","Admin_AD.asp")
	else
		Call Alert("添加失败，该广告名称已经存在！",-1)
	end if
	rs.close
	set rs=nothing
end sub

sub edit()
id=LaoYRequest(request("id"))
Call chkadAdmin(id)
set rs = server.CreateObject ("adodb.recordset")
sql="select * from "&tbname&"_AD where id="& id &""
rs.open sql,conn,1,1
%>
<table width="95%" border="0"  align=center cellpadding="3" cellspacing="2" bgcolor="#FFFFFF" class="admintable">
<form action="?action=savedit" method=post name="myform">
<tr> 
    <td colspan="5" class="admintitle">修改广告</td>
</tr>
<tr>
  <td width="20%" class=b1_1><p>广告名称</p>
    <p>（英文，勿重复！）</p></td> 
<td colspan=4 class=b1_1><input name="Title" type="text" value="<%=rs("Title")%>" size="40" maxlength="20" onKeyUp="value=value.replace(/[\W]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"></td>
</tr>
<tr>
  <td class=b1_1>图片上传</td>
  <td colspan=4 class=b1_1><iframe src="upload.asp?action=ad" width="400" height="25" frameborder="0" scrolling="no"></iframe></td>
</tr>
<tr>
  <td width="20%" class=b1_1>广告代码<br><br><input type="button" name="load" value="加载编辑器" />
				<input type="button" name="remove" value="删除编辑器" /></td>
  <td colspan=4 class=b1_1><textarea name="Content" cols="50" rows="8" id="Content" style="width:100%;height:200px;"><%=rs("Content")%></textarea></td>
</tr>
<tr>
  <td class=b1_1>广告说明</td>
  <td colspan=4 class=b1_1><input name="Note" type="text" id="Note" value="<%=rs("Note")%>" size="40"></td>
</tr>
<tr>
  <td class=b1_1>广告状态</td>
  <td colspan=4 class=b1_1><select name="yn" id="yn">
    <option value="1"<%=IIF(rs("yn")=1," selected","")%>>正常</option>
    <option value="0"<%=IIF(rs("yn")=0," selected","")%>>隐藏</option>
  </select>
  </td>
</tr>
<tr> 
<td width="20%" class="b1_1"></td>
<td class=b1_1 colspan=4><input name="id" type="hidden" value="<%=rs("ID")%>"><input name="Submit" type="submit" class="bnt" value="提 交"></td>
</tr>
</form>
</table>
<%
rs.close
set rs=nothing
end sub

sub savedit()
	Dim Title
	ID			=LaoYRequest(request.form("ID"))
	Title		=trim(request.form("Title"))
	Content		=trim(request.form("Content"))
	Note		=trim(request.form("Note"))
	yn			=trim(request.form("yn"))
	Call chkadAdmin(ID)
	set rs = server.CreateObject ("adodb.recordset")
	sql="select * from "&tbname&"_AD where ID="&id&""
	rs.open sql,conn,1,3
	if not(rs.eof and rs.bof) then
		rs("Title")			=Title
		rs("Content")		=Content
		rs("Note")			=Note
		rs("DateAndTime")	=Now()
		rs("yn")			=yn
		rs.update
		Response.write"<script>alert(""恭喜,修改成功！"");location.href=""Admin_AD.asp"";</script>"
	else
		Response.write"<script>alert(""修改错误！"");location.href=""Admin_AD.asp"";</script>"
	end if
	rs.close
	set rs=nothing
end sub

sub del()
	id=request("id")
	set rs=conn.execute("delete from "&tbname&"_AD where ID="&id)
	Call Alert ("删除成功","Admin_Ad.asp")
end sub

Sub delAll
ID=Trim(Request("ID"))
page=request("page")
If ID="" Then
	  Call Alert("请选择记录!",-1)
ElseIf Request("Del")="隐藏" Then
   set rs=conn.execute("update "&tbname&"_Ad set yn = 0 where ID In(" & ID & ")")
   Call Alert ("操作成功！","Admin_Ad.asp")
ElseIf Request("Del")="显示" Then
   set rs=conn.execute("update "&tbname&"_Ad set yn = 1 where ID In(" & ID & ")")
   Call Alert ("操作成功！","Admin_Ad.asp")
End If
End Sub

%>
<!--#include file="Admin_copy.asp"-->
</body>
</html>