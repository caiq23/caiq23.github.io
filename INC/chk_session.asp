<%
if session_user_id=0 then
	response.Redirect(BBS_folder&"inc/logout.asp")
	response.End()
end if

%>