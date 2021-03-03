<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="inc/wap-fun.asp" -->
<!-- #include file="inc/wap_session.asp" -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="gb2312">
        <%
		board_no=chk_num(trim_fun(request("board_no")))
		%>
<title>发表新帖子 - <%=bbsset_sitename%></title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
        
        
        
        <link rel="stylesheet" href="inc/wap_css.css">
        
	</head>
<%this_page="post"%>
	<body id="iframe_body">

<link rel="stylesheet" href="inc/ios_css.css">        
	<!-- #include file="inc/top.asp" --> 
    <form name="login" method="post" action="../inc/chk_post.asp?from_mobile=1">
<div class="post_title">发表新帖子</div>
    <div class="info_div" style=" margin-top:0px;">
    	
        	<li><input name="topic_title" id="topic_title" placeholder="请输入标题" value="<%=session("topic_title")%>"></li>
            <li><select class="input_wap_select" name="board_id">
				<%call dis_shopclass(0,board_no)%>	
            </select></li>
            
            <li><textarea class="input_wap_post_textarea" id="input_wap_post_textarea" placeholder="请输入正文" name="topic_Content"><%=session("topic_Content")%></textarea></li>
            <input name="upload_img_list" id="upload_img_list" type="hidden">
</div>
 <div class="post_upload_img_list" id="post_upload_img_list"></div>
            
    <div class="info_div">  
    	<li>
            <div class="left">回帖仅作者可见</div>
            <div class="right"><div class="tg-list-item"><input name="replay_cansee" value="1" class="tgl tgl-ios" id="cb2" type="checkbox"><label class="tgl-btn" for="cb2"></label></div></div>
        </li>
    	<li>
            <div class="left">设置回复可见内容</div>
            <div class="right"><div class="tg-list-item"><input name="if_reply_cansee" value="1" class="tgl tgl-ios" id="cb3" type="checkbox" onClick="if(this.checked==true){document.getElementById('reply_cansee_div').style.display='block';}else{document.getElementById('reply_cansee_div').style.display='none';}"><label class="tgl-btn" for="cb3"></label></div></div>
        </li>

    </div>
    
    
    
          
    <div id="reply_cansee_div">
        <div class="title"></div>
        <textarea  name="reply_cansee_Content" placeholder="在这输入的内容，别人需回复才能查看。（也可在正文加标记 [hide] 隐藏内容 [/hide] ）"><%=session("reply_cansee_Content")%></textarea>
    </div>
        
            
            
            
        
       
   
    </div>

    
    <!-- #include file="inc/end.asp" -->     
        
       </form> 


</body>
</html>


<script type="text/javascript" src="inc/iframe_js.js"></script>
<script>display_iframe(2);</script>