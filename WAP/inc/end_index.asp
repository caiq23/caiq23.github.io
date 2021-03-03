<div class="div_clear height_56"></div>
<div class="wap_bottom_bar">
	<li>
        <a href="index.asp" class="<%if this_page="index" and len(myurl)=0 then response.Write(" ative")%>">
        	<img src="img/bar/bar_home<%if this_page="index" and len(myurl)=0 then response.Write("2")%>.png">
             <div class="title">首页</div> 
        </a>
    </li>
	<li>
        <a href="board.asp" class="<%if this_page="board" then response.Write(" ative")%>">
        	<img src="img/bar/bar_board<%if this_page="board" then response.Write("2")%>.png">
             <div class="title">版块</div> 
        </a>
    </li>
    <li>
        <a href="post.asp?board_no=<%=board_no%>">
        	<img src="img/bar/new_post.png">
             <div class="title">发表</div> 
        </a>
    </li>
	<li>
        <a href="msg.asp" class="<%if this_page="msg" then response.Write(" ative")%>">
        	<img src="img/bar/bar_msg<%if this_page="msg" then response.Write("2")%>.png">
             <div class="title">消息 </div> 
             <%if all_my_not_read>0 then%><div class="num"><%=all_my_not_read%></div><%end if%>
        </a>
    </li>
	<li>
        <a href="info.asp" class="<%if this_page="info" or this_page="login" or this_page="edit_info" then response.Write(" ative")%>">
        	<img src="img/bar/bar_user<%if this_page="info" or this_page="login" or this_page="edit_info" then response.Write("2")%>.png">
             <div class="title">我的</div> 
        </a>
    </li>
</div>
<div class="opacity_div opacity_div_bottom"></div> 