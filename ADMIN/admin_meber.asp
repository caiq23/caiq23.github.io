<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/check_admin_session.asp" -->
<!-- #include file="../inc/fun-admin.asp" -->
<!Doctype html>
<html>
<%
		page_no=chk_num(trim_fun(request("page_no")))
		key_word=trim_fun(request("key_word"))
		dtfrom=trim_fun(request("dtfrom"))
		dtto=trim_fun(request("dtto"))
		see_type=chk_num(trim_fun(request("see_type")))

%>
<head>
<meta charset="gb2312">
<title>��Ա����</title>

	<link href="../inc/wdiii/common.css" rel="stylesheet">
   <link href="../inc/wdiii/table.css" rel="stylesheet">
   <script src="../inc/wdiii/index.js" type="text/javascript"></script>
   
   
   <script language="javascript" type="text/javascript" src="../inc/MyDate/WdatePicker.js"></script>
   
    

   
</head>



<body onload="setup();">
<%

sql="select * from BBS_User where 1=1"
  if len(key_word)>0 then sql=sql&" and (user_num like '%"& key_word &"%' or user_name like '%"& key_word &"%')"
  if see_type>0 then sql=sql&" and user_state="& see_type &""
  if len(dtfrom)>0 then sql=sql&" and user_addtime>='"& dtfrom &" 00:00:00'"
  if len(dtto)>0 then sql=sql&" and user_addtime<='"& dtto &" 24:00:00'"
  
  sql=sql&" order by id desc"
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
		end if
		allRecordCount=chk_num(allRecordCount)
		
		


	'ͳ�ƻ�Ա����
	sql_dl="select count(id) from BBS_User where 1=1"	
	set rs_dl=bbsconn.execute(sql_dl)
	all_order_0=chk_num(rs_dl(0))
	
	sql_dl="select count(id) from BBS_User where user_state=1"	
	set rs_dl=bbsconn.execute(sql_dl)
	all_order_1=chk_num(rs_dl(0))
	
	sql_dl="select count(id) from BBS_User where user_state=2"	
	set rs_dl=bbsconn.execute(sql_dl)
	all_order_2=chk_num(rs_dl(0))
	
	sql_dl="select count(id) from BBS_User where user_state=3"	
	set rs_dl=bbsconn.execute(sql_dl)
	all_order_3=chk_num(rs_dl(0))
	
	sql_dl="select count(id) from BBS_User where user_state=4"	
	set rs_dl=bbsconn.execute(sql_dl)
	all_order_4=chk_num(rs_dl(0))
	
	sql_dl="select count(id) from BBS_User where user_state=5"	
	set rs_dl=bbsconn.execute(sql_dl)
	all_order_5=chk_num(rs_dl(0))
	

		


		
%>




<div class="table-topmenu" >

    <div class="table-topmenu-left">
    <%if len(key_word)>0 or len(dtfrom)>0 or len(dtto)>0 then%>
        <a href="?" title="��������������" class="btn btn-gray">�������(<%=allRecordCount%>)</a>
        <%else%>
    	<a href="?see_type=0" class="btn <%if see_type=0 then %>btn-gray<%else%>btn-gray2<%end if%>">ȫ����Ա(<%=all_order_0%>)</a>
        <a href="?see_type=1" class="btn <%if see_type=1 then %>btn-gray<%else%>btn-gray2<%end if%>">������Ա(<%=all_order_1%>)</a>
        <a href="?see_type=2" class="btn <%if see_type=2 then %>btn-gray<%else%>btn-gray2<%end if%>">�ѽ���(<%=all_order_2%>)</a>
        <a href="?see_type=3" class="btn <%if see_type=3 then %>btn-gray<%else%>btn-gray2<%end if%>">������(<%=all_order_3%>)</a>
        <a href="?see_type=4" class="btn <%if see_type=4 then %>btn-gray<%else%>btn-gray2<%end if%>">VIP��Ա(<%=all_order_4%>)</a>
        <a href="?see_type=5" class="btn <%if see_type=5 then %>btn-gray<%else%>btn-gray2<%end if%>">��������(<%=all_order_5%>)</a>
        <%end if%>
        
    </div>
    
    <div class="table-topmenu-right">
    	

    </div>
    
</div>

<div class="search_form">
    <FORM class="form-inline" action="?" method="post">
        <table>
          <tbody>
            <tr>
              <th>��ʼ���ڣ�</th>
              <td>
              <input type="text" value="<%=dtfrom%>" name="dtfrom" onclick="WdatePicker({el:'dtfrom',skin:'whyGreen'})" class="form_datetime form-control" id="dtfrom" placeholder="��ʼʱ��" />              
              </td>
            </tr>
            <tr>
              <th>�������ڣ�</th>
              <td>              
              <input type="text" value="<%=dtto%>" name="dtto" onclick="WdatePicker({el:'dtto',skin:'whyGreen'})" class="form_datetime form-control" id="dtto" placeholder="����ʱ��" />
              </td>
            </tr>
            <tr>
              <th>�����ؼ��ʣ�</th>
              <td><input type="text" value="<%=key_word%>" name="key_word" class="form-control" placeholder="���������ؼ���" ></input></td>
            </tr>
            <tr>
              <td colspan="2" class="form_submit"><input type="submit"  class="btn btn-submit" value="��ѯ" title="��ѯ" /></td>
              </tr>
          </tbody>
        </table>   
    </FORM>
    
    
    
  <%
if len(key_word)>0 or len(dtfrom)>0 or len(dtto)>0 then
	%>
    <div id="alert-warning" class="alert alert-warning">
	
    <%if len(dtfrom)>0 then%>�� <span><%=dtfrom%></span> ��<%end if%>
    <%if len(dtto)>0 then%>�� <span><%=dtto%></span> ֹ��<%end if%>
    ������<%if len(key_word)>0 then%>
    ���� "<span><b><%=key_word%></b></span>" ��<%end if%>
	��Ա�� <span><%=allRecordCount%></span> ��
     <a href="javascript:void(0)" onClick="window.location.href='?'" class="close" title="�����������" >&times;</a>
    
    </div>
	<%
end if
%>  
    
    
</div>



    
   

    

    
    



   
<table class="table table-bordered table-hover table-responsive">
   <thead>
      <tr>
    <th>��</th>
    <th>�ʺ�</th>
    <th>����</th>
    <th>״̬</th>
    <th>������</th> 
    <th>�ظ���</th>    
    <th>ע��ʱ��</th>
    <th>����¼</th>
    <th>��¼��</th>
    <th>����</th>
      </tr>
   </thead>
   <tbody>


 
<% if rs.eof then%>
	<tr>
        <td colspan="10" style="height:500px; background-color:#fff; text-align:center;">
        	����ػ�Ա!
        </td>
    </tr>
    <%end if
  do while not rs.eof
  user_id=rs("user_id")
  
  'ͳ�ƻ�Ա������
  user_count_1=0
  sql_count="select count(id) from BBS_Topic where user_id="& user_id &" "
  set rs_count=bbsconn.execute(sql_count)
  if not rs_count.eof then user_count_1=chk_num(rs_count(0))
  user_count_2=0
  sql_count="select count(id) from BBS_Reply where user_id="& user_id &" "
  set rs_count=bbsconn.execute(sql_count)
  if not rs_count.eof then user_count_2=chk_num(rs_count(0))
  
  user_num=rs("user_num")
  user_name=rs("user_name")
  user_addtime=rs("user_addtime")
  lastlogin_time=rs("lastlogin_time")
  user_state=chk_num(rs("user_state"))
  login_times=chk_num(rs("login_times"))
  hy_do=""
  
  select case user_state
	  case 1
	  	hy_how="<font color=>����</font>"
		
		hy_do=hy_do&" <a class=""btn btn-info"" href=""../inc/admin_meber_check.asp?mydo=gag&modid="& user_id &""" onClick=""return makesure('�Ƿ��ֹ�û�Ա����?\n���Ժ�û�Ա��Ȼ���Ե�¼��������ӵȣ����޷���������');"" title=���Ի�Ա>����</a>"
		hy_do=hy_do&" <a class=""btn btn-info"" href=""../inc/admin_meber_check.asp?mydo=lock&modid="& user_id &""" onClick=""return makesure('�Ƿ������û�Ա����?\n������û�Ա�޷���¼���������������');"" title=������Ա>����</a>" 
		hy_do=hy_do&" <a class=""btn btn-info"" href=""../inc/admin_meber_check.asp?mydo=vip&modid="& user_id &""" onClick=""return makesure('�Ƿ���ΪVIP��Ա?\n���ú���Ҫ�������ð��ֻ��VIP��Ա���ܲ鿴');"" title=VIP��Ա>VIP</a>" 		 
		hy_do=hy_do&" <a class=""btn btn-info"" href=""../inc/admin_meber_check.asp?mydo=pass&modid="& user_id &""" onClick=""return makesure('�Ƿ��������û�Ϊ��������?\n�ɶ�ȫվ���ӽ��й���');"" title=��������>��������</a>"
		
	  case 2
	  	hy_how="<font color=red>�ѽ���</font>"
		 hy_do=hy_do&" <a class=""btn btn-success"" href=""../inc/admin_meber_check.asp?mydo=ungag&modid="& user_id &""" onClick=""return makesure('�Ƿ������Ըû�Ա?');"" title=�������>�������</a>" 
	  case 3
	  	hy_how="<font color=red>������</font>"	  
		hy_do=hy_do&" <a class=""btn btn-success"" href=""../inc/admin_meber_check.asp?mydo=unlock&modid="& user_id &""" onClick=""return makesure('�Ƿ��������û�Ա?');"" title=������Ա>�������</a>" 
	  case 5
	  	hy_how="<font color=green>��������</font>"	  
		hy_do=hy_do&" <a class=""btn btn-success"" href=""../inc/admin_meber_check.asp?mydo=unpass&modid="& user_id &""" onClick=""return makesure('�Ƿ�ȥ����������?');"" title=������Ա>ȥ����������</a>" 
	  case 4
	  	hy_how="<font color=blue>VIP</font>"	  
		hy_do=hy_do&" <a class=""btn btn-success"" href=""../inc/admin_meber_check.asp?mydo=unvip&modid="& user_id &""" onClick=""return makesure('�Ƿ�ȥ��VIP?');"" title=������Ա>ȥ��VIP</a>" 
  end select
  hy_do=hy_do&"<br><a href=""hyedit_gl.asp?mydo=mod&modid="& user_id &""" title=�޸Ļ�Ա���� class=""btn btn-warning"">�޸�</a> "
  hy_do=hy_do&"<a href=""../inc/admin_meber_check.asp?mydo=del_user_post&modid="& user_id &""" onClick=""return makesure('�Ƿ�ɾ���û�Ա���������������?\n�������û�Ա�����⡢�ظ�һ��ɾ��');"" class=""btn btn-danger"" title=ɾ������>ɾ��</a>"
  hy_do=hy_do&" <a href=""../inc/admin_meber_check.asp?mydo=del_user_img&modid="& user_id &""" onClick=""return makesure('ɾ�����û��ϴ�������ͼƬ?\n�������û�Ա��ͷ��һ��ɾ��');"" class=""btn btn-danger"" title=ɾ�����û������ϴ���ͼƬ>ɾͼ</a>" 
  hy_do=hy_do&" <a href=""../inc/admin_meber_check.asp?mydo=del_user&modid="& user_id &""" onClick=""return makesure('�Ƿ�ɾ���û�Ա?\n�������û�Ա�����⡢�ظ�һ��ɾ��');"" class=""btn btn-danger"" title=ɾ����Ա>ɾ��</a>" 
  %>
  


  
  <tr>
    <td><%=i+(page_no-1)*page_size%>&nbsp;</td>
    <td >
<%=user_num%>&nbsp;</td>
    <td><%=user_name%>&nbsp;</td>    
    <td><%=hy_how%>&nbsp;</td>
    <td><a href="admin_post.asp?see_user_id=<%=user_id%>" title="�鿴��������"><%=user_count_1%></a></td>
    <td><a href="admin_replay.asp?see_user_id=<%=user_id%>" title="�鿴�û�Ա����ظ�������"><%=user_count_2%></a></td>
    
    <td><%=howlong(user_addtime)%>&nbsp;</td>
    <td><%=howlong(lastlogin_time)%>&nbsp;</td>
    <td><%=login_times%>&nbsp;</td>
    <td align="right"><%=hy_do%></td>
  </tr>
  <%  
  if i>=page_size then exit do
  i=i+1
  rs.movenext
  loop
  

call display_blanktr(i,page_size,10)

  %>


   
   </tbody>
   

  <thead>
  	<tr>
        <th colspan="10" class="text-center">
        	
            <ul class="pagination">
               
            	<%=admin_page_no(page_no,pagecount,"key_word="& key_word &"&dtfrom="& dtfrom &"&dtto="& dtto &"&see_type="& see_type &"")%>
                
            </ul>
        </th>
    </tr>
  </thead>
  
  
</table>
 
  
</body>
</html>

