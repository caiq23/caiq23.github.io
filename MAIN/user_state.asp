     
     <%
	 if session_user_id=0 then
	 %>

     <div class="user_state"> 
     <form action="inc/chk_login.asp" method="post" name="login">
     <table>
  <tbody>
    <tr>
      
      <td width="70%" ><input name="user_num" placeholder="�û���" class="input_style" style="width:100%;"></td>
      <td width="30%" style="padding-left:10px;"><a href="<%=index_url%>r1.html">��ע��</a></td>
    </tr>
    <tr>
      
      <td>
      <input type="hidden" name="re_myurl" value="<%=myurl%>">      
      <input type="password" name="user_password" placeholder="����" class="input_style" style="width:100%;"></td>
      <td style="padding-left:10px;"><input type="submit" class="submit_style" value="��¼"></td>
    </tr>
  </tbody>
</table>     
	 </form>
     </div>
     


     <%if bbsset_open_qqlogin=1 then%>
         <div class="user_state_line"></div>
         <div class="user_state index_qqlogin">         
            <a href="<%=display_tlogin(1)%>"><img src="img/qq_login.gif"></a>
             <br>
             QQһ����¼
         </div>
     <%end if%>
     <%if bbsset_open_wxlogin=1 then%>
         <div class="user_state_line"></div>
         <div class="user_state index_qqlogin"> 
            <a href="<%=display_tlogin(2)%>"><img src="img/wx_login.gif"></a>
             <br>
             ΢��ɨһɨ��¼
         </div>
     <%end if%>
		<%
	 else
	 
	 %>
     
     <div class="bbs_user_login">
         <div class="user_login_float">
             <div class="top_user_ico"><img <%=get_userimg(session_user_id)%>></div>
         </div>
         <div class="user_login_float">
         	<div class="user_login_info">
         	<span class="user_login_info_title"><%=request.Cookies("xq_bbs")("user_num")%>��<%=request.Cookies("xq_bbs")("user_name")%>��</span>
            <br>
            
            <%
			my_alerts=0
			sql="select count(id) from BBS_Alert where alert_num2="& session_user_id &" and alert_state=1"			
			set rs=bbsconn.execute(sql)
			if not rs.eof then my_alerts=chk_num(rs(0))
			if my_alerts>0 then%> 
            <a href="<%=index_url%>a<%=session_user_id%>.html">�»ظ�( <font color="red"><%=my_alerts%></font> )</a><span class="user_login_info_line">&nbsp;&nbsp;|&nbsp;&nbsp;</span>
            <%end if%>
            <a href="<%=index_url%>u<%=session_user_id%>.html">�ҵ�����</a><span class="user_login_info_line">&nbsp;&nbsp;|&nbsp;&nbsp;</span>   
             <a href="<%=index_url%>e1.html">����</a><span class="user_login_info_line">&nbsp;&nbsp;|&nbsp;&nbsp;</span> 
            
             <%if session_admin_id>0 then%> 
             	<a href="admin/" target="_blank">����</a><span class="user_login_info_line">&nbsp;&nbsp;|&nbsp;&nbsp;</span> 
             <%end if%>           
             <a href="inc/logout.asp?myurl=<%=myurl%>">�˳�</a>
            </div> 
         </div>

     </div>
	 
	 <%
	 end if
	 %>  
        
      