<%
'显示屏蔽帖子
function can_display_post(reply_content,topic_state,board_id,replay_cansee,post_user_id,reply_user_id)
	can_display_post=reply_content
	
	select case topic_state
		case 1
			if session_user_id<>reply_user_id and session_admin_id=0 then can_display_post=""
			can_display_post=dis_block_info("lock","本内容审核中，只有管理员或有管理权限的成员可见")&can_display_post
		case 3
			if session_user_id<>reply_user_id and session_admin_id=0 then can_display_post=""
			can_display_post=dis_block_info("lock","该帖被管理员屏蔽，只有管理员或有管理权限的成员可见")&can_display_post
	 end select
	 board_cansee=chk_db("BBS_Board","board_id",board_id,"board_cansee")   
	  select case board_cansee
			case 1
				if session_user_id=0 then can_display_post=dis_block_info("lock","本版块需要登录后才能查看")
			case 2
				if user_state<4 and session_admin_id=0 then can_display_post=dis_block_info("lock","本版块需要有VIP/超级版主权限才能查看")
			case 3
				if user_state<5 and session_admin_id=0 then can_display_post=dis_block_info("lock","本版块需要有超级版主权限才能查看")
			case 4
				if session_admin_id=0 then can_display_post=dis_block_info("lock","本版块需要有管理员权限才能查看")
	  end select			  
	  if replay_cansee=1 then			  		
			if session_user_id<>post_user_id and session_user_id<>reply_user_id and session_admin_id=0 then can_display_post=""
			can_display_post=dis_block_info("lock","本贴回复只有原作者可见")&can_display_post
	  end if
end function

'读取当前所在版块		
function wap_get_board_class_href(topic_no,this_id)
	loop_topic_no=topic_no
	do while loop_topic_no>0
		sql_class="select * from BBS_Board where board_id="& loop_topic_no &""
		set rs_class=bbsconn.execute(sql_class)
		if rs_class.eof then exit do
		loop_board_name=rs_class("board_name")
		loop_board_belong=rs_class("board_belong")
		temp_href=""
		temp_href="<a class=""line2"">/</a>"
		temp_href=temp_href&"<a "
		if loop_topic_no=this_id then temp_href=temp_href&" class=""active"""
		temp_href=temp_href&" href=""list.asp?board_no="& loop_topic_no &""">"& loop_board_name &"</a>"
		wap_get_board_class_href=temp_href&wap_get_board_class_href
		loop_topic_no=loop_board_belong	
	loop
end function



'显示分页
function wap_page_no(page_no,page_end,page_url)
	page_end=chk_num(page_end)
	if page_end>1 then
		page_no=chk_num(page_no)
		if page_no=0 then page_no=1		
		if len(page_url)=0 then page_url="1=1"
		wap_page_no=wap_page_no&"<div class=""pagination""><div class=left><img src=""img/back.png"" onClick=""window.location.href='"& page_url &"&page_no="& page_no-1 &"'""></div><label for=""page_select""><select class=""select_input"" id=""page_select"" onchange=""window.location.href='"& page_url &"&page_no='+this.value"">"
		for page_i=1 to page_end
			wap_page_no=wap_page_no&"<option value="& page_i &" "
			if page_no=page_i then wap_page_no=wap_page_no&" selected"
			wap_page_no=wap_page_no&">"& page_i &"</option>"
		next
		wap_page_no=wap_page_no&"</select> / "&page_end
		wap_page_no=wap_page_no&"</label><div class=right><img src=""img/list_go.png"" onClick=""window.location.href='"& page_url &"&page_no="& page_no+1 &"'""></div></div>"
	end if		
end function





myurl=Request.ServerVariables("QUERY_STRING")
page_no=chk_num(trim_fun(request("page_no")))
if page_no<=0 then page_no=1
%>