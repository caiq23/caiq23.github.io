<!--#include file=heck.asp-->
<%
'*****************************************
'作者：guke
'QQ：6692103
'*****************************************
If Request("del") = "del" Then
Set rs = Conn.Execute("Delete From [2012] Where ID ="&Request("id"))
Response.Write "<script>alert('操作成功');this.location.href='t_kan.asp';</SCRIPT>"
rs.close
FiLePaTh = server.mappath("../2012/"&Request("id")&".html")
Set fso = CreateObject("Scripting.FileSystemObject")
fso.DeleteFile(filepath)
Set fso = nothing
End if
%>
<html>
<head>
<meta http-equiv=Content-Type content=text/html; charset=gb2312 />
<title>管理首页</title>
<link href=../images/css.css rel=stylesheet type=text/css />
</head>
<BODY leftmargin=0 topmargin=0 marginheight=0 marginwidth=0>
<script type="text/JavaScript">
function delpay()
{
   if(confirm("确定删除？"))
     return true;
   else
     return false;	 
}
</script>
<table cellpadding=0 cellspacing=0><tr><td><td height=15></td></tr></table>
<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
<tr>
<td>
<table width=95% border=0 cellpadding=0 cellspacing=1 align=center bgcolor=#cccccc>
                  <tr bgcolor=#ffffff>
                    <td width=8% align=center height=30>编 号</td>
                    <td align=center>标 题</td>
                    <td width=8% align=center>点 击</td>
                    <td width=10% align=center>发布日期</td>
                    <td width=10% align=center>操 作</td>
                  </tr>
<% 
set rs=server.createobject("adodb.recordset")  
sql ="select * from [2012] order by data Desc"
rs.open sql,conn,1,1
const maxperpage=15 '每一页显示                                  
dim currentpage                                  
rs.pagesize=maxperpage                                   
currentpage=request.querystring("pageid")                                   
if currentpage="" then                                   
currentpage=1                                   
elseif currentpage<1 then                                   
currentpage=1                                   
else                                   
currentpage=clng(currentpage)                                   
	if currentpage > rs.pagecount then                                   
	currentpage=rs.pagecount                                   
	end if                                   
end if                                                                    
if not isnumeric(currentpage) then                                   
currentpage=1                                   
end if                                   
dim totalput,n                                  
totalput=rs.recordcount                                   
if totalput mod maxperpage=0 then                                   
n=totalput\maxperpage                                   
else                                   
n=totalput\maxperpage+1                                   
end if                                   
if n=0 then                                   
n=1                                   
end if                                   
rs.move(currentpage-1)*maxperpage                                   
i=0                                   
do while i< maxperpage and not rs.eof
%>
                 <tr bgcolor=#ffffff> 
                    <td align=center height=30><%=rs("id")%></td>
 <td width=45%>&nbsp;<a href="../2012/<%=rs("id")%>.html" target="_blank"><%=rs("title")%></a></td>
                    <td align=center><%=rs("hot")%></td>
                    <td align=center><%=FormatDateTime(rs("data"),2)%></td>
                    <td align=center>
<TABLE cellpadding=0 cellspacing=0 border=0 align=center>
<tr><td><a href=e_kan.asp?id=<%=rs("id")%>>修改</a> | <a href="?del=del&id=<%=rs("id")%>" onClick="return delpay();">删除</a></td></tr></table>
</td>
</tr>
<%                                  
i=i+1                                  
rs.movenext                                  
loop                                  
%>
</table>
<table width=100% border=0 cellspacing=0 cellpadding=0>
<tr><td height=15></td></tr>
<tr>                            
<td align=center>页数：<%=currentpage%>/<% =n%>                            
<%k=currentpage                                                                              
 if k<>1 then%>                        
[<a href=t_kan.asp?pageid=1>首 页</a>]&nbsp;&nbsp;[<a href=t_kan.asp?pageid=<%=k-1%>>上一页</a>]<%else%>          &nbsp;&nbsp;[首 页]&nbsp;&nbsp;[上一页]&nbsp;                                                                           
<%end if%>
<%if k<>n then%>                                                                              
[<a href=t_kan.asp?pageid=<%=k+1%>>下一页</a>]&nbsp;&nbsp;[<a href=t_kan.asp?pageid=<%=n%>>尾 页</a>]<%else%>            [下一页]&nbsp;&nbsp;[尾 页]                                                                              
<%end if%> 
共有 <font color=red><%=totalput%></font> 条记录
</td></tr>       
</table>
<TABLE width=90% cellpadding=0 cellspacing=0 border=0 align=center>
<tr><td height=25></td></tr></table>
</body>
</html>