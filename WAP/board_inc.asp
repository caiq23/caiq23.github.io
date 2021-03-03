<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="inc/wap-fun.asp" -->
<!doctype html>
<html>
<head>
<meta charset="gb2312">
<title>无标题文档</title>
</head>

<body>


<div id="board_inc">
<%
	see_board_id=chk_num(trim_fun(request("see_board_id")))
	see_board_type=chk_num(trim_fun(request("see_board_type")))
	
	sql3="select top 10 * from BBS_Board where 1=1"

select case true
	case see_board_type=2
		sql3=sql3&" and board_index=1"
		sql3=sql3&" order by board_order desc"
		response.Write("<div class=""board_right_title"">推荐版块</div>")
	case see_board_id>0
		sql3=sql3&" and board_belong in ("& see_board_id &")"
		sql3=sql3&" order by board_order desc"
		response.Write("<div class=""board_right_title"">"& board_name &"</div>")
	case else
		sql3=sql3&" and board_count>1 and board_can_post<>10"
		sql3=sql3&" order by board_count desc"
		response.Write("<div class=""board_right_title"">热门版块</div>")
end select

	
	set rs3=bbsconn.execute(sql3)
	loop_i=1
	do while not rs3.eof
		board_id3=rs3("board_id")
		board_name3=rs3("board_name")
		board_count3=rs3("board_count")
		board_demo3=rs3("board_demo")
		board_img3=rs3("board_img")
		board_can_post3=chk_num(rs3("board_can_post"))
		%>
        	<li onClick="window.location.href='list.asp?board_no=<%=board_id3%>'">
            	<div class="class_img"><img src="<%=board_img3%>" onerror="this.src='img/logo.png'"></div>
                <div class="class_info">
                	<div class="left">
                        <div class="title_1"><%=board_name3%><span>(<%=board_count3%>)</span></div>
                        <div class="title_2"><%=board_demo3%></div>
                    </div>
                    <div class="right"><div class="link">进入</div></div>
                </div>
            </li>
<%

		rs3.movenext
		if loop_i>=10 then exit do
		loop_i=loop_i+1
	loop
	%>
</div>
<script>
	window.parent.document.getElementById('board_right').innerHTML=window.document.getElementById('board_inc').innerHTML;
</script>

</body>
</html>