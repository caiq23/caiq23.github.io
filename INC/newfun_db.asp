<%

'�Զ�ɾ�����ݿ���û�м�¼�����ݿⱸ���ļ�
  Function Bianli(path)
  	Bianli=0
    Set Fso=server.createobject("scripting.filesystemobject")
    'On Error Resume Next
    Set Objfolder=fso.getfolder(path)
    Set Objsubfolders=objfolder.subfolders
    For Each Objsubfolder In Objsubfolders
      Nowpath=path + "\" + Objsubfolder.name
      Set Objfiles=objsubfolder.files 
      For Each Objfile In Objfiles
	  	now_folder=objsubfolder.name
		if len(now_folder)>0 then			
			'�ȼ�����ݿ����Ƿ��м�¼,���û�о�ɾ��
			sql_backup2="select id from BBS_Backup where backup_date='"& now_folder &"'"
			set rs_backup2=bbsconn.execute(sql_backup2)
			if rs_backup2.eof then
				call del_db(now_folder,false)
				Bianli=Bianli+1
			end if
		end if
      Next
      'call Bianli(nowpath)
    Next  
    Set Objfolder=nothing  
    Set Objsubfolders=nothing  
    Set Fso=nothing  
  End Function 
  
  
  
'������ݿ��ļ��Ƿ����		  
function chk_dbfile(chk_date,chktype)
	'chktype 1������ݿ��ļ�2ֱ�Ӽ���ļ��Ƿ����
	if len(chk_date)>0 then
		chk_dbfile=false
		Set objfso = Server.CreateObject("Scripting.FileSystemObject")
		if chk_num(err)<>0 then 
			err.clear
			call dperror_admin(true,"ϵͳ���ܽ���fso������ȷ����Ŀռ�֧��fso","")
		end if
		if chktype=1 then
			chk_url=server.mappath(DB_folder & chk_date &"/"& DB_backupname)			
		else
			chk_url=server.mappath(chk_date)
		end if
		if objfso.fileexists(chk_url) then chk_dbfile=true
	end if
end function

'ɾ���ļ�
sub del_file(file_url)
	Set objfso = Server.CreateObject("Scripting.FileSystemObject")
	mappath_file_url=server.mappath(file_url)
	if objfso.fileexists(mappath_file_url) then objfso.DeleteFile(mappath_file_url)
end sub

'ɾ���������ݿ��ļ�
sub del_db(backup_date,del_dblog)
	del_date=backup_date
	del_date=replace(del_date,":","")
	del_date=replace(del_date," ","")
	del_date=replace(del_date,"-","")
	del_date=replace(del_date,"/","")
	del_date=replace(del_date,"\","")	
	
	if len(del_date)>0 then	
		err_num=chk_num(err)
		Set objfso = Server.CreateObject("Scripting.FileSystemObject")
		del_Folder=server.mappath(DB_folder&del_date)
		del_File=server.mappath(DB_folder&del_date&"\"&DB_backupname)
		if objfso.fileexists(del_File) then objfso.DeleteFile(del_File)		
		if objfso.Folderexists(del_Folder) then objfso.DeleteFolder(del_Folder)
		if del_dblog=true then
		'�Ƿ�ɾ�����ݿ��еļ�¼������ǻָ����ݿ⣬����Ҫɾ�����ָ����û���˱��ݼ�¼
			sql_backup="delete * from BBS_Backup where backup_date='"& del_date &"'"
			set rs_backup=bbsconn.execute(sql_backup)
		end if
		set objfso=nothing
	end if
end sub
	
'�������ݿ�
sub do_dbbackup(backup_type,can_dbcounts,bk_date)
	backup_type=chk_num(backup_type)
	can_dbcounts=chk_num(can_dbcounts)
	backup_date=bk_date
	backup_date=replace(backup_date,":","")
	backup_date=replace(backup_date," ","")
	backup_date=replace(backup_date,"-","")
	backup_date=replace(backup_date,"/","")
	backup_date=replace(backup_date,"\","")	
			
	if can_dbcounts=0 then can_dbcounts=5

		Set objfso = Server.CreateObject("Scripting.FileSystemObject")
		if chk_num(err)<>0 then 
			err.clear
			call dperror_admin(true,"�޷�����fso������ȷ����Ŀռ�֧��fso","")
		end if	
		backup_date_do=backup_date
		backup_date_do=server.mappath(DB_folder&backup_date_do)
		if backup_type=2 then
			
		else
			'������ڸñ���Ŀ¼�����ܱ���
			call dperror_admin(objfso.fileexists(backup_date_do&"\"&DB_backupname),"�������Ѿ��б��ݣ�����ɾ���ٱ���","")
		end if
		'���ֻ����10������,������ɾ��
		sql_backup2="select * from BBS_Backup where id not in (select top "& can_dbcounts-1 &" id from BBS_Backup order by id desc)"
		set rs_backup2=bbsconn.execute(sql_backup2)
		do while not rs_backup2.eof		
			call del_db(rs_backup2("backup_date"),true)
			rs_backup2.movenext
		loop
		'��������Ŀ¼			
		if not(objfso.Folderexists(backup_date_do)) then Set fy=objfso.CreateFolder(backup_date_do)
		objfso.copyfile DBPath,backup_date_do&"\"&DB_backupname
		
		'��¼���ݼ�¼
		'��¼��ȷ�ϵĻ�Ա��
		sql_backup="select count(id) from BBS_User"
		set rs_backup=bbsconn.execute(sql_backup)
		user_count=0
		if not rs_backup.eof then user_count=rs_backup(0)
		user_count=chk_num(user_count)
		
		sql_backup="select count(id) from BBS_Topic"
		set rs_backup=bbsconn.execute(sql_backup)
		post_count=0
		if not rs_backup.eof then post_count=rs_backup(0)
		post_count=chk_num(post_count)
		sql_backup="select count(id) from BBS_Reply"
		set rs_backup=bbsconn.execute(sql_backup)
		if not rs_backup.eof then post_count=chk_num(post_count)+chk_num(rs_backup(0))
		
		
		
		sql_backup="select * from BBS_Backup where backup_date='"& backup_date &"'"
		set rs_backup=server.CreateObject("adodb.recordset")
		rs_backup.open sql_backup,bbsconn,1,3
		if rs_backup.eof then rs_backup.addnew
			rs_backup("backup_date")=backup_date
			rs_backup("backup_type")=backup_type
			rs_backup("backup_time")=thistime
			rs_backup("user_count")=user_count
			rs_backup("post_count")=post_count
			
			rs_backup.update
		set rs_backup=nothing

end sub

'�ָ����ݿ�
sub db_dbrecovery(backup_date)
	Set objfso = Server.CreateObject("Scripting.FileSystemObject")
	'if chk_num(err)<>0 then 
		'err.clear
		'call dperror_admin(true,"","���ܽ���fso������ȷ����Ŀռ�֧��fso")
	'end if	
	if backup_date="reset" then
		do_backup_date=server.mappath(DB_folder&"reset.asp")
	else
		do_backup_date=server.mappath(DB_folder&backup_date)&"\"&DB_backupname
	end if
	
	call dperror_admin(not(objfso.fileexists(do_backup_date)),"������δ�б��ݣ�����","")						
	'������ڱȻָ�ʱ�仹�µ����ݿ⣬���޷��ָ�
	sql_backup="select backup_date,id from BBS_Backup where backup_date>'"& backup_date &"'"
	set rs_backup=bbsconn.execute(sql_backup)
	if not rs_backup.eof then
		old_backup_date=rs_backup("backup_date")
		old_backup_id=rs_backup("id")
		call dperror_admin(true,"ϵͳ�д��ڱ������Ϊ"& old_backup_id &"�����ݿ�["& old_backup_date &"]���ȵ�ǰ��Ҫ�ָ������ݿ⻹Ҫ�£�����ɾ�������ݿ⣬���ܽ��лָ�","")
	end if
	objfso.copyfile do_backup_date,DBPath
	'ɾ���ָ������ݿ�
	if backup_date<>"reset" then call del_db(backup_date,false) 
end sub

%>