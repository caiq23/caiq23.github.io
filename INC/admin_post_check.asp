<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/check_admin_session.asp" -->
<!-- #include file="../inc/fun-admin.asp" -->
<!Doctype html>
<html>
<head>
<meta charset="gb2312">
<title><%=this_title%>����</title>
</head>
<body>
<%
		page_no=chk_num(trim_fun(request("page_no")))
		modid=chk_num(trim_fun(request("modid")))
		board_id=chk_num(trim_fun(request("board_id")))
		mydo=trim_fun(request("mydo"))
		call dperror_admin(len(modid)=0 or isnull(modid),"��ȡ������Ϣ�������˳���¼���²���","")

  select case mydo
	  case "set_top"
	  	board_top=chk_num(trim_fun(request("board_top")))
		board_top_html=""
		select case board_top
			case 0
				board_top_html="ȡ������"
			case 1
				board_top_html="����"
			case 2
				board_top_html="ȫվ����"
		end select
	  	'����	  	
		sql="update BBS_Topic set board_top="& board_top &" where topic_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer(board_top_html&"�ɹ�")
		
	  case "move_to"
	  	'�ƶ�����	
		call dperror_admin(board_id<1,"��ȡ������","")
		sql="select * from BBS_Topic where topic_id="& modid &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then
			old_board_id=chk_num(rs("board_id"))
		end if
		call dperror_admin(old_board_id=board_id,"��ѡ����Ҫ�ƶ����İ��","")
		call mod_board_count(modid,1)				
		sql="update BBS_Topic set board_id="& board_id &" where topic_id="& modid &""
		set rs=bbsconn.execute(sql)
		call mod_board_count(modid,2)
		call dperror_referrer("�ƶ��ɹ�")
	  case "masking"
	  	'��������	  	
		sql="update BBS_Topic set topic_state=3 where topic_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("���γɹ�")
	  case "unmasking"
	  	'�������	  	
		sql="update BBS_Topic set topic_state=2 where topic_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("������γɹ�")
	  case "checked"
	  	'�������	  	
		sql="update BBS_Topic set topic_state=2 where topic_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_referrer("������ӳɹ�")
		
	  case "del_topic"
	  	'ɾ������	
		call mod_board_count(modid,1)
		call del_topic(modid)		
		call dperror_referrer("ɾ������ɹ�")
  end select




'����ǰ��������������
sub mod_board_count(topic_id,do_what)
	'do_whatΪ1��ʾ������2Ϊ����
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