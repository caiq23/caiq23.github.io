<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->



<%
goto_url=session("goto_url")
session("goto_url")=""
disinfo=session("disinfo")
if len(goto_url)=0 then goto_url=BBS_folder
if len(disinfo)=0 then disinfo="�����ɹ�"
%>

<div class="dis_error_div">
<div class="dis_error_img"><img src="img/error.gif"></div>
<div class="dis_error_text"><%=disinfo%><br>
<a href="<%=goto_url%>">������������û���Զ���ת������������</a>
</div>
</div>

<div style="clear:both;"></div>

<script type="text/javascript" language="javascript">
 function reloadyemian()
{ 
window.location.href="<%=goto_url%>"; 
} 
 window.setTimeout("reloadyemian();",3000); 
</script> 