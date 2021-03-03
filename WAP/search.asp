<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="inc/wap-fun.asp" -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="gb2312">
        
<title>搜索内容 - <%=bbsset_sitename%></title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
        
        <link rel="stylesheet" href="inc/wap_css.css">
	</head>

	<body onLoad="window.document.getElementById('key_word').focus();window.document.getElementById('key_word').click();"> 
    <%this_page="search"%>   
	<!-- #include file="inc/top.asp" --> 
    
    
    	
    	
   
			<%if bbsset_search_hotword=1 then%>
          
            <div class="search_title"> 热搜</div>
            <div class="search_hot"> 
                
                <%
                sql="select top 10 * from BBS_Search order by search_times desc"
                set rs=bbsconn.execute(sql)
                i=1
                do while not rs.eof
                    search_word=rs("search_word")
                    %><a href="index.asp?key_word=<%=Server.UrlEncode(search_word)%>"><%=search_word%></a><%
                    i=i+1
                    if i>=10 then exit do
                rs.movenext
                loop
                %>
                
            </div>
            <%end if%>        

    
    <!-- #include file="inc/end.asp" -->     
        
        
	</body>

</html>