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
	replay_id=chk_num(trim_fun(request("replay_id")))	
	replay_user_id=chk_num(trim_fun(request("replay_user_id")))	
	reply_content=trim_fun_2(request("reply_content"))
	user_id=chk_num(session_user_id)
	
	
	call dperror("",0,len(reply_content)=0 or isnull(reply_content),"����������",index_url&"h"& replay_id &".html")
	call dperror("",0,user_id<>replay_user_id,"��û���޸�Ȩ��",index_url&"h"& replay_id &".html")
	
	
	
	'��ȡ��Ա״̬
	call dperror("",0,user_state=2,"����Ȩ�޷������ѱ�����",index_url&"h"& replay_id &".html")
	call dperror("",0,user_state=3,"����Ȩ�޷������ѱ�����",index_url&"h"& replay_id &".html")
	
	reply_content=replace_filter(reply_content,bbsset_Filter_word)
	sql="select * from BBS_Reply where id="& replay_id &" and user_id="& user_id &""
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror("",0,rs.eof,"��û���޸�Ȩ��",index_url&"p"& topic_id &".html")
		topic_id=rs("topic_id")
		rs("reply_content")=reply_content
		rs("lastedit_time")=thistime
		if session_admin_id>0 then bbsset_topicpoststate=2
		rs("topic_state")=bbsset_topicpoststate
				
	rs.update
	
	
	call dperror("",0,true,"�޸ĳɹ�",index_url&"p"& topic_id &".html")
	response.End()


%>

</body>
</html>