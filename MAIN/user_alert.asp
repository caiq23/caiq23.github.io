<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->
<!-- #include file="../inc/chk_session.asp" -->
<script src="inc/wdiii/index.js" type="text/javascript"></script>

	<div class="Board_top">
		�ҵ�����
    </div>
    <div style="clear:both;"></div>



</div>   

    
   <div class="Board_table">
 <table>
     <thead>
         <tr>
          <th>
          �ҵ�����
          <div style="float:right; padding-right:10px;"><a href="inc/delete_alert.asp" onClick="return makesure('�Ƿ��������?');">�������</a></div>
          </th>
        </tr>
     </thead>
  <tbody>
 
  <%
  
  
  call dperror("",0,session_user_id<>topic_no,"�ⲻ������ҳ�棬�뷵�ز鿴","?u"& session_user_id &".html")
  
  sql="select * from BBS_Alert where alert_num2="& session_user_id &" order by id desc"  
  set rs=server.CreateObject("adodb.recordset")
  rs.open sql,bbsconn,1,1
	page_size=bbsset_boardpagesize
	
	if not rs.eof then
		rs.PageSize=page_size		
		pagecount=rs.PageCount '��ȡ��ҳ�� 
		if page_no>pagecount then page_no=pagecount		
		rs.AbsolutePage=page_no '���ñ�ҳҳ�� 
		allRecordCount=rs.RecordCount
	else
		%>
		
		    <tr>
      <td colspan="1">��������!</td>
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
		
		
		'��ȡ
		topic_title="��ɾ������"
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
          �ظ�����������
          <%if alert_state=1 then response.Write("</b>")%>
          <a href="<%=index_url%>p<%=alert_about_id%>.html" target="_blank"><%=topic_title%></a> 
          <a href="<%=index_url%>p<%=alert_about_id%>.html" target="_blank">�鿴</a>
          
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

'����Ѷ�
if page_no=1 then
	sql="update BBS_Alert set alert_state=2 where alert_num2="& session_user_id &" and alert_state=1"
	set rs=bbsconn.execute(sql)
end if
%>
