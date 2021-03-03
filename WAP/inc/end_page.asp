<div class="div_clear height_56"></div>
<div class="wap_bottom_bar">
<form id="reply_form" action="<%
		if session_user_id=0 then
			response.Write("login.asp")
		else
			response.Write("../inc/chk_replay.asp?from_mobile=1")
		end if%>" method="post" name="post_form">
<div class="wap_reply_bottom">
	 
    	<a href="index.asp" style="float:left;" ><img src="img/back.png" height="25"></a>
    	<input type="submit" value="回复" class="wap_reply_submit">
    	<textarea class="wap_reply_textarea"  onClick="<%
		if session_user_id=0 then
			response.Write("window.location.href='login.asp'")
		else
			response.Write("this.style.height='75px'")
		end if%>" onBlur="if(this.value==''){this.style.height='30px'}" id="wap_reply_textarea" name="topic_Content" placeholder="输入评论回复"></textarea>
        <input type="hidden" value="<%=topic_id%>" name="topic_id">
        <input type="hidden" value="0" id="quote_id" name="quote_id">
        
</div>
</form>  
</div>
<div class="opacity_div opacity_div_bottom"></div> 


