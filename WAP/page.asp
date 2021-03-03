<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="inc/wap-fun.asp" -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="gb2312">
        
<%


	sql="select * from BBS_Switch"
	set rs=bbsconn.execute(sql)
	if not rs.eof then
		BBS_Switch=rs("BBS_Switch")
		close_tips=rs("close_tips")
	end if
	if chk_num(BBS_Switch)=3 then
		response.Write(dis_block_info("lock",close_tips))
		response.End()
	end if
	
	topic_no=chk_num(trim_fun(request("topic_id")))
	call dperror_admin(topic_no<=0,"该页无内容","")
	
sql="select * from BBS_Topic where topic_id="& topic_no &""
set rs=server.CreateObject("adodb.recordset")
rs.open sql,bbsconn,1,3
call dperror_admin(rs.eof,"该页无内容","")
if not rs.eof then
	user_id=rs("user_id")
	post_user_id=user_id
	topic_id=chk_num(rs("topic_id"))
	topic_title=rs("topic_title")
	topic_Content=rs("topic_Content")
	topic_Content=trim_fun_3(topic_Content)
	topic_Content=chk_post_hide(topic_Content,topic_id)
	topic_Content=dis_post_img(topic_Content)
	topic_addtime=rs("topic_addtime")
	lastedit_time=rs("lastedit_time")
	board_id=rs("board_id")
	board_no=board_id
	topic_seetimes=chk_num(rs("topic_seetimes"))
	replay_count=chk_num(rs("replay_count"))
	topic_state=chk_num(rs("topic_state"))
	replay_cansee=chk_num(rs("replay_cansee"))
	board_top=chk_num(rs("board_top"))
	topic_title=dis_posttitle(topic_title,topic_state)
	rs("topic_seetimes")=topic_seetimes+1
	
	rs.update
	user_name=chk_db("BBS_User","user_id",user_id,"user_name")
end if

	

%>
        
		<title><%=topic_title%><%if topic_no>1 then response.Write(" - 第"& page_no &"页")%> - <%=bbsset_sitename%></title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
        
        <link rel="stylesheet" href="inc/wap_css.css">
	</head>

	<body>
    <%this_page="page"%>
<!-- #include file="inc/top.asp" -->

    <div class="index_top_menu ">
        	
            <a href="index.asp">首页</a>
            <%=wap_get_board_class_href(board_id,0)%>
        
    </div>

            
            
        <div class="wap_page">
            <%if page_no=1 then%>
            	<div class="page_title"><%=topic_title%></div>
                <div class="post_list">
                		
                        <div class="left"><a href="index.asp?order_type=10&see_userid=<%=post_user_id%>"><img <%=get_userimg(post_user_id)%> width="40" height="40"></a></div>
                        <div class="left">
                            <div class="title"><a href="index.asp?order_type=10&see_userid=<%=post_user_id%>"><%=user_name%></a></div>
                            <div class="content"><%=howlong(topic_addtime)%></div>
                        </div>
                        <div class="page_content clear_both">                                           
								
                            <%=can_display_post(topic_Content,topic_state,board_id,0,post_user_id,post_user_id)%>
                            
                        </div>
                        </div>
                    <%end if%>
<%

   set rs=server.CreateObject("adodb.recordset") 
   sql="select * from BBS_Reply where topic_id="& topic_no &" order by id asc"  
   rs.open sql,bbsconn,1,1
	page_size=bbsset_topicpagesize	
	if not rs.eof then
		rs.PageSize=page_size		
		pagecount=rs.PageCount '获取总页码 
		if page_no>pagecount then page_no=pagecount		
		rs.AbsolutePage=page_no '设置本页页码 
		allRecordCount=rs.RecordCount
		
	end if
	
	allRecordCount=chk_num(allRecordCount)
	i=1
	whoami=""
%>

<div class="page_reply_div_line">
    <div class="left"><img src="img/comments.png"> 全部回复（<%=allRecordCount%>）</div>
    <div class="right"><a href="index.asp?board_no=<%=board_id%>"><%=chk_db("BBS_Board","board_id",board_id,"board_name")%></a></div>
</div>
                    <div class="page_reply_div">
                    	
<%


   do while not rs.eof
	reply_user_id=rs("user_id")
	reply_content=rs("reply_content")
	reply_content=trim_fun_3(reply_content)
	topic_state=chk_num(rs("topic_state"))
	replay_id=chk_num(rs("id"))
	from_reply_id=chk_num(rs("from_reply_id"))
	reply_time=rs("reply_time")
	lastedit_time=rs("lastedit_time")
	reply_user_name=chk_db("BBS_User","user_id",reply_user_id,"user_name")
	user_where=i+(page_no-1)*page_size
	select case user_where
		case 1
			user_where="沙发"
		case 2
			user_where="板凳"
		case else
			user_where=user_where&"楼"
	end select
	
	post_title=0
	if page_no>1 and i=1 then post_title=1
%>
        <li>
        	<div class="left" style="width:15%; text-align:center">
                <a href="index.asp?order_type=10&see_userid=<%=reply_user_id%>" class="title">
                    <img <%=get_userimg(reply_user_id)%> width="42" height="42" class="user_img">
                </a>               
            </div>
            
         <div class="right" style="width:85%;">  
         	<div class="left">  
				<a href="index.asp?order_type=10&see_userid=<%=reply_user_id%>" class="title">                  
                    <%=reply_user_name%>
                    <div class="page_time"><%=howlong(reply_time)%></div>
                </a> 
             </div>
         	 <div class="right font_size_12 user_where"><a href="javascript:void(0);" onClick="quote_this('<%=user_where%>|<%=reply_user_name%>',<%=replay_id%>);">引用</a><%=user_where%></div>      
			  <%if from_reply_id>0 then
                  sql_from="select * from BBS_Reply where id="& from_reply_id &""
                  set rs_from=bbsconn.execute(sql_from)
                  if not rs_from.eof then
                        from_user_id=rs_from("user_id")
                        from_reply_time=howlong(rs_from("reply_time"))
						from_reply_content=rs_from("reply_content")
						from_reply_content=trim_fun_3(from_reply_content)
                        from_reply_content=RegExphtml(from_reply_content)
                        from_topic_state=chk_num(rs_from("topic_state"))
                        if from_topic_state<>2 then
                            from_reply_content="提示：原内容已被管理员屏蔽"
                        else
                            if len(from_reply_content)>0 then from_reply_content=left(from_reply_content,50)
                        end if
                        from_user_name=chk_db("BBS_User","user_id",from_user_id,"user_name")
                  else
                        from_user_name="未知用户"
                        from_reply_time=""
                        from_reply_content="提示：原内容已被删除"			
                  end if 
				  %><div style="clear:both; height:0px;"></div>
				  <div class="page_reply_from">
					<a href="page.asp?topic_id=<%=topic_id%>">引用 <%=from_user_name%> 发表于 <%=from_reply_time%></a><br><%=from_reply_content%>
				  </div>
              
               <%end if%>
            
        
        
            <div class="page_reply_content">
			<%=can_display_post(reply_content,topic_state,board_id,replay_cansee,post_user_id,reply_user_id)%>
            </div>
            
        </div>
            <div class="clear_both"></div>
        </li>       

<%
	if i>=page_size then exit do  
	i=i+1  
	rs.movenext
	loop
%>
                    </div>
                
            

            
            
        </div>
    
        
		
		<%=wap_page_no(page_no,pagecount,"page.asp?topic_id="&topic_id)%>
        
        
        
        
        
  
        

    
    <!-- #include file="inc/end.asp" -->     
        
        
	</body>

</html>
<script>
function quote_this(replay_username,replay_id){
		window.document.getElementById("wap_reply_textarea").placeholder='引用 '+replay_username+' 的回复';
		window.document.getElementById("quote_id").value=replay_id;
		<%if session_user_id>0 then%>window.document.getElementById("reply_form").action='../inc/chk_quote.asp?from_mobile=1';<%end if%>
		window.document.getElementById("wap_reply_textarea").focus();
		
		
	}
</script>