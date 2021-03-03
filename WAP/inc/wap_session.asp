<%
user_id=chk_num(Request.Cookies("xq_bbs")("user_id"))
if user_id=0 then
%>
<script>
window.parent.location.href='<%=BBS_folder%>wap/login.asp';
</script>
<%
'response.Redirect("login.asp")
response.End()
end if

%>
