<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/check_admin_session.asp" -->
<!-- #include file="../inc/fun-admin.asp" -->
<!-- #include file="../inc/newfun_db.asp" -->
<html>
<head>
<title>���ӹ���</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">   
<link href="../inc/wdiii/common.css" rel="stylesheet">
   <link href="../inc/wdiii/table.css" rel="stylesheet">
   <script src="../inc/wdiii/index.js" type="text/javascript"></script>
   
    

</head><body>
<%
page_no=chk_num(trim_fun(request("page_no")))
mydo=trim_fun(request("mydo"))
modid=chk_num(trim_fun(request("modid")))
%>


<div class="table-topmenu" >

    <div class="table-topmenu-left">
    	<a class="btn <%if len(mydo)=0 then %>btn-gray<%else%>btn-gray2<%end if%>" href="?">�����б�</a> 
        <a class="btn <%if len(mydo)>0 then %>btn-gray<%else%>btn-gray2<%end if%>" href="?mydo=add" title="��������">��������</a>
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
                <th align="left" width="30%">&nbsp;&nbsp;&nbsp;&nbsp;����������</th>
                <th align="left" width="70%"></th>             
            </tr>
        </thead>
        <tbody>
            <tr> 
                <td align="right">��������</td>
                <td align="left"><input type="text" name="link_title" class="form-control" placeholder="��������"></td>           </tr>
            <tr> 
                <td align="right">���ӵ�ַ</td>
                <td align="left"><input type="text" name="link_url" class="form-control" placeholder="���ӵ�ַ"></td>           </tr>
                
            <tr> 
                <td align="right"></td>
                <td align="left"><input type="submit" class="btn btn-submit" value="ȷ��"></td>           </tr>
        </tbody>
    </table>
</form>
<%
response.End()
case "addok"
	link_title=trim_fun(request("link_title"))
	link_url=trim_fun(request("link_url"))
	call dperror_admin(len(link_title)=0 or isnull(link_title),"���ⲻ��Ϊ��","")
	call dperror_admin(len(link_url)=0 or isnull(link_url),"��ַ����Ϊ��","")
	'��ȡ�������
	sql="select top 1 * from BBS_Link order by link_order desc"
	set rs=bbsconn.execute(sql)
	max_order=0
	if not rs.eof then max_order=chk_num(rs("link_order"))
	max_order=max_order+1
	sql="select * from BBS_Link where link_title='"& link_title &"' and link_url='"& link_url &"'"
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror_admin(not rs.eof,"�ظ�������","")
	rs.addnew
		rs("link_title")=link_title
		rs("link_url")=link_url
		rs("link_time")=thistime
		rs("link_order")=max_order
	rs.update
	call dperror_admin(true,"��ӳɹ�","?")
	response.End()
case "del"	
	call dperror_admin(modid<=0,"ID����","?")
	sql="delete * from BBS_Link where id="& modid &""
	set rs=bbsconn.execute(sql)
	call dperror_admin(true,"ɾ���ɹ�","?")
	response.End()
case "order"
	order_how=chk_num(trim_fun(request("order_how")))
	if order_how<=0 then order_how=1
	call dperror_admin(modid<=0,"ID����","?")
	
	'�ȶ���ԭ��������
	old_order=1
	sql="select * from BBS_Link where id="& modid &""
	set rs=bbsconn.execute(sql)	
	if not rs.eof then old_order=chk_num(rs("link_order"))
	
	new_order=1	
    if order_how=1 then
		'��ǰ
		sql="select top 1 * from BBS_Link where link_order>"& old_order &" order by link_order asc"
	else
		'�ź�
		sql="select top 1 * from BBS_Link where link_order<"& old_order &" order by link_order desc"
	end if
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	if not rs.eof then
		new_order=chk_num(rs("link_order"))
		rs("link_order")=old_order
		rs.update
	else
		new_order=old_order
	end if
	
	sql="update BBS_Link set link_order="& new_order &" where id="& modid &""
	set rs=bbsconn.execute(sql)
	call dperror_admin(true,"����ɹ�","?")
	response.End()
end select
%> 
    
   
<table class="table table-bordered table-hover table-responsive table-striped">
<thead>
          <tr> 
            <th>����</th>
            <th>����վ��</th>            
            <th>���ӵ�ַ</th>
            <th>���ʱ��</th>            
            <th>����</th>          
    </tr>
          </thead>
          <%
		  sql="select * from BBS_Link order by link_order desc"
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
                	��������!
				
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
		  		link_id=rs("id")
				link_title=rs("link_title")
				link_url=rs("link_url")
				link_time=rs("link_time")
				link_order=chk_num(rs("link_order"))
				
			  %>
			  <tr> 
				<td><%=i+(page_no-1)*page_size%></td>
				<td><%=link_title%></td>
				<td><%=link_url%></td>
                <td><%=link_time%></td>
                <td>
                <a href="?mydo=order&modid=<%=link_id%>&order_how=1" class="btn btn-info ">��ǰ</a>
				<a href="?mydo=del&modid=<%=link_id%>" class="btn btn-danger " onClick="return makesure('�Ƿ�ɾ�����޷��ָ�');">ɾ��</a>
				<a href="?mydo=order&modid=<%=link_id%>&order_how=2" class="btn btn-info ">�ź�</a>
                </td>               
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
