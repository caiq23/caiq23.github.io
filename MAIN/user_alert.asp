<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->
<!-- #include file="../inc/chk_session.asp" -->
<script src="inc/wdiii/index.js" type="text/javascript"></script>

	<div class="Board_top">
		我的提醒
    </div>
    <div style="clear:both;"></div>



</div>   

    
   <div class="Board_table">
 <table>
     <thead>
         <tr>
          <th>
          我的提醒
          <div style="float:right; padding-right:10px;"><a href="inc/delete_alert.asp" onClick="return makesure('是否清空提醒?');">清空提醒</a></div>
          </th>
        </tr>
     </thead>
  <tbody>
 
  <%
  
  
  call dperror("",0,session_user_id<>topic_no,"这不是您的页面，请返回查看","?u"& session_user_id &".html")
  
  sql="select * from BBS_Alert where alert_num2="& session_user_id &" order by id desc"  
  set rs=server.CreateObject("adodb.recordset")
  rs.open sql,bbsconn,1,1
	page_size=bbsset_boardpagesize
	
	if not rs.eof then
		rs.PageSize=page_size		
		pagecount=rs.PageCount '获取总页码 
		if page_no>pagecount then page_no=pagecount		
		rs.AbsolutePage=page_no '设置本页页码 
		allRecordCount=rs.RecordCount
	else
		%>
		
		    <tr>
      <td colspan="1">暂无提醒!</td>
      </tr>
		<%
	end if
	allRecordCount=chk_num(allRecordCount)
	i=1

  do while not rs.eof
		alert_num1=rs("alert_num1")
		alert_num2=rs("alert_num2")
		alert_about_id=rs("alert_about_id")
		alert_state=chk_num(rs("alert_state"))
		alert_time=howlong(rs("alert_time"))
		
		
		'读取
		topic_title="已删除帖子"
		sql2="select * from BBS_Topic where topic_id="& alert_about_id &""
		set rs2=bbsconn.execute(sql2)
		if not rs2.eof then
			topic_title=rs2("topic_title")
		end if
  %>
		<tr>
		  <td>
          <div class="alert_list_img top_user_ico">
          <a href="<%=index_url%>u<%=alert_num1%>.html" target="_blank"><img <%=get_userimg(alert_num1)%>></a>
          </div>
          <div id="alert_list_info" >
          <dl><%=alert_time%></dl>
          <br>
          <a href="<%=index_url%>u<%=alert_num1%>.html" target="_blank"><%=chk_db("BBS_User","user_id",alert_num1,"user_name")%></a> 
          <%if alert_state=1 then response.Write("<b>")%>
          回复了您的帖子
          <%if alert_state=1 then response.Write("</b>")%>
          <a href="<%=index_url%>p<%=alert_about_id%>.html" target="_blank"><%=topic_title%></a> 
          <a href="<%=index_url%>p<%=alert_about_id%>.html" target="_blank">查看</a>
          
          </div>
          </td>
		</tr>
    <%
	if i>=page_size then exit do
    i=i+1
	rs.movenext
	loop
	%>
    <tr>
      <td colspan="4"><ul class="pagination"><%=bbs_page_no(page_no,pagecount,"")%></ul></td>
      </tr>
    
  </tbody>
</table>

   </div>
<div style="clear:both;"></div>

<%

'标记已读
if page_no=1 then
	sql="update BBS_Alert set alert_state=2 where alert_num2="& session_user_id &" and alert_state=1"
	set rs=bbsconn.execute(sql)
end if
%>
