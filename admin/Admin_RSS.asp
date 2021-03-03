<!--#include file="../Inc/conn.asp"-->
<!--#include file="admin_check.asp"-->
<%
Call chkAdmin(19)
id=LaoYRequest(Trim(request("id")))
If id="" then
	set rss=server.createobject("ADODB.Recordset")
	sqls="select id from "&tbname&"_class Where link=0 order by ID desc"
	rss.open sqls,conn,1,3
	If Not rss.Eof Then 
	do while not (rss.eof or err) 
	Call CreateRss(rss("id"))
	rss.movenext
	loop
	end if
	rss.close :set rss=nothing
else
Call CreateRss(id)
end if
Call CreateRss(0)
Call Info("更新成功!")

Public function CreateRss(rssid)
	If rssid=0 then cname="最近更新" else cname=getclass(rssid,"classname")
	Crss = ""
	Crss = Crss&"<?xml version=""1.0"" encoding=""gb2312""?>" & VbCrLf
	Crss = Crss&"<rss version=""2.0"" xmlns:content=""http://purl.org/rss/1.0/modules/content/"" xmlns:wfw=""http://wellformedweb.org/CommentAPI/"" xmlns:dc=""http://purl.org/dc/elements/1.1/"">" & VbCrLf
	Crss = Crss&"<channel>" & VbCrLf
	Crss = Crss&"<title><![CDATA["&cname&"--"&SiteTitle&"]]></title>" & VbCrLf
	Crss = Crss&"<link>http://"&SiteUrl&"/</link>" & VbCrLf
	Crss = Crss&"<description><![CDATA["&Sitedescription&"]]></description>" & VbCrLf
	Crss = Crss&"<webMaster><![CDATA["&Sitelx&"]]></webMaster>" & VbCrLf
	Crss = Crss&"<language>zh-cn</language>" & VbCrLf
	Crss = Crss&"<copyright>Powered by laoy.net. Copyright c 2008-"&year(now)&" 老Y文章管理系统</copyright>" & VbCrLf
	Crss = Crss&"<generator><![CDATA[Powered by laoy.net. Copyright ? 2008-"&year(now)&" 老Y文章管理系统]]></generator>" & VbCrLf
	Crss = Crss&"<lastBuildDate>"&FormatEnTime(FormatDate(now,1,0))&"</lastBuildDate>" & VbCrLf
	Crss = Crss&"<ttl>60</ttl>" & VbCrLf
	set rs1=server.createobject("ADODB.Recordset")
	sql1="select Top 50 ID,Title,Author,Artdescription,ClassID,DateAndTime from "&tbname&"_Article where yn = 0"
	If rssid>0 then
		If Yao_MyID(rssid)="0" then
			SQL1=SQL1&" and ClassID="&rssid&""
		else
			MyID = Replace(""&Yao_MyID(rssid)&"","|",",")
			SQL1=SQL1&" and ClassID in ("&MyID&")"
		End if
	end if
	SQL1=SQL1&" order by DateAndTime desc,ID desc"
	rs1.open sql1,conn,1,3
	If Not rs1.Eof Then 
	do while not (rs1.eof or err) 
	Crss = Crss&"<item>" & VbCrLf
	Crss = Crss&"<guid>http://"&SiteUrl&apath(rs1("ID"),0)&"</guid>" & VbCrLf
	Crss = Crss&"<title><![CDATA["&LoseHtml(rs1("Title"))&"]]></title>" & VbCrLf
	Crss = Crss&"<author><![CDATA["&rs1("Author")&"]]></author>" & VbCrLf
	Crss = Crss&"<description><![CDATA["&left(LoseHtml(rs1("Artdescription")),250)&"...]]></description>" & VbCrLf
	Crss = Crss&"<link>http://"&SiteUrl&apath(rs1("ID"),0)&"</link>" & VbCrLf
	Crss = Crss&"<category domain=""http://"&SiteUrl&cpath(rs1("ClassID"),0)&"""><![CDATA["&getclass(rs1("ClassID"),"classname")&"]]></category>" & VbCrLf
	Crss = Crss&"<pubDate>"&FormatEnTime(FormatDate(rs1("DateAndTime"),1,0))&"</pubDate>" & VbCrLf
	Crss = Crss&"</item>" & VbCrLf
	  rs1.movenext
	  loop
	  end if
	  rs1.close
	  set rs1=nothing
	Crss = Crss&"</channel>" & VbCrLf
	Crss = Crss&"</rss>" & VbCrLf
	If rssid > 0 then rssid1 = rssid else rssid1 = ""
	Call CreateFile(Crss,"../Rss/rss"&rssid1&".xml")
end function

function FormatEnTime(theTime)
dim myArray1,myArray2,years,months,days,mytime
FormatEnTime=""
myArray1=split(theTime," ")
theTime=myArray1(0)
myArray2=split(theTime,"-")
years=myArray2(0)
months=myArray2(1)
days=myArray2(2)
mytime=myArray1(1)
select case months
case "1"
months="January"
case "2"
months="February"
case "3"
months="March"
case "4"
months="April"
case "5"
months="May"
case "6"
months="June"
case "7"
months="July"
case "8"
months="August"
case "9"
months="September"
case "10"
months="October"
case "11"
months="November"
case else
months="December"
end select
theTime=days&" "&months&" "&years&" "&mytime&" "&"+0800"
FormatEnTime=theTime
End Function
%>