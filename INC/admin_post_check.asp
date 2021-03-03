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
		board_id=chk_num(trim_fun(request("board_id")))
		mydo=trim_fun(request("mydo"))
		call dperror_admin(len(modid)=0 or isnull(modid),"读取帖子信息出错，请退出登录重新操作","")

  select case mydo
	  case "set_top"
	  	board_top=chk_num(trim_fun(request("board_top")))
		board_top_html=""
		select case board_top
			case 0
				board_top_html="取消顶置"
			case 1
				board_top_html="顶置"
			case 2
				board_top_html="全站顶置"
		end select
	  	'顶置	  	
		sql="update BBS_Topic set board_top="& board_top &" where topic_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer(board_top_html&"成功")
		
	  case "move_to"
	  	'移动帖子	
		call dperror_admin(board_id<1,"读取版块出错","")
		sql="select * from BBS_Topic where topic_id="& modid &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then
			old_board_id=chk_num(rs("board_id"))
		end if
		call dperror_admin(old_board_id=board_id,"请选择需要移动到的版块","")
		call mod_board_count(modid,1)				
		sql="update BBS_Topic set board_id="& board_id &" where topic_id="& modid &""
		set rs=bbsconn.execute(sql)
		call mod_board_count(modid,2)
		call dperror_referrer("移动成功")
	  case "masking"
	  	'屏蔽帖子	  	
		sql="update BBS_Topic set topic_state=3 where topic_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("屏蔽成功")
	  case "unmasking"
	  	'解除屏蔽	  	
		sql="update BBS_Topic set topic_state=2 where topic_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("解除屏蔽成功")
	  case "checked"
	  	'审核帖子	  	
		sql="update BBS_Topic set topic_state=2 where topic_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("审核帖子成功")
		
	  case "del_topic"
	  	'删除主题	
		call mod_board_count(modid,1)
		call del_topic(modid)		
		call dperror_referrer("删除主题成功")
  end select




'给当前版块减掉帖子数量
sub mod_board_count(topic_id,do_what)
	'do_what为1表示减掉，2为增加
	com_post_how=1
	sql="select count(id) from BBS_Reply where topic_id="& topic_id &""
	set rs=bbsconn.execute(sql)
	if not rs.eof then com_post_how=com_post_how+chk_num(rs(0))
	sql="select * from BBS_Board where board_id=(select board_id from BBS_Topic where topic_id="& topic_id &")"
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	if not rs.eof then
		board_count=chk_num(rs("board_count"))
		if do_what=1 then
			board_count=board_count-com_post_how
		else
			board_count=board_count+com_post_how
		end if
		if board_count<0 then board_count=0
		rs("board_count")=board_count
		rs.update
	end if
end sub
%>

</body>
</html>