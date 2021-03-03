<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="inc/wap-fun.asp" -->
<!doctype html>
<html>
<head>
<meta charset="gb2312">
<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name = "format-detection" content = "telephone=no">
<link rel="stylesheet" href="inc/wap_css.css">


<%
html_title="消息列表"
%>
<title><%=html_title%></title>
<body id="iframe_body">
<%this_page="msg"%>
<!-- #include file="inc/top.asp" -->

    
 <%
 
sql="select * from bbs_msg a where not exists (select id from bbs_msg b where ((a.msg_num_1=b.msg_num_1 and a.msg_num_2=b.msg_num_2) or (a.msg_num_1=b.msg_num_2 and a.msg_num_2=b.msg_num_1)) and a.id<b.id)"
sql=sql&" and (msg_num_1="& session_user_id &" or msg_num_2="& session_user_id &")"
if len(key_word)>0 then sql=sql&" and msg_title like '%"& key_word &"%'"
if len(dtfrom)>0 then sql=sql&" and msg_time>='"& dtfrom &"'"
if len(dtto)>0 then sql=sql&" and msg_time<='"& dtto &"'"
sql=sql&" order by id desc "

set rs=server.CreateObject("adodb.recordset")
rs.open sql,bbsconn,1,1
i=1

page_size=15
if not rs.eof then
	rs.PageSize=page_size
	pagecount=rs.PageCount
	if page_no<=0 then page_no=1
	if page_no>pagecount then page_no=pagecount
	rs.AbsolutePage=page_no '设置本页页码 
	allRecordCount=rs.RecordCount
end if
allRecordCount=chk_num(allRecordCount)
%>   
    


    
    	<%
			if page_no=1 then
		%>
    		<div class="msg_add">
            	<div class="title">新消息</div>
            	<form name="msg_add" method="post" action="msg_page.asp">
                <input class="input" name="see_num" type="search" placeholder="输入发送对象(登录账号/用户ID)">
                <div class="clear_both"></div>           	
                </form>	
            </div>	
    	<%	
		end if%>
    



<div class="msg_div_title">消息列表</div>
<div class="msg_div">


<%	
if rs.eof then
%><li>暂无消息!</li><%  
end if	
all_my_not_read=0
  do while not rs.eof
	
	
		re_content=rs("msg_content")
		re_msg_num_1=rs("msg_num_1")
		if session_user_id=re_msg_num_1 then re_msg_num_1=rs("msg_num_2")
		re_msg_time=rs("msg_time")
		
	sql_d="select * from BBS_User where user_id="& re_msg_num_1 &""
	set rs_d=bbsconn.execute(sql_d)
	if not rs_d.eof then
		this_hyname=rs_d("user_name")
		this_user_num=rs_d("user_num")
	end if
	sql_d="select count(id) from BBS_Msg where msg_num_1="& re_msg_num_1 &" and msg_num_2="& session_user_id &" and msg_state=0"
	set rs_d=bbsconn.execute(sql_d)
	my_not_read=rs_d(0)
	my_not_read=chk_num(my_not_read)
	all_my_not_read=all_my_not_read+my_not_read
		
		%>
	<li onClick="window.location.href='msg_page.asp?see_num=<%=re_msg_num_1%>'">
    	<div class="left"><img <%=get_userimg(re_msg_num_1)%>></div>
      <div class="left">
        	<div class="title"><%=this_hyname%></div>
            <div class="content"><%=re_content%></div>            
        </div>
      <div class="right">
            <div class="date"><%=howlong(re_msg_time)%></div> 
            <%if my_not_read>0 then%><div class="num"><%=my_not_read%></div><%end if%>        
        </div>
        <div class="clear_both"></div>
    </li>
<%	

if i>=page_size then exit do
		  i=i+1
		  rs.movenext
  loop
  %>
	

    
    
    
</div>
<%=wap_page_no(page_no,pagecount,"key_word="& key_word &"&dtfrom="& dtfrom &"&dtto="& dtto &"&see_type="& see_type &"")%>



</body>
</html>
<script type="text/javascript" src="inc/iframe_js.js"></script>
<script>display_iframe(3);</script>