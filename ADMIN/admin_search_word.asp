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
<title>帖子管理</title>

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
			pagecount=rs.PageCount '获取总页码 
			if page_no<=0 then page_no=1 '判断 
			if page_no>pagecount then page_no=pagecount
			rs.AbsolutePage=page_no '设置本页页码 
			allRecordCount=rs.RecordCount
		end if
		allRecordCount=chk_num(allRecordCount)
		
		


	'统计数量
	sql_dl="select count(id) from BBS_Search where 1=1"
	set rs_dl=bbsconn.execute(sql_dl)
	all_order_0=chk_num(rs_dl(0))
		
%>

<div class="table-topmenu" >

    <div class="table-topmenu-left">
    <%if len(key_word)>0 or len(dtfrom)>0 or len(dtto)>0 or see_user_id>0 then%>
        	<a href="?" title="点击清除搜索条件" class="btn btn-gray">搜索结果(<%=allRecordCount%>)</a>
        <%else%>
            <a href="?" class="btn <%if len(mydo)=0 then %>btn-gray<%else%>btn-gray2<%end if%>">全部搜索词</a>            
        <%end if%>
        <a class="btn <%if mydo="add" then %>btn-gray<%else%>btn-gray2<%end if%>" href="?mydo=add" title="增加搜索词">增加搜索词</a>
        
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
                <th align="left" width="30%">&nbsp;&nbsp;&nbsp;&nbsp;增加新搜索词</th>
                <th align="left" width="70%"></th>             
            </tr>
        </thead>
        <tbody>
            <tr> 
                <td align="right">搜索词</td>
                <td align="left"><input type="text" name="search_word" class="form-control" placeholder="搜索词"></td>           </tr>
            <tr> 
                <td align="right">排序</td>
                <td align="left"><input type="text" name="search_times" class="form-control" placeholder="排序">（只能填写数字，数字越大越靠前）</td>           </tr>
                
            <tr> 
                <td align="right"></td>
                <td align="left"><input type="submit" class="btn btn-submit" value="确定"></td>           </tr>
        </tbody>
    </table>
</form>
<%
response.End()
case "addok"
	search_word=trim_fun(request("search_word"))
	search_times=chk_num(trim_fun(request("search_times")))
	call dperror_admin(len(search_word)=0 or isnull(search_word),"搜索词不能为空","")
	call dperror_admin(search_times<=0,"网址不能为空","")
	sql="select * from BBS_Search where search_word='"& search_word &"'"
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror_admin(not rs.eof,"重复的搜索词","")
	rs.addnew
		rs("search_word")=search_word
		rs("search_times")=search_times
	rs.update
	call dperror_admin(true,"添加成功","?")
	response.End()
case "del"	
	sql="delete * from BBS_Search where id="& modid &""
	set rs=bbsconn.execute(sql)
	call dperror_admin(true,"删除成功","?")

end select
%> 



<div class="search_form">
    <FORM class="form-inline" action="?" method="post">
        <table>
          <tbody>
            
            <tr>
              <th>包含关键词：</th>
              <td><input type="text" value="<%=key_word%>" name="key_word" class="form-control" placeholder="输入搜索关键词" ></input></td>
            </tr>
            <tr>
              <td colspan="2" class="form_submit"><input type="submit"  class="btn btn-submit" value="查询" title="查询" /></td>
              </tr>
          </tbody>
        </table>   
    </FORM>
    
    
    
  <%
if len(key_word)>0 or len(dtfrom)>0 or len(dtto)>0 or see_user_id>0 then
	%>
    <div id="alert-warning" class="alert alert-warning">    
    搜索到
	<%if len(key_word)>0 then%>包含 "<span><b><%=key_word%></b></span>" 的<%end if%>
    
	关键词共 <span><%=allRecordCount%></span> 条
     <a href="javascript:void(0)" onClick="window.location.href='?'" class="close" title="清除搜索条件" >&times;</a>
    
    </div>
	<%
end if
%>      
</div> 
   
<table class="table table-bordered table-hover table-responsive">
   <thead>
      <tr>
    <th>序</th>
    <th>搜索词</th>
    <th>排序</th>
    <th>操作</th>
      </tr>
   </thead>
   <tbody>


 
<% if rs.eof then%>
	<tr>
        <td colspan="10" style="height:500px; background-color:#fff; text-align:center;">
        	无相关会员!
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
    <td><a href="?mydo=del&modid=<%=search_word_id%>" onClick="return makesure('是否删除?');" class="btn btn-red" >删除</a></td>
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

