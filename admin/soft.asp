<!--#include file="heck.asp"-->
<%
'*****************************************
'作者：guke
'QQ：6692103
'*****************************************
   if request("soft")<>"" then
      if cint(request("soft"))<1 then
         currentPage=1
      else
         currentPage=cint(request("soft"))
      end if
   else        
      currentPage=1        
   end if   
response.write "开始生成网页"
set rs=server.CreateObject("ADODB.RecordSet")

'***生成HTML
     MaxPerPage=1
    rs.open ("select * from [2012] order by id desc"),conn,1,1
    if not rs.eof then
     rs.pagesize=MaxPerPage
     mpage=rs.pagecount
     rs.move  (currentPage-1)*MaxPerPage
     end if
    response.write "<br><br>已生成 / 要生成: <font color=#FF0000>"&currentPage-1&"</font>/<font color=#FF0000><b>"&mpage&"</b></font>个，"
    if mpage<currentPage then
      response.write "操作完成!"
    else
response.write "<meta http-equiv=Refresh content='0; URL=soft.asp?soft="&currentPage+1&"'>"
idd=rs("id")
rs.close
%>
<!--#include file="fso_html.asp"-->
<%
end if
%>