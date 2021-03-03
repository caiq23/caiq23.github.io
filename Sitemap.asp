<!--#include file="Inc/conn.asp"--><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>网站地图-<%=SiteTitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta name="keywords" content="<%=Sitekeywords%>" />
<meta name="description" content="<%=Sitedescription%>" />

<style>
<!--
body {font-size:12px;}
a:link,a:visited {font-size:14px; color:#0033FF;}
a:hover { font-size:14px;color:#ff0000; text-decoration:none;}
li {list-style:none;margin:0;padding:0}
img {border:0;}

#logo {margin-bottom:50px;}
#sitemap {float:left;width:760px;margin:0 auto;}
#sitemap li {clear:both;margin:15px 0;}
.small {padding-left:15px;}
-->
</style>
</head>
<body>
	<div id="logo">
		<a href="http://<%=SiteUrl%>"><img src="<%=sitelogo%>" alt="<%=SiteTitle%>" /></a>
	</div>
	<div id="sitemap">
		<ul>
		<%
set rs8=conn.execute("select * from "&tbname&"_Class Where TopID=0 order by num asc")
NoI=0
do while not rs8.eof
NoI=NoI+1%>
			<li>·<a href="<%=IIf(rs8("link")=1,laoy(rs8("url")),cpath(rs8("ID"),0))%>"><%=rs8("ClassName")%></a> <%=rs8("ReadMe")%></li><%
		    Sqlpp ="select * from "&tbname&"_Class Where TopID="&Rs8("ID")&" order by num"   
   			Set Rspp=server.CreateObject("adodb.recordset")   
   			rspp.open sqlpp,conn,1,1
			Do while not Rspp.Eof
%>
				<li class="small">|--<a href="<%=IIf(rspp("link")=1,laoy(rspp("url")),cpath(rspp("ID"),0))%>"><%=rspp("ClassName")%></a> <%=rspp("ReadMe")%></li><%
			Rspp.Movenext   
      		Loop
   rspp.close
   set rspp=nothing
rs8.movenext
loop%>
<%rs8.close
set rs8=nothing%>
		</ul>
	</div>
</body>
</html>