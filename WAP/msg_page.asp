<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="inc/wap-fun.asp" -->


<%
see_num=trim_fun(request("see_num"))

html_title="查看消息"
call dperror_admin(len(see_num)=0,"请输入接收人帐号","")

	sql="select * from BBS_User where 1=1"
	if isnumeric(see_num) then
		sql=sql&" and (user_id="& see_num &" or user_num='"& see_num &"')"
	else
		sql=sql&" and user_num='"& see_num &"'"
	end if	
	set rs=bbsconn.execute(sql)
	call dperror_admin(rs.eof,"接收人帐号不存在","")
	see_num=chk_num(rs("user_id"))
	call dperror_admin(see_num=session_user_id,"接收人不能是自己","")
	see_hyname=rs("user_name")
	see_user_num=rs("user_num")
	html_title=see_hyname &"("& see_user_num &")"
	
	'更新已读
	sql="update bbs_msg set msg_state=1 where msg_num_1="& see_num &" and msg_num_2="& session_user_id &" and msg_state=0"
	set rs=bbsconn.execute(sql)

%>

<!doctype html>
<html>
<head>
<meta charset="gb2312">
<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name = "format-detection" content = "telephone=no">
<link rel="stylesheet" href="inc/wap_css.css">



<title><%=html_title%></title>
<body style="background-color:#f1f2f7;" onLoad="var h = document.documentElement.scrollHeight || document.body.scrollHeight;window.scrollTo(h,h);">
<%this_page="msg_page"%>



 <!-- #include file="inc/top.asp" -->

    
 <%
sql="select * from bbs_msg where 0=0"
sql=sql&" and ((msg_num_1="& see_num &" and msg_num_2="& session_user_id &") or (msg_num_2="& see_num &" and msg_num_1="& session_user_id &"))"
sql=sql&" order by id asc"
set rs=server.CreateObject("adodb.recordset")
rs.open sql,bbsconn,1,1
i=1
page_size=15
page_no=chk_num(trim_fun(request("page_no")))
if not rs.eof then
	rs.PageSize=page_size
	pagecount=rs.PageCount '获取总页码 
	if page_no<=0 then page_no=pagecount '判断 
	if page_no>pagecount then page_no=pagecount
	rs.AbsolutePage=page_no '设置本页页码 
	allRecordCount=rs.RecordCount
end if

response.Write(wap_page_no(page_no,pagecount,"see_num="& see_num &""))

  do while not rs.eof
  
		msg_id=rs("id")
		msg_num_1=chk_num(rs("msg_num_1"))
		msg_num_2=chk_num(rs("msg_num_2"))
		msg_time=rs("msg_time")		
		msg_content=rs("msg_content")
		call display_msg_page(msg_time,msg_num_1,session_user_id,msg_content)

		  if i>=page_size then exit do
		  i=i+1
		  rs.movenext
  loop
  %>


<!-- #include file="inc/end.asp" -->

</body>
</html>

<%
'显示对话框
sub display_msg_page(msg_time,msg_num_1,msg_num_2,msg_content)
	if msg_num_1<>msg_num_2 then
		this_temp_1="1"		
		this_temp_3="2"
	else
		this_temp_1="2"
		this_temp_3="1"
		this_temp_2=" style="" background-color:#12b8f6; color:#fff;"""
	end if
	
	sql_d="select * from BBS_User where user_id="& msg_num_1 &""
	set rs_d=bbsconn.execute(sql_d)
	if not rs_d.eof then
		d_hyname=rs_d("user_name")
		d_user_num=rs_d("user_num")
	end if
	
%>
	<div class="msg_page_div">
    	<div class="date"><%=howlong(msg_time)%></div>
    	<div class="msgpage_img msg_div_<%=this_temp_1%>"><img class="user" <%=get_userimg(msg_num_1)%>></div>        
        <div class="msgpage_box msg_div_<%=this_temp_3%>">
            <div class="box_title_<%=this_temp_1%>"><div class="box_title_span"><%=d_user_num%></div><%=d_hyname%></div>
            <div class="box_msg" <%=this_temp_2%>><%=msg_content%></div>
            <div class="msg_<%=this_temp_1%>"><img src="img/msg_<%=this_temp_1%>.png"></div>
        </div>        
        <div class="clear_both"></div>
    </div>
<%end sub%>