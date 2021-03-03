<div class="div_clear height_56"></div>
<div class="wap_bottom_bar">
    	<form id="reply_form" name="msg" method="post" action="../inc/chk_msg.asp">
        
<div class="wap_reply_bottom">
	<a href="index.asp?bt_show=3" style="float:left;" ><img src="img/back.png" height="25"></a>
    		<input type="submit" value="发表" class="wap_reply_submit">
        	<textarea class="wap_reply_textarea" onClick="this.style.height='75px'"  onBlur="if(this.value==''){this.style.height='30px'}" id="wap_reply_textarea" name="msg_content" placeholder="输入内容"></textarea>
            <input type="hidden" name="msg_num_2" value="<%=see_num%>">
            <input type="hidden" name="from_mobile" value="1">
            <input type="hidden" name="mydo" value="addok">
        	
</div>
        </form>

</div>
<div class="opacity_div opacity_div_bottom"></div> 