<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/check_admin_session.asp" -->
<!-- #include file="../inc/fun-admin.asp" -->
<!Doctype html>
<html>
<%
		page_no=chk_num(trim_fun(request("page_no")))
		key_word=trim_fun(request("key_word"))
		mydo=trim_fun(request("mydo"))
		modid=chk_num(trim_fun(request("modid")))
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


sql="select * from BBS_Search where 1=1"
  if len(key_word)>0 then sql=sql&" and search_word like '%"& key_word &"%'"
  
  sql=sql&" order by search_times desc"
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
	sql_dl="select count(id) from BBS_Search where 1=1"
	set rs_dl=bbsconn.execute(sql_dl)
	all_order_0=chk_num(rs_dl(0))
		
%>

<div class="table-topmenu" >

    <div class="table-topmenu-left">
    <%if len(key_word)>0 or len(dtfrom)>0 or len(dtto)>0 or see_user_id>0 then%>
        	<a href="?" title="��������������" class="btn btn-gray">�������(<%=allRecordCount%>)</a>
        <%else%>
            <a href="?" class="btn <%if len(mydo)=0 then %>btn-gray<%else%>btn-gray2<%end if%>">ȫ��������</a>            
        <%end if%>
        <a class="btn <%if mydo="add" then %>btn-gray<%else%>btn-gray2<%end if%>" href="?mydo=add" title="����������">����������</a>
        
    </div>
    
    <div class="table-topmenu-right">
    	

    </div>
    
</div>


<%






select case mydo
case "add"
%>
<form name="form" method="post" action="?mydo=addok">
    <table class="table table-bordered table-responsive">
        <thead>
            <tr> 
                <th align="left" width="30%">&nbsp;&nbsp;&nbsp;&nbsp;������������</th>
                <th align="left" width="70%"></th>             
            </tr>
        </thead>
        <tbody>
            <tr> 
                <td align="right">������</td>
                <td align="left"><input type="text" name="search_word" class="form-control" placeholder="������"></td>           </tr>
            <tr> 
                <td align="right">����</td>
                <td align="left"><input type="text" name="search_times" class="form-control" placeholder="����">��ֻ����д���֣�����Խ��Խ��ǰ��</td>           </tr>
                
            <tr> 
                <td align="right"></td>
                <td align="left"><input type="submit" class="btn btn-submit" value="ȷ��"></td>           </tr>
        </tbody>
    </table>
</form>
<%
response.End()
case "addok"
	search_word=trim_fun(request("search_word"))
	search_times=chk_num(trim_fun(request("search_times")))
	call dperror_admin(len(search_word)=0 or isnull(search_word),"�����ʲ���Ϊ��","")
	call dperror_admin(search_times<=0,"��ַ����Ϊ��","")
	sql="select * from BBS_Search where search_word='"& search_word &"'"
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror_admin(not rs.eof,"�ظ���������","")
	rs.addnew
		rs("search_word")=search_word
		rs("search_times")=search_times
	rs.update
	call dperror_admin(true,"��ӳɹ�","?")
	response.End()
case "del"	
	sql="delete * from BBS_Search where id="& modid &""
	set rs=bbsconn.execute(sql)
	call dperror_admin(true,"ɾ���ɹ�","?")

end select
%> 



<div class="search_form">
    <FORM class="form-inline" action="?" method="post">
        <table>
          <tbody>
            
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
    ������
	<%if len(key_word)>0 then%>���� "<span><b><%=key_word%></b></span>" ��<%end if%>
    
	�ؼ��ʹ� <span><%=allRecordCount%></span> ��
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
    <th>������</th>
    <th>����</th>
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
  
  search_word=rs("search_word")
  search_word_id=rs("id")
  search_times=chk_num(rs("search_times"))
  %>
  


  
  <tr>
    <td><%=i+(page_no-1)*page_size%>&nbsp;</td>
    <td><%=search_word%>&nbsp;</td>
    <td><%=search_times%></td>     
    <td><a href="?mydo=del&modid=<%=search_word_id%>" onClick="return makesure('�Ƿ�ɾ��?');" class="btn btn-red" >ɾ��</a></td>
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

