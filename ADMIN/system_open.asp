<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/check_admin_session.asp" -->
<!-- #include file="../inc/fun-admin.asp" -->
<%

mydo=trim_fun(request("mydo"))
close_tips=trim_fun(request("close_tips"))
BBS_Switch=chk_num(trim_fun(request("BBS_Switch")))

	select case mydo
		case "save"
			call dperror_admin(BBS_Switch=0,"开关不明确，请重新登录后再操作","")
			sql="update BBS_Switch set BBS_Switch="& BBS_Switch &",close_tips='"& close_tips &"'"
			set rs=bbsconn.execute(sql)
			call dperror_admin(true,"操作成功","system_open.asp")
	end select
	sql="select * from BBS_Switch"
	set rs=bbsconn.execute(sql)
	if not rs.eof then
		BBS_Switch=rs("BBS_Switch")
		close_tips=rs("close_tips")
	end if	
	BBS_Switch=chk_num(BBS_Switch)
	BBS_Switch_html=""
	select case BBS_Switch
	case 1
		BBS_Switch_html="<font color=blue>系统开启中，会员可登录可发贴</font>"
	case 2
		BBS_Switch_html="<font color=red>会员不可登录，帖子正常显示</font>"
	case 3
		BBS_Switch_html="<font color=red>会员不可登录，所有帖子屏蔽</font>"
	end select

%>

<html>
<head>
<title>系统总开关</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">   <link href="../inc/wdiii/common.css" rel="stylesheet">
   <link href="../inc/wdiii/table.css" rel="stylesheet">
   <script src="../inc/wdiii/index.js" type="text/javascript"></script>
   
    

    
</head>

<body>
<div class="table-topmenu" >

    <div class="table-topmenu-left">
        <a href="javascript:void(0)" class="btn btn-gray">系统开关</a>
    </div>
    
    <div class="table-topmenu-right">
      
    </div>
    
</div>



<form name="form1" method="post" action="?mydo=save">
	<table class="table table-bordered  table-responsive td_title ">
          <tr> 
            <th colspan="2" style="height:30px;" class="right_title">系统总开关</th>    
          </tr>
          	<tr> 
                <td width="30%"><div align="right">当前系统状态:&nbsp;</div></td>
                <td width="70%">
                  <div align="left"><%=BBS_Switch_html%>
                </div></td>               
            </tr>
            <tr> 
                <td><div align="right">系统开关:&nbsp;</div></td>
                <td>
                  <div align="left"><select class="form-control" name="BBS_Switch">
                      <option value="1">正常运行</option>
                      <option value="2" <%if BBS_Switch=2 then%>selected<%end if%>>关闭登录</option>
                      <option value="3" <%if BBS_Switch=3 then%>selected<%end if%>>关闭系统</option>
                    </select>
                </div></td>       
            </tr>
    
                <td><div align="right">关闭提示:&nbsp;</div></td>
                <td>
                  <div align="left"><input class="form-control" name="close_tips" value="<%=close_tips%>" size="50">                    
                </div></td>               
            </tr>
            <tr> 
                <td style="height:50px;"><div align="right">&nbsp;</div></td>
                <td>
                  <div align="left">
                  
                  <input class="btn btn-primary" type="submit" name="Submit" value="确定">
                </div></td>               
            </tr>
            
				
  </table>
</form>

</body>
</html>
