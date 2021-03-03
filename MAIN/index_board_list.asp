<%
dis_class=0
sql2="select * from BBS_Board where board_belong="& board_belong &""
set rs2=bbsconn.execute(sql2)
if not rs2.eof then dis_class=1

if dis_class=1 then

	if board_belong=0 then
		sql="select * from BBS_Board where board_belong="& board_belong &" order by board_order desc"
	else
		sql="select * from BBS_Board where board_id="& board_belong &" order by board_order desc"
	end if

set rs=bbsconn.execute(sql)
%><div class="bbs_main"><%
do while not rs.eof
board_id=rs("board_id")
board_name=rs("board_name")
board_list=chk_num(rs("board_list"))
%>

	<div class="bbs_content_title">
        <a href="<%=index_url%>b<%=board_id%>.html"><%=board_name%></a>
    </div>
	<%sql2="select * from BBS_Board where board_belong="& board_id &" order by board_order desc"
    set rs2=bbsconn.execute(sql2)
	
    do while not rs2.eof
	
    board_id2=rs2("board_id")
	this_board_class_2=dis_allmyclass(board_id2)
    board_name2=rs2("board_name")
	board_demo2=rs2("board_demo")
	board_img2=rs2("board_img")	
	board_count2=chk_num(rs2("board_count"))
		sql3="select count(id) from BBS_Reply where topic_id in (select topic_id from BBS_Topic where board_id="& board_id2 &")"
    	set rs3=bbsconn.execute(sql3)
		board_count2=board_count2+rs3(0)
	
	today_board_count=0	
	sql3="select top 1 * from BBS_Topic where board_id in ("& this_board_class_2 &") and left(topic_addtime,10)='"& left(thistime,10) &"'"	
    set rs3=bbsconn.execute(sql3)		
    if not rs3.eof then today_board_count=1
	sql3="select top 1 * from BBS_Reply where left(reply_time,10)='"& left(thistime,10) &"' and topic_id in (select topic_id from BBS_Topic where board_id in ("& this_board_class_2 &"))"
    set rs3=bbsconn.execute(sql3)		
    if not rs3.eof then today_board_count=1
	
	forum_gif=""
	if today_board_count>0 then forum_gif="_new"
	
    %>
    <li <%if board_list>1 then%> style="float:left; clear:none; width:<%=92/board_list%>%; padding-left:<%=8/board_list%>%;"<%end if%>>
    	<div class="bbs_board_left forum_ico">                       
            <a href="<%=index_url%>b<%=board_id2%>.html"><img src="<%=board_img2%>" width="40" height="40" onerror="this.src='img/forum_new.gif'"> </a>            
        </div>
    	<div class="bbs_board_left" <%if board_list=1 then%> style="width:55%;" <%else%> style=""<%end if%>>
            <div class="bbs_board_title">
            <a href="<%=index_url%>b<%=board_id2%>.html"><%=board_name2%></a></div>
            <div class="bbs_board_demo">
                <%if board_list=1 then%>
					<%=board_demo2%>
                <%else%>
                	帖数：<%=board_count2%> 今天：<%=today_board_count%>
                <%end if%>                
            </div>
            
            
            
            
            
            
<%



	sql3="select top 1 * from BBS_Topic where board_id in ("& this_board_class_2 &") and topic_state=2 order by id desc"
	set rs3=bbsconn.execute(sql3)
	
	if rs3.eof then		
		last_post_info="<div class=""bbs_board_topic_no"">暂无贴子</div>"
		topic_title=""
	else
		topic_id=rs3("topic_id")
		topic_title=rs3("topic_title")
		
		user_id=rs3("user_id")
		topic_addtime=rs3("topic_addtime")			
		user_name=chk_db("BBS_User","user_id",user_id,"user_name")
		
		
		'读取最后回复
		sql3="select top 1 * from BBS_Reply where topic_id in (select topic_id from BBS_Topic where board_id in ("& this_board_class_2 &") and topic_state=2) order by id desc"
		set rs3=bbsconn.execute(sql3)
		re_user_id=0
		re_user_name=user_name
		re_topic_addtime=topic_addtime	
		if not rs3.eof then
			re_user_id=chk_num(rs3("user_id"))	
			re_user_name=chk_db("BBS_User","user_id",re_user_id,"user_name")
			re_topic_addtime=rs3("reply_time")
			re_topic_id=rs3("topic_id")
			
			if re_topic_addtime>topic_addtime then
				'这里改变最新回复的主题		
				sql3="select * from BBS_Topic where topic_id="& re_topic_id &" and topic_state=2"
				set rs3=bbsconn.execute(sql3)
				if not rs3.eof then
					topic_id=rs3("topic_id")
					topic_title=rs3("topic_title")
					
					user_id=re_user_id
					topic_addtime=re_topic_addtime	
					user_name=re_user_name
				end if
			end if
		end if
		last_post_info="<div class=""bbs_board_topic_title""><a href="""& index_url &"p"& topic_id &".html"" title="""& topic_title &""">"& left(topic_title,15) &"</a></div><div class=""bbs_board_topic_date"">"& howlong(topic_addtime) &"<a href="""& index_url &"u"& user_id &".html"" id=""hot_link"">"& user_name &"</a></div>"
	end if

%>
            
            
            
            
            
            
            
            
            
            <div class="bbs_board_demo">
            <%if board_list=1 then%>
                热点：
                <%
                sql3="select top 1 * from BBS_Topic where board_id in ("& this_board_class_2 &")  order by replay_count desc"
                set rs3=bbsconn.execute(sql3)
                if rs3.eof then		
                %><span class="bbs_board_topic_no">暂无热点</span><%
                else
                    topic_id_hot=rs3("topic_id")
                    topic_title_hot=rs3("topic_title")
                    
                    user_id_hot=rs3("user_id")
                    topic_addtime_hot=rs3("topic_addtime")
                    
                    user_name_hot=chk_db("BBS_User","user_id",user_id,"user_name")                    
                    
                %>
                    <a href="<%=index_url%>p<%=topic_id_hot%>.html" id="hot_link" title="<%=topic_title_hot%>"><%=left(topic_title_hot,15)%></a>
                <%end if%>
            <%else
				
			%> 
            		最后发表：<%
							if topic_title<>"" then
								%><a href="<%=index_url%>p<%=topic_id%>.html" id="hot_link" title="<%=topic_title%>"><%=howlong(topic_addtime)%></a><%
							else
								response.Write("暂无")
							end if
			end if%>
            </div>
        </div>
        <%if board_list=1 then%>
            <div class="bbs_board_left" style="width:10%;">
                <div class="bbs_board_date">
                    <span><%=today_board_count%></span> / <%=board_count2%>
                </div>
            </div>
            <div class="bbs_board_right">
                <%=last_post_info%>
            </div> 
        <%end if%>      
        <div style="clear:both;"></div>
    </li>
    <%
	
	rs2.movenext
	loop
	%>
    <%
	rs.movenext
	loop
	%>
    <div style="clear:both;"></div>
</div>
<%end if%>