<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/check_admin_session.asp" -->
<!-- #include file="../inc/fun-admin.asp" -->
<!-- #include file="../inc/newfun_db.asp" -->
<html>
<head>
<title>数据库备份</title>
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
    	<a class="btn btn-gray" href="javascript:void(0);">数据库列表</a> 
        <a class="btn btn-gray2" href="db_backup_check.asp?mydo=db_backup&can_dbcounts=<%=can_dbcounts%>" title="备份数据库" onClick="return makesure('即将进行数据库备份\n如果已备份数大于<%=can_dbcounts%>份，将会删除最旧的数据库！\n该操作无法恢复，是否继续！');">手动备份</a>          
        <a class="btn btn-gray2" href="db_backup_check.asp?mydo=db_clear&backup_date=<%=thistoday%>" title="清理空间里已经失效的数据库" onClick="return makesure('即将清理已经失效的数据库备份文件\n不会对当前数据库产生影响，是否继续！');">清理</a>
    </div>
    
    <div class="table-topmenu-right">
       *数据库备份和恢复都是不可逆操作，操作前请再三确认，操作后无法恢复！
    </div>
    
</div>


    
    
   
<table class="table table-bordered table-hover table-responsive table-striped">
<thead>
          <tr> 
            <th>排序</th>
            <th>备份序号</th>            
            <th>会员数</th>
            <th>帖子数(包含回复)</th>
            <th>操作类型</th>
            <th>备份时间</th>
            <th>状态</th>
            <th>管理</th>            
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
			pagecount=rs.PageCount '获取总页码 
			if page_no<=0 then page_no=1 '判断 
			if page_no>pagecount then page_no=pagecount
			rs.AbsolutePage=page_no '设置本页页码 
			allRecordCount=rs.RecordCount
		else
			%><thead>
			<tr> 
				<td colspan="8" style="height:500px; background-color:#fff; text-align:center;">
                	暂无备份记录，请养成经常备份的好习惯!
				
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
				who_do="未知"
				select case backup_type
					case 1
						who_do="手动备份"
					case 2
						who_do="自动备份"
				end select
				backup_time=rs("backup_time")
				user_count=rs("user_count")
				chk_dbstatus_html="未知"
				chk_dbstatus=chk_dbfile(backup_date,1)
				can_do=""
				if chk_dbstatus=true then
					chk_dbstatus_html="<font color=blue>完好</font>"
					
					can_do="<a class=""btn btn-primary"" href=""db_backup_check.asp?mydo=db_recovery&backup_date="& backup_date &""" onClick=""return makesure('即将恢复数据库，恢复后，当前数据都会还原到备份日期的数据库。\n恢复后，将会删除所恢复的数据库备份\n本操作不可撤消，是否继续！');"" title=恢复该备份>恢复</a>"
					
				else
					chk_dbstatus_html="<font color=red>不存在</font>"
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
                <td><%=can_do%> <a class="btn btn-danger " href="db_backup_check.asp?mydo=db_del&backup_date=<%=backup_date%>" onClick="return makesure('即将删除该数据库备份\n本操作不可撤消，是否继续！');" title="删除该备份">删除</a></td>
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
