<!--#include file="../Inc/conn.asp"-->
<!--#include file="admin_check.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>无标题文档</title>
<link href="images/Admin_css.css" type=text/css rel=stylesheet>
<link rel="shortcut icon" href="<%=SitePath%>images/myfav.ico" type="image/x-icon" />
</head>

<body>
<%
Call chkAdmin(12)
	if request("action") = "add" then 
		call add()
	elseif request("action")="edit" then
		call edit()
	elseif request("action")="savenew" then
		call savenew()
	elseif request("action")="savedit" then
		call savedit()
	elseif request("action")="del" then
		call del()
	else
		call List()
	end if
 
sub List()
   Dim Sqlp,Rsp,TempStr
%>
<table border="0" cellspacing="2" cellpadding="3"  align="center" class="admintable">
<tr> 
  <td colspan="7" align=left class="admintitle">栏目列表　[<a href="?action=add">添加</a>]　[<a href="Admin_RSS.asp">更新所有RSS</a>]</td>
</tr>
  <tr align="center"> 
    <td width="24%" class="ButtonList">栏目名称</td>
    <td width="8%" class="ButtonList">栏目ID</td>
    <td width="12%" class="ButtonList">用户投稿</td>
    <td width="8%" class="ButtonList">排序</td>
    <td width="9%" class="ButtonList">菜单显示</td>
    <td width="12%" class="ButtonList">首页显示</td>
    <td width="27%" class="ButtonList">操 作</td>
  </tr>
<%
   Sqlp ="select * from "&tbname&"_Class Where TopID = 0 order by num"   
   Set Rsp=server.CreateObject("adodb.recordset")   
   rsp.open sqlp,conn,1,1 
   If Rsp.Eof and Rsp.Bof Then
      Response.Write("没有分类")
   Else
   NoI=0
      Do while not Rsp.Eof   
	NoI=NoI+1
%>
    <tr bgcolor="#f1f3f5" onMouseOver="this.style.backgroundColor='#EAFCD5';this.style.color='red'" onMouseOut="this.style.backgroundColor='';this.style.color=''">
    <td height="24" class="tdleft"><%=NoI%> . <%=rsp("ClassName")%> <%If rsp("url")<>"" then Response.Write("<font color=blue>[外]</font>") else Response.Write("<font color=red>("&Mydb("Select Count([ID]) From ["&tbname&"_Article] Where ClassID="&rsp("ID")&"",1)(0)&")</font>") end if%></td>
    <td height="24" align="center"><%=rsp("ID")%></td>
    <td height="24" align="center" class="tdleft"><%If rsp("IsUser")=1 then Response.Write("<font color=red>√</font>") else Response.Write("ㄨ") end if%></td>
    <td height="24" align="center"><%=rsp("Num")%></td>
    <td height="24" align="center"><%If rsp("IsMenu")=1 then Response.Write("<font color=red>√</font>") else Response.Write("ㄨ") end if%></td>
    <td height="24" align="center"><%If rsp("IsIndex")=1 then Response.Write("<font color=red>√</font>") else Response.Write("ㄨ") end if%></td>
    <td width="27%" align="center"><%If rsp("link")=0 then%><a href="Admin_RSS.asp?ID=<%=rsp("ID")%>">更新RSS</a> | <%End if%><a href="?action=edit&id=<%=rsp("ID")%>">编辑</a> | <a href="?action=del&id=<%=rsp("ID")%>" onClick="JavaScript:return confirm('删除栏目同时会删除该栏目下的文章！确定？')">删除</a></td>
  </tr>
<%
		    Sqlpp ="select * from "&tbname&"_Class Where TopID="&Rsp("ID")&" order by num"   
   			Set Rspp=server.CreateObject("adodb.recordset")   
   			rspp.open sqlpp,conn,1,1
			NoI1=0
			Do while not Rspp.Eof
			NoI1=NoI1+1
%>
    <tr bgcolor="#f1f3f5" onMouseOver="this.style.backgroundColor='#EAFCD5';this.style.color='red'" onMouseOut="this.style.backgroundColor='';this.style.color=''">
    <td height="25" class="tdleft">　　|- <%=rspp("ClassName")%> <font color=red>(<%=Mydb("Select Count([ID]) From ["&tbname&"_Article] Where ClassID="&rspp("ID")&"",1)(0)%>)</font></td>
    <td height="25" align="center"><%=rspp("ID")%></td>
    <td height="25" align="center" class="tdleft"><%If rspp("IsUser")=1 then Response.Write("<font color=red>√</font>") else Response.Write("ㄨ") end if%></td>
    <td height="25" align="center"><%=rspp("Num")%></td>
    <td height="25" align="center"><%If rspp("IsMenu")=1 then Response.Write("<font color=red>√</font>") else Response.Write("ㄨ") end if%></td>
    <td height="25" align="center"><%If rspp("IsIndex")=1 then Response.Write("<font color=red>√</font>") else Response.Write("ㄨ") end if%></td>
    <td width="27%" align="center"><%If rspp("link")=0 then%><a href="Admin_RSS.asp?ID=<%=rspp("ID")%>">更新RSS</a> | <%End if%><a href="?action=edit&id=<%=rspp("ID")%>">编辑</a> | <a href="?action=del&id=<%=rspp("ID")%>" onClick="JavaScript:return confirm('删除栏目同时会删除该栏目下的文章！确定？')">删除</a></td>
  </tr>
<%
			Rspp.Movenext   
      		Loop
			rspp.close
			set rspp=nothing
      Rsp.Movenext   
      Loop   
   End if
   rsp.close
   set rsp=nothing
%>  
</table>
<%
end sub

sub add()
%>
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="2" bgcolor="#FFFFFF" class="admintable">
<tr> 
  <td colspan="5" class="admintitle">添加栏目</th></tr>
<form action="?action=savenew" method=post>
<tr>
<td width="20%" class=b1_1>栏目名称</td>
<td colspan=4 class=b1_1><input type="text" name="ClassName" size="30"></td>
</tr>
<tr>
<td width="20%" class=b1_1>栏目副标题</td>
<td colspan=4 class=b1_1><input type="text" name="ClassName2" size="30"></td>
</tr>
<tr>
  <td class=b1_1>所属栏目</td>
  <td colspan=4 class=b1_1><select ID="TopID" name="TopID">
    <%call Admin_ShowClass_Option()%></select></td>
</tr>
<tr> 
<td width="20%" class=b1_1>排　　序</td>
<td colspan=4 class=b1_1><input name="num" type="text" value="10" size="4" maxlength="3"></td>
</tr>
<tr>
  <td class=b1_1>外部链接</td>
  <td colspan=4 class=b1_1><input name="Url" type="text" id="Url" size="40">
    <span class="note">非外部链接请保留为空</span></td>
</tr>
<tr>
  <td class=b1_1>栏目关键字</td>
  <td colspan=4 class=b1_1><input name="KeyWord" type="text" id="KeyWord" size="40">
    <span class="note">针对搜索引擎关键字设置,多个用英文逗号隔开</span></td>
</tr>
<tr>
  <td class=b1_1>栏目介绍</td>
  <td colspan=4 class=b1_1><textarea name="ReadMe" cols="40" rows="5" id="ReadMe"></textarea></td>
</tr>
<tr>
  <td class=b1_1>打开方式</td>
  <td colspan=4 class=b1_1><select name="target" id="target">
      <option value="_top" selected>_top</option>
      <option value="_blank">_blank</option>
      <option value="_parent">_parent</option>
      <option value="_self">_self</option>
    </select></td>
</tr>
<tr>
  <td class=b1_1>导航栏是否显示</td>
  <td colspan=4 class=b1_1><input name="IsMenu" type="radio" class="noborder" value="1" checked>
    是
      <input name="IsMenu" type="radio" class="noborder" value="0">
      否</td>
</tr>
<tr>
  <td class=b1_1>首页是否显示</td>
  <td colspan=4 class=b1_1><input name="IsIndex" onClick="if(this.checked){
			  laoy1.style.display = '';
              laoy2.style.display = '';
		  }" type="radio" class="noborder" value="1" checked>
是
  <input name="IsIndex" onClick="if(this.checked){
			  laoy1.style.display = 'none';
              laoy2.style.display = 'none';
		  }" type="radio" class="noborder" value="0">
否</td>
</tr>
<tr id="laoy1">
  <td class=b1_1>首页显示数量</td>
  <td colspan=4 class=b1_1><input name="IndexNum" type="text" id="IndexNum" value="10" size="4" maxlength="2"></td>
</tr>
<tr id="laoy2">
  <td class=b1_1>是否在首页显示图片文章</td>
  <td colspan=4 class=b1_1><input name="Indeximg" type="radio" class="noborder" value="1">
是
  <input name="Indeximg" type="radio" class="noborder" value="0" checked>
否</td>
</tr>
<tr>
  <td class=b1_1>该栏目是否允许用户投稿</td>
  <td colspan=4 class=b1_1><input name="IsUser" type="radio" class="noborder" value="1" checked>
是
  <input name="IsUser" type="radio" class="noborder" value="0">
否</td>
</tr>
<tr>
  <td class=b1_1>浏览权限</td>
  <td colspan=4 class=b1_1><select name="ReadPower" size=4 multiple id="ReadPower">
    <%=ShowlevelOption(0)%>
  </select>
    <span class="note">注：当选择中包含游客等级时，所有用户都可查看。可按住Ctrl多选!</span></td>
</tr>
<tr> 
<td width="20%" class=b1_1></td>
<td class=b1_1 colspan=4><input name="Submit" type="submit" class="bnt" value="添 加"></td>
</tr></form>
</table>
<%
end sub

sub del()
	id=request("id")
	If Mydb("Select Count([ID]) From ["&tbname&"_Class] Where TopID="&ID&"",1)(0)>0 then
		Response.Write("<script language=javascript>alert('请先删除下级栏目!');history.back(1);</script>")
		Response.End
	else
		set rs=conn.execute("delete from "&tbname&"_Class where id="&id)
		set rs=conn.execute("delete from "&tbname&"_Article where ClassID In(" & ID & ")")
	end if
	Response.write"<script>alert(""删除成功！"");location.href=""Admin_Class.asp"";</script>"
end sub

sub savenew()
	if trim(request.form("ClassName"))="" then
		Response.write"<script>alert(""请填写栏目名称！"");location.href=""?action=add"";</script>"
		Response.End
	end if
	ClassName=trim(request.form("ClassName"))
	ClassName2=trim(request.form("ClassName2"))
	num=trim(request.form("num"))
	KeyWord=trim(request.form("KeyWord"))
	ReadMe=trim(request.form("ReadMe"))
	IsMenu=request.form("IsMenu")
	IsIndex=request.form("IsIndex")
	Indexnum=trim(request.form("Indexnum"))
	Indeximg=trim(request.form("Indeximg"))
	TopID=request.form("TopID")
	Url=trim(request.form("Url"))
	target=trim(request.form("target"))
	IsUser=request.form("IsUser")
	ReadPower		=request.form("ReadPower")
	ReadPower 		=replace(ReadPower," ","")
	If TopID>0 then
		If getclass(TopID,"TopID")>0 then Call Alert("请选择顶级栏目",-1)
	End if
	set rs = server.CreateObject ("adodb.recordset")
	sql="select * from "&tbname&"_Class"
	rs.open sql,conn,1,3
		rs.AddNew 
		rs("ClassName")		=ClassName
		rs("ClassName2")		=ClassName2
		rs("num")			=num
		rs("KeyWord")		=KeyWord
		rs("ReadMe")		=ReadMe
		rs("IsMenu")		=IsMenu
		rs("IsIndex")		=IsIndex
		rs("Indexnum")		=Indexnum
		rs("Indeximg")		=Indeximg
		rs("TopID")			=TopID
		rs("url")			=Url
		rs("target")		=target
		rs("ReadPower")		=ReadPower
		If rs("url")<>"" then
		rs("link")			=1
		else
		rs("link")			=0
		End if
		rs("IsUser")		=IsUser
		
		rs.update
		Response.write"<script>alert(""恭喜,添加成功！"");location.href=""Admin_Class.asp"";</script>"
	rs.close
	set rs=nothing
end sub

sub edit()
id=request("id")
set rs = server.CreateObject ("adodb.recordset")
sql="select * from "&tbname&"_Class where id="& id &""
rs.open sql,conn,1,1
%>
<table width="95%" border="0"  align=center cellpadding="3" cellspacing="2" bgcolor="#FFFFFF" class="admintable">
<form action="?action=savedit" method=post>
<tr> 
    <td colspan="5" class="admintitle">修改栏目</td>
</tr>
<tr> 
<td width="20%" class="b1_1">栏目名称</td>
<td colspan=4 class=b1_1><input type="text" name="ClassName" size="30" value="<%=server.htmlencode(rs("ClassName"))%>"></td>
</tr>
<tr> 
<td width="20%" class="b1_1">栏目副标题</td>
<td colspan=4 class=b1_1><input type="text" name="ClassName2" size="30" value="<%=rs("ClassName2")%>"></td>
</tr>
<tr>
  <td class="b1_1">所属栏目</td>
  <td colspan=4 class=b1_1><select ID="TopID" name="TopID">
    <%
	Response.Write("<option value=""0"">做为顶级分类</option>")
	If Mydb("Select Count([ID]) From ["&tbname&"_Class] Where TopID="&ID&"",1)(0)=0 then
	Dim Sqlp,Rsp,TempStr
   Sqlp ="select * from "&tbname&"_Class Where TopID = 0 and ID<>"&ID&" And Link=0 order by num"   
   Set Rsp=server.CreateObject("adodb.recordset")   
   rsp.open sqlp,conn,1,1 
   If Rsp.Eof and Rsp.Bof Then
      Response.Write("<option value="""">请先添加分类</option>")
   Else
      Do while not Rsp.Eof   
         Response.Write("<option value=" & """" & Rsp("ID") & """" & "")
		 If rs("topid")=Rsp("ID") then
			Response.Write(" selected" ) 
		 end if
         Response.Write(">|-" & Rsp("ClassName") & "")
         Response.Write("</option>" ) 
      Rsp.Movenext   
      Loop   
   End if
   End if%>
  </select></td>
</tr>
<tr>
  <td class="b1_1">排　　序</td>
  <td colspan=4 class=b1_1><input name="Num" type="text" id="Num" value="<%=rs("Num")%>" size="4" maxlength="3"></td>
</tr>
<tr>
  <td height="45" class="b1_1">外部链接</td>
  <td colspan=4 class=b1_1><input name="Url" type="text" id="Url" value="<%=rs("Url")%>" size="40">
    <span class="note">非外部链接请保留为空</span></td>
</tr>
<tr>
  <td class="b1_1">栏目关键字</td>
  <td colspan=4 class=b1_1><input name="KeyWord" type="text" id="KeyWord" value="<%=rs("KeyWord")%>" size="40">
    <span class="note">针对搜索引擎关键字设置,多个用英文逗号隔开</span></td>
</tr>
<tr>
  <td class="b1_1">栏目介绍</td>
  <td colspan=4 class=b1_1><textarea name="ReadMe" cols="40" rows="5" id="ReadMe"><%=rs("ReadMe")%></textarea></td>
</tr>
<tr>
  <td class=b1_1>打开方式</td>
  <td colspan=4 class=b1_1><select name="target" id="target">
    <option value="_top"<%If rs("target")="_top" then Response.Write(" selected") end if%>>_top</option>
    <option value="_blank"<%If rs("target")="_blank" then Response.Write(" selected") end if%>>_blank</option>
    <option value="_parent"<%If rs("target")="_parent" then Response.Write(" selected") end if%>>_parent</option>
    <option value="_self"<%If rs("target")="_self" then Response.Write(" selected") end if%>>_self</option>
  </select></td>
</tr>
<tr>
  <td class=b1_1>导航栏是否显示</td>
  <td colspan=4 class=b1_1><input name="IsMenu" type="radio" class="noborder" value="1"<%If rs("IsMenu")=1 then Response.Write(" checked") end if%>>
是
  <input name="IsMenu" type="radio" class="noborder" value="0"<%If rs("IsMenu")=0 then Response.Write(" checked") end if%>>
否</td>
</tr>
<tr>
  <td class=b1_1>首页是否显示</td>
  <td colspan=4 class=b1_1><input name="IsIndex" onClick="if(this.checked){
			  laoy1.style.display = '';
              laoy2.style.display = '';
		  }" type="radio" class="noborder" value="1"<%If rs("IsIndex")=1 then Response.Write(" checked") end if%>>
是
  <input name="IsIndex" onClick="if(this.checked){
			  laoy1.style.display = 'none';
              laoy2.style.display = 'none';
		  }" type="radio" class="noborder" value="0"<%If rs("IsIndex")=0 then Response.Write(" checked") end if%>>
否</td>
</tr>
<tr id="laoy1"<%If rs("IsIndex")=0 then Response.Write(" style=""display:none;""") end if%>>
  <td class=b1_1>首页显示数量</td>
  <td colspan=4 class=b1_1><input name="IndexNum" type="text" id="IndexNum" value="<%=rs("IndexNum")%>" size="4" maxlength="2"></td>
</tr>
<tr id="laoy2"<%If rs("IsIndex")=0 then Response.Write(" style=""display:none;""") end if%>>
  <td class=b1_1>是否在首页显示图片文章</td>
  <td colspan=4 class=b1_1><input name="Indeximg" type="radio" class="noborder" value="1"<%If rs("Indeximg")=1 then Response.Write(" checked") end if%>>
是
  <input name="Indeximg" type="radio" class="noborder" value="0"<%If rs("Indeximg")=0 then Response.Write(" checked") end if%>>
否</td>
</tr>
<tr>
  <td class=b1_1>是否允许用户投稿</td>
  <td colspan=4 class=b1_1><input name="IsUser" type="radio" class="noborder" value="1"<%If rs("IsUser")=1 then Response.Write(" checked") end if%>>
是
  <input name="IsUser" type="radio" class="noborder" value="0"<%If rs("IsUser")=0 then Response.Write(" checked") end if%>>
否</td>
</tr>
<tr>
  <td class=b1_1>浏览权限</td>
  <td colspan=4 class=b1_1><select name="ReadPower" size=4 multiple id="ReadPower">
    <%=ShowlevelOption(rs("ReadPower"))%>
  </select>
    <span class="note">注：当选择中包含游客等级时，所有用户都可查看。可按住Ctrl多选!</span></td>
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
	Dim ClassName
	id=request.form("id")
	ClassName=request.form("ClassName")
	ClassName2=request.form("ClassName2")
	Num=request.form("Num")
	TopID=request.form("TopID")
	KeyWord=trim(request.form("KeyWord"))
	ReadMe=trim(request.form("ReadMe"))
	IsMenu=request.form("IsMenu")
	IsIndex=request.form("IsIndex")
	Indexnum=trim(request.form("Indexnum"))
	Indeximg=trim(request.form("Indeximg"))
	Url=trim(request.form("Url"))
	target=trim(request.form("target"))
	IsUser=request.form("IsUser")
	ReadPower		=request.form("ReadPower")
	ReadPower 		=Replace(ReadPower," ","")
	
	If TopID>0 then
		If getclass(TopID,"TopID")>0 then Call Alert("请选择顶级栏目",-1)
	End if
	set rs = server.CreateObject ("adodb.recordset")
	sql="select * from "&tbname&"_Class where ID="&id&""
	rs.open sql,conn,1,3
	if not(rs.eof and rs.bof) then
		rs("ClassName")		= ClassName
		rs("ClassName2")		= ClassName2
		rs("Num")			= Num
		rs("KeyWord")		=KeyWord
		rs("ReadMe")		=ReadMe
		rs("IsMenu")		=IsMenu
		rs("IsIndex")		=IsIndex
		rs("Indexnum")		=Indexnum
		rs("Indeximg")		=Indeximg
		rs("TopID")			=TopID
		rs("url")			=Url
		rs("target")		=target
		rs("ReadPower")		=ReadPower
		If rs("url")<>"" then
		rs("link")			=1
		else
		rs("link")			=0
		End if
		rs("IsUser")		=IsUser
		
		rs.update
		Response.write"<script>alert(""恭喜,修改成功！"");location.href=""Admin_Class.asp"";</script>"
	else
		Response.write"<script>alert(""修改错误！"");location.href=""Admin_Class.asp"";</script>"
	end if
	rs.close
	set rs=nothing
end sub

sub Admin_ShowClass_Option()
   Dim Sqlp,Rsp,TempStr
   Sqlp ="select * from "&tbname&"_Class Where TopID = 0 And Link=0 order by num"   
   Set Rsp=server.CreateObject("adodb.recordset")   
   rsp.open sqlp,conn,1,1 
   Response.Write("<option value=""0"">做为顶级分类</option>") 
   If Rsp.Eof and Rsp.Bof Then
      Response.Write("<option value="""">请先添加分类</option>")
   Else
      Do while not Rsp.Eof   
         Response.Write("<option value=" & """" & Rsp("ID") & """" & "")
         Response.Write(">|-" & Rsp("ClassName") & "")
         Response.Write("</option>" ) 
      Rsp.Movenext   
      Loop   
   End if
   rsp.close
   set rsp=nothing
end sub 
%>
<!--#include file="Admin_copy.asp"-->
</body>
</html>