<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/check_admin_session.asp" -->
<!-- #include file="../inc/fun-admin.asp" -->
<%
page_no=chk_num(trim_fun(request("page_no")))
board_can_post=chk_num(trim_fun(request("board_can_post")))
board_cansee=chk_num(trim_fun(request("board_cansee")))
if board_can_post<1 then board_can_post=1
mydo=trim_fun(request("mydo"))
modid=chk_num(trim_fun(request("modid")))
board_name=trim_fun(request("board_name"))
board_demo=trim_fun(request("board_demo"))
board_law=request("board_law")
board_belong=chk_num(trim_fun(request("board_belong")))
see_level=chk_num(trim_fun(request("see_level")))
if see_level<=0 then see_level=1
see_belong=chk_num(trim_fun(request("see_belong")))
board_index=chk_num(trim_fun(request("board_index")))
board_list=chk_num(trim_fun(request("board_list")))
if board_list<=0 then board_list=1

select case mydo
	case "order"
		order_how=chk_num(trim_fun(request("order_how")))
		call dperror_admin(modid=0,"读取版块信息出错，请重新登录后再操作","")
		call dperror_admin(order_how<1,"操作出错，请重新登录后再操作","")
		sql="select * from BBS_Board where board_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_admin(rs.eof,"读取版块出错","?see_level=0")
		old_board_order=chk_num(rs("board_order"))
		board_belong=chk_num(rs("board_belong"))
		if order_how=1 then
			sql="select top 1 * from BBS_Board where board_order>"& old_board_order &" and board_belong="& board_belong &" order by board_order asc"
		else
			sql="select top 1 * from BBS_Board where board_order<"& old_board_order &" and board_belong="& board_belong &" order by board_order desc"
		end if
		set rs=server.CreateObject("adodb.recordset")
		rs.open sql,bbsconn,1,3
		if not rs.eof then
			new_board_order=chk_num(rs("board_order"))
			rs("board_order")=old_board_order
			rs.update
		else
			new_board_order=old_board_order
		end if
		sql="update BBS_Board set board_order="& new_board_order &" where board_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_admin(true,"排序成功","?see_belong="&board_belong)
		
	case "del"
		call dperror_admin(modid=0,"读取版块信息出错，请重新登录后再操作","")	
		sql="select * from BBS_Board where board_belong="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_admin(not rs.eof,"该版块存在下级版块，请先删除下级版块再操作","?see_level=0")
		sql="select * from BBS_Topic where board_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_admin(not rs.eof,"该版块存在产品，请先删除产品再操作","?see_level=0")
		sql="select * from BBS_Board where board_id="& modid &""
		set rs=server.CreateObject("adodb.recordset")
		rs.open sql,bbsconn,1,3
		call dperror_admin(rs.eof,"读取出错，请重新登录后操作","?see_level=0")
		board_belong=chk_num(rs("board_belong"))
		rs.delete
		rs.update
		call dperror_admin(true,"删除成功","?see_belong="&board_belong)
	case "addok"
		call dperror_admin(len(board_name)=0 or isnull(board_name),"版块名称不能为空","?see_level=0")
		call dperror_admin(board_list<=0,"子版块列数必须大于0","")
		call dperror_admin(board_list>6,"子版块列数不能大于6","")
		
		this_board_order=0
		sql="select max(board_order) from BBS_Board where board_belong="& board_belong &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then this_board_order=chk_num(rs(0))
		this_board_order=this_board_order+1
				
		board_level=0
		sql="select * from BBS_Board where board_id="& board_belong &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then board_level=rs("board_level")
		board_level=chk_num(board_level)+1
		board_id=0
		sql="select max(board_id) from BBS_Board"
		set rs=bbsconn.execute(sql)
		if not rs.eof then board_id=rs(0)
		board_id=chk_num(board_id)+1
		sql="select * from BBS_Board where board_name='"& board_name &"' and board_level="& board_level &" and board_belong="& board_belong &""
		set rs=server.CreateObject("adodb.recordset")
		rs.open sql,bbsconn,1,3
		call dperror_admin(not rs.eof,"版块名称有相同，请检查","")		
		rs.addnew
			rs("board_name")=board_name
			rs("board_demo")=board_demo	
			rs("board_law")=board_law		
			rs("board_level")=board_level
			rs("board_belong")=board_belong
			rs("board_id")=board_id
			rs("board_can_post")=board_can_post	
			rs("board_order")=this_board_order	
			rs("board_cansee")=board_cansee	
			rs("board_list")=board_list	
			
		rs.update
		call dperror_admin(true,"添加成功","?see_belong="&board_belong)
	case "modok"
		call dperror_admin(modid=0,"读取版块信息出错，请重新登录后再操作","")	
		call dperror_admin(board_list<=0,"子版块列数必须大于0","")
		call dperror_admin(board_list>6,"子版块列数不能大于6","")		
		call dperror_admin(len(board_name)=0 or isnull(board_name),"版块名称不能为空","?see_level=0")
		board_level=0
		this_board_order=1
		sql="select * from BBS_Board where board_id="& board_belong &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then
			board_level=chk_num(rs("board_level"))
			this_board_order=chk_num(rs("board_order"))
		end if
		board_level=board_level+1
		sql="select * from BBS_Board where board_name='"& board_name &"' and board_level="& board_level &" and board_belong="& board_belong &" and board_id<>"& modid &""
		set rs=bbsconn.execute(sql)
		call dperror_admin(not rs.eof,"版块名称有相同，请检查","")
		
		old_board_belong=0
		
		
		sql="select * from BBS_Board where board_id="& modid &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then old_board_belong=chk_num(rs("board_belong"))
		if board_belong<>old_board_belong then
			this_board_order=0
			sql="select max(board_order) from BBS_Board where board_belong="& board_belong &""
			set rs=bbsconn.execute(sql)
			if not rs.eof then this_board_order=chk_num(rs(0))
			this_board_order=this_board_order+1
		end if
		
		sql="select * from BBS_Board where board_id="& modid &""
		set rs=server.CreateObject("adodb.recordset")
		rs.open sql,bbsconn,1,3
		call dperror_admin(rs.eof,"读取版块信息出错，请重新登录后再操作","")
			rs("board_name")=board_name
			rs("board_demo")=board_demo
			rs("board_law")=board_law	
			rs("board_belong")=board_belong
			rs("board_level")=board_level
			rs("board_can_post")=board_can_post	
			'rs("board_order")=this_board_order
			rs("board_index")=board_index
			rs("board_cansee")=board_cansee	
			rs("board_list")=board_list	
			
		rs.update
		call dperror_admin(true,"修改成功","?see_belong="&board_belong)
end select

%>

<html>
<head>
<title>主题版块</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">




	<link href="../inc/wdiii/common.css" rel="stylesheet">
   <link href="../inc/wdiii/table.css" rel="stylesheet">
   <script src="../inc/wdiii/index.js" type="text/javascript"></script>
   
   
   
	<link rel="stylesheet" href="../inc/qingeditor/themes/default/default.css" />
	<link rel="stylesheet" href="../inc/qingeditor/plugins/code/prettify.css" />
	<script charset="gb2312" src="../inc/qingeditor/qingeditor-all.js"></script>
	<script charset="gb2312" src="../inc/qingeditor/lang/zh-CN.js"></script>
	<script charset="gb2312" src="../inc/qingeditor/plugins/code/prettify.js"></script>
	<script>
		qingeditor.ready(function(K) {
			var editor1 = K.create('textarea[name="board_law"]', {
				cssPath : '../inc/qingeditor/plugins/code/prettify.css',
				uploadJson : '../inc/qingeditor/asp/upload_json.asp',
				fileManagerJson : '../inc/qingeditor/asp/file_manager_json.asp',
				allowFileManager : true,
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						K('form[name=post_form]')[0].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						K('form[name=post_form]')[0].submit();
					});
				}
			});
			prettyPrint();
		});
	</script>


</head>

<body>

<div class="table-topmenu" >

    <div class="table-topmenu-left">
      <A href="?" class="btn btn-gray" >版块列表</A> 
    </div>
    
    <div class="table-topmenu-right">
    
<A href="?mydo=add&board_belong=<%=see_belong%>" class="btn btn-success" title="增加新版块">新版块</A>
    </div>
    
</div>

<%
select case mydo
case "mod","add"
	mydohtml="新增"
	

	if mydo="mod" then
		call dperror_admin(modid=0,"读取版块信息出错，请重新登录后再操作","")
		sql="select * from BBS_Board where board_id="& modid &""		
		set rs=bbsconn.execute(sql)
		call dperror_admin(rs.eof,"读取版块信息出错，请重新登录后再操作","")
		board_name=rs("board_name")
		board_demo=rs("board_demo")
		board_law=rs("board_law")
		board_img=rs("board_img")
		board_id=chk_num(rs("board_id"))
		board_belong=chk_num(rs("board_belong"))
		board_level=chk_num(rs("board_level"))
		board_index=chk_num(rs("board_index"))
		board_cansee=chk_num(rs("board_cansee"))
		board_list=chk_num(rs("board_list"))
		board_can_post=rs("board_can_post")	
		mydohtml="修改"
	end if
	%>
	<form action="?mydo=<%=mydo%>ok&modid=<%=modid%>" name="post_form" method="post">
   <table class="table table-bordered table-hover table-responsive">
   <thead>
        <tr> 
        	<th colspan="2"><%=mydohtml%>版块</th>
        </tr>
    </thead>
        <tr> 
            <td><div align="right">版块名称:&nbsp;</div></td>
            <td><div align="left">
              &nbsp;<input class="form-control" name="board_name" value="<%=board_name%>">
            </div></td>
        </tr>
        <%if mydo="mod" then%>
        <tr> 
            <td><div align="right">版块图标:&nbsp;</div></td>
            <td><div align="left"><br>
              <img src="<%=board_img%>" id="board_img" style="cursor:pointer" title="点击更换" width="40" height="40" onerror="this.src='../img/forum_new.gif'" onClick="document.getElementById('uploadpic_iframe').contentWindow.document.getElementById('file1').click();">
              <iframe id="uploadpic_iframe" name="uploadpic_iframe" src="../main/upload_pic.asp?upload_type=3&pic_size=500&modid=<%=board_id%>" style="display:none"></iframe>
              <input class="form-control" name="board_img" type="hidden" value="<%=board_img%>">
              <br>点击图标可以更换，最合适规格是40*40像素
            </div></td>
        </tr>
        <%end if%>
        <tr> 
            <td><div align="right">子版块列数:&nbsp;</div></td>
            <td><div align="left">
              &nbsp;<input class="form-control" name="board_list" value="<%=board_list%>">(默认为1)
            </div></td>
        </tr>
        <tr> 
            <td><div align="right">是否在导航中显示:&nbsp;</div></td>
            <td><div align="left">
             &nbsp;<select class="form-control" name="board_index">
                         <option value="0"  >否</option>
                         <option value="1"  <%if board_index=1 then response.Write(" selected")%> >是</option>
                     </select>
            </div></td>
        </tr>
        <tr> 
            <td><div align="right">谁能发贴:&nbsp;</div></td>
            <td><div align="left">
             &nbsp;<select class="form-control" name="board_can_post">
                         <option value="1"  >所有人能发贴</option>
                         <option value="2" <%if board_can_post=2 then response.Write(" selected")%>  >VIP/超级版主/管理员</option>
                         <option value="3"  <%if board_can_post=3 then response.Write(" selected")%> >超级版主/管理员</option>
                         <option value="4" <%if board_can_post=4 then response.Write(" selected")%>  >管理员</option>
						 <option value="10" <%if board_can_post=10 then response.Write(" selected")%> >禁止发贴</option>
                     </select>
            </div></td>
        </tr>
        <tr> 
            <td><div align="right">谁能看贴:&nbsp;</div></td>
            <td><div align="left">
             &nbsp;<select class="form-control" name="board_cansee">
                         <option value="0"  >所有人能看贴</option>
                         <option value="1" <%if board_cansee=1 then response.Write(" selected")%>   >登录后的用户</option>
                         <option value="2" <%if board_cansee=2 then response.Write(" selected")%>  >VIP/超级版主/管理员</option>
                         <option value="3"  <%if board_cansee=3 then response.Write(" selected")%> >超级版主/管理员</option>
                         <option value="4" <%if board_cansee=4 then response.Write(" selected")%>  >管理员</option>
                     </select>
            </div></td>
        </tr>        
        <tr> 
            <td><div align="right">所属版块:&nbsp;</div></td>
            <td><div align="left">
             &nbsp;<select class="form-control" name="board_belong">
                         <option value="0"  >顶级版块</option>
						 <%call dis_shopclass(0,board_belong)%>                         
                     </select>
            </div></td>
        </tr>
        <tr> 
            <td><div align="right">版块简介:&nbsp;</div></td>
            <td><div align="left">
             &nbsp;<textarea class="input_style" name="board_demo" style="  color:#000; width:50%; margin:auto; height:50px;"><%=board_demo%></textarea>
            </div></td>
        </tr>
        <tr> 
            <td><div align="right">版规:&nbsp;</div></td>
            <td><div align="left">
             &nbsp;
             <textarea class="input_style" cols="50" role="50" name="board_law" style="  color:#000; width:70%; margin:auto; height:300px;"><%=board_law%></textarea>
            </div></td>
        </tr>
       
			<tr> 
            <td></td>
            <td style="text-align:left;">
           <input type="submit" class="btn btn-primary" value="确定">
            </td>
        </tr>
    		<tr><th colspan="2"></th></tr>
     </table>
				</form>
<%
case else
%>
	<table class="table table-bordered table-hover table-responsive">
    <thead>
          <tr>
            
            <th align="left" style="padding-left:20px;">版块名称</th>
            <th>图标</th>
            <th>主题总数</th>
            <th>谁能发贴</th>            
            <th>谁能看贴</th>
            <th>版块级别</th>
            <th>管理</th>
          </tr>
        </thead>
<%loop_i=chk_num(see_level)

	call dis_class_table(0)

%>
    		
</table>
<%end select%>
</body>
</html>
<%

sub dis_class_table(see_belong)
		  dim sql,rs,board_belong
		  sql="select * from BBS_Board where 1=1 "
		  sql=sql&" and board_belong="& see_belong &""
		  sql=sql&" order by board_order desc"
		  
		  set rs=server.CreateObject("adodb.recordset")
		  rs.open sql,bbsconn,1,3
		  i=1	  
		  page_size=10
		  do while not rs.eof		  		
		  		board_id=rs("board_id")				
		  		board_name=rs("board_name")				
				board_demo=rs("board_demo")
				board_img=rs("board_img")
				board_belong=chk_num(rs("board_belong"))
				board_level=chk_num(rs("board_level"))
				'response.Write("blank_i_board_level="&blank_i_board_level&"<br>")
				'response.Write("board_level="&board_level&"<br>")
				'response.Write("blank_i="&blank_i&"<br>")
				'response.Write("<br>")
				for n_i=2 to board_level
					board_name="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"&board_name
				next
				board_can_post=chk_num(rs("board_can_post"))				
				board_can_post_html="未知"
				select case board_can_post
					case 1
						board_can_post_html="<font color=blue>所有人</font>"
					case 2
						board_can_post_html="<font color=green>VIP/超级版主/管理员</font>"
					case 3
						board_can_post_html="<font color=green>超级版主/管理员</font>"
					case 4
						board_can_post_html="<font color=green>管理员</font>"					
					case 10
						board_can_post_html="<font color=red>禁止发贴</font>"
				end select	
				board_cansee=chk_num(rs("board_cansee"))				
				board_cansee_html="未知"
				select case board_cansee
					case 0
						board_cansee_html="<font color=blue>所有人</font>"
					case 1
						board_cansee_html="<font color=green>登录后</font>"	
					case 2
						board_cansee_html="<font color=green>VIP/超级版主/管理员</font>"
					case 3
						board_cansee_html="<font color=green>超级版主/管理员</font>"
					case 4
						board_cansee_html="<font color=green>管理员</font>"	
				end select			
				if loop_i=0 then loop_i=board_level
				board_belong_html=""
				board_belong_board_id=0
				if board_belong>0 then
					sql_belong="select * from BBS_Board where board_id="& board_belong &""
					set rs_belong=bbsconn.execute(sql_belong)
					if not rs_belong.eof then
						board_belong_html=rs_belong("board_name")
						board_belong_board_id=rs_belong("board_id")
					end if
				end if
				board_belong_board_id_2=0
				if board_belong_board_id>0 then
					sql_belong="select * from BBS_Board where board_id="& board_belong_board_id &""
					set rs_belong=bbsconn.execute(sql_belong)
					if not rs_belong.eof then
						board_belong_board_id_2=rs_belong("board_belong")
					end if
				end if
				board_belong_board_id_2=chk_num(board_belong_board_id_2)


				'统计全部有多少个下属主题
				have_board_belong=0
					sql_belong="select count(id) from BBS_Topic where board_id in (select board_id from BBS_Board where board_id="& board_id &" or  board_id in ("& dis_allmyclass(board_id) &"))"
					set rs_belong=bbsconn.execute(sql_belong)
					if not rs_belong.eof then have_board_belong=rs_belong(0)
					have_board_belong=chk_num(have_board_belong)
				
					

if mydo<>"mod" and mydo<>"add" then
name_nbsp=""

temp_i=board_level-loop_i
for dis_i=1 to temp_i
	name_nbsp=name_nbsp&"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
next

temp_count_1=have_board_belong

%>
<tr <%if board_level=1 then%> style="background-color:#f1f1f1;" <%end if%> >
    <td align="left" style="padding-left:20px;"><%=board_name%>
    </td>
    <td><img src="<%=board_img%>" width="40" height="40" onerror="this.src='../img/forum_new.gif'" >
    </td>
    
    <td>
    	<%=temp_count_1%>
    
    </td>
    <td>
    	<%=board_can_post_html%>
    
    </td>
    <td>
		<%=board_cansee_html%>
    </td>

    <td>
    第<%=board_level%>级
    
								
    </td>
    <td>
       
                      
        <a href="?mydo=order&modid=<%=board_id%>&order_how=1" class="btn btn-info" title="移上">移上</a>
        <A href="?mydo=add&board_belong=<%=board_id%>" class="btn btn-success" title="增加新版块">新版块</A>
        <a href="?mydo=mod&modid=<%=board_id%>" class="btn btn-warning" title="修改本版块">修改</a>        
        <a href="?mydo=del&modid=<%=board_id%>" class="btn btn-danger" onClick="return makesure('即将删除该版块，是否继续！');" title="删除本版块">删除</a>
        <a href="?mydo=order&modid=<%=board_id%>&order_how=2" class="btn btn-info" title="移下">移下</a>
        
    </td>               
</tr>
<%
end if
	call dis_class_table(board_id)
				  rs.movenext
		  loop
		  
end sub










%>
