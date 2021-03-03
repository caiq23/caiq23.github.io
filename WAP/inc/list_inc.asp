        <div class="wap_list">
        

<%


sql="select * from BBS_Topic where 1=1 "
'if board_no>0 then sql=sql&" and board_id in ("& dis_allmyclass(board_no) &")"
if board_no>0 then sql=sql&" and board_id ="& board_no &""

if len(key_word)>0 then sql=sql&" and topic_title like '%"& key_word &"%' or topic_id in (select topic_id from BBS_Reply where reply_content like '%"& key_word &"%')"

select case order_type
	case 10
		sql=sql&" and user_id="& see_userid &""
	case 11
		sql=sql&" and topic_id in (select topic_id from BBS_Reply where user_id="& see_userid &")"
	case 12
		sql=sql&" and topic_id in (select alert_about_id from BBS_Alert where alert_num2="& see_userid &")"
		'标记已读
		if page_no=1 then
			sql2="update BBS_Alert set alert_state=2 where alert_num2="& see_userid &" and alert_state=1"
			set rs2=bbsconn.execute(sql2)
		end if
		
	case 2
		sql=sql&" and datediff('d',topic_addtime,now())<=30 and replay_count>0 order by replay_count desc"
	case 3
		sql=sql&" order by lastreply_time desc"
end select

if order_type<>2 and order_type<>3 then sql=sql&" order by id desc"

set rs=server.CreateObject("adodb.recordset")
rs.open sql,bbsconn,1,1
page_size=bbsset_boardpagesize
if not rs.eof then
	rs.PageSize=page_size		
	pagecount=rs.PageCount '获取总页码 
	if page_no>pagecount then page_no=pagecount		
	rs.AbsolutePage=page_no '设置本页页码 
	allRecordCount=rs.RecordCount
	%>

	<%
else
	if this_board_can_post<>10 then response.Write("<div class=""post_list_2"">暂无帖子!</div>")
end if
allRecordCount=chk_num(allRecordCount)
i=1
do while not rs.eof
		topic_id=rs("topic_id")
		topic_title=rs("topic_title")
		topic_title=left(topic_title,20)
		if instr(topic_title,key_word)>0 then topic_title=replace(topic_title,key_word,"<font style=color:red>"& key_word &"</font>")
		topic_state=chk_num(rs("topic_state"))
		topic_addtime=rs("topic_addtime")
		topic_seetimes=chk_num(rs("topic_seetimes"))
		replay_count=chk_num(rs("replay_count"))
		post_user_id=rs("user_id")
		replay_cansee=chk_num(rs("replay_cansee"))
		board_id=rs("board_id")
		user_name=chk_db("BBS_User","user_id",post_user_id,"user_name")
		
		
%>
        	<li onClick="window.location.href='page.asp?topic_id=<%=topic_id%>'">
            	<div class="post_list">
                	
                        <div class="left"><img <%=get_userimg(post_user_id)%> width="42" height="42"></div>
                        <div class="left">
                            <div class="title"><%=user_name%></div>
                            <div class="content"><%=howlong(topic_addtime)%></div>
                        </div>
<div class="page_content_right"> 
    <div class="post_content clear_both"><%=can_display_post(topic_title,topic_state,board_id,0,post_user_id,post_user_id)%></div>	
                    	
                    
                
<%
   set rs2=server.CreateObject("adodb.recordset") 
   sql2="select * from BBS_Reply where topic_id="& topic_id &" order by id desc"  
   rs2.open sql2,bbsconn,1,1
	page_size2=3
	i2=1	
	if not rs2.eof then
		rs2.PageSize=page_size2		
		pagecount2=rs2.PageCount '获取总页码 	
		rs2.AbsolutePage=1 '设置本页页码 
		allRecordCount2=rs2.RecordCount	
		response.Write("<div class=post_list_reply>")
	end if
do while not rs2.eof
	user_id2=rs2("user_id")
	user_name2=chk_db("BBS_User","user_id",user_id2,"user_name")
	reply_content=rs2("reply_content")
	reply_content=trim_fun_3(reply_content)
	reply_content=RegExphtml(reply_content)
	if len(reply_content)>0 then reply_content=left(reply_content,20)
	if instr(reply_content,key_word)>0 then reply_content=replace(reply_content,key_word,"<font style=color:red>"& key_word &"</font>")
	topic_state=chk_num(rs2("topic_state"))

%>      <div class="replay_li">
            
            <div class="left">
                <div class="title"><%=can_display_post("<span>"& user_name2 &"：</span>"&reply_content,topic_state,board_id,replay_cansee,post_user_id,user_id2)%></div>
            </div>
        </div>
    
<%
	rs2.movenext
	if i2>=page_size2 then exit do
	i2=i2+1
	
loop
%><div class="re_tall"><img src="img/re_tall.png"></div><%
if not rs2.eof then
%><div class="center  font_size_14 clear_both replay_li_more">查看全部<%=allRecordCount2%>条回复 > </div>

<%
end if
if i2>1 then response.Write("<div class=clear_both></div></div>")
%>
			
		</div>
	<div class="clear_both"></div>
</div>
    
</li>

    


<%
	if i>=page_size then exit do
	i=i+1
	rs.movenext
loop
%>

        </div>
  	<%if this_board_can_post<>10 then%>
 
 <%=wap_page_no(page_no,pagecount,"list.asp?see_userid="& see_userid &"&order_type="& order_type &"&key_word="& key_word &"&board_no="& board_no &"")%>
  
    <%end if%>
	