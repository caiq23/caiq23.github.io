<!-- #include file="conn-bbs.asp" -->

<!Doctype html>
<html>
<head>
<meta charset="gb2312">
<title>注册会员</title>
<!-- #include file="../inc/chk_session.asp" -->
</head>
<body>
<%
	msg_content=trim_fun_2(request("msg_content"))
	msg_num_1=session_user_id
	msg_num_2=chk_num(trim_fun(request("msg_num_2")))
	from_mobile=chk_num(trim_fun(request("from_mobile")))
	
	call dperror("",from_mobile,len(msg_content)=0 or isnull(msg_content),"内容不能为空",index_url&"n"& board_id &".html")
	call dperror("",from_mobile,msg_num_2<=0,"接收人出错，请重新登录后操作",index_url&"n"& board_id &".html")
	
	sql="select * from BBS_User where user_id="& msg_num_2 &""
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,1
	call dperror("",from_mobile,rs.eof,"接收人不存在，请重新登录后操作",index_url&"n"& board_id &".html")
	call dperror("",from_mobile,chk_num(rs("msg_open"))=0,"接收人已关闭站内消息功能",index_url&"n"& board_id &".html")
	
	
	'检查今天已发用户数
	sql="select count(id) from BBS_Msg where msg_num_1="& msg_num_1 &" and left(msg_time,10)='"& left(thistime,10) &"'"
	set rs=bbsconn.execute(sql)
	call dperror("",from_mobile,rs(0)>=bbsset_msg_times,"本站设置每天最多可发"& bbsset_msg_times &"条站内消息",index_url&"n"& board_id &".html")
	
	
	sql="select * from BBS_Msg where msg_num_1="& msg_num_1 &" and msg_num_2="& msg_num_2 &" and msg_content='"& msg_content &"'"
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror("",from_mobile,not rs.eof,"重复的内容",index_url&"n"& board_id &".html")
	rs.addnew
		rs("msg_num_1")=msg_num_1
		rs("msg_num_2")=msg_num_2
		rs("msg_content")=msg_content
		rs("msg_time")=thistime
					
	rs.update
	
	

	
	if from_mobile=1 then
		call dperror(BBS_folder&"wap/msg_page.asp?see_num="&msg_num_2,from_mobile,true,"发布成功","")
	else
		call dperror("",from_mobile,true,"发布成功",index_url&"p"& topic_id &".html")
	end if
	
	response.End()


%>

</body>
</html>