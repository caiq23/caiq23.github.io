<!--#include file="heck.asp"-->
<%
'*****************************************
'作者：guke
'QQ：6692103
'*****************************************
    if request("page")<>"" then
      if cint(request("page"))<1 then
         currentPage2=1
      else
         currentPage2=cint(request("page"))
      end if
   else        
      currentPage2=1        
   end if

FileName = "list.txt"         '模版文件路径
FilePath = Server.MapPath("../images")&"\"&FileName
set fso = server.CreateObject("scripting.filesystemobject")
if not fso.FileExists(FilePath) then
Response.Write"<br/><font color=red>错误提示：没有发现模版文件。</font>"
response.end
end if
set fout = fso.opentextfile(FilePath,1,true)
pencat = fout.readall
fout.close
  
'## 读取列表
set rs=server.CreateObject("ADODB.RecordSet")
sql="select * from [2012] order by data desc"
rs.open sql,conn,1,1
if rs.eof then
html=html&"<div class=""list_z"">暂时没有文章。</div>"
mpage2=1
else
html=html&"<div class=""list_z"">"
MaxPerPage2=15
rs.pagesize=MaxPerPage2
mpage2=rs.pagecount
rs.move  (currentPage2-1)*MaxPerPage2
allshu=rs.recordcount
h=0
do while not rs.eof
html=html&"<ul>"
html=html&"<li><a href=""2012/"&rs("id")&".html"" target=""_blank"" title="""&rs("title")&""">"&left(rs("title"),28)&"</a></li>"
html=html&"<li class=""o"">发表时间："&rs("data")&"</li>"
html=html&"</ul>"
h=h+1                              
if h>=MaxPerPage2 then exit do
rs.movenext
loop
html=html&"</div>"
end if

'## 读取TOP
top10=top10&"<h2>热门点击</h2>"
top10=top10&"<div class=""about"">"
top10=top10&"<ul>"
i=0
set rs=server.createobject("adodb.recordset")
sql="select * from [2012] order by hot desc"
rs.open sql,conn,1,1
do while not rs.eof
top10=top10&"<li><a href=""2012/"&rs("id")&".html"" target=""_blank"" title="""&rs("title")&""">"&left(rs("title"),23)&"</a></li>"
i=i+1
if i>=15 then exit do
rs.movenext
loop
top10=top10&"</ul></div>"
rs.close

'## 读取页次
if mpage2>1 then
pageno=currentPage2
html=html&"<div class=""page"">"
if cint(pageno)>1 then
if cint(pageno)=2 then
html=html&"<a href=""/"">上一页</a>"
else
html=html&"<a href=""index_"&currentPage2-1&".html"">上一页</a>"
if currentPage2>4 and mpage2>4 then
if currentPage2="5" then
html=html&"<a href=""index.html"">1</a>"
else
html=html&"<a href=""index.html"">1</a>..."
end if
end if
end if
end if
    for s=pageno-3 to pageno+3
    if s>0 then
    if s<mpage2+1 then
    if s=cint(currentPage2) then 
    html=html&"<strong>"&s&"</strong>"
    else
    if s=1 then
    html=html&"<a href=""index.html"">1</a>"
    else
    html=html&"<a href=""index_"&s&".html"">"&s&"</a>"
    end if
    end if
    end if
    end if
    next
if cint(pageno)< mpage2 then
if mpage2-currentPage2>3 and mpage2>4 then
if mpage2-currentPage2="4" then
html=html&"<a href=""index_"&mpage2&".html"">"&mpage2&"</a>"
else
html=html&"...<a href=""index_"&mpage2&".html"">"&mpage2&"</a>"
end if
end if
html=html&"<a href=""index_"&currentPage2+1&".html"">下一页</a>"
end if
html=html&"</div>"
end if
rs.close

if currentPage2="1" then 
index="index"
else 
index="index_"&currentPage2&""
end if

title="2012年12月21日世界末日。"                                                '首页标题
keywords="2012,2012年,2012世界末日"
description="玛雅人说2012年12月21日的黑夜降临以后，12月22日的黎明永远不会到来。"
'## 生成HTML
pencat=replace(pencat,"{$top10$}",top10)
pencat=replace(pencat,"{$title$}",title)
pencat=replace(pencat,"{$keywords$}",keywords)
pencat=replace(pencat,"{$description$}",description)
pencat=replace(pencat,"{$html$}",html)
pencat=replace(pencat,"{$top10$}",top10)
pencat=replace(pencat,"{$addtime$}","")
pencat=replace(pencat,"{$hot$}","")
pencat=replace(pencat,"{$about$}","")
pencat=replace(pencat,"{$date$}",year(now()))
Set fout = fso.CreateTextFile(server.mappath("../"&index&".html"))
fout.Write pencat
fout.close
set fso = nothing

if currentPage2<mpage2 then
response.write "<br>已生成分页:<font color=#FF0000>"&currentPage2&"</font>/<font color=#FF0000><b>"&mpage2&"</b></font>个"
response.write "<meta http-equiv=Refresh content='0; URL=list.asp?page="&cint(currentPage2+1)&"'>"
end if
if mpage2=currentPage2 then
response.write "操作完成"
end if
%>