<%
	Dim LaoYAdminID,LaoYAdminName,LaoYAdminPass,IsAdmin,rs5
	LaoYAdminID		=LaoYRequest(Request.Cookies("LaoYAdmin")("UserID"))
	LaoYAdminName	=CheckStr(Request.Cookies("LaoYAdmin")("UserName"))
	LaoYAdminPass	=CheckStr(Request.Cookies("LaoYAdmin")("UserPass"))
	LaoAdminRndPass	=CheckStr(Request.Cookies("LaoYAdmin")("AdminRndPass"))
	
	If LaoYAdminID<>"" and LaoYAdminName<>"" and LaoYAdminPass<>"" and LaoAdminRndPass<>"" then
	set rs5 = server.CreateObject ("adodb.recordset")
	sql="Select Top 1 * from ["&tbname&"_Admin] where id="& LaoYAdminID &" and Admin_Pass='"&LaoYAdminPass&"' and Admin_Name='"&LaoYAdminName&"' and AdminRndPass='"&LaoAdminRndPass&"'"
	on error resume next
	rs5.open sql,conn,1,1
	Dim myadminid,myadminpass,myadminuser
	myadminid		=rs5("ID")
	myadminpass		=rs5("Admin_Pass")
	myadminuser		=rs5("Admin_Name")
	myadminip		=rs5("Admin_IP")
	yaomight		=rs5("AdminMight")
	yaoadmintype	=rs5("AdminType")
	yaoadpower		=rs5("ADPower")
	yaoWritePower	=rs5("WritePower")
	yaoManagePower	=rs5("ManagePower")
	yaoAdminRndPass =rs5("AdminRndPass")
	rs5.close
	set rs5=nothing
		If myadminid<>Int(LaoYAdminID) or myadminpass<>LaoYAdminPass or myadminuser<>LaoYAdminName or yaoAdminRndPass<>LaoAdminRndPass Then
			IsAdmin=0
		Else
			IsAdmin=1
		End if
	End if
	
	If IsAdmin<>1 then
	Response.Redirect ""&SitePath&SiteAdmin&"/Admin_Login.asp"
	End if
%>