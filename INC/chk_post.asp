<!-- #include file="conn-bbs.asp" -->
<!-- #include file="../inc/chk_session.asp" -->
<!Doctype html>
<html>
<head>
<meta charset="gb2312">
<title>ע���Ա</title>
</head>
<body>
<%
	topic_title=trim_fun(request("topic_title"))
	upload_img_list=trim_fun_2(request("upload_img_list"))
	board_id=chk_num(trim_fun(request("board_id")))	
	replay_cansee=chk_num(trim_fun(request("replay_cansee")))	
	
	if_reply_cansee=chk_num(trim_fun(request("if_reply_cansee")))
	reply_cansee_Content=trim_fun_2(request("reply_cansee_Content"))
	
	
	user_id=chk_num(session_user_id)
	session("topic_Content")=request("topic_Content")
	topic_Content=trim_fun_2(session("topic_Content"))
	session("topic_title")=topic_title
	session("reply_cansee_Content")=reply_cansee_Content
	from_mobile=chk_num(trim_fun(request("from_mobile")))
	
	
	if if_reply_cansee=1 and len(reply_cansee_Content)>0 then topic_Content=topic_Content &"[hide]"& reply_cansee_Content &" [/hide]"
	
	call dperror("",from_mobile,len(topic_title)=0 or isnull(topic_title),"���ⲻ��Ϊ��",index_url&"n"& board_id &".html")
	if bbsset_post_mini1>0 then call dperror("",from_mobile,len(topic_title)<bbsset_post_mini1,"���ⲻ������"& bbsset_post_mini1 &"����",index_url&"n"& board_id &".html")
	call dperror("",from_mobile,board_id<=0,"��ѡ����",index_url&"n"& board_id &".html")
	call dperror("",from_mobile,len(topic_Content)=0 or isnull(topic_Content),"����������",index_url&"n"& board_id &".html")
	if bbsset_post_mini2>0 then call dperror("",from_mobile,len(topic_Content)<bbsset_post_mini2,"���ݲ�������"& bbsset_post_mini2 &"����",index_url&"n"& board_id &".html")
	call dperror("",from_mobile,user_id<=0,"���¼�����",index_url&"n"& board_id &".html")
	
	call chk_post_user_state(bbsset_post_times1,bbsset_post_times2,bbsset_post_times3user_state,user_id,session_admin_id,index_url&"n"& board_id &".html")

	topic_Content=topic_Content&upload_img_list
	
	sql="select * from BBS_Board where board_id="& board_id &""
	set rs=bbsconn.execute(sql)
	if not rs.eof then
		board_can_post=chk_num(rs("board_can_post"))
		select case board_can_post
			case 2
				call dperror("",from_mobile,user_state<4 and session_admin_id=0,"�������ҪVIP/��������/����Ա���ܷ���������Ȩ�޲���",index_url&"b"& board_id &".html")
			case 3
				call dperror("",from_mobile,user_state<5 and session_admin_id=0,"�������Ҫ��������/����Ա���ܷ���������Ȩ�޲���",index_url&"b"& board_id &".html")
			case 4
				call dperror("",from_mobile,session_admin_id=0,"�������Ҫ����Ա���ܷ���������Ȩ�޲���",index_url&"b"& board_id &".html")
			case 10
				call dperror("",from_mobile,true,"����鲻�ܷ���",index_url&"b"& board_id &".html")
		end select		
	end if
	
	
	
	for i=1 to 100
		'�������7λ��
		Randomize Timer 
		topic_id = Int(8999999 * Rnd + 1000000)
		sql="select id from BBS_Topic where topic_id="& topic_id &""
		set rs=bbsconn.execute(sql)
		if rs.eof then exit for
		call dperror("",from_mobile,i>=100,"ϵͳ��������ID�������Ժ�������",index_url&"n"& board_id &".html")
	next
	
	topic_title=replace_filter(topic_title,bbsset_Filter_word)
	topic_Content=replace_filter(topic_Content,bbsset_Filter_word)
	sql="select * from BBS_Topic where (topic_title='"& topic_title &"' or topic_Content='"& topic_Content &"') and board_id="& board_id &""
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror("",from_mobile,not rs.eof,"�ظ������������",index_url&"n"& board_id &".html")
	rs.addnew
		rs("topic_id")=topic_id
		rs("board_id")=board_id
		rs("user_id")=user_id
		rs("topic_title")=topic_title
		rs("topic_Content")=topic_Content
		rs("topic_addtime")=thistime
		rs("replay_cansee")=replay_cansee	
		rs("from_mobile")=from_mobile	
		if session_admin_id>0 then bbsset_topicpoststate=2
		rs("topic_state")=bbsset_topicpoststate
					
	rs.update
	
	

	
	'���Ӱ��������
	sql="update BBS_Board set board_count=board_count+1 where board_id="& board_id &""
	set rs=bbsconn.execute(sql)
	
	
	session("topic_Content")=""
	session("topic_title")=""
	session("reply_cansee_Content")=""
	
	
	if from_mobile=1 then
		call dperror(BBS_folder&"wap/page.asp?topic_id="&topic_id,from_mobile,true,"�����ɹ�","")
	else
		call dperror("",from_mobile,true,"�����ɹ�",index_url&"p"& topic_id &".html")
	end if
	
	response.End()


%>

</body>
</html>