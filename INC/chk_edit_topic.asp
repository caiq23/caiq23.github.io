<!-- #include file="conn-bbs.asp" -->
<!-- #include file="../inc/chk_session.asp" -->
<!Doctype html>
<html>
<head>
<meta charset="gb2312">
<title>注册会员</title>
</head>
<body>
    
<%
	topic_title=trim_fun(request("topic_title"))
	topic_id=chk_num(trim_fun(request("topic_id")))	
	replay_cansee=chk_num(trim_fun(request("replay_cansee")))
	topic_user_id=chk_num(trim_fun(request("topic_user_id")))	
	topic_Content=trim_fun_2(request("topic_Content"))
	user_id=chk_num(session_user_id)
	
	call dperror("",0,len(topic_title)=0 or isnull(topic_title),"标题不能为空",index_url&"z"& topic_id &".html")
	call dperror("",0,len(topic_Content)=0 or isnull(topic_Content),"请输入内容",index_url&"z"& topic_id &".html")
	if bbsset_post_mini1>0 then call dperror("",0,len(topic_title)<bbsset_post_mini1,"标题不能少于"& bbsset_post_mini1 &"个字",index_url&"n"& board_id &".html")
	if bbsset_post_mini2>0 then call dperror("",0,len(topic_Content)<bbsset_post_mini2,"内容不能少于"& bbsset_post_mini2 &"个字",index_url&"z"& topic_id &".html")
	call dperror("",0,user_id<>topic_user_id,"您没有修改权限",index_url&"z"& topic_id &".html")
	
	
	
	'读取会员状态
	call dperror("",0,user_state=2,"您无权限发贴，已被禁言",index_url&"p"& topic_id &".html")
	call dperror("",0,user_state=3,"您无权限发贴，已被锁定",index_url&"p"& topic_id &".html")
	
	topic_title=replace_filter(topic_title,bbsset_Filter_word)
	topic_Content=replace_filter(topic_Content,bbsset_Filter_word)
	sql="select * from BBS_Topic where topic_id="& topic_id &" and user_id="& user_id &""
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror("",0,rs.eof,"您没有修改权限",index_url&"p"& topic_id &".html")
		rs("topic_title")=topic_title
		rs("topic_Content")=topic_Content
		rs("lastedit_time")=thistime
		rs("replay_cansee")=replay_cansee
		if session_admin_id>0 then bbsset_topicpoststate=2
		rs("topic_state")=bbsset_topicpoststate	
	rs.update
	
	
	call dperror("",0,true,"修改成功",index_url&"p"& topic_id &".html")
	response.End()


%>

</body>
</html>