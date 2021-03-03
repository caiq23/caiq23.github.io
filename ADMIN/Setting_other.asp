<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/check_admin_session.asp" -->
<!-- #include file="../inc/fun-admin.asp" -->
<%


mydo=trim(request("mydo"))
	if mydo="yes" then
		set rs=server.createobject("adodb.recordset")
		sql="select * from BBS_Setting "
		rs.open sql,bbsconn,1,1 
		while not rs.eof
				set_name=rs("set_name")
				set_value=request(set_name)
				set_title=rs("set_title")
				
				strsql ="update BBS_Setting set set_value='"& set_value &"' where set_name='" & set_name &"'"
				set rstemp=bbsconn.execute(strsql)
				set rstemp=nothing
		rs.movenext
		wend
		'删除缓存
		call del_cache()
		call dperror_admin(true,"修改成功","Setting_other.asp")
	end if


set rs=server.createobject("adodb.recordset")
sql="select * from BBS_Setting "
rs.open sql,bbsconn,1,1 
j=rs.recordcount
%>

<html>
<head>
<title>参数设置</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">  
 <link href="../inc/wdiii/common.css" rel="stylesheet">
   <link href="../inc/wdiii/table.css" rel="stylesheet">
   <script src="../inc/wdiii/index.js" type="text/javascript"></script>
   <style>
   input{ }
   .form-textarea{ width:95%; height:55px; margin:5px;margin-left:0px; padding:5px; border:1px #ccc solid;}
   </style>
    

</head>

<body>
<div class="table-topmenu" >

    <div class="table-topmenu-left">
        <a href="javascript:void(0)" class="btn btn-gray">参数设置</a>
    </div>
    
    <div class="table-topmenu-right">
       *修改设置参数后，必须点击 <strong>确定保存</strong> ，这样参数设置才有效
    </div>
    
</div>

<form name="form1" method="post" action="?mydo=yes">

<table class="table table-bordered table-responsive td_title">
<thead>
          <tr> 
            <th width="20%"><div align="right">项目名称&nbsp;&nbsp;</div></th>
            <th width="50%"><div align="left">&nbsp;&nbsp;参数值</div></th>
            <th width="30%"><div align="left">&nbsp;项目说明</div></th>
          </tr>
          </thead>
          <tbody>
          <%while not rs.eof
		  set_name=rs("set_name")
		  set_title=rs("set_title")
		  set_value=rs("set_value")
		  set_demo=rs("set_demo")
		  %>
          <tr> 
            <td>
              <div align="right">
                <% =set_title%>:&nbsp;
            </div></td>
            <td style="padding-left:10px;">
              <div align="left">
                <%select case set_name
					case "bbsset_site_keyword","bbsset_site_description","bbsset_Filter_word","bbsset_site_name2","bbsset_site_name3","bbsset_site_census"
						
						%>
                        <textarea name="<% =set_name%>" class="form-textarea" ><%=set_value%></textarea>
                    
                    <%case "bbsset_open_wxlogin","bbsset_html_open","bbsset_topicpoststate","bbsset_search_hotword","bbsset_open_qqlogin","bbsset_open_reghy","bbsset_open_wap","bbsset_open_pay"
						
						%>
                        <select class="form-control" style="width:50px;" name="<% =set_name%>">
                            <option value="1">是</option>
                            <option value="2" <% if set_value=2 then response.Write(" selected ")%>>否</option>
                        </select>
                    
                    <%case else%>
                    	<input class="form-control" name="<% =set_name%>" type="text"  value="<%=set_value%>">
                    <%end select%>
                  </div>
            </td>
            <td><div align="left" style="line-height:20px;">
              &nbsp;<% =set_demo%>&nbsp;</div></td>
          </tr>
          <% rs.movenext
wend%>
</tbody>
<thead>
<tr> 
            <td style="height:50px;">&nbsp;</td>
      <td style="height:50px;"><div align="left">
        &nbsp;<input class="btn btn-primary" type="submit" name="Submit" value="确定保存" onClick="javascript:return makesure('此操作将更新系统设置参数\n您确定要继续吗？');">
      </div></td>
            <td style="height:50px;">&nbsp;</td>
          </tr>
        </table>
</thead>
  
</form>
</body>
</html>
