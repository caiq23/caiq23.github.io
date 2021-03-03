<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="inc/wap-fun.asp" -->
<%
board_no=chk_num(trim_fun(request("board_no")))
see_userid=chk_num(trim_fun(request("see_userid")))
order_type=chk_num(trim_fun(request("order_type")))
key_word=trim_fun(request("key_word"))

select case true
	case len(key_word)>0
		title="搜索"""&key_word&""""
	case order_type=12
		title="回复通知"
	case order_type=11
		title="参与的主题"
	case order_type=10
		title="发表的主题"
	case order_type=3
		title="最新回复"
	case order_type=2
		title="一月最热"
	case order_type=1
		title="最新主题"
	case board_no>0
		sql="select * from BBS_Board where board_id="& board_no &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then
			this_board_id=board_no
			this_board_name=rs("board_name")
			this_board_demo=rs("board_demo")
			this_board_law=rs("board_law")
			this_board_count=rs("board_count")
			this_board_can_post=chk_num(rs("board_can_post"))
			
			
		end if
		title=this_board_name
	case else
		title="首页"
end select
if page_no>1 then title=title&" - 第"& page_no &"页"
'title=title&" - "&bbsset_sitename
%>
<!DOCTYPE html>
<html><head>
		<meta charset="gb2312">
		<title><%=title&" - "&bbsset_sitename%></title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">        
        <link rel="stylesheet" href="inc/wap_css.css">
        
	</head>

	<body id="iframe_body">

    <%this_page="list"%>
    
		<!-- #include file="inc/top.asp" -->



<%select case true%>
<%case board_no>0%>   
    <div class="index_top_menu">
        <div class="left">	
            <a href="index.asp">首页</a>
            <%=wap_get_board_class_href(board_no,board_no)%>
        </div>
    </div>
<%sql="select * from BBS_Board where board_belong="& board_no &""
sql=sql&" order by board_order desc"
set rs=bbsconn.execute(sql)
do while not rs.eof
board_id=rs("board_id")
board_name=rs("board_name")
board_count=rs("board_count")
board_demo=rs("board_demo")
board_img=rs("board_img")
board_can_post=chk_num(rs("board_can_post"))


%>
    <div class="index_board_div" onClick="window.location.href='?board_no=<%=board_id%>'">
    	<div class="left">
    		<img src="<%=board_img%>" width="31" height="31" onerror="this.src='../img/forum_new.gif'"> 
        </div>
        <div class="left text">	
            <div class="title"><%=board_name%>(<%=board_count%>)</div>
            <div class="content"><%=this_board_demo%></div>
        </div>
        <div class="clear_both"></div>
    </div>
    
<%
rs.movenext
loop
%>
             
  
<%end select%>


    <%if order_type>=10 or len(myurl)=0 then%>
	<!-- #include file="inc/wap_session.asp" -->
        <div class="index_class_menu">
            <%if order_type>=10 then %>
                <a href="?order_type=10&see_userid=<%=see_userid%>" <%if order_type=10 then response.Write(" class=""active""")%>>我的帖子</a>
                <a href="?order_type=11&see_userid=<%=see_userid%>" <%if order_type=11 then response.Write(" class=""active""")%>>我参与的</a>
                <a href="?order_type=12&see_userid=<%=see_userid%>" <%if order_type=12 then response.Write(" class=""active""")%>>回复通知</a>
            <%end if%> 
        </div>
    <%end if%> 


<!-- #include file="inc/list_inc.asp" -->
     
     
    
    

    
	</body>

</html> 
