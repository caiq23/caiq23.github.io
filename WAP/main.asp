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
		title="最热主题"
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
title=title&" - "&bbsset_sitename
%>
<!DOCTYPE html>
<html><head>
		<meta charset="gb2312">
		<title><%=title%></title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">        
        <link rel="stylesheet" href="inc/wap_css.css">
        
	</head>

	<body id="iframe_body">

    <%this_page="main"%>
    
		<!-- #include file="inc/top.asp" -->


<div class="index_bg"></div>

<%select case true%>
    
<%case instr(myurl,"order_type")>0 or len(myurl)=0%>
   


<%if len(myurl)=0 then%>

    <div class="index_board_class">
        <%
        sql="select * from BBS_Board order by board_count desc"
        set rs=bbsconn.execute(sql)
        loop_i=1
        do while not rs.eof
            board_id=rs("board_id")
            board_name=left(rs("board_name"),5)
            board_count=rs("board_count")
            board_can_post=chk_num(rs("board_can_post"))
            board_img=rs("board_img")
            
            %>
                <li onClick="window.location.href='list.asp?board_no=<%=board_id%>'">
                    <img src="<%=board_img%>" width="30" height="30" onerror="this.src='img/logo.png'"><br>
                    <%=board_name%>
                </li>
            <%
            rs.movenext
            if loop_i>=10 then exit do
            loop_i=loop_i+1
        loop
        %>
        <div class=" clear_both"></div>
    </div>
<%end if%>
<div class=" clear_both"></div>
              
  
<%end select%>


    <%if instr(myurl,"order_type")>0 or len(myurl)=0 then%>        
        <div class="index_class_menu">
            <%if order_type<10 then %>
                <a href="list.asp?order_type=1" <%if order_type<=1 then response.Write(" class=""active""")%>>最新发贴</a>
                <a href="list.asp?order_type=2" <%if order_type=2 then response.Write(" class=""active""")%>>一月热贴</a>
                <a href="list.asp?order_type=3" <%if order_type=3 then response.Write(" class=""active""")%>>最新回贴</a>
           
            <%end if%> 
        </div>
    <%end if%> 


<!-- #include file="inc/list_inc.asp" -->
     
     
    
    

    
	</body>

</html> 

<script type="text/javascript" src="inc/iframe_js.js"></script>
<script>display_iframe(0);</script>