<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->

<script language="javascript" type="text/javascript" src="inc/main.js"></script>
<%


select case left(myurl,1)
	case "k" 
		board_name="与“"& keyword &"”相关的帖子"
		board_sql=" and topic_title like '%"& keyword &"%' or topic_id in (select topic_id from BBS_Reply where reply_content like '%"& keyword &"%')"
		now_board=topic_no
		board_count=0
		today_board_count=0

	case "b" 
		sql="select * from BBS_Board where board_id="& topic_no &""
		set rs=bbsconn.execute(sql)
		if rs.eof then
			response.Redirect("?")
			response.End()
		end if
		board_id=rs("board_id")
		board_name=rs("board_name")
		board_demo=rs("board_demo")
		board_law=rs("board_law")
		board_sql=" and board_id="& board_id
		now_board=topic_no
		board_count=chk_num(rs("board_count"))
		board_can_post=chk_num(rs("board_can_post"))
		sql="select count(id) from BBS_Topic where board_id="& topic_no &" and left(topic_addtime,10)='"& left(thistime,10) &"'"
		set rs=bbsconn.execute(sql)
		today_board_count=chk_num(rs(0))		
		
	case "u"
		board_id=topic_no
		'board_name=chk_db("BBS_User","user_id",topic_no,"user_name")&" 全部帖子"
		board_sql=" and user_id="& board_id	
		now_board=0
		sql="select count(id) from BBS_Topic where user_id="& topic_no &""
		set rs=bbsconn.execute(sql)
		board_count=chk_num(rs(0))
		sql="select count(id) from BBS_Topic where user_id="& topic_no &" and left(topic_addtime,10)='"& left(thistime,10) &"'"
		set rs=bbsconn.execute(sql)
		today_board_count=chk_num(rs(0))
		
end select


if left(myurl,1)="b" then
	board_belong=topic_no
	%><!-- #include file="index_board_list.asp" --><%
end if

if board_can_post<>10 then
	if len(keyword)=0 then
	%>
		<div class="Board_top">
			<div class="Board_title">
            
            
<%select case left(myurl,1)
case "u"
	sql="select * from BBS_User where user_id="& topic_no &""
	set rs=bbsconn.execute(sql)
	if rs.eof then
		response.Redirect("?")
		response.End()
	end if
	user_name=rs("user_name")
	user_sign=rs("user_sign")
	user_qq=rs("user_qq")
	user_tel=rs("user_tel")
	msg_open=chk_num(rs("msg_open"))
	
%>
<div style="padding-left:10px;">
	<div class="top_user_ico"><a href="<%=index_url%>u<%=board_id%>.html"><img <%=get_userimg(board_id)%>></a></div>
	<a href="<%=index_url%>u<%=board_id%>.html"><%=user_name%></a>
    
    <br>
    签名：<%=user_sign%><br>
    QQ：<%=user_qq%><br>
    电话：<%=user_tel%><br>
    短消息：<%
	if msg_open=1 then
	%>已开启 <img src="img/msg.png" title="点击给TA发送短消息">
    <%else%>
    已关闭，TA不接收任何短消息
    <%end if%>
    
</div>
	
<%case "b"%>
	<a href="<%=index_url%>b<%=board_id%>.html"><%=board_name%></a>
<%end select%>
			&nbsp;&nbsp;今日: <span class="Board_about_count"><%=today_board_count%></span>
			<span class="Board_about_line">&nbsp;|&nbsp;</span>
			帖子: <span class="Board_about_count"><%=board_count%></span>           
            </div>			
            <div class="Board_about"><%=board_demo%></div>
            <div class="board_demo"><%=board_law%></div>
		</div>
		<div style="clear:both;"></div>
	
<%if left(myurl,1)="b" then%>
<%=dis_pos_do(session_user_id,now_board)%>	
<%end if%>		
	<%end if%>
	</div>   
		
		
	   <div class="Board_table">
	 <table>
		 <thead>
			 <tr>
			  <th width="62%">主题</th>
			  <th>作者</th>
			  <th>回复/查看</th>
			  <th>最后发表</th>
			</tr>
		 </thead>
	  <tbody>
<%
if left(myurl,1)="b" and page_no=1 then
	'全站顶置
	  sql="select * from BBS_Topic where board_top=2"
	  'sql=sql&board_sql
	  sql=sql&" order by board_top desc"
	  set rs=server.CreateObject("adodb.recordset")
	  rs.open sql,bbsconn,1,1
	  i=1	  
	  do while not rs.eof
		topic_id=rs("topic_id")
		topic_title=rs("topic_title")		
		topic_state=chk_num(rs("topic_state"))
		topic_addtime=rs("topic_addtime")
		topic_seetimes=chk_num(rs("topic_seetimes"))
		replay_count=chk_num(rs("replay_count"))
		user_id=rs("user_id")
	 	call display_this_title(topic_id,topic_title,user_id,topic_addtime,replay_count,topic_seetimes,2)
		i=i+1
	  rs.movenext
	  loop
	  
	'本版块顶置
	  sql="select * from BBS_Topic where board_top=1"
	  sql=sql&board_sql
	  sql=sql&" order by board_top desc"
	  set rs=server.CreateObject("adodb.recordset")
	  rs.open sql,bbsconn,1,1
	 
	  do while not rs.eof
		topic_id=rs("topic_id")
		topic_title=rs("topic_title")
		topic_state=chk_num(rs("topic_state"))
		topic_addtime=rs("topic_addtime")
		topic_seetimes=chk_num(rs("topic_seetimes"))
		replay_count=chk_num(rs("replay_count"))
		user_id=rs("user_id")
	 	call display_this_title(topic_id,topic_title,user_id,topic_addtime,replay_count,topic_seetimes,1)		
		i=i+1
	  rs.movenext
	  loop
		if i>1 then
%>
		<tr>
		  <td colspan="4" id="board_top_list">版块主题</td>
	    </tr> 
	  <%
	  end if
end if
	  
	  sql="select * from BBS_Topic where board_top=0"
	  if session_user_id>0 then
		sql=sql&" and (topic_state=2 or user_id="& session_user_id &" or "& session_user_id &">0)"
	  else
		sql=sql&" and topic_state=2"
	  end if
	  sql=sql&board_sql
	  sql=sql&" order by id desc"
	  set rs=server.CreateObject("adodb.recordset")
	  rs.open sql,bbsconn,1,1
		page_size=bbsset_boardpagesize
		
		if not rs.eof then
			rs.PageSize=page_size		
			pagecount=rs.PageCount '获取总页码 
			if page_no>pagecount then page_no=pagecount		
			rs.AbsolutePage=page_no '设置本页页码 
			allRecordCount=rs.RecordCount
		else
			%>
			
				<tr>
		  <td colspan="4">暂无帖子!</td>
		  </tr>
			<%
		end if
		allRecordCount=chk_num(allRecordCount)
		i=1
	
	  do while not rs.eof
		topic_id=rs("topic_id")
		topic_title=rs("topic_title")
		topic_state=chk_num(rs("topic_state"))
		topic_addtime=rs("topic_addtime")
		topic_seetimes=chk_num(rs("topic_seetimes"))
		replay_count=chk_num(rs("replay_count"))
		user_id=rs("user_id")
	    call display_this_title(topic_id,topic_title,user_id,topic_addtime,replay_count,topic_seetimes,0)
		if i>=page_size then exit do
		i=i+1
		rs.movenext
		loop
		%>
		<tr>
		  <td colspan="4"><ul class="pagination"><%=bbs_page_no(page_no,pagecount,"")%></ul></td>
		  </tr>
		
	  </tbody>
	</table>
	
	   </div>
	<div style="clear:both;"></div>
<%end if%>


<%
'显示列表
sub display_this_title(topic_id,topic_title,user_id,topic_addtime,replay_count,topic_seetimes,board_top)
		
		topic_title=dis_posttitle(topic_title,topic_state)
		full_title=topic_title
		topic_title=left(topic_title,35)
		if instr(topic_title,keyword)>0 then topic_title=replace(topic_title,keyword,"<font style=color:red>"& keyword &"</font>")	
		user_name=chk_db("BBS_User","user_id",user_id,"user_name")
				
		'读取最后回复
		sql2="select top 1 * from BBS_Reply where topic_id="& topic_id &" order by id desc"
		set rs2=bbsconn.execute(sql2)
		re_user_id=user_id
		re_user_name=user_name
		re_topic_addtime=topic_addtime
		if not rs2.eof then
			re_user_id=chk_num(rs2("user_id"))	
			re_user_name=chk_db("BBS_User","user_id",re_user_id,"user_name")
			re_topic_addtime=rs2("reply_time")
		end if
		folder_img=""
		select case board_top
			case 0
				folder_img="folder_new"
			case 1
				folder_img="pin_1"
			case 2
				folder_img="pin_2"
		end select
	 
%>
		<tr>
		  <td class="board_topic_title"><a href="<%=index_url%>p<%=topic_id%>.html" title="<%=full_title%>">
		  <img src="img/<%=folder_img%>.gif">
		  <%=topic_title%></a></td>
		  <td><a href="<%=index_url%>u<%=user_id%>.html"><%=user_name%></a><br><%=howlong(topic_addtime)%></td>
		  <td><%=replay_count%><br><%=topic_seetimes%></td>
		  <td><a href="<%=index_url%>u<%=re_user_id%>.html"><%=re_user_name%></a><br><%=howlong(re_topic_addtime)%></td>
		</tr>
<%end sub%>