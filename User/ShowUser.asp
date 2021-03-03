<!--#include file="../Inc/conn.asp"-->
<!--#include file="../Inc/ubb.asp"-->
<%
Dim ID,UserName
ID=LaoYRequest(request("id"))
UserName1=CheckStr(Trim(request("UserName")))
set rs=server.createobject("adodb.recordset")
If ID<>"" then
sql="select * from "&tbname&"_User where id="&ID&""
Else
sql="select * from "&tbname&"_User where UserName='"&UserName1&"'"
End if
rs.open sql,conn,1,1
if rs.eof and rs.bof then
Call Alert("不正确的用户",""&SitePath&"Index.asp")
else
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta name="keywords" content="<%=Sitekeywords%>" />
<link href="<%=SitePath%>images/css<%=Css%>.css" type=text/css rel=stylesheet>
<script type="text/javascript" src="<%=SitePath%>js/main.asp"></script>
<title><%=rs("UserName")%>的资料-<%=SiteTitle%></title>
</head>
<body>
<div class="mwall">
<%=Head%>
<%=Menu%><div class="mw">
	<div class="dh">
		<%=search%>您现在的位置：<a href="<%=SitePath%>Index.asp">首页</a> >> <a href="UserList.asp?t=0">会员列表</a> >> 会员详细资料
    </div>
	<div id="nw_left">
		<div id="web2l">
			<div id="content" style="height:320px;">
<%
UserID=Request.Cookies("Yao")("ID")
If UserID="" then
Response.Write("<div style='text-align:center;padding-top:120px;'>只有登录用户才能查看资料</div>")
else
%>
			  <table width="80%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#f7f7f7" style="margin-bottom:176px;">
                <tr>
                  <td width="30%" height="30" align="left" bgcolor="#FFFFFF">用户名：</td>
                  <td width="37%" align="left" bgcolor="#FFFFFF"><%=rs("UserName")%></td>
                  <td width="33%" rowspan="5" align="center" bgcolor="#FFFFFF"><img src="<%If rs("UserFace")<>"" then Response.Write(""&laoyface(rs("UserFace"))&"") else Response.Write(""&SitePath&"images/noface.gif") end if%>" width=100 height=100/></td>
                </tr>
                <tr>
                  <td height="30" align="left" bgcolor="#FFFFFF"><%=moneyname%>：</td>
                  <td align="left" bgcolor="#FFFFFF"><font style="color:#ff0000;font-weight:bold;"><%=rs("UserMoney")%></font></td>
                </tr>
                <tr>
                  <td height="30" align="left" bgcolor="#FFFFFF">等级：</td>
                  <td align="left" bgcolor="#FFFFFF"><%=UserGroupInfo(rs("UserGroupID"),0)%></td>
                </tr>
                <tr>
                  <td height="30" align="left" bgcolor="#FFFFFF">性别：</td>
                  <td align="left" bgcolor="#FFFFFF"><%=IIf(rs("sex")=0,"女","男")%></td>
                </tr>
                <tr>
                  <td height="30" align="left" bgcolor="#FFFFFF">Email地址：</td>
                  <td align="left" bgcolor="#FFFFFF"><%=rs("Email")%></td>
                </tr>
                <tr>
                  <td height="30" align="left" bgcolor="#FFFFFF">籍贯(省/市)：</td>
                  <td colspan="2" align="left" bgcolor="#FFFFFF"><%=rs("province")%><%=rs("city")%></td>
                </tr>
                <tr>
                  <td height="30" align="left" bgcolor="#FFFFFF">出生日期：</td>
                  <td colspan="2" align="left" bgcolor="#FFFFFF"><%=rs("Birthday")%></td>
                </tr>
                <tr>
                  <td height="30" align="left" bgcolor="#FFFFFF">QQ号码：</td>
                  <td colspan="2" align="left" bgcolor="#FFFFFF"><%=rs("UserQQ")%></td>
                </tr>
                <tr>
                  <td height="30" align="left" bgcolor="#FFFFFF">最近登录时间：</td>
                  <td colspan="2" align="left" bgcolor="#FFFFFF"><%=rs("LastTime")%></td>
                </tr>
                <tr>
                  <td height="30" align="left" bgcolor="#FFFFFF">最后登陆IP：</td>
                  <td colspan="2" align="left" bgcolor="#FFFFFF"><a href="http://www.laoy.net/other/IP.asp?ip=<%=iparray(rs("LastIP"))%>" target="_blank"><%=iparray(rs("LastIP"))%></a>　←点击ＩＰ查询位置</td>
                </tr>
              </table>
<%End if%>
			</div>
		</div>
		<div id="web2l">
			<h6><%=rs("UserName")%>发布的文章</h6>
			<div id="marticle">
				<ul>
				<%Call ShowArticle(0,10,5,"·",100,"UserID = "&rs("ID")&"","ID desc",1,1,0)%>
				<li class="lookmore"><a href="<%=SitePath%>Search.asp?KeyWord=<%=rs("ID")%>&type=2">查看更多<%=rs("UserName")%>的文章...</a></li>
				</ul>
			</div><div id="clear"></div>
		</div><%If laoyvip then%>
        <div id="web2l">
			<h6><%=rs("UserName")%>发布的帖子</h6>
			<div id="marticle">
				<ul>
<%
set rs1=server.createobject("ADODB.Recordset")
sql1="select Top 10 id,title,AddTime from "&tbname&"_Guestbook where yn = 1 and yaoid = 0 and userid = "&rs("id")&" order by ID desc"
rs1.open sql1,conn,1,3
NoI=0
If Not rs1.Eof Then 
do while not (rs1.eof or err)
NoI=NoI+1 
%>
			<li><span style="float:right;font-style:italic;font-family:Arial; "><%=FormatDate(rs1(2),5,0)%></span><font class='laoynoi1'><%=NoI%></font>.<a href="<%=sitepath%>bbs/dispbbs.asp?id=<%=rs1(0)%>" target="_blank"><%=rs1(1)%></a></li>
  <%
  rs1.movenext
  loop
  else
  Response.Write("		<li>"&rs("UserName")&"还没有帖子!</li>")
  end if
  rs1.close
  set rs1=nothing
  %>
				<li class="lookmore"><a href="<%=SitePath%>bbs/?KeyWord=<%=rs("UserName")%>">查看更多<%=rs("UserName")%>的帖子...</a></li>
				</ul>
			</div><div id="clear"></div>
		</div><%End If%>
	</div>
	<div id="nw_right">
		<%Echo ShowAD(3)%>
		<div id="web2r">
			<h5>最新文章</h5>
			<ul id="list10">
            	<%Call ShowArticle(0,10,5,"·",100,"no","DateAndTime desc,ID desc",0,1,0)%>
            </ul>
  		</div>
	</div>
</div><%
rs.close
set rs=nothing
end if
%>
<%=Copy%></div>
</body>
</html>
