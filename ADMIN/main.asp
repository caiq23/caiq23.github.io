<!--#include file="../Inc/conn.asp"-->
<!--#include file="admin_check.asp"-->
<%
Select Case Request("Sub")
Case "Logout"
  Response.Cookies("LaoYAdmin").path=SitePath
  Response.Cookies("LaoYAdmin")("UserID")=""
  Response.Cookies("LaoYAdmin")("UserPass")=""
  Response.Cookies("LaoYAdmin")("UserName")=""
  response.Redirect "Admin_Login.asp"
Case "delmdb"
If yaoadmintype=1 then
  call BackupData()
  set rs=conn.execute("delete from "&tbname&"_Article")
  set rs=conn.execute("delete from "&tbname&"_XinQing")
  set rs=conn.execute("delete from "&tbname&"_Pl")
  set rs=conn.execute("delete from "&tbname&"_GuestBook")
  set rs=conn.execute("delete from "&tbname&"_Class Where link=0")
  set rs=conn.execute("delete from "&tbname&"_User")
  set rs=conn.execute("delete from "&tbname&"_Vote")
  Call Alert ("初始化完成","main.Asp?Sub=Main")
End if
Case "indexhtml"
	dim http,reurl
	set http=Server.createobject("Micro"&"soft."&chr(120)&"MLHTTP") 
	Http.open "GET","http://"&request.servervariables("server_name")&SitePath&"index.asp?n="&now&"",false 
	Http.send() 
	set objStream = Server.CreateObject("ADO"&"DB.Str"&"eam") 
	objStream.type = 1 
	objStream.open 
	objstream.write http.responseBody
	objstream.saveToFile server.mappath("../index.html"),2
	Call Alert ("已生成!","main.asp?Sub=Main")
Case "Main"
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=GB2312" />
<title>admin</title>
<link href="Images/admin_css.css" rel="stylesheet" type="text/css" />

</head>
<body>
<table width="98%" border="0" align="left" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15" height="30"><img src="images/tab_03.gif" width="15" height="30" /></td>
        <td width="24" background="images/tab_05.gif"><img src="images/311.gif" width="16" height="16" /></td>
        <td width="1373" background="images/tab_05.gif" class="title1">系统信息</td>
        <td width="14"><img src="images/tab_07.gif" width="14" height="30" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="9" background="images/tab_12.gif">&nbsp;</td>
        <td bgcolor="#f3ffe3">
          <table border="0" align="center" cellpadding="3" cellspacing="1" class="admintable1">
            <tr>
              <td width="33%" align="left" bgcolor="#FFFFFF" style="height:30px;">文章总数：<%If Mydb("Select Count([ID]) From ["&tbname&"_Article] Where yn=1",1)(0)>0 then%><font color="blue"><b><%=Mydb("Select Count([ID]) From ["&tbname&"_Article] Where yn=1",1)(0)%></b></font>/<%end if%><font color="red"><%=Mydb("Select Count([ID]) From ["&tbname&"_Article]",1)(0)%></font> <font color="blue">[<a href="Admin_Article.asp">管理</a>]</font></td>
              <td width="33%" align="left" bgcolor="#FFFFFF">留言总数：<%If Mydb("Select Count([ID]) From ["&tbname&"_Guestbook] Where yn=0",1)(0)>0 then%><font color="blue"><b><%=Mydb("Select Count([ID]) From ["&tbname&"_Guestbook] Where yn=0",1)(0)%></b></font>/<%end if%><font color="red"><%=Mydb("Select Count([ID]) From ["&tbname&"_Guestbook]",1)(0)%></font> <font color="blue">[<a href="Admin_Guestbook.asp">管理</a>]</font> </td>
              <td align="left" bgcolor="#FFFFFF">评论总数：<%If Mydb("Select Count([ID]) From ["&tbname&"_Pl] Where yn=0",1)(0)>0 then%><font color="blue"><b><%=Mydb("Select Count([ID]) From ["&tbname&"_Pl] Where yn=0",1)(0)%></b></font>/<%end if%><font color="red"><%=Mydb("Select Count([ID]) From ["&tbname&"_Pl]",1)(0)%></font> <font color="blue">[<a href="Admin_Pl.asp">管理</a>]</font></td>
            </tr>
            <tr>
              <td width="33%" align="left" bgcolor="#FFFFFF" style="height:30px;">会员总数：<%If Mydb("Select Count([ID]) From ["&tbname&"_User] Where yn=0",1)(0)>0 then%><font color="blue"><b><%=Mydb("Select Count([ID]) From ["&tbname&"_User] Where yn=0",1)(0)%></b></font>/<%end if%><font color="red"><%=Mydb("Select Count([ID]) From ["&tbname&"_User]",1)(0)%></font> <font color="blue">[<a href="Admin_User.asp">管理</a>][<a href="Admin_Group.Asp">等级管理</a>]</font></td>
              <td width="33%" align="left" bgcolor="#FFFFFF">链接总数：<%If Mydb("Select Count([ID]) From ["&tbname&"_Link] Where yn=0",1)(0)>0 then%><font color="blue"><b><%=Mydb("Select Count([ID]) From ["&tbname&"_Link] Where yn=0",1)(0)%></b></font>/<%end if%><font color="red"><%=Mydb("Select Count([ID]) From ["&tbname&"_Link] Where yn<>2",1)(0)%></font> <font color="blue">[<a href="Admin_Link.asp">管理</a>]</font> <font color="blue">[<a href="Admin_Link.asp?action=add">添加</a>]</font></td>
              <td align="left" bgcolor="#FFFFFF"></td>
            </tr>
            <%
  j = 1
  Set Rs = MYDB("Select [BotName],[LastDate] From ["&tbname&"_Bots] Order By [LastDate] Desc",1)
  Do While Not Rs.Eof
  j = j + 1
  %>
            <tr>
              <%For i = 1 To 3%>
              <%If Not Rs.Eof Then%>
              <td align="left" bgcolor="#FFFFFF" style="height:30px;"><strong><font color="#50691B"><%=Rs(0)%></font></strong>&nbsp;&nbsp;<%=IIF(Month(Rs(1))=Month(Date) And Day(Rs(1))=Day(Date),Rs(1) & " <font color=red size=1>New</font>",Rs(1))%></td>
              <%Else%>
              <td align="left" bgcolor="#FFFFFF">&nbsp;</td>
              <%End If%>
              <%If Not Rs.Eof Then Rs.MoveNext%>
              <%Next%>
            </tr>
            <%
  If j >=2 Then j = 0
  Loop
  Rs.Close : Set Rs = Nothing
  %>
          </table>
          <table border="0" align="center" cellpadding="3" cellspacing="1" class="admintable1" style="margin-top:5px;">
            <tr>
              <td width="33%" align="left" bgcolor="#FFFFFF" style="height:30px;">服务器IP地址：<%=Request.ServerVariables("LOCAL_ADDR")%></td>
              <td width="33%" align="left" bgcolor="#FFFFFF">IIS版本名称：<%=Request.ServerVariables("SERVER_SOFTWARE")%></td>
              <td align="left" bgcolor="#FFFFFF">服务器Session数量：<%=Session.Contents.Count%></td>
            </tr>
            <tr>
              <td width="33%" align="left" bgcolor="#FFFFFF" style="height:30px;">服务器当前时间：<%=Now()%></td>
              <td colspan="2" align="left" bgcolor="#FFFFFF">站点物理路径：<%=Request.ServerVariables("APPL_PHYSICAL_PATH")%></td>
            </tr>
	<%
	Dim InstallObj(6)
	InstallObj(0) = "ADODB.Connection"
	InstallObj(1) = strobjectfso
	InstallObj(2) = strobjectads
	InstallObj(3) = strobjectxmlhttp
	InstallObj(4) = "Persits.Jpeg"
	InstallObj(5) = "JMail.SmtpMail"
	For i = 0 To Ubound(InstallObj)-2
		Response.Write "  <tr>" & Vbcrlf 
		Response.Write "    <td width=""33%"" align=""left"" bgcolor=""#FFFFFF"" style=""height:30px;"">" & InstallObj(i) & "："
		If IsObjInstalled(InstallObj(i)) Then Response.Write "<font color='green'>支持</font>" Else Response.Write "<font color='red'>不支持</font>"
		Response.Write "</td>" & Vbcrlf 
		Response.Write "    <td width=""33%"" align=""left"" bgcolor=""#FFFFFF"">" & InstallObj(i+1) & "："
		If IsObjInstalled(InstallObj(i+1)) Then Response.Write "<font color='green'>支持</font>" Else Response.Write "<font color='red'>不支持</font>"
		Response.Write "</td>" & Vbcrlf 
		Response.Write "    <td align=""left"" bgcolor=""#FFFFFF"">" & InstallObj(i+2) & "："
		If IsObjInstalled(InstallObj(i+2)) Then Response.Write "<font color='green'>支持</font>" Else Response.Write "<font color='red'>不支持</font>"
		Response.Write "</td>" & Vbcrlf 
		Response.Write "  </tr>" & Vbcrlf
		i=i+2
	Next
	%>
          </table>
          <table border="0" cellspacing="2" cellpadding="3"  align="center" class="admintable1" style="margin-top:5px;">
<tr> 
  <td align=left class="admintitle">官方最新消息</td>
</tr>
<tr> 
  <td width="50%" bgcolor="#FFFFFF" style="text-align:left;"><iframe marginheight=0 marginwidth=0 frameborder=0 width=100% height=200 scrolling=NO src="http://serve.laoy.net/<%if laoyvip then Echo "vip.asp" End if%>"></iframe></td>
  </tr>
</table><%If yaoadmintype=1 then%>
          <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td width="50%"><table border="0" cellspacing="2" cellpadding="3"  align="left" class="admintable1" style="margin-top:5px;width:99%;">
                <tr>
                  <td align="left" class="admintitle">网站初始化</td>
                </tr>
                <tr>
                  <td height="80" bgcolor="#FFFFFF" style="text-align:left;height:75px;line-height:22px;">注意：此操作会<font color="red"><b>清空网站文章、栏目、留言、评论</b></font>,用于网站初始安装，请谨慎操作。你看清楚了吗？
                    <form id="form1" name="form1" method="post" action="main.asp?Sub=delmdb">
                        <input type="submit" name="button" id="button" value="我看清楚了，清吧!" onclick="JavaScript:return   confirm('真的要清？不可恢复的哦!')" style="background:#ffffff;"/>
                    </form></td>
                </tr>
              </table></td>
              <td><table border="0" cellspacing="2" cellpadding="3" align="right" class="admintable1" style="margin-top:5px;width:99%">
                <tr>
                  <td align="left" class="admintitle">快捷管理</td>
                </tr>
                <tr>
                  <td height="80" bgcolor="#FFFFFF" style="text-align:left;height:75px;line-height:22px;text-align:center;"><input type="button" name="button" value="更新RSS" class="bnt" onClick="window.location.href='Admin_RSS.asp'" />
                   <input type="button" name="button" value="更新CSS" class="bnt" onClick="window.location.href='Admin_CssHtml.asp'" />
                    <input type="button" name="button" value="更新地图" class="bnt" onClick="window.location.href='Admin_xml.asp?action=google'" /></td>
                </tr>
              </table></td>
            </tr>
          </table><%End if%></td>
        <td width="9" background="images/tab_16.gif">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="29"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15" height="29"><img src="images/tab_20.gif" width="15" height="29" /></td>
        <td background="images/tab_21.gif">&nbsp;</td>
        <td width="14"><img src="images/tab_22.gif" width="14" height="29" /></td>
      </tr>
    </table></td>
  </tr>
</table><script src="http://my.laoy.net/app.asp?domain=<%=Request.ServerVariables("HTTP_HOST")&sitepath%>&version=<%=version%>"></script>
<%
sub BackupData()
	dim Dbpath,bkfolder,bkdbname,fso
	Dbpath=SitePath&"data/"&DataName
	Dbpath=server.mappath(Dbpath)
	bkfolder="../Databackup/"
	CreateFolder(bkfolder&"index.html")
	Set Fso=Server.CreateObject("Scripting.FileSystemObject")
	if fso.fileexists(dbpath) then
		If CheckDir(bkfolder) = True Then
		fso.copyfile dbpath,bkfolder& "\"& FormatDate(now,12,0)&".mdb"
		end if
	End if
end sub
'------------------检查某一目录是否存在-------------------
Function CheckDir(FolderPath)
    dim fso1
	folderpath=Server.MapPath(".")&"\"&folderpath
    Set fso1 = Server.CreateObject("Scripting.FileSystemObject")
    If fso1.FolderExists(FolderPath) then
       '存在
       CheckDir = True
    Else
       '不存在
       CheckDir = False
    End if
    Set fso1 = nothing
End Function
%></body>
</html>
<%End Select%>