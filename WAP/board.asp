<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="inc/wap-fun.asp" -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="gb2312">

        
		<title>版块</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
        <script type="text/javascript" src="inc/wap.js"></script> 
        <link rel="stylesheet" href="inc/wap_css.css">

	</head>
    
<body id="iframe_body">

    <%

	
	this_page="board"%>
    <!-- #include file="inc/top.asp" -->
    
    
    
    
    
    
    
			<%
			html_left="<div class=""menu-left"" id=""menuLeft""><ul class=""menu-left-ul"">"
			html_right="<div class=""menu-right"" id=""menuRight""><div class=""menu-right-content"">"			
			
				sql="select * from BBS_Board where board_belong=0"
				sql=sql&" order by board_order desc"
				set rs=bbsconn.execute(sql)
				i=3
				
			
				do while not rs.eof
				board_id=rs("board_id")
				board_name=rs("board_name")
				board_count=rs("board_count")
				board_can_post=chk_num(rs("board_can_post"))
				html_left=html_left&"<li class=""menu-left-li"">"& board_name &"</li>"
				
           
                see_board_id=board_id
                'see_board_type=chk_num(trim_fun(request("see_board_type")))    
				
				
                sql3="select * from BBS_Board where 1=1"
            
				select case true
					case see_board_type=2
						sql3=sql3&" and board_index=1"
						sql3=sql3&" order by board_order desc"
						'title_2=title_2&"<div class=""board_right_title"">推荐版块</div>"
					case see_board_id>0
						sql3=sql3&" and board_belong in ("& see_board_id &")"
						sql3=sql3&" order by board_order desc"
						html_right=html_right&"<div class=""content-item""><div class=""title"">"& board_name &"</div><ul>"
						'title_2=title_2&"<div class=""board_right_title"">"& board_name &"</div>"
					case else
						sql3=sql3&" and board_count>1 and board_can_post<>10"
						sql3=sql3&" order by board_count desc"
						'title_2=title_2&"<div class=""board_right_title"">热门版块</div>"
				end select
            
                
				set rs3=server.CreateObject("adodb.recordset")
				rs3.open sql3,bbsconn,1,3
                loop_i=1
				if not rs3.eof then 
					recordcount3=rs3.recordcount
				end if
                do while not rs3.eof
                    board_id3=rs3("board_id")
                    board_name3=rs3("board_name")
                    board_count3=rs3("board_count")
                    board_demo3=rs3("board_demo")
                    board_img3=rs3("board_img")
                    board_can_post3=chk_num(rs3("board_can_post"))	
					
					html_right=html_right&"<li onClick=""window.location.href='list.asp?board_no="& board_id3 &"'"""
									if loop_i<>recordcount3 then
										html_right=html_right&" class=""on"""
									end if
									html_right=html_right&">"&_
                    				"<div class=""class_img""><img src="""& board_img3 &""" onerror=""this.src='img/logo.png'""></div>"&_
                            		"<div class=""class_info"">"&_
                                	"<div class=""left"">"&_
                                    "<div class=""title_1"">"& board_name3 &"<span>("& board_count3 &")</span></div>"&_
                                    "<div class=""title_2"">"& board_demo3 &"</div>"&_
                                	"</div>"&_
                                	"<div class=""right""><div class=""link"">进入</div></div>"&_
                            		"</div></li>"   
					      
                    rs3.movenext
                    loop_i=loop_i+1
                loop				
				html_right=html_right&"</ul></div>"
                
				
				
            rs.movenext
			i=i+1
            loop
			
			
			'html_left=html_left&"<li>&nbsp;</li><li>&nbsp;</li><li>&nbsp;</li>"
			html_left=html_left&"</ul></div>"
			'html_right=html_right&"<li>&nbsp;</li><li>&nbsp;</li><li>&nbsp;</li>"
			html_right=html_right&"</div></div>"
            %>

	
<div class="menu">
	<%=html_left%>
    <%=html_right%>    
</div>




    
<script type="text/javascript">
    	$('#menuLeft .menu-left-li').click(function (e) {
    		var i = $(this).index();
    		var t = $('#menuRight').scrollTop() - $(window).width()/ 375 * 50 * 1;
			//var t =0;
    		$('#menuLeft .menu-left-li').eq(i).addClass('on').siblings().removeClass('on');
    		$('#menuRight').scrollTop( $('#menuRight .content-item').eq(i).offset().top + t);
    	})
    	//左边联动

		var heightArr = [];
    	for (var i = 0; i < $('#menuRight .content-item').length; i++) {
    		heightArr.push($('#menuRight .content-item').eq(i).offset().top);
    	}
    	// 元素相对窗口顶部偏移量存成数组


  		$('#menuRight').scroll(function () {
    		var t = $(this).scrollTop();

    		for (var i in heightArr) {
		        if ((t + $(window).width()/ 375 * 50 *1) >= heightArr[i]){
			       $('#menuLeft .menu-left-li').eq(i).addClass('on').siblings().removeClass('on');
			    }
	        }

     		$('#menuLeft').stop().animate({
     			scrollTop: $('#menuLeft .menu-left-li').height() * ($('#menuLeft .menu-left-li.on').index()+0.5) - ($('#menuLeft').height()/2)
    		}, 200)
    		// 左侧按钮位置垂直居中
    	})
    	//右边联动
    </script>

	</body>

</html>
