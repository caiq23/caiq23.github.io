<%@ LANGUAGE = VBScript CodePage = 936%>
<%
'Response.Buffer = True
'Response.ExpiresAbsolute = Now() - 1
'Response.Expires = 0
'Response.CacheControl = "no-cache"
'Response.AddHeader "Pragma", "No-Cache"

   	set bbsconn=server.createobject("adodb.connection")	
	Server.ScriptTimeout=1200
	
	
	
	
	
	
	
	
	
	
	
	
	'BBS_folder��̳����װĿ¼����/��ͷ����/��β����Ŀ¼����д/������bbsĿ¼������д/bbs/
	BBS_folder="/"	
	
	'DB_folder���ݿ�ĵ�ַ����/��β����Ŀ¼�����ա�����BBS_folder��д��
	DB_folder="mdb/"
	
	'DB_name���ݿ��ļ����ƣ�������.asp��β�������д���#�ŷ�ֹ�����أ��磺#mdb.asp
	DB_name="mdb.mdb"
	
	'�������ݿ�ʱ����󱣴�����
	can_dbcounts=10
	
	'�������ݿ���ļ����ƣ��벻Ҫ��.mdbΪ��β����ֹ����������
	DB_backupname="backup.asp"
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	
	DB_folder=BBS_folder&DB_folder
	DBPath = DB_folder&DB_name
	
	if chkFile(DBPath)="no" then
		alert_html="�����������ݿ�������޸�inc/conn-bbs.asp���DB_folderΪʵ�����ݿ�����Ŀ¼��"
		%><script>
        alert('<%=alert_html%>');
        </script><%
		response.Write(alert_html)
		response.End()
	end if
	DBPath = Server.MapPath(DBPath)

	bbsconn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & DBPath &";" 
	'bbsconn.CursorLocation = adUseClient
	
	
thistime=formattime(now)	

	session_user_id=chk_num(Request.Cookies("xq_bbs")("user_id"))
	session_admin_id=chk_num(Request.Cookies("xq_bbs")("admin_id"))
	user_state=chk_num(Request.Cookies("xq_bbs")("user_state"))
	


myurl=Request.ServerVariables("QUERY_STRING")

if instr(myurl,".html")>0 then
	t_arr=split(myurl,".html")
	t_arr_1=t_arr(0)
	if t_arr_1&".html"<>myurl then
		response.Redirect("?"&t_arr_1&".html")
		response.End()
	else
		myurl=t_arr_1
	end if
end if

myurl=replace(myurl,"404;http://"&Request.ServerVariables("SERVER_NAME")&":80","")
myurl=replace(myurl,BBS_folder,"")
re_myurl=myurl

%>

<!-- #include file="fun-bbs.asp" -->
<!-- #include file="config-bbs.asp" -->
<%
'����Ƿ�����α��̬
index_url=BBS_folder
if bbsset_html_open=2 then index_url=index_url&"?"

%>
