<!--#include file="heck.asp"-->
<%
'*****************************************
'作者：guke
'QQ：6692103
'*****************************************
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title></title>
<link href=../images/css.css rel=stylesheet type=text/css />
</head>
<body>
<TABLE width="98%" border=0 align=center cellPadding=6 cellSpacing=1 bgcolor="#CCCCCC">
<tr><td height=3></td></tr>
<tr>
      <TD width="17%" align=center height=11 bgcolor="#FFFFFF">服务器类型</TD>
      <TD width="83%" bgcolor="#FFFFFF" ><%=Request.ServerVariables("OS")%>　IP：<%=Request.ServerVariables("LOCAL_ADDR")%></TD>
    </TR>
    <TR>
      <TD height=12 align=center bgcolor="#FFFFFF">IIS 版本</TD>
      <TD width="83%" bgcolor="#FFFFFF"><%=Request.ServerVariables("SERVER_SOFTWARE")%></TD>
    </TR>
    <TR>
      <TD height=12 align=center bgcolor="#FFFFFF">脚本引擎</TD>
      <TD width="83%" bgcolor="#FFFFFF"><%=ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %></TD>
    </TR>
</TABLE>
<TABLE width="100%" align=center>
  <TR>
    <TD align="center"><br/>Copyright (c) <%=year(now())%> my478 All Rights Reserved.</TD>
</TR>
</TABLE>
</BODY>
</HTML>