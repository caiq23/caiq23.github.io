<!--#include file="Inc/conn.asp"-->
<!--#include file="Inc/ubb.asp"-->
<!--#include file="Inc/fenye.asp"-->
<%
sj=1
Dim ID,page,Durl
ID=LaoYRequest(request("id"))
page=LaoYRequest(Request("Page"))
Durl=LCase(Request.ServerVariables("HTTP_X_REWRITE_URL"))
'If Durl<>"" then
'If html=2 or (html=1 And Instr(Durl,"list.asp")=0) or (html=3 And Instr(Durl,"list.asp")>0) then
'Response.Status="301 Moved Permanently"
'Response.AddHeader "Location",apath(ID,page)
'End if
'End If
set rs=server.createobject("adodb.recordset")
sql="select * from "&tbname&"_Article where id="&id
rs.open sql,conn,1,1
if rs.eof and rs.bof then
Call Alert("不正确的ID!",SitePath)
else

If rs("Linkurl")<>"" then
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>转向：<%=rs("title")%></title>
<style>
#ndiv{ 
	width:450px;
	padding:8px;
	margin-top:8px;
	background-color:#FCFFF0;
	border:3px solid #B4EF94;
	height:100px;
	text-align:left;
	font-size:14px;
	line-height:180%;
}
</style>
<meta http-equiv="refresh" content="1;URL=<%=rs("LinkUrl")%>">
</head>
<body>
<div align='center'>
<div id='ndiv'>
正在转向：<a href='<%=rs("LinkUrl")%>'><%=rs("LinkUrl")%></a>，请稍候...
</div>
</div>
</body>
</html>
<%
Response.End
Else

set rsClass=server.createobject("adodb.recordset")
sql = "select * from "&tbname&"_Class where ID="&rs("ClassID")&""
rsClass.open sql,conn,1,1  
if rsClass.eof and rsClass.bof then
  Call Alert("没有此分类,返回首页!","index.asp")
else
  ClassName=rsClass("ClassName")
  CReadPower=rsClass("ReadPower")
  TopID=rsClass("TopID")
rsClass.close
set rsClass=nothing
end if

If rs("PageNum")=0 then
	Content=ManualPagination1(rs("ID"),UBBCode(rs("Content")))
else
	Content=AutoPagination1(rs("ID"),UBBCode(rs("Content")),rs("PageNum"))
End if
Content=Replace(Content,"<img","<img title="""&rs("title")&""" alt="""&rs("title")&"""")
Content=UBB_mp4(Content)
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta name="keywords" content="<%=Replace(rs("KeyWord"),"|",",")%>" />
<meta name="description" content="<%=left(LoseHtml(rs("Content")),120)%>" />
<meta name="applicable-device" content="pc,mobile">
<meta name="MobileOptimized" content="width"/>
<meta name="HandheldFriendly" content="true"/>
<meta http-equiv="Cache-Control" content="no-transform" /> 
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link href="<%=SitePath%>images/css<%=Css%>.css" type=text/css rel=stylesheet>
<script type="text/javascript" src="<%=SitePath%>js/main.asp"></script>
<title><%=LoseHtml(rs("Title"))%><%=IIF(page>0,"("&page&")","")%>-<%=LoseHtml(ClassName)%>--<%=sitetitle%>-Powered by www.laoy.net</title>
</head>
<body<%If ""&IsPing&""=1 then%> onLoad="showre(<%=ID%>,1)"<%end if%>><%If laoyvip then
Echo "<script type=""text/javascript"">uaredirect(""http://"&SiteUrl&SitePath&"3g"&apath(id,page)&""");</script>"
End If%>
<div class="mwall">
<%=Head%>
<%=Menu%><div class="mw">
	<div class="dh">
		<%=search%>您现在的位置：<a href="<%=SitePath%>">首页</a> >> <%If TopID>0 then Response.Write("<a href="""&cpath(TopID,0)&""">"&getclass(TopID,"classname")&"</a> >> ") End if%><a href="<%=cpath(rs("ClassID"),0)%>"><%=getclass(rs("ClassID"),"classname")%></a> >> 内容
    </div>
	<div id="nw_left">
		<div id="web2l">
			<h1><%=rs("Title")%><%=IIF(page>0,"("&page&")","")%></h1>
			<h3>时间：<%=rs("DateAndTime")%><%If IsHits=1 then%> 点击：<span id="count"><img src="<%=SitePath%>images/loading2.gif" /></span><%End if%></h3>
			<div id="content">
            	<%If Iszhaiyao=1 and b<2 then%><div class="zhaiyao"><b>　　核心提示：</b><%=left(rs("Artdescription"),150)%>...</div><%End if%>
				<%Echo ShowAD(1)%>
				<%
				if rs("yn")=1 then 
					if rs("UserID") = Int(LaoYID) then
					Echo Content
					Else
					Echo "<div style=""margin:40px auto;text-align:center;color:#ff0000;"">该文章还没有通过审核</div>"
					end if
				end if
				
				if rs("yn")= 0 then 
						If Rs("ReadPower") = "0" then
							Echo Content
						Else
							If Rs("ReadPower") <> "" then
								If Instr(","& Rs("ReadPower") &",",","& UserInfo(LaoYID,0) &",") > 0 Then
									Echo Content
								Else
									Response.Write("<div style=""font-size:12px;color:#ff0000;text-align:center;padding:20px;"">对不起,你没有浏览权限,该文章只有<font color=blue>"&ShowlevelOption2(Rs("ReadPower"))&"</font>才能浏览</div>")
								End if
							Else
								If CReadPower = "0" or CReadPower = "" then
									Echo Content
								Else
									If Not(Instr(","& CReadPower &",",",0,") <> 0 Or CReadPower = "0") Then
										If Instr(","& CReadPower &",",","& UserInfo(LaoYID,0) &",") > 0 Then
											Echo Content
										Else
											Response.Write("<div style=""font-size:12px;color:#ff0000;text-align:center;padding:20px;"">对不起,你没有浏览权限,该文章只有<font color=blue>"&ShowlevelOption2(CReadPower)&"</font>才能浏览</div>")
										End if
									Else
										Echo Content
									End if								
								End if
							End if						
						End if
				end if
				%>
			</div>
				<%
				If rs("KeyWord")<>"" then
					If rs("KeyWord")=rs("Title") then
					Else
					Response.Write "<div class=""tags"">Tags:"
					aa = Split(ucase(rs("KeyWord")), "|")
					For i=0 to Ubound(aa)
					Response.Write "<a href="""&SitePath&"Search.asp?KeyWord="&Server.UrlEncode(aa(i))&""">"& aa(i) &"</a>"&  "&nbsp;"
					Next
					Response.Write "</div>"
					End if
				End if
		 		%>
            <div id="copy"><%If IsAuthor =1 then%>作者：<%=rs("author")%><%End if:If rs("UserID")>0 then Response.Write("　录入：<a href="""&SitePath&"User/ShowUser.asp?ID="&rs("UserID")&""" title=""点击查看资料""><u>"&UserInfo(rs("UserID"),2)&"</u></a>") end if%>　<%If IsFrom =1 then%>来源：<%=rs("CopyFrom")%><%End if%></div>
            <%If rs("Vote")<>"" then Response.Write(""&ShowVoteList2(rs("Vote"))&"") End if%>
            <%If Iswz=1 then%><script type="text/javascript" src="<%=SitePath%>js/wz.js"></script><%End if%>
			<%Echo ShowAD(2)%>
            <%If mood=1 then%><div style="margin:0 auto;width:530px;">
            <script language="javascript">
			var infoid = '<%=ID%>';
			</script>
			<script language = "JavaScript" src ="<%=SitePath%>js/mood.asp?ID=<%=ID%>"></script>
            </div><%End if%>
            <div class="sxart">
			<%=thehead%><%=thenext%>
            </div>
		</div>
		<div id="web2l">
			<h6>相关文章</h6>
			<div id="marticle">
				<ul>
					<%=ShowMutualityArticle(ID,""&rs("KeyWord")&"",20,"·",0)%>
				</ul>
			</div>
            <div id="clear"></div>
		</div><%If IsPing=1 then%>
		<div id="web2l">
			<h6>相关评论</h6>
			<div id="list"><img src="<%=sitepath%>images/loading.gif" /></div>
			<div id="MultiPage"></div>
			<div id="clear"></div>
			<h6>发表我的评论</h6>
			<div style="height:205px;">
			<div class="pingp">
			<%
			If PingNum=0 then
				Echo ShowAD(5)
			else
            for i = 1 to PingNum%>
                <img src="<%=SitePath%>images/faces/<%=i%>.gif" onclick='insertTags("[laoy:","]","<%=i%>")'/>
            <%
			Next
			End if
			%>
  			</div>			<div class="artpl">
				<ul>
					<li>大名：<input name="memAuthor" type="text" class="borderall" id="memAuthor" value="<%=IIf(IsUser=1,UserName,iparray(GetIP))%>" Readonly maxlength="8"/></li>
					<li>内容：<textarea name="memContent" cols="30" rows="8" style="width:250px;height:120px;" wrap="virtual" id="memContent" class="borderall"/></textarea></li>
					<li><input name="ArticleID" type="hidden" id="ArticleID" value="<%=ID%>" />
      <input name="button3" type="button"  class="borderall" id = "sendGuest" onClick="AddNew()" value="发 表" /></li>
	  			</ul>
	  		</div>
		</div></div><%end if%>
	</div>
	<div id="nw_right">
		<%Echo ShowAD(3)%>
		<div id="web2r">
			<h5>本类热门</h5>
			<ul id="list10">
            	<%Call ShowArticle(rs("ClassID"),10,5,"·",100,"no","Hits desc,ID desc",0,0,0)%>
            </ul>
  		</div>
		<div id="web2r">
			<h5>本类推荐</h5>
			<ul id="list10">
            	<%Call ShowArticle(rs("ClassID"),10,5,"·",100,"IsHot=1","ID desc",0,0,0)%>
            </ul>
  		</div>
        <div id="web2r">
			<h5>本类固顶</h5>
			<ul id="list10">
            	<%Call ShowArticle(rs("ClassID"),10,5,"·",100,"IsTop=1","ID desc",0,0,0)%>
            </ul>
  		</div>
	</div>
</div>
<script type="text/javascript" src="<%=SitePath%>Ajaxpl.asp"></script>
<%End if%>
<%
rs.close
set rs=nothing
end if
	
function thehead 
headrs=server.CreateObject("adodb.recordset") 
sql="select top 1 ID,Title from "&tbname&"_Article where id<"&id&" and ClassID="&rs("ClassID")&" and yn = 0 order by id desc" 
set headrs=conn.execute(sql) 
if headrs.eof then 
response.Write("<li>上一篇：没有了</li>") 
else 
a0=headrs("id") 
a1=headrs("Title")
response.Write("<li>上一篇：<a href='"&apath(a0,0)&"'>"&a1&"</a></li>") 
end if 
headrs.close
set headrs=nothing
end function

function thenext 
newrs=server.CreateObject("adodb.recordset") 
sql="select top 1 ID,Title from "&tbname&"_Article where id>"&id&" and ClassID="&rs("ClassID")&" and yn = 0 order by id asc" 
set newrs=conn.execute(sql) 
if newrs.eof then 
response.Write("<li>下一篇：没有了</li>")
else 
a0=newrs("id") 
a1=newrs("Title")
response.Write("<li>下一篇：<a href='"&apath(a0,0)&"'>"&a1&"</a></li>") 
end if
newrs.close
set newrs=nothing
end function
If IsHits=1 then
%>
<div style="display:none;" id="_count">
<script type="text/javascript" src="<%=SitePath%>js/count.asp?id=<%=ID%>"></script>
</div>
<script>$('count').innerHTML=$('_count').innerHTML;</script>
<%End if%><%=Copy%></div>
</body>
</html>