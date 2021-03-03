<%@ LANGUAGE = VBScript CodePage = 936%>
<%
'Response.Buffer = True
'Response.ExpiresAbsolute = Now() - 1
'Response.Expires = 0
'Response.CacheControl = "no-cache"
'Response.AddHeader "Pragma", "No-Cache"

   	set bbsconn=server.createobject("adodb.connection")	
	Server.ScriptTimeout=1200
	
	
	
	
	
	
	
	
	
	
	
	
	'BBS_folder论坛程序安装目录，以/开头，以/结尾，根目录请填写/。如在bbs目录下面填写/bbs/
	BBS_folder="/"	
	
	'DB_folder数据库的地址，以/结尾，根目录请留空。请结合BBS_folder填写。
	DB_folder="mdb/"
	
	'DB_name数据库文件名称，建议以.asp结尾，名字中带有#号防止被下载，如：#mdb.asp
	DB_name="mdb.mdb"
	
	'备份数据库时，最大保存数量
	can_dbcounts=10
	
	'备份数据库的文件名称，请不要以.mdb为结尾，防止被他人下载
	DB_backupname="backup.asp"
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	
	DB_folder=BBS_folder&DB_folder
	DBPath = DB_folder&DB_name
	
	if chkFile(DBPath)="no" then
		alert_html="错误：连接数据库出错，请修改inc/conn-bbs.asp里的DB_folder为实际数据库所在目录。"
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
'检查是否开启了伪静态
index_url=BBS_folder
if bbsset_html_open=2 then index_url=index_url&"?"

%>
