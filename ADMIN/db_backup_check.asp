<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/check_admin_session.asp" -->
<!-- #include file="../inc/fun-admin.asp" -->
<!-- #include file="../inc/newfun_db.asp" -->
<%

mydo=trim_fun(request("mydo"))
backup_date=trim_fun(request("backup_date"))
	if mtdo="db_recovery" then
		call dperror_admin(len(backup_date)=0 or isnull(backup_date),"��ѡ������","")
		'if instr(backup_date,"-")>0 then backup_date=replace(backup_date,"-","")
	end if
	select case mydo
		case "db_del"			
			call del_db(backup_date,true)
			call dperror_admin(true,"��ϲ��ɾ���ɹ�","db_backup.asp")	
			
		case "db_backup"		
			call do_dbbackup(1,can_dbcounts,thistime)
			call dperror_admin(true,"��ϲ�����ݳɹ�","db_backup.asp")		
		
		case "db_reset"
			call db_dbrecovery("reset")			
			call dperror_admin(true,"��ϲ����ʼ���ɹ�\n��ע�����Ա�ʻ�����Ҳ���ָ�Ϊ��ʼֵ","db_backup.asp")
			
		case "db_recovery"
			call db_dbrecovery(backup_date)			
			call dperror_admin(true,"��ϲ���ָ��ɹ�\nͬʱ����ɾ���ñ����ļ�","db_backup.asp")
			
		case "db_clear"
			'chk_docount=chk_num(Bianli(server.mappath(DB_folder)))
			
			'�������ݿ��м�¼����ʵ���Ѿ������ڵ��ļ�
			'�ȶ�ȡ���ݿ�
			sql_backup="select * from BBS_Backup"
			set rs_backup=server.CreateObject("adodb.recordset")			
			Set objfso = server.createobject("scripting.filesystemobject")
				if chk_num(err)<>0 then
					err.clear
					call dperror_admin(true,"���ܽ���fso������ȷ����Ŀռ�֧��fso","db_backup.asp")
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
				dis_html="�����ɹ�����û����Ҫ�����ʧЧ���ݿ�"
			else
				dis_html="����ɹ�����ɾ��"& chk_docount &"��ʧЧ���ݿ�"
			end if
			call dperror_admin(true,dis_html,"db_backup.asp")
	end select


%>

<html>
<head>
<title>���ݿⱸ��</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
</body>
</html>
