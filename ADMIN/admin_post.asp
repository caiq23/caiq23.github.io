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
		see_user_id=chk_num(trim_fun(request("see_user_id")))

%>
<head>
<meta charset="gb2312">
<title>���ӹ���</title>

	<link href="../inc/wdiii/common.css" rel="stylesheet">
   <link href="../inc/wdiii/table.css" rel="stylesheet">
   <script src="../inc/wdiii/index.js" type="text/javascript"></script>   
   
   <script language="javascript" type="text/javascript" src="../inc/MyDate/WdatePicker.js"></script>
   
       
</head>



<body onload="setup();">
<%

sql="select * from BBS_Topic where 1=1"
  if len(key_word)>0 then sql=sql&" and user_id in (select user_id from BBS_User where user_num='"& key_word &"' or user_name='"& key_word &"')"
  if see_type>0 then sql=sql&" and topic_state="& see_type &""
  if len(dtfrom)>0 then sql=sql&" and topic_addtime>='"& dtfrom &" 00:00:00'"
  if len(dtto)>0 then sql=sql&" and topic_addtime<='"& dtto &" 24:00:00'"
  if see_user_id>0 then sql=sql&" and user_id="& see_user_id &""
  
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
		
		


	'ͳ������
	sql_dl="select count(id) from BBS_Topic where 1=1"
	if see_user_id>0 then sql_dl=sql_dl&" and user_id="& see_user_id &""
	set rs_dl=bbsconn.execute(sql_dl)
	all_order_0=chk_num(rs_dl(0))
	
	sql_dl="select count(id) from BBS_Topic where topic_state=1"
	if see_user_id>0 then sql_dl=sql_dl&" and user_id="& see_user_id &""
	set rs_dl=bbsconn.execute(sql_dl)
	all_order_1=chk_num(rs_dl(0))
	
	sql_dl="select count(id) from BBS_Topic where topic_state=2"	
	if see_user_id>0 then sql_dl=sql_dl&" and user_id="& see_user_id &""
	set rs_dl=bbsconn.execute(sql_dl)
	all_order_2=chk_num(rs_dl(0))
	
	sql_dl="select count(id) from BBS_Topic where topic_state=3"	
	if see_user_id>0 then sql_dl=sql_dl&" and user_id="& see_user_id &""
	set rs_dl=bbsconn.execute(sql_dl)
	all_order_3=chk_num(rs_dl(0))
		
%>

<div class="table-topmenu" >

    <div class="table-topmenu-left">
    <%if len(key_word)>0 or len(dtfrom)>0 or len(dtto)>0 or see_user_id>0 then%>
        	<a href="?" title="��������������" class="btn btn-gray">�������(<%=allRecordCount%>)</a>
        <%else%>
            <a href="?see_user_id=<%=see_user_id%>&see_type=0" class="btn <%if see_type=0 then %>btn-gray<%else%>btn-gray2<%end if%>">ȫ������(<%=all_order_0%>)</a>
            <a href="?see_user_id=<%=see_user_id%>&see_type=1" class="btn <%if see_type=1 then %>btn-gray<%else%>btn-gray2<%end if%>">δ���(<%=all_order_1%>)</a>
            <a href="?see_user_id=<%=see_user_id%>&see_type=2" class="btn <%if see_type=2 then %>btn-gray<%else%>btn-gray2<%end if%>">�����(<%=all_order_2%>)</a>
            <a href="?see_user_id=<%=see_user_id%>&see_type=3" class="btn <%if see_type=3 then %>btn-gray<%else%>btn-gray2<%end if%>">������(<%=all_order_3%>)</a>
        <%end if%>
        
    </div>
    
    <div class="table-topmenu-right">
    	

    </div>
    
</div>

<div class="search_form">
    <FORM class="form-inline" action="?see_user_id=<%=see_user_id%>" method="post">
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
if len(key_word)>0 or len(dtfrom)>0 or len(dtto)>0 or see_user_id>0 then
	%>
    <div id="alert-warning" class="alert alert-warning">
	
    <%if len(dtfrom)>0 then%>�� <span><%=dtfrom%></span> ��<%end if%>
    <%if len(dtto)>0 then%>�� <span><%=dtto%></span> ֹ��<%end if%>
    ������
	<%if len(key_word)>0 then%>���� "<span><b><%=key_word%></b></span>" ��<%end if%>
    <%if see_user_id>0 then%><%=chk_db("BBS_User","user_id",see_user_id,"user_name")%> �����<%end if%>
	���ӹ� <span><%=allRecordCount%></span> ��
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
    <th>�鿴��</th> 
    <th>�ظ���</th>    
    <th>����ʱ��</th>
    <th style="text-align:left;">��������</th>
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
  topic_id=rs("topic_id")
  user_id=rs("user_id")
  
  sql_count="select * from BBS_User where user_id="& user_id &" "
  set rs_count=bbsconn.execute(sql_count)
  user_num=""
  user_name=""
  if not rs_count.eof then  
	  user_num=rs_count("user_num")
	  user_name=rs_count("user_name")
  end if
  
  topic_addtime=rs("topic_addtime")
  topic_state=chk_num(rs("topic_state"))
  topic_seetimes=chk_num(rs("topic_seetimes"))
  replay_count=chk_num(rs("replay_count"))
  topic_title=rs("topic_title")
  hy_do=""
  select case topic_state
	  case 1
	  	hy_how="<font color=red>δ���</font>"			
		hy_do=hy_do&" <a class=""btn btn-success"" href=""../inc/admin_post_check.asp?mydo=checked&modid="& topic_id &""" onClick=""return makesure('�Ƿ���˸�����?');"" title=���>���</a>"				 
	  case 2
	  	hy_how="<font color=green>����</font>"
		 hy_do=" <a class=""btn btn-info"" href=""../inc/admin_post_check.asp?mydo=masking&modid="& topic_id &""" onClick=""return makesure('�Ƿ����θ�����?\n���κ�����������޷��鿴�����ǻظ����ݻ����Ա����˲鿴');"" title=����>����</a>" 
	  case 3
	  	hy_how="<font color=blue>������</font>"	  
		hy_do="<a class=""btn btn-success"" href=""../inc/admin_post_check.asp?mydo=unmasking&modid="& topic_id &""" onClick=""return makesure('�Ƿ�������?');"" title=�������>�ָ�</a>" 
  end select
  hy_do=hy_do&" <a href=""../inc/admin_post_check.asp?mydo=del_topic&modid="& topic_id &""" onClick=""return makesure('�Ƿ�ɾ��������?\n�����������⡢�ظ�һ��ɾ��');"" class=""btn btn-danger"" title=ɾ������>ɾ����</a>" 
  %>
  


  
  <tr>
    <td><%=i+(page_no-1)*page_size%>&nbsp;</td>
    <td><%=user_num%>&nbsp;</td>
    <td><a href="?see_user_id=<%=user_id%>" title="�鿴��������"><%=user_name%></a></td>    
    <td><%=hy_how%>&nbsp;</td>
    <td><%=topic_seetimes%></td>
    <td><%=replay_count%></td>    
    <td><%=howlong(topic_addtime)%>&nbsp;</td>
    <td style="text-align:left; padding:0px;"><a href="../?p<%=topic_id%>.html" target="_blank" title="<%=topic_title%>"><%=left(topic_title,15)%></a>&nbsp;</td>
    <td><%=hy_do%></td>
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
            	<%=admin_page_no(page_no,pagecount,"see_user_id="& see_user_id &"&key_word="& key_word &"&dtfrom="& dtfrom &"&dtto="& dtto &"&see_type="& see_type &"")%>
            </ul>
        </th>
    </tr>
  </thead>
  
  
</table>
 
  
</body>
</html>

