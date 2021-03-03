<%

	session("user_num")=""
	
	
	Response.Cookies("xq_bbs")("user_id")=""
	Response.Cookies("xq_bbs")("user_name")=""
	Response.Cookies("xq_bbs")("user_num")=""
	Response.Cookies("xq_bbs")("user_state")=""
	Response.Cookies("xq_bbs")("admin_id")=""
	
%>
<script>
parent.window.location.href='../';
</script>
<%
response.End()
%>