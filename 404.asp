<!-- #include file="inc/conn-bbs.asp" -->
<%
call dperror("",0,bbsset_html_open=2,"本站暂未开启伪静态功能",BBS_folder)
url_file=myurl
url_file=replace(url_file,".html","")
call dperror("",0,len(url_file)=0 or isnull(url_file),"该页无内容","")
server.Transfer("index.asp")
%>