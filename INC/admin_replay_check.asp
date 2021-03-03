<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/check_admin_session.asp" -->
<!-- #include file="../inc/fun-admin.asp" -->
<!Doctype html>
<html>
<head>
<meta charset="gb2312">
<title><%=this_title%>帖子</title>
</head>
<body>
<%
		page_no=chk_num(trim_fun(request("page_no")))
		modid=chk_num(trim_fun(request("modid")))
		mydo=trim_fun(request("mydo"))
		call dperror_admin(len(modid)=0 or isnull(modid),"读取回复信息出错，请退出登录重新操作","")

  select case mydo
	  case "masking"
	  	'屏蔽帖子	  	
		sql="update BBS_Reply set topic_state=3 where id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("屏蔽成功")
	  case "unmasking"
	  	'解除屏蔽	  	
		sql="update BBS_Reply set topic_state=2 where id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("解除屏蔽成功")
	  case "checked"
	  	'审核帖子	  	
		sql="update BBS_Reply set topic_state=2 where id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("审核帖子成功")
		
	  case "del_replay"
	  	'删除回复	
		
	com_post_how=1
	sql="select * from BBS_Board where board_id=(select board_id from BBS_Topic where topic_id=(select topic_id from BBS_Reply where id="& modid &"))"
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	if not rs.eof then
		board_count=chk_num(rs("board_count"))-com_post_how
		if board_count<0 then board_count=0
		rs("board_count")=board_count
		rs.update
	end if
		
		call del_replay(modid)
		call dperror_referrer("删除回复成功")
  end select


%>

</body>
</html>