<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->



<div class="list_div">
<a href="<%=index_url%>m1.html" <%if topic_no=1 then response.Write(" id=""list_div_onselect""")%>>����ע��</a>
<a href="<%=index_url%>m2.html" <%if topic_no=2 then response.Write(" id=""list_div_onselect""")%>>�����¼</a>
<a href="<%=index_url%>m3.html" <%if topic_no=3 then response.Write(" id=""list_div_onselect""")%>>��Ծ�û�</a>
<a href="<%=index_url%>m4.html" <%if topic_no=4 then response.Write(" id=""list_div_onselect""")%>>С����</a>
<a href="<%=index_url%>m8.html" <%if topic_no=8 then response.Write(" id=""list_div_onselect""")%>>VIP�û�</a>
<a href="<%=index_url%>m5.html" <%if topic_no=5 then response.Write(" id=""list_div_onselect""")%>>��������</a>
<a href="<%=index_url%>m6.html" <%if topic_no=6 then response.Write(" id=""list_div_onselect""")%>>��ͷ��</a>
<a href="<%=index_url%>m7.html" <%if topic_no=7 then response.Write(" id=""list_div_onselect""")%>>��ݵ�¼</a>
</div> 

   <div class="Board_table user_table">
 <table>
     <thead>
         <tr>
          <th>��</th>
          <th>�û�ͷ��</th>
          <th>�û��ǳ�</th>
          <th>��¼�ʺ�</th>          
          <th>�ʻ�״̬</th>
          <th>ע��ʱ��</th>          
          <th>����¼</th>
          <th>�ܵ�¼����</th>
          <th>������</th>
        </tr>
     </thead>
  <tbody>
  
<%
sql="select * from BBS_User where 1=1"
select case topic_no
	case 1
		sql=sql&" order by id desc"
	case 2
		sql=sql&" order by lastlogin_time desc"
	case 3
		sql=sql&" order by login_times desc"
	case 4
		sql=sql&" and (user_state=2 or user_state=3) order by id desc"
	case 5
		sql=sql&" and user_state=5 order by id desc"
	case 6
		sql=sql&" and len(user_img)>0 order by id desc"
	case 7
		sql=sql&" and len(qq_OpenID)>0 order by id desc"
	case 8
		sql=sql&" and user_state=4 order by id desc"
end select
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
		%><tr><td colspan="9">��������û�!</td></tr><%
	end if
	allRecordCount=chk_num(allRecordCount)
	i=1
  do while not rs.eof
    user_id=rs("user_id")
  	user_num=rs("user_num")
	user_num_html=user_num
	user_num_html=replace(user_num_html&"++",right(user_num_html,2)&"++","**")
	user_name=rs("user_name")
	user_addtime=howlong(rs("user_addtime"))
	lastlogin_time=howlong(rs("lastlogin_time"))
	user_state=chk_num(rs("user_state"))	
	user_state_html=""
	select case user_state
		case 1	
			user_state_html="����"
		case 2	
			user_state_html="<font color=red>�ѽ���</font>"
		case 3	
			user_state_html="<font color=blue>������</font>"
		case 4	
			user_state_html="<font color=green>VIP</font>"
		case 5	
			user_state_html="<font color=green>��������</font>"
	end select
	login_times=chk_num(rs("login_times"))
	'��ȡ�û�Ա�ܷ�����
	myallpost_count=0
	sql_count="select count(id) from BBS_Topic where user_id="& user_id &""
	set rs_count=bbsconn.execute(sql_count)
	myallpost_count=myallpost_count+rs_count(0)
	sql_count="select count(id) from BBS_Reply where user_id="& user_id &""
	set rs_count=bbsconn.execute(sql_count)
	myallpost_count=myallpost_count+rs_count(0)
  %>
    <tr>
      <td><%=i+(page_no-1)*page_size%></td>
      <td><div class="top_user_ico"><a href="<%=index_url%>u<%=user_id%>.html"><img <%=get_userimg(user_id)%>></a></div></td>
      <td><%=user_name%></td>
      <td><%=user_num_html%></td>      
      <td><%=user_state_html%></td>
      <td><%=user_addtime%></td>      
      <td><%=lastlogin_time%></td>
      <td><%=login_times%></td>
      <td><a href="<%=index_url%>u<%=user_id%>.html"><%=myallpost_count%></a></td>
    </tr>
    <%
	if i>=page_size then exit do
    i=i+1
	rs.movenext
	loop
	%>
    <tr>
      <td colspan="9"><ul class="pagination"><%=bbs_page_no(page_no,pagecount,"")%></ul></td>
      </tr>
    
  </tbody>
</table>

   </div>
<div style="clear:both;"></div>
