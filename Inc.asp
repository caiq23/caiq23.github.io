<%
Function Head()
	If laoyvip and sj=0 then
	Head="<script type=""text/javascript"">uaredirect(""http://"&SiteUrl&SitePath&"3g/"");</script>"
	End If
	Head=Head&"<div id=""webhead"">" & VbCrLf
	Head=Head&"	<div id=""toplogin"">" & VbCrLf
	Head=Head&"		<span>" & VbCrLf
	Head=Head&"		<script type=""text/javascript"" src="""&Sitepath&"js/date.js""></script>" & VbCrLf
	Head=Head&"		</span>" & VbCrLf
	If useroff=1 then
	Head=Head&"		<script type=""text/javascript"" src="""&SitePath&"js/login.asp?s="&now&"""></script>" & VbCrLf
	else
	Head=Head&"		<script language=javascript src="""&Sitepath&"js/wealth.js""></script>" & VbCrLf
	End if
	Head=Head&"	<div id=""clear""></div>" & VbCrLf
	Head=Head&"	</div>" & VbCrLf
	If toplogo=0 then
	Head=Head&"<div style=""height:65px;""><div id=""logo"">"
	Head=Head&"<a href=""http://"&SiteUrl&SitePath&"""><img src="""&SiteLogo&""" alt="""&SiteTitle&""" /></a>" & VbCrLf
	Head=Head&"</div>" & VbCrLf
	Head=Head&"<div id=""banner"">"
	Head=Head&ShowAD(4)
	Head=Head&"</div>" & VbCrLf
	Head=Head&"<div id=""topright"">" & VbCrLf
	Head=Head&"		<div class=""topright3""><li><a href=""javascript:void(0);"" onclick=""SetHome(this,'http://"&siteurl&"');"">设为首页</a></li><li><a href=""javascript:addfavorite()"">加入收藏</a></li><li style=""text-align:center;""><a id=""StranLink"">繁體中文</a></li><li style=""text-align:right;""><a href="""&SitePath&"sitemap.asp"">网站地图</a></li></div><div id=""clear""></div>" & VbCrLf
	Head=Head&"		<div class=""textad"">"
	Head=Head&ShowAD(10)
	Head=Head&"		</div>" & VbCrLf
	Head=Head&"</div></div>" & VbCrLf
	ElseIf toplogo=1 then
	Head=Head&"		<a href=""http://"&SiteUrl&SitePath&"""><img src="""&SiteLogo&""" alt="""&SiteTitle&""" /></a>" & VbCrLf
	ElseIf toplogo=2 then
	Head=Head&"		<embed src="""&SiteLogo&""" type=""application/x-shockwave-flash"" width=""950"" quality=""high"" />" & VbCrLf
	End if
	Head=Head&"</div>" & VbCrLf
	Head=Head&"	<div id=""clear""></div>" & VbCrLf
End function

Function Menu()
	Menu=""
	Menu=Menu&"<div id=""webmenu"">"& vbCrLf
	Menu=Menu&"	<ul>"& vbCrLf
	set rs8=conn.execute("select [ID],[ClassName],[Num],[IsMenu],[link],[Url],[target] from "&tbname&"_Class Where IsMenu=1 order by num asc")
	NoI=0
	do while not rs8.eof
	NoI=NoI+1
	Menu=Menu&"<li"
	If Mydb("Select Count([ID]) From ["&tbname&"_Class] Where TopID="&rs8("ID")&"",1)(0)>0 then
	Menu=Menu&" onmouseover=""displaySubMenu(this)"" onmouseout=""hideSubMenu(this)"")"
	End if
	Menu=Menu&">"
	If NoI>1 then Menu=Menu&menuimg
    Menu=Menu&" <a href="""
	If rs8("link")=1 then
	Menu=Menu&laoy(rs8("url"))
	else
	Menu=Menu&cpath(rs8("ID"),0)
	End if
	Menu=Menu&""" target="""&rs8("target")&""">"&rs8("ClassName")&"</a>"
	If Mydb("Select Count([ID]) From ["&tbname&"_Class] Where TopID="&rs8("ID")&"",1)(0)>0 then
    Menu=Menu&"<div>"& vbCrLf
		Sqlpp ="select [ID],[ClassName],[Num],[IsMenu],[link],[Url],[target] from "&tbname&"_Class Where TopID="&Rs8("ID")&" order by num"   
		Set Rspp=server.CreateObject("adodb.recordset")   
		rspp.open sqlpp,conn,1,1
		Do while not Rspp.Eof
    Menu=Menu&"<a href="""&cpath(rspp("ID"),0)&""" target="""&rspp("target")&""">"&rspp("ClassName")&"</a>"& vbCrLf
		Rspp.Movenext   
		Loop
		rspp.close : set rspp=nothing
    Menu=Menu&"</div>"& vbCrLf
	End if
    Menu=Menu&"</li>"
	rs8.movenext
	loop
	rs8.close
	set rs8=nothing
	If rss=1 then
    Menu=Menu&"	        <li><a href="""&sitepath&"Rss/Rss.xml"" target=""_blank""><img src="""&sitepath&"images/rss.gif"" alt=""订阅本站Rss""/></a></li>"& vbCrLf
    End if
	Menu=Menu&"	</ul>"& vbCrLf
	Menu=Menu&"</div>"& vbCrLf
	Menu=Menu&"<div id=""clear""></div>"& vbCrLf
	Menu=Menu&ShowAD(11)
End function

Function Copy1
	Copy1=""
	Copy1=Copy1&"<div id=""clear""></div>" & VbCrLf
	Copy1=Copy1&"<div id=""webcopy"">" & VbCrLf
	If laoyvip then Copy1=Copy1&DiypageMenu()
	Copy1=Copy1&"	<li>"&SiteTitle&"(<a href=""http://"&SiteUrl&""">"&SiteUrl&"</a>) &copy; "&year(Now)&" 版权所有 All Rights Reserved.</li>" & VbCrLf
	Copy1=Copy1&"	<li>"&Sitelx&" <a href=""https://beian.miit.gov.cn/"" target=""_blank"">"&SiteTcp&"</a></li>" & VbCrLf
	Copy1=Copy1&Label(2)
	'Copy1=Copy1&ScriptTime & VbCrLf
	Copy1=Copy1&"</div>" & VbCrLf
	Copy1=Copy1&"<script language=""javascript"" src="""&SitePath&"js/Std_StranJF.Js""></script>"
End function

Function Copy
	Copy=Copy1
	Conn.Close : Set Conn = Nothing	
End function

Function search
	search=""
	search=search&"<div style=""float:right;margin-top:-5px;background:url("&SitePath&"images/search.jpg) left no-repeat;padding-left:100px;"">" & VbCrLf
	search=search&"<form id=""form1"" name=""form1"" method=""post"" action="""&SitePath&"Search.asp?action=search"" target=""_blank"">" & VbCrLf
	search=search&"<input name=""KeyWord"" type=""text"" id=""KeyWord"" value="""&keyword&""" maxlength=""10"" size=""13"" class=""borderall"" style=""height:17px;""/>" & VbCrLf
	search=search&"  <select name=""bbs"" id=""bbs"">" & VbCrLf
	search=search&"    <option value=""1"">站内搜索</option>" & VbCrLf
	search=search&"    <option value=""3"">百度搜索</option>" & VbCrLf
	search=search&"    <option value=""4"">Google搜索</option>" & VbCrLf
	search=search&"    <option value=""5"">youdao搜索</option>" & VbCrLf
	search=search&"    <option value=""6"">雅虎搜索</option>" & VbCrLf
	search=search&"  </select>" & VbCrLf
	search=search&"<input type=""submit"" name=""Submit"" value=""搜 索"" class=""borderall"" style=""height:21px;""/>" & VbCrLf
	search=search&"</form>" & VbCrLf
	search=search&"</div>" & VbCrLf
End Function

Function DiypageMenu()
	DiypageMenu=""
	DiypageMenu=DiypageMenu&"<div class=""DiypageMenu"">"& vbCrLf
	set rs8=conn.execute("select [ID],[title],[display],[dir] from "&tbname&"_Diypage Where display=1 order by num asc,id desc")
	NoI=0
	do while not rs8.eof
	NoI=NoI+1
	If NoI>1 then DiypageMenu=DiypageMenu&" | "
	DiypageMenu=DiypageMenu&"<a href="""&sitepath&rs8("dir")&".html"">"&rs8("title")&"</a>"
	rs8.movenext
	loop
	rs8.close : set rs8=nothing
	DiypageMenu=DiypageMenu&"</div>"& vbCrLf
	DiypageMenu=DiypageMenu&"<div id=""clear""></div>"& vbCrLf
End function
%>