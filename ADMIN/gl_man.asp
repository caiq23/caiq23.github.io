<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/check_admin_session.asp" -->
<!-- #include file="../inc/fun-admin.asp" -->
<%

mydo=trim_fun(request("mydo"))
admin_num=trim_fun(request("admin_num"))
admin_name=trim_fun(request("admin_name"))
admin_pw=trim_fun(request("admin_pw"))
user_id=trim_fun(request("user_id"))
modid=chk_num(trim_fun(request("modid")))
page_no=chk_num(trim_fun(request("page_no")))

select case mydo
	case "del"
dperror_admin_doing="ɾ������Ա"

		call dperror_admin(modid=0,"��ȡ����Ա��Ϣ���������µ�¼���ٲ���","")
		'��������һ������Ա������ɾ��
		sql="select count(id) from BBS_Admin"
		set rs=bbsconn.execute(sql)
		if not rs.eof then all_glcount=rs(0)
		all_glcount=chk_num(all_glcount)
		call dperror_admin(all_glcount=1,"����ɾ�����һ������Ա","")
		'����ɾ���Լ�
		sql="select id from BBS_Admin where id="& modid &" and admin_num='"& session("admin_num") &"'"
		set rs=bbsconn.execute(sql)
		call dperror_admin(not rs.eof,"����ɾ���Լ�","")
		sql="delete * from BBS_Admin where id="& modid &""
		set rs=bbsconn.execute(sql)
call dperror_admin(true,"ɾ���ɹ�","?")
	case "addok"
dperror_admin_doing="��ӹ���Ա"
call dperror_admin(len(admin_num)=0 or isnull(admin_num),"�ʺŲ���Ϊ�գ�����","")
call dperror_admin(len(admin_pw)=0 or isnull(admin_pw),"���벻��Ϊ�գ�����","")

		user_id=get_hy_id(user_id,admin_num)
		sql="select * from BBS_Admin where admin_num='"& admin_num &"'"
		set rs=server.CreateObject("adodb.recordset")
		rs.open sql,bbsconn,1,3
		call dperror_admin(not rs.eof,"�õ�¼�ʺ��Ѿ����ظ�������","")
		rs.addnew
			rs("admin_num")=admin_num
			rs("admin_pw")=admin_pw
			rs("admin_addtime")=thistime
			rs("admin_name")=admin_name
			rs("user_id")=user_id
		rs.update
call dperror_admin(true,"���ӳɹ�","?")
	case "mod"
		sql="select * from BBS_Admin where id="& modid &""
		set rs=server.CreateObject("adodb.recordset")
		rs.open sql,bbsconn,1,1
		call dperror_admin(rs.eof,"��ȡ����Ա��Ϣ���������µ�¼���ٲ���","")
			admin_num=rs("admin_num")
			admin_pw=rs("admin_pw")
			admin_name=rs("admin_name")
			user_id=rs("user_id")
			
				sql_hy="select * from BBS_User where user_id="& user_id &""
				set rs_hy=bbsconn.execute(sql_hy)
				user_num=""
				user_name=""
				if not rs_hy.eof then
					user_num=rs_hy("user_num")
					user_name=rs_hy("user_name")
				end if
				
	case "modok"
dperror_admin_doing="�޸Ĺ���Ա"
		user_id=get_hy_id(user_id,admin_num)
		sql="select * from BBS_Admin where id="& modid &""
		set rs=server.CreateObject("adodb.recordset")
		rs.open sql,bbsconn,1,3
		call dperror_admin(rs.eof,"��ȡ����Ա��Ϣ���������µ�¼���ٲ���","")
			rs("admin_num")=admin_num
			rs("admin_pw")=admin_pw
			rs("admin_name")=admin_name
			rs("user_id")=user_id
		rs.update
call dperror_admin(true,"�޸ĳɹ�","")
end select




%>

<html>
<head>
<title>����Ա��Ϣ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

	<link href="../inc/wdiii/common.css" rel="stylesheet">
   <link href="../inc/wdiii/table.css" rel="stylesheet">
   <script src="../inc/wdiii/index.js" type="text/javascript"></script>
   
   
   <script language="javascript" type="text/javascript" src="../inc/MyDate/WdatePicker.js"></script>
   
    

</head>

<body>

<div class="table-topmenu" >

    <div class="table-topmenu-left">
         <A href="?" class="btn <%if see_type=0 and (len(mydo)=0 or isnull(mydo)) then %>btn-gray<%else%>btn-gray2<%end if%>" title="����Ա�б�">����Ա�б�</A>
        <A href="?mydo=add" class="btn <%if mydo<>"add" then %>btn-gray2<%else%>btn-gray<%end if%>" title="��������Ա">��������Ա</A> 

    </div>
    
    <div class="table-topmenu-right">
    
    </div>
    
</div>

   

	<table class="table table-bordered table-hover table-responsive table-striped">
    <thead>
          <tr> 
            <th>���</th>
            <th>����Ա����</th>            
            <th>��¼�ʺ�</th>
            <th>��¼����</th>
            <th>����ʱ��</th>
            <th>����¼</th>
            <th>��Ӧ��Ա</th>
            <th>����</th>            
          </tr>
          </thead>
          <%
		  select case true
		  case mydo="mod" or mydo="add"
		  		if mydo="add" then
					admin_num=""
					admin_pw=""
					admin_name=""
				end if
		  		if len(admin_addtime)=0 or isnull(admin_addtime) then admin_addtime=thistime
				%>
                <form action="?mydo=<%=mydo%>ok&modid=<%=modid%>" name="form1" method="post">
                    <tr style="height:50px; background-color:#fff;"> 
                        <td>1</td>
                        <td><input class="form-control" placeholder="����" name="admin_name" value="<%=admin_name%>"></td>
                        <td><input class="form-control" placeholder="��¼�ʺ�" name="admin_num" value="<%=admin_num%>"></td>
                        <td><input class="form-control" placeholder="����" name="admin_pw" type="password" value="<%=admin_pw%>"></td>
                        <td><%=howlong(admin_addtime)%></td>
                        <td><%=howlong(admin_addtime)%></td>
                        <td><input class="form-control" placeholder="��Ա��¼�ʺ�" name="user_id" value="<%=user_num%>">
                        </td>
                        <td><input class="btn btn-primary" type="submit" name="Submit" value="ȷ��">
                        </td>               
                    </tr>
                    <tr style="height:450px; background-color:#fff;"> 
                        <td colspan="6">
                        </td>
                    </tr>
				</form>
		 <%case else
		  
		  
		  sql="select * from BBS_Admin where 1=1"
		  if mydo="mod" and modid>0 then sql=sql&" and id="& modid &""
		  sql=sql&" order by id asc"
		  set rs=server.CreateObject("adodb.recordset")
		  rs.open sql,bbsconn,1,1
		  i=1
	 		 page_size=15
			if not rs.eof then
				rs.PageSize=page_size
				pagecount=rs.PageCount '��ȡ��ҳ�� 
				if page_no<=0 then page_no=1 '�ж� 
				if page_no>pagecount then page_no=pagecount
				rs.AbsolutePage=page_no '���ñ�ҳҳ�� 
				allRecordCount=rs.RecordCount
			else
			%><thead>
			<tr> 
				<td colspan="6">
                	���޹���Ա
				
                </td>
			  </tr>
              </thead>
			<%
			end if
			%><tbody><%				
		  do while not rs.eof
		  		admin_id=rs("id")
		  		admin_num=rs("admin_num")
				admin_pw=rs("admin_pw")
				admin_addtime=rs("admin_addtime")
				admin_lastlogin=rs("admin_lastlogin")
				admin_name=rs("admin_name")
				user_id=rs("user_id")
				sql_hy="select * from BBS_User where user_id="& user_id &""
				set rs_hy=bbsconn.execute(sql_hy)
				user_num="��"
				user_name="-"
				if not rs_hy.eof then
					user_num=rs_hy("user_num")
					user_name=rs_hy("user_name")
				end if
				if mydo<>"mod" and mydo<>"add" then
					  %>
					  <tr> 
						<td><%=i+(page_no-1)*page_size%></td>
						<td><%=admin_name%></td>
						<td><%=admin_num%></td>
						<td>***</td>                        
						<td><%=howlong(admin_addtime)%></td>
                        <td><%=howlong(admin_lastlogin)%></td>
                        <td><%=user_num%>��<%=user_name%>��</td>
						<td><a class="btn btn-warning" href="?mydo=mod&modid=<%=admin_id%>" title="�޸Ĺ���Ա��Ϣ">�޸�</a>
						<a class="btn btn-danger" href="?mydo=del&modid=<%=admin_id%>" onClick="return makesure('����ɾ���ù���Ա\n���������ɳ������Ƿ������');" title="ɾ���ù���Ա">ɾ��</a>
                        
						</td>               
					  </tr>
					  <%
				  end if
				  i=i+1
				  if i>=page_size then exit do
				  rs.movenext
		  loop
		  
call display_blanktr(i,page_size,6)
		  %>


		  
		  <%
		 end select%>
         
         </tbody>
         
   
  <thead>
  	<tr>
        <td colspan="6" class="text-center">
            <ul class="pagination">
            	<%=admin_page_no(page_no,pagecount,"key_word="& key_word &"&dtfrom="& dtfrom &"&dtto="& dtto &"&see_type="& see_type &"")%>
            </ul>
        </td>
    </tr>
  </thead>
  
         

     </table>

</body>
</html>
