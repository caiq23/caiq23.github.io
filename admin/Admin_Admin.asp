<!--#include file="../inc/conn.asp"-->
<!--#include file="Admin_check.asp"-->
<!--#include file="../Inc/md5.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="images/Admin_css.css" type=text/css rel=stylesheet>

<style>
.classlist {float:left;margin:0;padding:0;}
.classlist ul {float:left;margin:0;padding:0;}
.classlist li {margin:0;padding:0;padding:3px 0;border-bottom:1px solid #ffffff;}
.classlist li span {float:right;margin-top:-3px;}
.classlist .bigclass {font-weight:bold;clear:both;list-style:none;margin:5px 0;}
.classlist .yaoclass {font-weight:normal;list-style:none;padding-left:10px;}
</style>
<title>管理员管理</title>
</head>
<body>
<%
If yaoadmintype<>1 then
Select Case Request("Action")
	Case "Edit1"
	    edit1()
	Case "SEdit1"
	    SEdit1()
	Case else
        edit1()
end Select

Sub Edit1()
set rs=server.CreateObject("ADODB.RECORDSET")
sql="select * from ["&tbname&"_Admin] Where Admin_Name='"&myadminuser&"'"
rs.open sql,conn,1,1
 %>
<table border="0" align="center" cellpadding="3" cellspacing="2" bgcolor="#FFFFFF" class="admintable">
  <tr>
    <td colspan="2" class="admintitle"> 修改管理员密码</td>
  </tr>
  <form action="?Action=SEdit1" method="post">
  <tr>
    <td width="20%" height="25" bgcolor="f7f7f7">&nbsp;用户名称：</td>
    <td height="25" bgcolor="f7f7f7"><%=rs("Admin_Name")%></td>
  </tr>
  <tr>
    <td height="25" bgcolor="f7f7f7">&nbsp;用户密码：</td>
    <td height="25" bgcolor="f7f7f7"><input name="Admin_Pass"type="text" size="30"></td>
  </tr>
  <tr>
    <td height="25" colspan="2" align="center" class="tabletd2"><input type="submit" name="Submit" value="确定修改"></td>
  </tr>
  </form>
</table>
<% 
rs.close
set rs=nothing
End Sub 

Sub SEdit1()
Admin_Pass=CheckStr(request("Admin_Pass"))
if len(Admin_Pass)<6 then
Call Alert ("用户名不能少于6位!",-1)
else
set rs=server.CreateObject("ADODB.RECORDSET")
sql="Select * from "&tbname&"_Admin Where Admin_Name='"&myadminuser&"'"
rs.open sql,conn,1,3
If Admin_Pass<>"" then
rs("Admin_Pass")=Mid(md5("laoy"&Admin_Pass,32),11,19)
end if
rs.update
rs.close
set rs=nothing
Call Alert ("密码修改成功！你的新密码是 "&Admin_Pass&" ","Admin_admin.asp")
end if
End Sub 

Else
If yaoadmintype<>1 then
	Call Info("没有权限!")
End if
dim rs,sql
Select Case Request("Action")
	Case "add"
	    Add()
	Case "sAdd"
	    sAdd()
    Case "Edit"
	    edit()
	Case "SEdit"
	    SEdit()
	Case "Edit_Might"
	    Edit_Might()
	Case "SaveEditMight"
		SaveEditMight()
	Case "Del"
	    Del()
    Case else
        List()
end Select

Sub SEdit()
id=trim(request("id"))
username=trim(request("username"))
Admin_Pass=CheckStr(request("Admin_Pass"))
if len(username)<2 then
Call Alert ("用户名不能少于2位!",-1)
else
set rs=server.CreateObject("ADODB.RECORDSET")
sql="Select * from ["&tbname&"_Admin] Where id="&id&""
rs.open sql,conn,1,3
rs("Admin_Name")=username
If Admin_Pass<>"" then
rs("Admin_Pass")=Mid(md5("laoy"&Admin_Pass,32),11,19)
end if
rs.update
rs.close
set rs=nothing
Call Alert ("修改成功!","Admin_admin.asp")
end if
End Sub 
%>
<% Sub List() %>	
<table border="0" align="center" cellpadding="3" cellspacing="2" bgcolor="#FFFFFF" class="admintable">
  <tr>
    <td colspan="7" class="admintitle">管理员列表 [<a href="?action=add">添加</a>]</td>
  </tr>
  <tr>
    <td width="5%" height="25" align="center" bgcolor="#FFFFFF" class="ButtonList">ID</td>
    <td width="21%" align="center" bgcolor="#FFFFFF" class="ButtonList">管理员名称</td>
    <td width="12%" align="center" bgcolor="#FFFFFF" class="ButtonList">类型</td>
    <td width="18%" align="center" bgcolor="#FFFFFF" class="ButtonList">最后登陆时间</td>
    <td width="16%" align="center" bgcolor="#FFFFFF" class="ButtonList">最后登陆IP</td>
    <td width="28%" align="center" bgcolor="#FFFFFF" class="ButtonList">管理选项</td>
  </tr>
<%
set rs=server.CreateObject("ADODB.RECORDSET")
sql="select * from ["&tbname&"_Admin]"
rs.open sql,conn,1,1
if rs.eof and rs.bof then
response.Write("<tr><td colspan=""5""><li>Sorry,当前没有管理员...</li></td></tr>")
else
do while not rs.eof 
%>
  <tr>
    <td height="25" align="center" bgcolor="f7f7f7"><%=rs("id")%></td>
    <td align="center" bgcolor="f7f7f7"><%=rs("Admin_Name")%></td>
    <td align="center" bgcolor="f7f7f7"><%If rs("AdminType")=1 then Response.Write("<font style=""color:#ff0000"">超级管理员</font>") else Response.Write("受限管理员") end if%></td>
    <td align="center" bgcolor="f7f7f7"><%if rs("Admin_Time")<>"" then response.Write(""&rs("Admin_Time")&"") else response.Write("尚未登陆") end if%></td>
    <td align="center" bgcolor="f7f7f7"><%if rs("Admin_IP")<>"" then response.Write(""&rs("Admin_IP")&"") else response.Write("尚未登陆") end if%></td>
	<td bgcolor="f7f7f7" style="padding-left:25px;"><a href="?Action=Edit&id=<%=rs("id")%>">修改</a><%If rs("id")<>1 then%> <a href="?Action=Edit_Might&id=<%=rs("id")%>">权限管理</a> <a href="?action=Del&id=<%=rs("ID")%>" onClick="JavaScript:return confirm('确定删除管理员“<%=rs("Admin_Name")%>”吗？')">删除</a><%End if%></td>
  </tr>
  <%
  rs.movenext
  loop
  end if
  rs.close
  set rs=nothing
  %>
</table>
<%
End Sub

Sub Add()
%>
<table border="0" align="center" cellpadding="3" cellspacing="2" bgcolor="#FFFFFF" class="admintable">
  <tr>
    <td colspan="2" class="admintitle"> 添加管理员</td>
  </tr>
  <form action="?Action=sAdd" method="post">
  <tr>
    <td height="25" colspan="2" bgcolor="f7f7f7" style="font-weight:bold;">注：用户名和密码请不要包含任何特殊字符或者危险字符[如or,and,delete等]</td>
    </tr>
  <tr>
    <td width="20%" height="25" bgcolor="f7f7f7">&nbsp;用户名称：</td>
    <td height="25" bgcolor="f7f7f7"><input name="username" type="text" size="30"></td>
  </tr>
  <tr>
    <td height="25" bgcolor="f7f7f7">&nbsp;用户密码：</td>
    <td height="25" bgcolor="f7f7f7"><input name="Admin_Pass" type="text" size="30"></td>
  </tr>
  <tr>
    <td height="25" colspan="2" align="center" class="tabletd2"><input type="submit" name="Submit" value="添加"></td>
  </tr>
  </form>
</table>
<%
End Sub

Sub sAdd()
	username			=trim(request.form("username"))
	Admin_Pass			=CheckStr(request.form("Admin_Pass"))
	If username="" or Admin_Pass="" then
	Call Alert ("请填写用户名和密码!",-1)
	End if
	set rs = server.CreateObject ("adodb.recordset")
	sql="select * from ["&tbname&"_Admin]"
	rs.open sql,conn,1,3
		rs.AddNew 
		rs("Admin_Name")		=username
		rs("Admin_Pass")		=Mid(md5("laoy"&Admin_Pass,32),11,19)
		rs("AdminType")			=0
		rs.update
		Call Alert ("添加成功,请为其指定权限！","Admin_Admin.asp")
	rs.close
End Sub

Sub Del()
	id=request("id")
	set rs=conn.execute("delete from ["&tbname&"_Admin] where AdminType=0 and id="&id)
	Call Alert ("删除成功！","Admin_admin.asp")
end sub

Sub Edit()
Id=CheckStr(Trim(request("id")))
set rs=server.CreateObject("ADODB.RECORDSET")
sql="select * from ["&tbname&"_Admin] Where ID="&ID&""
rs.open sql,conn,1,1
 %>
<table border="0" align="center" cellpadding="3" cellspacing="2" bgcolor="#FFFFFF" class="admintable">
  <tr>
    <td colspan="2" class="admintitle"> 修改管理员资料</td>
  </tr>
  <form action="?Action=SEdit" method="post">
  <tr>
    <td height="25" colspan="2" bgcolor="f7f7f7" style="font-weight:bold;">注：用户名和密码请不要包含任何特殊字符或者危险字符[如or,and,delete等]</td>
    </tr>
  <tr>
    <td width="20%" height="25" bgcolor="f7f7f7">&nbsp;用户名称：</td>
    <td height="25" bgcolor="f7f7f7"><input name="username" value="<%=rs("Admin_Name")%>" type="text" size="30"></td>
  </tr>
  <tr>
    <td height="25" bgcolor="f7f7f7">&nbsp;用户密码：</td>
    <td height="25" bgcolor="f7f7f7"><input name="Admin_Pass"type="text" size="30"><input type=hidden name=id value="<%=request("id")%>"></td>
  </tr>
  <tr>
    <td height="25" colspan="2" align="center" class="tabletd2"><input type="submit" name="Submit" value="确定修改"></td>
  </tr>
  </form>
</table>
<% 
rs.close
set rs=nothing
End Sub 

Sub Edit_Might()
	dim	j,tmpmenu,menuname,menurl
    sql = "select * from ["&tbname&"_Admin] where id="& Clng(request("id"))
	set rs = Conn.Execute(sql)
	
dim	MightList(3,10)
MightList(0,0) = "基本管理"
MightList(0,1) = "网站配置@@1"
MightList(0,2) = "风格管理@@2"
MightList(0,3) = "外部调用@@3"
MightList(0,4) = "标签管理@@4"  

MightList(1,0) = "辅助功能"
MightList(1,1) = "留言管理@@5"
MightList(1,2) = "评论管理@@6" 
MightList(1,3) = "链接管理@@7" 
MightList(1,4) = "链接栏目管理@@8"
MightList(1,5) = "投票管理@@9"
MightList(1,6) = "关键字管理@@10"
MightList(1,7) = "会员管理@@11"

MightList(2,0) = "内容管理" 
MightList(2,1) = "文章栏目添加 | 管理@@12" 
MightList(2,2) = "文章采集管理@@13"
MightList(2,3) = "单页管理@@20"

MightList(3,0)="数据处理" 
MightList(3,2)="压缩数据库@@14" 
MightList(3,3)="备份数据库@@15" 
MightList(3,4)="恢复数据库@@16" 
MightList(3,1)="空间占用查看@@17"
MightList(3,5)="Google地图生成@@18"
MightList(3,6)="Rss生成@@19"
%>
<SCRIPT language=javascript>
function SelectAll(form){
  for (var i=0;i<form.AdminMight.length;i++){
    var e = form.AdminMight[i];
    if (e.disabled==false)
       e.checked = form.chkAll.checked;
    }
}
</script>
<form method="post" name="myform" action="?Action=SaveEditMight">
<%
dim rsa,AdminID
AdminID = request("id")
Set rsa = Conn.Execute("Select * from ["&tbname&"_Admin] WHERE id="& AdminID &" order by id")
%>
<table border="0" cellpadding="3" cellspacing="1" class="admintable1">
  <tr>
    <td class="admintitle">管理员权限管理</td>
  </tr>
  <tr>
    <td><b>管理员姓名</b>：<%=rsa("Admin_Name")%></td>
  </tr>
  <tr>
    <td><b>管理员类型</b>：
      <input name="AdminType" type="radio" class="noborder" onClick="MightList.style.display='none'" value="1" <%if rsa("AdminType") = 1 then response.write "checked"%>>
      超级管理员
      <input name="AdminType" type="radio" class="noborder" onClick="MightList.style.display=''" value="0" <%if rsa("AdminType") = 0 then response.write "checked"%>>
	  受限管理员</td>
  </tr>
  <tr>
    <td id="MightList" style="display:<%if rsa("AdminType") = 1 then response.write "none" end if%>">
	<fieldset style="margin:2px 2px 2px 2px">
			<legend><B>系统权限内容</B>	</legend>
<table width="100%" border="0" cellspacing="8" cellpadding="0">
  <tr>
    <td>
	<%
	Dim n,i
	n = 0
	for i=0 to ubound(MightList,1)
		If i<>0 then
		Response.Write "<br><br>"
		End if
		Response.Write "<b>"&MightList(i,0)&"</b><br>"
		for	j=1	to ubound(MightList,2)
			if isempty(MightList(i,j)) then exit for
			tmpmenu=split(MightList(i,j),"@@")
			menuname=tmpmenu(0)
			menurl=tmpmenu(1)
			n = n+1
			%>
			<input name="AdminMight" type="checkbox" class="noborder" id="AdminMight" value="<%=menurl%>"<% if instr(","& rs("AdminMight") &",",","& menurl &",")>0 then response.write " checked" %>><%=n%>.&nbsp;<%=menuname%>&nbsp;
		<%
		next
	next
		%>
	<br><br>
	<input name="chkAll" type="checkbox" class="noborder" id="chkAll" onClick=SelectAll(this.form)>
	选择所有权限</td>
  </tr>
</table>
</fieldset>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="50%" valign="top"><fieldset style="margin:10px 2px 2px 2px">
        <legend><b>文章管理权限</b></legend>
        <table width="100%" border="0" cellspacing="8" cellpadding="0">
          <tr>
            <td>
            <div class="classlist">
            	<ul>
                	<li><span>录入　管理</span>栏目名称　[<b>注：</b>拥有管理权限同时就有了录入权限]</li>
<%
set rs8=conn.execute("select * from "&tbname&"_Class Where TopID=0 And Link=0 order by num asc")
NoI=0
do while not rs8.eof
NoI=NoI+1%>
			<li class="bigclass"><%If mydb("Select Count([ID]) From ["&tbname&"_Class] Where TopID="&rs8("ID")&"",1)(0)=0 then%><span><input type="checkbox" name="WritePower" id="WritePower" value="<%=rs8("ID")%>"<% if instr(","& rs("WritePower") &",",","& rs8("ID") &",")>0 then response.write " checked"%> class="noborder">　<input type="checkbox" name="ManagePower" id="ManagePower" value="<%=rs8("ID")%>"<% if instr(","& rs("ManagePower") &",",","& rs8("ID") &",")>0 then response.write " checked"%> class="noborder"></span><%End if%><%=rs8("ClassName")%></li><%
		    Sqlpp ="select * from "&tbname&"_Class Where TopID="&Rs8("ID")&" order by num"   
   			Set Rspp=server.CreateObject("adodb.recordset")   
   			rspp.open sqlpp,conn,1,1
			Do while not Rspp.Eof
%>
			<li class="yaoclass"><span><input type="checkbox" name="WritePower" id="WritePower" value="<%=rspp("ID")%>"<% if instr(","& rs("WritePower") &",",","& rspp("ID") &",")>0 then response.write " checked"%> class="noborder">　<input type="checkbox" name="ManagePower" id="ManagePower" value="<%=rspp("ID")%>"<% if instr(","& rs("ManagePower") &",",","& rspp("ID") &",")>0 then response.write " checked"%> class="noborder"></span><%=rspp("ClassName")%></a></li><%
			Rspp.Movenext   
      		Loop
   rspp.close
   set rspp=nothing
rs8.movenext
loop
rs8.close
set rs8=nothing%>
				</ul>
			</div>
			</td>
          </tr>
        </table>
		</fieldset></td>
    <td valign="top"><fieldset style="margin:10px 2px 2px 2px">
        <legend><b>广告管理权限</b></legend>
        <table width="100%" border="0" cellspacing="8" cellpadding="0">
          <tr>
            <td>
            <div class="classlist">
            	<ul>
                	<li><span>管理</span>广告名称</li>
<%
set rs8=conn.execute("select * from "&tbname&"_AD order by ID desc")
NoI=0
do while not rs8.eof
NoI=NoI+1%>
			<li class="bigclass"><span><input type="checkbox" name="ADPower" id="ADPower" value="<%=rs8("ID")%>"<% if instr(","& rs("ADPower") &",",","& rs8("ID") &",")>0 then response.write " checked"%> class="noborder"></span><%=NoI%>.<%=rs8("Title")%></li><%
rs8.movenext
loop
rs8.close
set rs8=nothing%>
				</ul>
			</div>
			</td>
          </tr>
        </table>
		</fieldset></td>
  </tr>
</table>
		<br></td>
  </tr>
  <tr>
    <td><div align="center">
      <input name="Submit" type="submit" id="Submit" value="确定修改">
      <input type="hidden" name="id" Value="<%=request("id")%>">
    </div></td>
  </tr>
</table>
</form>
<%
End Sub

Sub SaveEditMight()
id=request("id")
AdminMight=request("AdminMight")
AdminType=request("AdminType")
WritePower=request("WritePower")
ManagePower=request("ManagePower")
ADPower=request("ADPower")

set rs=server.CreateObject("ADODB.RECORDSET")
sql="Select * from ["&tbname&"_Admin] Where id="&id&""
rs.open sql,conn,1,3
rs("AdminType") = AdminType
rs("AdminMight") = replace(AdminMight," ","")
rs("WritePower") = replace(WritePower," ","")
rs("ManagePower") = replace(ManagePower," ","")
rs("ADPower") = replace(ADPower," ","")
rs.update
rs.close
set rs=nothing
Call Alert ("修改成功!","Admin_admin.asp")
End Sub

End if
%>
<!--#include file="Admin_copy.asp"-->
</body>
</html>