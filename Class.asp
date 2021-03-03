<!--#include file="Inc/conn.asp"-->
<!--#include file="Inc/Cls_vbsPage.asp"-->
<%
sj=1
Dim ID : ID=LaoYRequest(request("id"))
If ID="" then Call Alert("不正确的ID","Index.asp")
Dim page : page=LaoYRequest(request("page"))
If page="" then page=1
Dim Durl:Durl=LCase(Request.ServerVariables("HTTP_X_REWRITE_URL"))
'If Durl<>"" then
'If ((html=1 or html=2) And Instr(Durl,"class.asp")=0) or (html=3 And Instr(Durl,"class.asp")>0) then
'Response.Status="301 Moved Permanently"
'Response.AddHeader "Location",cpath(ID,page)
'End if
'End If
set rsclass=server.createobject("adodb.recordset")
sql="select * from "&tbname&"_Class where id="&id
rsclass.open sql,conn,1,1
if rsclass.eof and rsclass.bof then
Call Alert("不正确的ID","Index.asp")
else
if rsclass("Link")=1 then
Response.Redirect ""&laoy(rsclass("Url"))&""
End if
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta name="keywords" content="<%=rsclass("keyword")%>" />
<meta name="description" content="<%=rsclass("ReadMe")%>" />
<meta name="applicable-device" content="pc,mobile">
<meta name="MobileOptimized" content="width"/>
<meta name="HandheldFriendly" content="true"/>
<link href="<%=SitePath%>images/css<%=Css%>.css" type=text/css rel=stylesheet>
<script type="text/javascript" src="<%=SitePath%>js/main.asp"></script><%If rss=1 then%>
<link rel="alternate" title="订阅<%=rsclass("ClassName")%>(RSS 2.0)" href="http://<%=SiteUrl%><%=SitePath%>Rss/Rss<%=ID%>.xml" type="application/rss+xml" /><%end if%>
<title><%=LoseHtml(rsclass("ClassName"))%><%=IIF(rsclass("ClassName2")<>"","-"&rsclass("ClassName2")&"-","-")%><%=SiteTitle%></title>
</head>
<body>
<div class="mwall"><%If laoyvip then
Echo "<script type=""text/javascript"">uaredirect(""http://"&SiteUrl&SitePath&"3g"&cpath(id,page)&""");</script>"
End If%>
<%=Head%>
<%=Menu%><div class="mw">
	<div class="dh">
		<%=search%>您现在的位置：<a href="<%=sitepath%>">首页</a> >> <%If rsclass("TopID")>0 then%><a href="<%=cpath(rsclass("TopID"),0)%>"><%=getclass(rsclass("TopID"),"classname")%></a> >> <%End if%><a href="<%=cpath(ID,0)%>"><%=rsclass("ClassName")%></a> >> 列表
    </div>
	<div id="nw_left">
<%If Mydb("Select Count([ID]) From ["&tbname&"_Class] Where TopID="&ID&"",1)(0)>0 then%>
		<div id="web2l" style="border:0;"><%
		    Sqlpp ="select [ID],[ClassName] from "&tbname&"_Class Where TopID="&ID&" order by num"   
   			Set Rspp=server.CreateObject("adodb.recordset")   
   			rspp.open sqlpp,conn,1,1
			NoI=0
			Do while not Rspp.Eof
			NoI=NoI+1
%>
			<div id="sclass" class="borderall"<%If isEven(NoI)=0 then Response.Write(" style=""margin-left:8px;""") End if%>>
				<h6><span><a href="<%=cpath(rspp("ID"),0)%>">more...</a></span><a href="<%=cpath(rspp("ID"),0)%>"><%=rspp("ClassName")%></a><%If rss=1 then%><a href="http://<%=SiteUrl%><%=SitePath%>Rss/Rss<%=rspp("ID")%>.xml" target="_blank"><img src="images/rss.gif" alt="订阅<%=LoseHtml(rspp("ClassName"))%>(RSS 2.0)" style="margin:0 0 0 30px;"/></a><%End if%></h6>
				<ul>
					<%Call ShowArticle(rspp("id"),10,5,"·",100,"no","DateAndTime desc,ID desc",0,0,0)%>
				</ul>
			</div><%If isEven(NoI)=0 then Response.Write("<div id=""clear""></div>") End if
			Rspp.Movenext   
      		Loop
   			rspp.close
   			set rspp=nothing
%> 
		</div>
<%else%>
		<div id="web2l">
        	<h6><%=rsclass("ClassName")%></h6>
			<div id="content">
            	<ul id="listul">
<%
Dim ors
Set ors=new Cls_vbsPage	'创建对象
Set ors.Conn=conn		'得到数据库连接对象
With ors
If artlistnum=0 then artlistnum=10
	.PageSize=artlistnum		'每页记录条数
	.RecType=-1
	'记录总数(>0为另外取值再赋予或者固定值,0执行count设置存cookies,-1执行count不设置cookies)
	.JsUrl=""			'Cls_jsPage.js的路径
	.Pkey="ID"			'主键
	.Field="ID,Title,DateAndTime,Hits,IsTop,Images,TitleFontColor,Artdescription"
	.Table=tbname&"_Article"
	.Condition="yn=0 and classid="&id&""		'条件,不需要where
	.OrderBy="IsTop Desc,DateAndTime Desc,ID Desc"	'排序,不需要order by,需要asc或者desc
End With

RecCount=ors.RecCount()'记录总数
Rs=ors.ResultSet()		'返回ResultSet
NoI=0
If  RecCount<1 Then
Echo "<li>没有记录</li>"
Else 
iPageCount=Abs(Int(-Abs(RecCount/artlistnum)))
For i=0 To Ubound(Rs,2)
NoI=NoI+1
%>
				<li><%if rs(5,i)<>"" and artlist=0 then%><div style="float:left;margin:5px 5px 0 5px;"><a href="<%=apath(rs(0,i),0)%>" target="_blank"><img src="<%=rs(5,i)%>" style="width:90px;height:90px;" alt="<%=rs(1,i)%>"/></a></div><%end if%><%If rs(4,i)=1 then Response.Write("<font color=red>[顶]</font>") end if%><a href="<%=apath(rs(0,i),0)%>" target="_blank"><%if rs(6,i)<>"" then Response.Write("<font style=""color:"&rs(6,i)&""">"&rs(1,i)&"</font>") else Response.Write(""&rs(1,i)&"") end if%></a>
				<span style="color:#AAA;font-size:12px;"><%=FormatDate(rs(2,i),11,1)%> 点击：<%=rs(3,i)%> 评论:<%=Mydb("Select Count([ID]) From ["&tbname&"_Pl] Where yn=1 And ArticleID="&rs(0,i)&"",1)(0)%></span></li><%If artlist=0 then%>
                <div class="box"<%if rs(5,i)<>"" then Response.Write(" style=""height:65px;""") end if%>><%=left(LoseHtml(rs(7,i)),90)%>...</div><%End if%>
                <hr style="height:1px;border:0;border-bottom:1px dashed #ccc;">
<%
Next	
End If
Dim apage,bpage,ppage,npage,tapage,tbpage
apage=page-2
bpage=page+2
ppage=page-1
npage=page+1
tapage=page-10
tbpage=page+10
If apage<1 then apage=1
If bpage>iPageCount then bpage=iPageCount
If tapage<1 then tapage=1
If tbpage>iPageCount then tbpage=iPageCount
%>
				</ul>
			</div>
<div id="clear"></div>
<div id="page">
	<ul>
<li><a href="<%=cpath(ID,0)%>">首　页</a></li>
<li><%if ppage<1 then%><span>上一页</span><%else%><a href="<%=cpath(ID,ppage)%>">上一页</a></li><%end if%><%for i= apage to bpage%>
<li><%if i=int(page) then%><span><%=i%></span><%else%><a href="<%=cpath(ID,i)%>"><%=i%></a><%end if%></li><%next%>
<li><%if npage>iPageCount then%><span>下一页</span><%else%><a href="<%=cpath(ID,npage)%>">下一页</a><%end if%></li>
<li><a href="<%=cpath(ID,iPageCount)%>">末　页</a></li>
<li><span><select name='select' onChange='javascript:window.location.href=(this.options[this.selectedIndex].value);'><%for i = tapage to tbpage%>
<option value="<%=cpath(ID,i)%>"<%if i=int(page) then Echo " selected=""selected""" end if%>><%=i%></option><%next%>
</select></span></li>
<li><span><input type="text" onClick="this.value='';" onKeyDown="var intstr=/^\d+$/;if(intstr.test(this.value)&&this.value<=<%=iPageCount%>&&this.value>=1&&event.keyCode==13){if(this.value==1){location.href='<%=cpath(ID,0)%>';}else{location.href='<%=sitepath&IIf(html=3,"class_"&ID&"_' + this.value + '.html","class.asp?id="&ID&"&page=' + this.value + '")%>';}}" value="GO" size="3" maxlength="5"" /></span></li>
<li><span>共<font color="#009900"><b><%=RecCount%></b></font>条记录 <%=artlistnum%>条/每页</span></li>
    </ul>
</div>
        </div>
<%
end if
%>
	</div>
	<div id="nw_right">
		<%Echo ShowAD(3)%>
        <div id="web2r">
			<h5>本类热门</h5>
			<ul id="list10">
            	<%Call ShowArticle(ID,10,5,"",100,"no","Hits desc,ID desc",0,0,1)%>
            </ul>
  		</div>
        <div id="web2r">
			<h5>图片推荐</h5>
			<ul class="topimg">
                <%Call ShowImgArticle(ID,4,100,"no","DateAndTime desc,ID desc",60,60,1)%>
            </ul>
  		</div>
	</div>
</div>
<%
rsclass.close
set rsclass=nothing
end if%>
<%=Copy%></div>
</body>
</html>