<%
menu_user_name="<a href=""login.asp"">请登录</a>"
menu_user_sign="登录后更精彩"
menu_user_img="<a href=""login.asp""><img class=""user_img"" src="""& BBS_folder &"img/user_logo.jpg""></a>"
if session_user_id>0 then
	m_sql="select * from BBS_User where user_id="& session_user_id &""
	set m_rs=bbsconn.execute(m_sql)
	if not m_rs.eof then
		menu_user_name=m_rs("user_name")
		menu_user_sign=m_rs("user_sign")
		menu_user_img=m_rs("user_img")
		menu_user_img="<img class=""user_img"" src="""& BBS_folder&menu_user_img &""">"
	end if
end if
%>
<div class="index_menu" id="index_menu">
	<div class="menu_top">
        <div class="left"><%=menu_user_img%></div>
        <div class="left"><span class="title"><%=menu_user_name%></span></div> 
        <div class="sign"><%=menu_user_sign%></div>
    </div>

    <div class="left_menu">
        <li><a href="index.asp"><img src="img/leftmenu/index.png">论坛首页</a></li>        
        <li><a href="search.asp"><img src="img/leftmenu/search.png">搜索</a></li>
        <li><a href="info.asp"><img src="img/leftmenu/set.png">设置</a></li>
        <li><a href="board.asp"><img src="img/leftmenu/borad.png">论坛版块</a></li>
        <%if session_user_id>0 then %><li><a href="index.asp?see_userid=<%=session_user_id%>"><img src="img/leftmenu/mypost.png">我的帖子</a></li><%end if%>
        
    </div>
    <%if session_user_id>0 then %>
    	<input type="button" class="logout_wap" style=" width:80%;margin:50px 0px 0px 10% ; text-align:center; clear:both; " onClick="window.location.href='../inc/logout.asp?from_mobile=1'" value="退出登录">
    <%end if%>
    
    <div class="left_menu_bottom">
    
        <%=bbsset_site_census%>
    </div>

</div>
<div class="hide_menu" id="hide_menu" onClick="menu_close();"></div>