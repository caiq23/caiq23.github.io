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
<title>帖子管理</title>

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
			pagecount=rs.PageCount '获取总页码 
			if page_no<=0 then page_no=1 '判断 
			if page_no>pagecount then page_no=pagecount
			rs.AbsolutePage=page_no '设置本页页码 
			allRecordCount=rs.RecordCount
		end if
		allRecordCount=chk_num(allRecordCount)
		
		


	'统计数量
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
        	<a href="?" title="点击清除搜索条件" class="btn btn-gray">搜索结果(<%=allRecordCount%>)</a>
        <%else%>
            <a href="?see_user_id=<%=see_user_id%>&see_type=0" class="btn <%if see_type=0 then %>btn-gray<%else%>btn-gray2<%end if%>">全部贴子(<%=all_order_0%>)</a>
            <a href="?see_user_id=<%=see_user_id%>&see_type=1" class="btn <%if see_type=1 then %>btn-gray<%else%>btn-gray2<%end if%>">未审核(<%=all_order_1%>)</a>
            <a href="?see_user_id=<%=see_user_id%>&see_type=2" class="btn <%if see_type=2 then %>btn-gray<%else%>btn-gray2<%end if%>">已审核(<%=all_order_2%>)</a>
            <a href="?see_user_id=<%=see_user_id%>&see_type=3" class="btn <%if see_type=3 then %>btn-gray<%else%>btn-gray2<%end if%>">已屏蔽(<%=all_order_3%>)</a>
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
              <th>开始日期：</th>
              <td>
              <input type="text" value="<%=dtfrom%>" name="dtfrom" onclick="WdatePicker({el:'dtfrom',skin:'whyGreen'})" class="form_datetime form-control" id="dtfrom" placeholder="开始时间" />              
              </td>
            </tr>
            <tr>
              <th>结束日期：</th>
              <td>              
              <input type="text" value="<%=dtto%>" name="dtto" onclick="WdatePicker({el:'dtto',skin:'whyGreen'})" class="form_datetime form-control" id="dtto" placeholder="结束时间" />
              </td>
            </tr>
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
	
    <%if len(dtfrom)>0 then%>从 <span><%=dtfrom%></span> 起，<%end if%>
    <%if len(dtto)>0 then%>到 <span><%=dtto%></span> 止，<%end if%>
    搜索到
	<%if len(key_word)>0 then%>包含 "<span><b><%=key_word%></b></span>" 的<%end if%>
    <%if see_user_id>0 then%><%=chk_db("BBS_User","user_id",see_user_id,"user_name")%> 发表的<%end if%>
	帖子共 <span><%=allRecordCount%></span> 条
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
    <th>帐号</th>
    <th>姓名</th>
    <th>状态</th>
    <th>查看数</th> 
    <th>回复数</th>    
    <th>发表时间</th>
    <th style="text-align:left;">帖子内容</th>
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
	  	hy_how="<font color=red>未审核</font>"			
		hy_do=hy_do&" <a class=""btn btn-success"" href=""../inc/admin_post_check.asp?mydo=checked&modid="& topic_id &""" onClick=""return makesure('是否审核该帖子?');"" title=审核>审核</a>"				 
	  case 2
	  	hy_how="<font color=green>正常</font>"
		 hy_do=" <a class=""btn btn-info"" href=""../inc/admin_post_check.asp?mydo=masking&modid="& topic_id &""" onClick=""return makesure('是否屏蔽该帖子?\n屏蔽后该帖子主题无法查看，但是回复内容还可以被他人查看');"" title=屏蔽>屏蔽</a>" 
	  case 3
	  	hy_how="<font color=blue>屏蔽中</font>"	  
		hy_do="<a class=""btn btn-success"" href=""../inc/admin_post_check.asp?mydo=unmasking&modid="& topic_id &""" onClick=""return makesure('是否解除屏蔽?');"" title=解除屏蔽>恢复</a>" 
  end select
  hy_do=hy_do&" <a href=""../inc/admin_post_check.asp?mydo=del_topic&modid="& topic_id &""" onClick=""return makesure('是否删除该主题?\n将会连该主题、回复一起删除');"" class=""btn btn-danger"" title=删除主题>删主题</a>" 
  %>
  


  
  <tr>
    <td><%=i+(page_no-1)*page_size%>&nbsp;</td>
    <td><%=user_num%>&nbsp;</td>
    <td><a href="?see_user_id=<%=user_id%>" title="查看他的主题"><%=user_name%></a></td>    
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

