<!-- #include file="inc/conn-bbs.asp" -->
<%
call dperror("",0,bbsset_html_open=2,"��վ��δ����α��̬����",BBS_folder)
url_file=myurl
url_file=replace(url_file,".html","")
call dperror("",0,len(url_file)=0 or isnull(url_file),"��ҳ������","")
server.Transfer("index.asp")
%>