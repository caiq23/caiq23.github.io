<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->
<script language="javascript" type="text/javascript" src="inc/main.js"></script>

	<div class="Board_top">
		<%select case topic_no
        case 1	
            response.Write("��������")
        case 2
            response.Write("���»ظ�")
        case 3
            response.Write("��������")
        case 4
            response.Write("��������")
        case 5
            response.Write("һ������")
        case 6
            response.Write("һ������")
		case 7
            response.Write("����ظ�")
        end select
        %>
    </div>
    <div style="clear:both;"></div>

<div class="topic_post">
<%if session_user_id>0 then
%><a href="<%=index_url%>n<%=now_board%>.html" title="������"><img src="img/pn_post.png"></a><%
else
%><a href="javascript:void(0);" onClick="display_login_div();" title="������"><img src="img/pn_post.png"></a><%
end if%>

</div>

</div>   
<div class="list_div">
<a href="<%=index_url%>t4.html" <%if topic_no=4 then response.Write(" id=""list_div_onselect""")%>>��������</a>
<a href="<%=index_url%>t7.html" <%if topic_no=7 then response.Write(" id=""list_div_onselect""")%>>����ظ�</a>
<a href="<%=index_url%>t1.html" <%if topic_no=1 then response.Write(" id=""list_div_onselect""")%>>��������</a>
<a href="<%=index_url%>t2.html" <%if topic_no=2 then response.Write(" id=""list_div_onselect""")%>>���»ظ�</a>
<a href="<%=index_url%>t3.html" <%if topic_no=3 then response.Write(" id=""list_div_onselect""")%>>��������</a>
<a href="<%=index_url%>t5.html" <%if topic_no=5 then response.Write(" id=""list_div_onselect""")%>>һ������</a>
<a href="<%=index_url%>t6.html" <%if topic_no=6 then response.Write(" id=""list_div_onselect""")%>>һ������</a>
</div>   
    
   <div class="Board_table">
 <table>
     <thead>
         <tr>
          <th width="60%">����</th>
          <th>����</th>
          <th>�ظ�/�鿴</th>
          <th>��󷢱�</th>
        </tr>
     </thead>
  <tbody>
 
  <%
  sql="select * from BBS_Topic where 1=1"
  
select case topic_no
	case 1
		sql=sql&" and topic_state=2"
		sql=sql&" order by id desc"	
	case 2
		sql=sql&" and topic_state=2 and not(len(lastreply_time)=0 and isnull(lastreply_time)) "
		sql=sql&" order by lastreply_time desc"	
	case 3
		sql=sql&" and topic_state=2"
		sql=sql&" order by replay_count desc"	
	case 4
		sql=sql&" and topic_state=1"
		sql=sql&" order by id desc"	
	case 5
		sql=sql&" and topic_state=2"
		sql=sql&" and datediff('d',topic_addtime,now())<=7"		
		sql=sql&" order by replay_count desc"	
	case 6
		sql=sql&" and topic_state=2"
		sql=sql&" and datediff('d',topic_addtime,now())<=30"		
		sql=sql&" order by replay_count desc"
	case 7
		sql=sql&" and topic_id in (select topic_id from BBS_Reply where topic_state=1)"
		sql=sql&" order by id desc"		
end select
'response.Write(sql)
  
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
      <td colspan="4">��������!</td>
      </tr>
		<%
	end if
	allRecordCount=chk_num(allRecordCount)
	i=1

  do while not rs.eof
		topic_id=rs("topic_id")
		topic_title=rs("topic_title")
		
		topic_state=chk_num(rs("topic_state"))
		topic_title=dis_posttitle(topic_title,topic_state)
		full_title=topic_title
		topic_title=left(topic_title,35)
		if instr(topic_title,keyword)>0 then topic_title=replace(topic_title,keyword,"<font style=color:red>"& keyword &"</font>")	
		topic_addtime=rs("topic_addtime")
		topic_seetimes=chk_num(rs("topic_seetimes"))
		replay_count=chk_num(rs("replay_count"))
		user_id=rs("user_id")
		user_name=chk_db("BBS_User","user_id",user_id,"user_name")
		
		
		'��ȡ���ظ�
		sql2="select top 1 * from BBS_Reply where topic_id="& topic_id &" order by id desc"
		set rs2=bbsconn.execute(sql2)
		re_user_id=0
		re_user_name=user_name
		re_topic_addtime=topic_addtime
		if not rs2.eof then
			re_user_id=chk_num(rs2("user_id"))	
			re_user_name=chk_db("BBS_User","user_id",re_user_id,"user_name")
			re_topic_addtime=rs2("reply_time")
		end if
  %>
		<tr>
		  <td class="board_topic_title"><a href="<%=index_url%>p<%=topic_id%>.html" title="<%=full_title%>">
		  <img src="img/folder_common.gif">
		  <%=topic_title%></a></td>
		  <td><a href="<%=index_url%>u<%=user_id%>.html"><%=user_name%></a><br><%=howlong(topic_addtime)%></td>
		  <td><%=replay_count%><br><%=topic_seetimes%></td>
		  <td><a href="<%=index_url%>u<%=re_user_id%>.html"><%=re_user_name%></a><br><%=howlong(re_topic_addtime)%></td>
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
