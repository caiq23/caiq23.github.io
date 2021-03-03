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
<title>会员管理</title>

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
			pagecount=rs.PageCount '获取总页码 
			if page_no<=0 then page_no=1 '判断 
			if page_no>pagecount then page_no=pagecount
			rs.AbsolutePage=page_no '设置本页页码 
			allRecordCount=rs.RecordCount
		end if
		allRecordCount=chk_num(allRecordCount)
		
		


	'统计会员数量
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
        <a href="?" title="点击清除搜索条件" class="btn btn-gray">搜索结果(<%=allRecordCount%>)</a>
        <%else%>
    	<a href="?see_type=0" class="btn <%if see_type=0 then %>btn-gray<%else%>btn-gray2<%end if%>">全部会员(<%=all_order_0%>)</a>
        <a href="?see_type=1" class="btn <%if see_type=1 then %>btn-gray<%else%>btn-gray2<%end if%>">正常会员(<%=all_order_1%>)</a>
        <a href="?see_type=2" class="btn <%if see_type=2 then %>btn-gray<%else%>btn-gray2<%end if%>">已禁言(<%=all_order_2%>)</a>
        <a href="?see_type=3" class="btn <%if see_type=3 then %>btn-gray<%else%>btn-gray2<%end if%>">已锁定(<%=all_order_3%>)</a>
        <a href="?see_type=4" class="btn <%if see_type=4 then %>btn-gray<%else%>btn-gray2<%end if%>">VIP会员(<%=all_order_4%>)</a>
        <a href="?see_type=5" class="btn <%if see_type=5 then %>btn-gray<%else%>btn-gray2<%end if%>">超级版主(<%=all_order_5%>)</a>
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
if len(key_word)>0 or len(dtfrom)>0 or len(dtto)>0 then
	%>
    <div id="alert-warning" class="alert alert-warning">
	
    <%if len(dtfrom)>0 then%>从 <span><%=dtfrom%></span> 起，<%end if%>
    <%if len(dtto)>0 then%>到 <span><%=dtto%></span> 止，<%end if%>
    搜索到<%if len(key_word)>0 then%>
    包含 "<span><b><%=key_word%></b></span>" 的<%end if%>
	会员共 <span><%=allRecordCount%></span> 人
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
    <th>主题数</th> 
    <th>回复数</th>    
    <th>注册时间</th>
    <th>最后登录</th>
    <th>登录数</th>
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
  user_id=rs("user_id")
  
  '统计会员发贴数
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
	  	hy_how="<font color=>正常</font>"
		
		hy_do=hy_do&" <a class=""btn btn-info"" href=""../inc/admin_meber_check.asp?mydo=gag&modid="& user_id &""" onClick=""return makesure('是否禁止该会员发言?\n禁言后该会员仍然可以登录、浏览帖子等，但无法发表帖子');"" title=禁言会员>禁言</a>"
		hy_do=hy_do&" <a class=""btn btn-info"" href=""../inc/admin_meber_check.asp?mydo=lock&modid="& user_id &""" onClick=""return makesure('是否锁定该会员发言?\n锁定后该会员无法登录、浏览、发表帖子');"" title=锁定会员>锁定</a>" 
		hy_do=hy_do&" <a class=""btn btn-info"" href=""../inc/admin_meber_check.asp?mydo=vip&modid="& user_id &""" onClick=""return makesure('是否设为VIP会员?\n设置后，需要另外设置版块只有VIP会员才能查看');"" title=VIP会员>VIP</a>" 		 
		hy_do=hy_do&" <a class=""btn btn-info"" href=""../inc/admin_meber_check.asp?mydo=pass&modid="& user_id &""" onClick=""return makesure('是否任命该用户为超级版主?\n可对全站帖子进行管理');"" title=超级版主>超级版主</a>"
		
	  case 2
	  	hy_how="<font color=red>已禁言</font>"
		 hy_do=hy_do&" <a class=""btn btn-success"" href=""../inc/admin_meber_check.asp?mydo=ungag&modid="& user_id &""" onClick=""return makesure('是否解除禁言该会员?');"" title=解除禁言>解除禁言</a>" 
	  case 3
	  	hy_how="<font color=red>锁定中</font>"	  
		hy_do=hy_do&" <a class=""btn btn-success"" href=""../inc/admin_meber_check.asp?mydo=unlock&modid="& user_id &""" onClick=""return makesure('是否解除锁定该会员?');"" title=解锁会员>解除锁定</a>" 
	  case 5
	  	hy_how="<font color=green>超级版主</font>"	  
		hy_do=hy_do&" <a class=""btn btn-success"" href=""../inc/admin_meber_check.asp?mydo=unpass&modid="& user_id &""" onClick=""return makesure('是否去除超级版主?');"" title=解锁会员>去除超级版主</a>" 
	  case 4
	  	hy_how="<font color=blue>VIP</font>"	  
		hy_do=hy_do&" <a class=""btn btn-success"" href=""../inc/admin_meber_check.asp?mydo=unvip&modid="& user_id &""" onClick=""return makesure('是否去除VIP?');"" title=解锁会员>去除VIP</a>" 
  end select
  hy_do=hy_do&"<br><a href=""hyedit_gl.asp?mydo=mod&modid="& user_id &""" title=修改会员资料 class=""btn btn-warning"">修改</a> "
  hy_do=hy_do&"<a href=""../inc/admin_meber_check.asp?mydo=del_user_post&modid="& user_id &""" onClick=""return makesure('是否删除该会员所发表的所有帖子?\n将会连该会员的主题、回复一起删除');"" class=""btn btn-danger"" title=删除帖子>删贴</a>"
  hy_do=hy_do&" <a href=""../inc/admin_meber_check.asp?mydo=del_user_img&modid="& user_id &""" onClick=""return makesure('删除该用户上传的所有图片?\n将会连该会员的头像一起删除');"" class=""btn btn-danger"" title=删除该用户所有上传的图片>删图</a>" 
  hy_do=hy_do&" <a href=""../inc/admin_meber_check.asp?mydo=del_user&modid="& user_id &""" onClick=""return makesure('是否删除该会员?\n将会连该会员的主题、回复一起删除');"" class=""btn btn-danger"" title=删除会员>删人</a>" 
  %>
  


  
  <tr>
    <td><%=i+(page_no-1)*page_size%>&nbsp;</td>
    <td >
<%=user_num%>&nbsp;</td>
    <td><%=user_name%>&nbsp;</td>    
    <td><%=hy_how%>&nbsp;</td>
    <td><a href="admin_post.asp?see_user_id=<%=user_id%>" title="查看他的主题"><%=user_count_1%></a></td>
    <td><a href="admin_replay.asp?see_user_id=<%=user_id%>" title="查看该会员参与回复的主题"><%=user_count_2%></a></td>
    
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

