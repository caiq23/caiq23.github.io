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
		'ɾ������
		call del_cache()
		call dperror_admin(true,"�޸ĳɹ�","Setting_other.asp")
	end if


set rs=server.createobject("adodb.recordset")
sql="select * from BBS_Setting "
rs.open sql,bbsconn,1,1 
j=rs.recordcount
%>

<html>
<head>
<title>��������</title>
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
        <a href="javascript:void(0)" class="btn btn-gray">��������</a>
    </div>
    
    <div class="table-topmenu-right">
       *�޸����ò����󣬱����� <strong>ȷ������</strong> �������������ò���Ч
    </div>
    
</div>

<form name="form1" method="post" action="?mydo=yes">

<table class="table table-bordered table-responsive td_title">
<thead>
          <tr> 
            <th width="20%"><div align="right">��Ŀ����&nbsp;&nbsp;</div></th>
            <th width="50%"><div align="left">&nbsp;&nbsp;����ֵ</div></th>
            <th width="30%"><div align="left">&nbsp;��Ŀ˵��</div></th>
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
                            <option value="1">��</option>
                            <option value="2" <% if set_value=2 then response.Write(" selected ")%>>��</option>
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
        &nbsp;<input class="btn btn-primary" type="submit" name="Submit" value="ȷ������" onClick="javascript:return makesure('�˲���������ϵͳ���ò���\n��ȷ��Ҫ������');">
      </div></td>
            <td style="height:50px;">&nbsp;</td>
          </tr>
        </table>
</thead>
  
</form>
</body>
</html>
