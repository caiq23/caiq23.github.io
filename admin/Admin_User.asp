<!--#include file="../Inc/conn.asp"-->
<!--#include file="../Inc/md5.asp"-->
<!--#include file="../Inc/Function_Page.asp"-->
<!--#include file="admin_check.asp"-->
<%
Call chkAdmin(11)
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>无标题文档</title>
<link href="images/Admin_css.css" type=text/css rel=stylesheet>
<script language="javascript" type="text/javascript" src="<%=SitePath%>js/setdate/WdatePicker.js"></script>

</head>

<body>
<table width="95%" border="0" cellspacing="2" cellpadding="3"  align=center class="admintable" style="margin-bottom:5px;">
    <tr><form name="form1" method="get" action="Admin_User.asp">
      <td height="25" bgcolor="f7f7f7">快速查找：
        <SELECT onChange="javascript:window.open(this.options[this.selectedIndex].value,'main')"  size="1" name="s">
        <OPTION value=""<%If request("s")="" then Response.Write(" selected") end if%>>-=请选择=-</OPTION>
        <OPTION value="?s=all"<%If request("s")="all" then Response.Write(" selected") end if%>>所有用户</OPTION>
        <OPTION value="?s=yn1"<%If request("s")="yn1" then Response.Write(" selected") end if%>>已审的用户</OPTION>
        <OPTION value="?s=yn0"<%If request("s")="yn0" then Response.Write(" selected") end if%>>未审的用户</OPTION>
        <OPTION value="?s=2"<%If request("s")="2" then Response.Write(" selected") end if%>>24小时登录用户</OPTION>
        <OPTION value="?s=1"<%If request("s")="1" then Response.Write(" selected") end if%>>24小时注册用户</OPTION>
      </SELECT>      </td>
      <td bgcolor="f7f7f7">
        <input name="keyword" type="text" id="keyword" value="<%=request("keyword")%>">
        <input name="Submit2" type="submit" class="bnt" value="搜索"></td>
      </form>
    </tr>
</table>
<%
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
	elseif request("action")="updateusergroup" then
		call updateusergroup()
	elseif request("action")="deljf" then
		call deljf()
	elseif request("action")="isyn" then
		call isyn()
	else
		call List()
	end if
 
sub List()
%>
<table border="0" cellspacing="2" cellpadding="3"  align="center" class="admintable">
<tr> 
  <td colspan="9" align=left class="admintitle">用户列表　[<a href="?action=add">添加</a>]</td>
</tr>
  <tr align="center"> 
    <td width="15%" class="ButtonList">用户名</td>
    <td width="5%" class="ButtonList">积分</td>
    <td width="12%" class="ButtonList">等级</td>
    <td width="4%" class="ButtonList">性别</td>
    <td width="10%" class="ButtonList">籍贯</td>
    <td width="14%" class="ButtonList">注册时间</td>
    <td width="13%" class="ButtonList">注册ＩＰ</td>
    <td width="14%" class="ButtonList">操 作</td>
  </tr>
<%
page=request("page")
Hits=request("hits")
s=Request("s")
Articleclass=request("ClassID")
keyword=request("keyword")
usergroupid=request("usergroupid")
dengji=request("dengji")
Set mypage=new xdownpage
mypage.getconn=conn
mysql="select * from "&tbname&"_User"
	if s="yn0" then
	mysql=mysql&" Where yn=0"
	elseif s="yn1" then
	mysql=mysql&" Where yn=1"
	elseif s="1" then
		If IsSqlDataBase = 1 then
		mysql=mysql&" Where datediff(hh,RegTime,GetDate()) <= 24"
		else
		mysql=mysql&" Where datediff('h',RegTime,Now()) <= 24"
		End if
	elseif s="2" then
		If IsSqlDataBase = 1 then
		mysql=mysql&" Where datediff(hh,LastTime,GetDate()) <= 24"
		else
		mysql=mysql&" Where datediff('h',LastTime,Now()) <= 24"
		End if
	elseif s="vip" then
	mysql=mysql&" Where usergroupid=30"
	elseif keyword<>"" then
	mysql=mysql&" Where UserName like '%"&keyword&"%'"
	elseif usergroupid<>"" then
	mysql=mysql&" Where usergroupid = "&usergroupid&""
	elseif dengji<>"" then
	mysql=mysql&" Where dengji = '"&dengji&"'"
	End if
mysql=mysql&" order by ID desc"
mypage.getsql=mysql
mypage.pagesize=15
set rs=mypage.getrs()
for i=1 to mypage.pagesize
    if not rs.eof then 
%>
    <tr bgcolor="#f1f3f5" onMouseOver="this.style.backgroundColor='#EAFCD5';this.style.color='red'" onMouseOut="this.style.backgroundColor='';this.style.color=''">
    <td height="25" class="tdleft"><%if rs("QQOpenID")<>"" then Echo "<font color=red>【QQ登录】</font>" end if%><%=rs("UserName")%> ( <a href="Admin_Article.asp?userid=<%=rs("id")%>"><font style="color:#F00"><%=mydb("Select Count([ID]) From ["&tbname&"_Article] Where UserID="&rs("ID")&"",1)(0)%></font></a> )</td>
    <td height="25" align="center" class="tdleft"><%=rs("UserMoney")%></td>
    <td height="25" align="center" class="tdleft"><%=UserGroupInfo(rs("usergroupid"),0)%></td>
    <td height="25" align="center"><%If rs("Sex")=1 then Response.Write("男") else Response.Write("女") end if%></td>
	<td align="center"><%=rs("province")%><%=rs("city")%></td>
    <td align="center"><%=rs("regtime")%></td>
    <td align="center"><a href="http://www.laoy.net/other/ip.asp?ip=<%=rs("IP")%>" target="_blank" title="点击查询来源"><u><%=rs("IP")%></u></a></td>
    <td width="11%" align="center">
			<%
			Response.Write "<a href='?action=isyn&yn="&rs("yn")&"&ID=" & rs("ID") & "&page="&request("page")&"'>"
            If rs("yn")=0 Then
               Response.Write "<font color=red>未审</font>"
            Else
               Response.Write "已审"
            End If
            Response.Write "</a>"
           %>|<a href="?action=edit&id=<%=rs("ID")%>">编辑</a>|<a href="?action=del&id=<%=rs("ID")%>&UserName=<%=rs("UserName")%>" onClick="JavaScript:return confirm('确认删除吗？这将会连同该用户发表的文章一起删除！')">删除</a></td>
  </tr>
<%
        rs.movenext
    else
         exit for
    end if
next
%>
<tr><td colspan=8 class=td>
<div id="page">
	<ul style="text-align:left;">
    <%=mypage.showpage()%>
    </ul>
</div>
</td>
</tr>
</table>
<%
	rs.close
	set rs=nothing
%>
<table border="0" cellspacing="2" cellpadding="3"  align="center" class="admintable">
  <tr>
    <td colspan="2" align=left class="admintitle">清空用户积分</td>
  </tr>
  <tr>
    <td height="50">
      <form name="form1" method="post" action="?action=deljf">
        <input type="submit" name="button" id="button" value="用户积分归零"  onClick="JavaScript:return confirm('确认清空吗？不可恢复！')">
      请慎重操作：此操作将导致所有用户积分归零并不可恢复!
      </form>
    </td>
  </tr>
</table>
<%
end sub

sub add()
%>
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="2" bgcolor="#FFFFFF" class="admintable">
<tr> 
  <td colspan="5" class="admintitle">添加会员</th></tr>
<form action="?action=savenew" name="UserReg" method=post>
<tr>
<td width="20%" class=b1_1>会员名称</td>
<td class=b1_1 colspan=4><input name="UserName" type="text" id="UserName" size="30"></td>
</tr>
<tr> 
<td width="20%" class=b1_1>密码</td>
<td colspan=4 class=b1_1><input name="PassWord" type="text" id="PassWord" size="30"></td>
</tr>
<tr>
  <td class=b1_1>性别</td>
  <td colspan=4 class=b1_1><select name="Sex" id="Sex">
    <option value="1">男</option>
    <option value="0">女</option>
  </select></td>
</tr>
<tr>
  <td class=b1_1>出生日期</td>
  <td colspan=4 class=b1_1><input name='Birthday' type='text' class="borderall" onFocus="WdatePicker({isShowClear:false,readOnly:true,startDate:'1960-01-01',minDate:'1960-01-01',maxDate:'1994-12-31',skin:'whyGreen'})" style="width:140px;"/></td>
</tr>
<tr>
  <td class=b1_1>籍贯(省/市)：</td>
  <td colspan=4 class=b1_1><select onChange="setcity();" name='province' style="width:90px;">
    <option value=''>请选择省份</option>
    <option value="广东">广东</option>
    <option value="北京">北京</option>
    <option value="重庆">重庆</option>
    <option value="福建">福建</option>
    <option value="甘肃">甘肃</option>
    <option value="广西">广西</option>
    <option value="贵州">贵州</option>
    <option value="海南">海南</option>
    <option value="河北">河北</option>
    <option value="黑龙江">黑龙江</option>
    <option value="河南">河南</option>
    <option value="香港">香港</option>
    <option value="湖北">湖北</option>
    <option value="湖南">湖南</option>
    <option value="江苏">江苏</option>
    <option value="江西">江西</option>
    <option value="吉林">吉林</option>
    <option value="辽宁">辽宁</option>
    <option value="澳门">澳门</option>
    <option value="内蒙古">内蒙古</option>
    <option value="宁夏">宁夏</option>
    <option value="青海">青海</option>
    <option value="山东">山东</option>
    <option value="上海">上海</option>
    <option value="山西">山西</option>
    <option value="陕西">陕西</option>
    <option value="四川">四川</option>
    <option value="安徽">安徽</option>
    <option value="台湾">台湾</option>
    <option value="天津">天津</option>
    <option value="新疆">新疆</option>
    <option value="西藏">西藏</option>
    <option value="云南">云南</option>
    <option value="浙江">浙江</option>
    <option value="海外">海外</option>
  </select>
    <select name='city'  style="width:90px;">
    </select>
    <script src="<%=SitePath%>js/getcity.js"></script>
    <script>initprovcity('','');</script>
    <font color="#FF0000">*</font></td>
</tr>
<tr>
  <td class=b1_1>积分</td>
  <td colspan=4 class=b1_1><input name="UserMoney" type="text" id="UserMoney" value="0" size="30" maxlength="5"></td>
</tr>
<tr>
  <td class=b1_1>用户邮箱</td>
  <td colspan=4 class=b1_1><input name="Email" type="text" id="Email" size="30"></td>
</tr>
<tr>
  <td class=b1_1>QQ</td>
  <td colspan=4 class=b1_1><input name="UserQQ" type="text" id="UserQQ" size="30"></td>
</tr>
<tr> 
<td width="20%" class=b1_1></td>
<td colspan=4 class=b1_1><input name="Submit" type="submit" class="bnt" value="添 加"></td>
</tr></form>
</table>
<%
end sub

sub savenew()
	UserName=trim(request.form("UserName"))
	PassWord=trim(request.form("PassWord"))
	Email=trim(request.form("Email"))
	sex=trim(request.form("sex"))
	UserQQ=trim(request.form("UserQQ"))
	UserMoney=trim(request.form("UserMoney"))
	Birthday = 		request.form("Birthday")
	Province = 		request.form("Province")
	City = 			request.form("City")
	
	if UserName="" or PassWord="" then
		Call Alert ("用户名和密码不能为空",-1)
	end if
	if Birthday="" then
		Call Alert ("生日不能为空",-1)
	end if

	set rs = server.CreateObject ("adodb.recordset")
	sql="select * from "&tbname&"_User where UserName='"&UserName&"'"
	rs.open sql,conn,1,3
	if rs.eof and rs.bof then
		rs.AddNew 
		rs("UserName")		=UserName
		rs("Email")			=Email
		rs("UserQQ")		=UserQQ
		rs("Sex")			=sex
		rs("PassWord")		=md5(PassWord,16)
		rs("UserMoney")		=UserMoney
		rs("Birthday")		=Birthday
	  	rs("usergroupid")	=1
	  	rs("yn")=1
		rs("RegTime")=Now
		rs("IP")=GetIP
		rs("province")=Province
		rs("city")=City

		rs.update
		Call Alert ("添加成功！","Admin_User.asp")
	else
		Call Alert ("该用户已存在！",-1)
	end if
	rs.close
	set rs=nothing
end sub

sub del()
	id=request("id")
	set rs=conn.execute("delete from "&tbname&"_User where id="&id)
	set rs=conn.execute("delete from "&tbname&"_Article where UserID="&id)
	Call Alert ("删除成功","Admin_User.asp")
end sub

sub isyn()
	id=request("id")
	yn=request("yn")
	page=request("page")
	If yn=1 then
	yn=0
	else
	yn=1
	End if
	set rs=conn.execute("Update ["&tbname&"_User] set yn="&yn&" Where ID="&id)
	Response.Redirect "Admin_User.asp?page="&page&""
end sub

sub edit()
id=request("id")
set rs = server.CreateObject ("adodb.recordset")
sql="select * from "&tbname&"_User where id="& id &""
rs.open sql,conn,1,1
%>
<table width="95%" border="0"  align=center cellpadding="3" cellspacing="2" bgcolor="#FFFFFF" class="admintable">
<form action="?action=savedit" name="UserReg" method=post>
<tr> 
    <td colspan="5" class="admintitle">修改会员</td>
</tr>
<tr> 
<td width="20%" class="b1_1">会员登录名</td>
<td colspan=4 class=b1_1><%=rs("UserName")%></td>
</tr>
<tr>
  <td class="b1_1">用户组</td>
  <td colspan=4 class=b1_1><select size=1 name="usergroupid">
<%
set trs=conn.Execute("select UserGroupID,GroupName from "&tbname&"_UserGroup order by UserPowers asc")
do while not trs.eof
response.write "<option value="&trs(0)
if rs("usergroupid")=trs(0) then response.write " selected "
response.write ">"&tRs(1)&"</option>" & VbCrLf
trs.movenext
loop
trs.close
set trs=nothing
%>
</select></td>
</tr>
<tr>
  <td class="b1_1">密码</td>
  <td colspan=4 class=b1_1><input name="PassWord" type="text" id="PassWord" size="30" maxlength="12">
    *不修改请留空,原密码:<%=rs("PassWord")%></td>
</tr>
<tr>
  <td class="b1_1">性别</td>
  <td colspan=4 class=b1_1><select name="Sex" id="Sex">
    <option value="1"<%If rs("Sex")=1 then Response.Write(" selected") End if%>>男</option>
    <option value="0"<%If rs("Sex")=0 then Response.Write(" selected") End if%>>女</option>
  </select></td>
</tr>
<tr>
  <td class="b1_1">籍贯(省/市)：</td>
  <td colspan=4 class=b1_1><select name='province' id="province" style="width:90px;" onChange="setcity();">
    <option value=''>请选择省份</option>
    <option value="广东">广东</option>
    <option value="北京">北京</option>
    <option value="重庆">重庆</option>
    <option value="福建">福建</option>
    <option value="甘肃">甘肃</option>
    <option value="广西">广西</option>
    <option value="贵州">贵州</option>
    <option value="海南">海南</option>
    <option value="河北">河北</option>
    <option value="黑龙江">黑龙江</option>
    <option value="河南">河南</option>
    <option value="香港">香港</option>
    <option value="湖北">湖北</option>
    <option value="湖南">湖南</option>
    <option value="江苏">江苏</option>
    <option value="江西">江西</option>
    <option value="吉林">吉林</option>
    <option value="辽宁">辽宁</option>
    <option value="澳门">澳门</option>
    <option value="内蒙古">内蒙古</option>
    <option value="宁夏">宁夏</option>
    <option value="青海">青海</option>
    <option value="山东">山东</option>
    <option value="上海">上海</option>
    <option value="山西">山西</option>
    <option value="陕西">陕西</option>
    <option value="四川">四川</option>
    <option value="安徽">安徽</option>
    <option value="台湾">台湾</option>
    <option value="天津">天津</option>
    <option value="新疆">新疆</option>
    <option value="西藏">西藏</option>
    <option value="云南">云南</option>
    <option value="浙江">浙江</option>
    <option value="海外">海外</option>
  </select>
    <select name='city' id="city"  style="width:90px;">
    </select>
    <script src="<%=SitePath%>js/getcity.js"></script>
    <script>initprovcity('<%=rs("province")%>','<%=rs("city")%>');</script>
    <font color="#FF0000">*</font></td>
</tr>
<tr>
  <td class="b1_1">积分</td>
  <td colspan=4 class=b1_1><input name="UserMoney" type="text" id="UserMoney" value="<%=rs("UserMoney")%>" size="30"></td>
</tr>
<tr>
  <td class="b1_1">用户邮箱</td>
  <td colspan=4 class=b1_1><input name="Email" type="text" id="Email" value="<%=rs("Email")%>" size="30"></td>
</tr>
<tr>
  <td class=b1_1>生日</td>
  <td colspan=4 class=b1_1><input name="Birthday" type="text" id="Birthday" value="<%=rs("Birthday")%>" size="30"></td>
</tr>
<tr>
  <td class=b1_1>QQ</td>
  <td colspan=4 class=b1_1><input name="UserQQ" type="text" id="UserQQ" value="<%=rs("UserQQ")%>" size="30"></td>
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
	Dim id
	id=request.form("id")
	'UserName=trim(request.form("UserName"))
	PassWord=trim(request.form("PassWord"))
	Email=trim(request.form("Email"))
	Birthday=trim(request.form("Birthday"))
	UserQQ=trim(request.form("UserQQ"))
	usergroupid=trim(request.form("usergroupid"))
	Sex=trim(request.form("Sex"))
	Province = 		request.form("Province")
	City = 			request.form("City")
	UserMoney=		request.form("UserMoney")
	
	set rs = server.CreateObject ("adodb.recordset")
	sql="select * from "&tbname&"_User where ID="&id&""
	rs.open sql,conn,1,3
	if not(rs.eof and rs.bof) then
		'rs("UserName")		= UserName
		rs("Email")			= Email
		If birthday<>"" then
		rs("Birthday")		=Birthday
		end if
		rs("UserQQ")		=UserQQ
		rs("Sex")			=Sex
		If PassWord<>"" then
		rs("PassWord")		=md5(PassWord,16)
		end if
		rs("usergroupid")	=usergroupid
		rs("province")		=Province
		rs("city")			=City
		rs("UserMoney")		=UserMoney
		
		rs.update
		Response.write"<script>alert(""恭喜,修改成功！"");location.href=""Admin_User.asp"";</script>"
	else
		Response.write"<script>alert(""修改错误！"");location.href=""Admin_User.asp"";</script>"
	end if
	rs.close
	set rs=nothing
end sub

sub deljf()
	set rs=conn.execute("Update "&tbname&"_User set UserMoney = 0")
	Call Alert ("积分已归零！","admin_user.asp")
end sub
%>
<!--#include file="Admin_copy.asp"-->
</body>
</html>