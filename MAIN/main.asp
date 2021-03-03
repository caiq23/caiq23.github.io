<!-- #include file="../inc/conn-bbs.asp" -->
<%
formattime(foo_time)

	'统计帖子数量
	sql_dl="select count(id) from BBS_Topic where left(topic_addtime,10)='"& left(formattime(DateAdd("d",-1,thistime)),10) &"'"	
	set rs_dl=bbsconn.execute(sql_dl)
	all_yesterday_post=chk_num(rs_dl(0))
	sql_dl="select count(id) from BBS_Reply where left(reply_time,10)='"& left(formattime(DateAdd("d",-1,thistime)),10) &"'"		
	set rs_dl=bbsconn.execute(sql_dl)
	all_yesterday_post=all_yesterday_post+chk_num(rs_dl(0))
	
	sql_dl="select count(id) from BBS_Topic where left(topic_addtime,10)='"& left(thistime,10) &"'"	
	set rs_dl=bbsconn.execute(sql_dl)
	all_today_post=chk_num(rs_dl(0))
	sql_dl="select count(id) from BBS_Reply where left(reply_time,10)='"& left(thistime,10) &"'"		
	set rs_dl=bbsconn.execute(sql_dl)
	all_today_post=all_today_post+chk_num(rs_dl(0))
	
	sql_dl="select count(id) from BBS_Topic"	
	set rs_dl=bbsconn.execute(sql_dl)
	all_post=chk_num(rs_dl(0))
	sql_dl="select count(id) from BBS_Reply"	
	set rs_dl=bbsconn.execute(sql_dl)
	all_post=all_post+chk_num(rs_dl(0))
	
	sql_dl="select count(id) from BBS_User"	
	set rs_dl=bbsconn.execute(sql_dl)
	all_user=chk_num(rs_dl(0))
	
	sql_dl="select top 1 * from BBS_User order by id desc"	
	set rs_dl=bbsconn.execute(sql_dl)
	if not rs_dl.eof then
		top1_user_name=rs_dl("user_name")
		top1_user_id=rs_dl("user_id")
	end if

%>
        <div class="topnews_div">
        	<div class="topnews_left">
            	<img src="img/chart.png">
                今日 :  <b><%=all_today_post%></b> <span>&nbsp;&nbsp;|&nbsp;&nbsp;</span> 
                昨日 :  <b><%=all_yesterday_post%></b> <span>&nbsp;&nbsp;|&nbsp;&nbsp;</span>  
                帖子 :  <b><%=all_post%></b> <span>&nbsp;&nbsp;|&nbsp;&nbsp;</span>  
                会员 : <b><%=all_user%></b> <span>&nbsp;&nbsp;|&nbsp;&nbsp;</span> 
                欢迎新会员 : <a href="<%=index_url%>m1.html"><%=top1_user_name%></a>
            </div>
            <div class="topnews_right"><a href="<%=index_url%>t1.html">最新主题</a></div>
        </div>
<div style="clear:both;"></div>




<%board_belong=0%>
<!-- #include file="index_board_list.asp" -->



</div>