
<!-- #include file="inc/conn-bbs.asp" -->
<!doctype html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=gb2312" />

<!-- #include file="inc/myurl.asp" -->

<meta name="keywords" content="<%=site_keyword%>" />
<meta name="description" content="<%=site_description%>" />

<link rel="stylesheet" type="text/css" href="inc/index.css"/>
<link rel="stylesheet" type="text/css" href="inc/bbs.css"/>

<script type="text/javascript" src="inc/jquery.min.js"></script>
	
    <script type="text/javascript" src="inc/code2/jquery.qrcode.min.js"></script> 
    
<title><%=title%> - <%=bbsset_sitename%></title>
</head>



<div class="css_top" style="background-color:#f2f2f2; border-bottom:1px #cdcdcd solid; ">
	<div class="css_top_div">
 		<div class="css_top_title">
            <%=bbsset_site_name3%>
        </div> 

	</div>	
</div>



<div class="css_top_blank" >
    <div class="css_top_blank2">
        <div class="css_top_logo"  style="padding-top:15px;">
            <a href="<%=BBS_folder%>" title="首页"><img src="img/logo.png" alt="首页"></a>            
        </div>
        
        <div style="float:right;  padding-top:15px; padding-bottom:5px;">
        <!-- #include file="main/user_state.asp" -->
        </div>
        

        
    </div>
</div>


<div class="page_single_top">
	<div class="page_single_top2">
    <ul>
        <li><a href="<%=BBS_folder%>" <%if len(myurl)=0 then response.Write(" id=""onselect_topmenu""")%>>论坛首页</a></li>
        <%
		sql="select * from BBS_Board where board_index=1 order by board_order desc"
		set rs=bbsconn.execute(sql)
		do while not rs.eof
			this_board_id=rs("board_id")
			this_board_name=rs("board_name")
			temp_html="<li><a href="""& index_url &"b"& this_board_id &".html"""
			if (left(myurl,1)="b" and topic_no=this_board_id) or (left(myurl,1)="p" and board_id=this_board_id) then temp_html=temp_html&" id=""onselect_topmenu"""
			temp_html=temp_html&">"& this_board_name &"</a></li>"
			response.Write(temp_html)
			rs.movenext
		loop
		%>
        <li><a href="http://www.mlmzj.com/mlmzj/xqbbs/" target="_blank">小清论坛</a></li>

    </ul>
    </div>

    <div class="search_top">
    	<div class="search_top_1">
            <form name="search" action="?" method="get" accept-charset="gb2312" onsubmit="document.charset='gb2312';">
                <input name="keyword" class="search_input" value="<%=keyword%>" placeholder="请输入搜索内容">
                <input class="search_submit" type="submit" value=""  title="点击搜索">
            </form>
        </div>
        <%if bbsset_search_hotword=1 then%>
        <div class="search_top_2">
        	<span>热搜：</span>
			<%
            sql="select top 10 * from BBS_Search order by search_times desc"
            set rs=bbsconn.execute(sql)
			i=1
            do while not rs.eof
                search_word=rs("search_word")
                %><a href="<%=BBS_folder%>?keyword=<%=Server.UrlEncode(search_word)%>"><%=search_word%></a><%
				i=i+1
				if i>=10 then exit do
            rs.movenext
            loop
            %>
            
        </div>
        <%end if%>
    </div>
</div>









<div class="page_single_main">
	<div class="page_single_main_div">
        
<div style="float:left"><div class="page_single_main_title">
		<img src="img/home_ico.png"> <span>></span>
		<a href="<%=BBS_folder%>"><%=bbsset_sitename%></a><%=where_now%></div></div>
        <div class="page_single_content">        	
			<div class="bbs_content">
			
			<%server.execute("main/"&goto_file&".asp")%>
            
            </div>
        </div>
    </div>
</div>

<%if len(myurl)=0 then%>
<div class="index_link">
	<div class="bbs_content_title">
        友情链接
    </div>
	<div class="index_link_text">
    	<%
		sql="select * from BBS_Link order by link_order desc"
		set rs=bbsconn.execute(sql)
		do while not rs.eof
			link_title=rs("link_title")
			link_url=rs("link_url")
			link_time=rs("link_time")
			%><a href="<%=link_url%>" target="_blank" title="<%=link_title%>"><%=link_title%></a><%
			rs.movenext
		loop
		%>
        
        <div style="clear:both;"></div>
    </div>
</div>
<%end if%>

<!-- #include file="main/login.asp" -->





<div class="css_end">

    
    <div class="css_end_2">
        Powered by <a href="http://www.mlmzj.com/mlmzj/xqbbs/" target="_blank">小清论坛</a> v2.2.2
        <br>
        <span>2016-<%=year(now)%> www.mlmzj.com</span>
    </div>
    

        
    <div class="css_end_3">
    	<a href="wap/<%=mobile_url%>">手机版</a> <span>|</span>
        <a href="<%=index_url%>m4.html">小黑屋</a> <span>|</span>
        <a href="http://www.mlmzj.com/" target="_blank" title="直销软件">直销软件</a> <span>|</span>
        <%=bbsset_site_census%>
        <br>
        <span>GMT+8,<%=now()%></span>
    </div> 
    

         
</div>


<div class="code2_div" id="code2_div">
	<div class="code2_close"><img src="img/code_close.gif" title="关闭" onClick="window.document.getElementById('code2_div').style.display='none'"></div>
    <script>
    <%
	code2="http://"&Request.ServerVariables("HTTP_HOST")&Request.ServerVariables("PATH_INFO")&"?"&myurl
	%>
        jQuery(function(){
        var mode = !!document.createElement('canvas').getContext ? 'canvas' : 'table';
        jQuery('#output').qrcode({render:mode,text:"<%=code2%>",width:80,height:80});
        })
    </script>
    <div id="output"></div>
    扫一扫访问
</div>

</bod></html>
