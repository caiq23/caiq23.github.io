<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/check_admin_session.asp" -->
<!-- #include file="../inc/fun-admin.asp" -->
<%

mydo=trim_fun(request("mydo"))
close_tips=trim_fun(request("close_tips"))
BBS_Switch=chk_num(trim_fun(request("BBS_Switch")))

	select case mydo
		case "save"
			call dperror_admin(BBS_Switch=0,"���ز���ȷ�������µ�¼���ٲ���","")
			sql="update BBS_Switch set BBS_Switch="& BBS_Switch &",close_tips='"& close_tips &"'"
			set rs=bbsconn.execute(sql)
			call dperror_admin(true,"�����ɹ�","system_open.asp")
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
		BBS_Switch_html="<font color=blue>ϵͳ�����У���Ա�ɵ�¼�ɷ���</font>"
	case 2
		BBS_Switch_html="<font color=red>��Ա���ɵ�¼������������ʾ</font>"
	case 3
		BBS_Switch_html="<font color=red>��Ա���ɵ�¼��������������</font>"
	end select

%>

<html>
<head>
<title>ϵͳ�ܿ���</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">   <link href="../inc/wdiii/common.css" rel="stylesheet">
   <link href="../inc/wdiii/table.css" rel="stylesheet">
   <script src="../inc/wdiii/index.js" type="text/javascript"></script>
   
    

    
</head>

<body>
<div class="table-topmenu" >

    <div class="table-topmenu-left">
        <a href="javascript:void(0)" class="btn btn-gray">ϵͳ����</a>
    </div>
    
    <div class="table-topmenu-right">
      
    </div>
    
</div>



<form name="form1" method="post" action="?mydo=save">
	<table class="table table-bordered  table-responsive td_title ">
          <tr> 
            <th colspan="2" style="height:30px;" class="right_title">ϵͳ�ܿ���</th>    
          </tr>
          	<tr> 
                <td width="30%"><div align="right">��ǰϵͳ״̬:&nbsp;</div></td>
                <td width="70%">
                  <div align="left"><%=BBS_Switch_html%>
                </div></td>               
            </tr>
            <tr> 
                <td><div align="right">ϵͳ����:&nbsp;</div></td>
                <td>
                  <div align="left"><select class="form-control" name="BBS_Switch">
                      <option value="1">��������</option>
                      <option value="2" <%if BBS_Switch=2 then%>selected<%end if%>>�رյ�¼</option>
                      <option value="3" <%if BBS_Switch=3 then%>selected<%end if%>>�ر�ϵͳ</option>
                    </select>
                </div></td>       
            </tr>
    
                <td><div align="right">�ر���ʾ:&nbsp;</div></td>
                <td>
                  <div align="left"><input class="form-control" name="close_tips" value="<%=close_tips%>" size="50">                    
                </div></td>               
            </tr>
            <tr> 
                <td style="height:50px;"><div align="right">&nbsp;</div></td>
                <td>
                  <div align="left">
                  
                  <input class="btn btn-primary" type="submit" name="Submit" value="ȷ��">
                </div></td>               
            </tr>
            
				
  </table>
</form>

</body>
</html>
