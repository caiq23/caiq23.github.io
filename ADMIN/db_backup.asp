<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/check_admin_session.asp" -->
<!-- #include file="../inc/fun-admin.asp" -->
<!-- #include file="../inc/newfun_db.asp" -->
<html>
<head>
<title>���ݿⱸ��</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">   
<link href="../inc/wdiii/common.css" rel="stylesheet">
   <link href="../inc/wdiii/table.css" rel="stylesheet">
   <script src="../inc/wdiii/index.js" type="text/javascript"></script>
   
    

</head>
<%






page_no=chk_num(trim_fun(request("page_no")))
%>
<body>

<div class="table-topmenu" >

    <div class="table-topmenu-left">
    	<a class="btn btn-gray" href="javascript:void(0);">���ݿ��б�</a> 
        <a class="btn btn-gray2" href="db_backup_check.asp?mydo=db_backup&can_dbcounts=<%=can_dbcounts%>" title="�������ݿ�" onClick="return makesure('�����������ݿⱸ��\n����ѱ���������<%=can_dbcounts%>�ݣ�����ɾ����ɵ����ݿ⣡\n�ò����޷��ָ����Ƿ������');">�ֶ�����</a>          
        <a class="btn btn-gray2" href="db_backup_check.asp?mydo=db_clear&backup_date=<%=thistoday%>" title="����ռ����Ѿ�ʧЧ�����ݿ�" onClick="return makesure('���������Ѿ�ʧЧ�����ݿⱸ���ļ�\n����Ե�ǰ���ݿ����Ӱ�죬�Ƿ������');">����</a>
    </div>
    
    <div class="table-topmenu-right">
       *���ݿⱸ�ݺͻָ����ǲ��������������ǰ������ȷ�ϣ��������޷��ָ���
    </div>
    
</div>


    
    
   
<table class="table table-bordered table-hover table-responsive table-striped">
<thead>
          <tr> 
            <th>����</th>
            <th>�������</th>            
            <th>��Ա��</th>
            <th>������(�����ظ�)</th>
            <th>��������</th>
            <th>����ʱ��</th>
            <th>״̬</th>
            <th>����</th>            
          </tr>
          </thead>
          <%
		  sql="select * from BBS_Backup order by id desc"
		  set rs=server.CreateObject("adodb.recordset")
		  rs.open sql,bbsconn,1,1
		  i=1
  page_size=12
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
				<td colspan="8" style="height:500px; background-color:#fff; text-align:center;">
                	���ޱ��ݼ�¼�������ɾ������ݵĺ�ϰ��!
				
                </td>
			  </tr>
              </thead>
			<%
			end if
			%>
			<tbody>
			<%
			allRecordCount=chk_num(allRecordCount)
		  do while not rs.eof		  		
				backup_id=rs("id")
		  		backup_date=rs("backup_date")
				backup_type=chk_num(rs("backup_type"))
				post_count=chk_num(rs("post_count"))
				who_do="δ֪"
				select case backup_type
					case 1
						who_do="�ֶ�����"
					case 2
						who_do="�Զ�����"
				end select
				backup_time=rs("backup_time")
				user_count=rs("user_count")
				chk_dbstatus_html="δ֪"
				chk_dbstatus=chk_dbfile(backup_date,1)
				can_do=""
				if chk_dbstatus=true then
					chk_dbstatus_html="<font color=blue>���</font>"
					
					can_do="<a class=""btn btn-primary"" href=""db_backup_check.asp?mydo=db_recovery&backup_date="& backup_date &""" onClick=""return makesure('�����ָ����ݿ⣬�ָ��󣬵�ǰ���ݶ��ỹԭ���������ڵ����ݿ⡣\n�ָ��󣬽���ɾ�����ָ������ݿⱸ��\n���������ɳ������Ƿ������');"" title=�ָ��ñ���>�ָ�</a>"
					
				else
					chk_dbstatus_html="<font color=red>������</font>"
				end if
			  %>
			  <tr> 
				<td><%=i+(page_no-1)*page_size%></td>
				<td><%=backup_id%></td>
				<td><%=user_count%></td>
                <td><%=post_count%></td>
                <td><%=who_do%></td>
                <td><%=backup_time%></td>
                <td><%=chk_dbstatus_html%></td>
                <td><%=can_do%> <a class="btn btn-danger " href="db_backup_check.asp?mydo=db_del&backup_date=<%=backup_date%>" onClick="return makesure('����ɾ�������ݿⱸ��\n���������ɳ������Ƿ������');" title="ɾ���ñ���">ɾ��</a></td>
			  </tr>
			  <%
			  if i>page_size then exit do
			  i=i+1
			  rs.movenext
		  loop
		  

call display_blanktr(i,page_size,8)
		  %>
    
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
