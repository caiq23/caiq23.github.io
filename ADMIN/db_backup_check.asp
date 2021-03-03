<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/check_admin_session.asp" -->
<!-- #include file="../inc/fun-admin.asp" -->
<!-- #include file="../inc/newfun_db.asp" -->
<%

mydo=trim_fun(request("mydo"))
backup_date=trim_fun(request("backup_date"))
	if mtdo="db_recovery" then
		call dperror_admin(len(backup_date)=0 or isnull(backup_date),"请选择日期","")
		'if instr(backup_date,"-")>0 then backup_date=replace(backup_date,"-","")
	end if
	select case mydo
		case "db_del"			
			call del_db(backup_date,true)
			call dperror_admin(true,"恭喜：删除成功","db_backup.asp")	
			
		case "db_backup"		
			call do_dbbackup(1,can_dbcounts,thistime)
			call dperror_admin(true,"恭喜：备份成功","db_backup.asp")		
		
		case "db_reset"
			call db_dbrecovery("reset")			
			call dperror_admin(true,"恭喜：初始化成功\n请注意管理员帐户密码也都恢复为初始值","db_backup.asp")
			
		case "db_recovery"
			call db_dbrecovery(backup_date)			
			call dperror_admin(true,"恭喜：恢复成功\n同时，已删除该备份文件","db_backup.asp")
			
		case "db_clear"
			'chk_docount=chk_num(Bianli(server.mappath(DB_folder)))
			
			'清理数据库有记录，但实际已经不存在的文件
			'先读取数据库
			sql_backup="select * from BBS_Backup"
			set rs_backup=server.CreateObject("adodb.recordset")			
			Set objfso = server.createobject("scripting.filesystemobject")
				if chk_num(err)<>0 then
					err.clear
					call dperror_admin(true,"不能建立fso对象，请确保你的空间支持fso","db_backup.asp")
				end if
			rs_backup.open sql_backup,bbsconn,1,3
			do while not rs_backup.eof
				backup_date=rs_backup("backup_date")				
				if not(objfso.FolderExists(server.mappath(DB_folder&"\"&backup_date))) then										
					chk_docount=chk_docount+1
					rs_backup.delete
					rs_backup.update
				end if
				rs_backup.movenext
			loop
			
			if chk_docount=0 then
				dis_html="操作成功，但没有需要清理的失效数据库"
			else
				dis_html="清理成功，共删除"& chk_docount &"个失效数据库"
			end if
			call dperror_admin(true,dis_html,"db_backup.asp")
	end select


%>

<html>
<head>
<title>数据库备份</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
</body>
</html>
