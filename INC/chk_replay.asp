<!-- #include file="conn-bbs.asp" -->
<!-- #include file="../inc/chk_session.asp" -->
<!Doctype html>
<html>
<head>
<meta charset="gb2312">
<title>�ظ�</title>
</head>
<body>
<%
	topic_id=chk_num(trim_fun(request("topic_id")))	
	topic_Content=trim_fun_2(request("topic_Content"))
	user_id=chk_num(session_user_id)
	from_mobile=chk_num(trim_fun(request("from_mobile")))
	
	call dperror("",from_mobile,topic_id<=0,"��ѡ��ظ�������",index_url&"p"& topic_id &".html")
	call dperror("",from_mobile,len(topic_Content)=0 or isnull(topic_Content),"����������",index_url&"p"& topic_id &".html")
	if bbsset_post_mini2>0 then call dperror("",from_mobile,len(topic_Content)<bbsset_post_mini2,"���ݲ�������"& bbsset_post_mini2 &"����",index_url&"p"& topic_id &".html")
	call dperror("",from_mobile,user_id<=0,"���¼�����",index_url&"p"& topic_id &".html")
	
	call chk_post_user_state(bbsset_post_times1,bbsset_post_times2,bbsset_post_times3user_state,user_id,session_admin_id,index_url&"p"& topic_id &".html")
	
	'��ȡ����ID
	board_id=0
	sql="select * from BBS_Topic where topic_id="& topic_id &""
	set rs=bbsconn.execute(sql)
	this_user_id=0
	if not rs.eof then
		board_id=chk_num(rs("board_id"))
		this_user_id=chk_num(rs("user_id"))
	end if
	
	sql="select * from BBS_Board where board_id="& board_id &""
	set rs=bbsconn.execute(sql)
	if not rs.eof then
		board_can_post=chk_num(rs("board_can_post"))
		call dperror("",from_mobile,board_can_post=10,"����鲻�ܷ���",index_url&"b"& board_id &".html")
	end if	
	
	
	
	sql="select * from BBS_Reply where reply_content='"& topic_Content &"' and topic_id="& topic_id &""
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror("",from_mobile,not rs.eof,"�ظ�������",index_url&"p"& topic_id &".html")
	rs.addnew
		rs("topic_id")=topic_id
		rs("reply_content")=topic_Content
		rs("user_id")=user_id
		rs("reply_time")=thistime
		if session_admin_id>0 then bbsset_topicpoststate=2
		rs("topic_state")=bbsset_topicpoststate			
	rs.update
	
	
	'����Ӧ�������ӻظ���
	sql="update BBS_Topic set replay_count=replay_count+1,lastreply_time='"& thistime &"' where topic_id="& topic_id &""
	set rs=bbsconn.execute(sql)
	
	'���Ӱ��������
	sql="update BBS_Board set board_count=board_count+1 where board_id="& board_id &""
	set rs=bbsconn.execute(sql)
	
	'��������������
	if user_id<>this_user_id then
		sql="insert into BBS_Alert(alert_num1,alert_num2,alert_about_id,alert_state,alert_time) values("& user_id &","& this_user_id &","& topic_id &",1,'"& thistime &"')"
		set rs=bbsconn.execute(sql)
	end if
	
	
	if from_mobile=1 then
		call dperror(BBS_folder&"wap/page.asp?topic_id="&topic_id,from_mobile,true,"�����ɹ�","")
	else
		call dperror("",from_mobile,true,"�ظ��ɹ�",index_url&"p"& topic_id &".html")
	end if
	
	response.End()


%>

</body>
</html>