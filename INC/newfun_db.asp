<%

'自动删除数据库中没有记录的数据库备份文件
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
			'先检查数据库中是否有记录,如果没有就删除
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
  
  
  
'检查数据库文件是否存在		  
function chk_dbfile(chk_date,chktype)
	'chktype 1检查数据库文件2直接检查文件是否存在
	if len(chk_date)>0 then
		chk_dbfile=false
		Set objfso = Server.CreateObject("Scripting.FileSystemObject")
		if chk_num(err)<>0 then 
			err.clear
			call dperror_admin(true,"系统不能建立fso对象，请确保你的空间支持fso","")
		end if
		if chktype=1 then
			chk_url=server.mappath(DB_folder & chk_date &"/"& DB_backupname)			
		else
			chk_url=server.mappath(chk_date)
		end if
		if objfso.fileexists(chk_url) then chk_dbfile=true
	end if
end function

'删除文件
sub del_file(file_url)
	Set objfso = Server.CreateObject("Scripting.FileSystemObject")
	mappath_file_url=server.mappath(file_url)
	if objfso.fileexists(mappath_file_url) then objfso.DeleteFile(mappath_file_url)
end sub

'删除备份数据库文件
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
		'是否删除数据库中的记录，如果是恢复数据库，则不需要删除。恢复后就没有了备份记录
			sql_backup="delete * from BBS_Backup where backup_date='"& del_date &"'"
			set rs_backup=bbsconn.execute(sql_backup)
		end if
		set objfso=nothing
	end if
end sub
	
'备份数据库
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
			call dperror_admin(true,"无法建立fso对象，请确保你的空间支持fso","")
		end if	
		backup_date_do=backup_date
		backup_date_do=server.mappath(DB_folder&backup_date_do)
		if backup_type=2 then
			
		else
			'如果存在该备份目录，则不能备份
			call dperror_admin(objfso.fileexists(backup_date_do&"\"&DB_backupname),"该日期已经有备份，请先删除再备份","")
		end if
		'最多只能有10个备份,其他的删除
		sql_backup2="select * from BBS_Backup where id not in (select top "& can_dbcounts-1 &" id from BBS_Backup order by id desc)"
		set rs_backup2=bbsconn.execute(sql_backup2)
		do while not rs_backup2.eof		
			call del_db(rs_backup2("backup_date"),true)
			rs_backup2.movenext
		loop
		'创建备份目录			
		if not(objfso.Folderexists(backup_date_do)) then Set fy=objfso.CreateFolder(backup_date_do)
		objfso.copyfile DBPath,backup_date_do&"\"&DB_backupname
		
		'记录备份记录
		'记录已确认的会员数
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

'恢复数据库
sub db_dbrecovery(backup_date)
	Set objfso = Server.CreateObject("Scripting.FileSystemObject")
	'if chk_num(err)<>0 then 
		'err.clear
		'call dperror_admin(true,"","不能建立fso对象，请确保你的空间支持fso")
	'end if	
	if backup_date="reset" then
		do_backup_date=server.mappath(DB_folder&"reset.asp")
	else
		do_backup_date=server.mappath(DB_folder&backup_date)&"\"&DB_backupname
	end if
	
	call dperror_admin(not(objfso.fileexists(do_backup_date)),"该日期未有备份，请检查","")						
	'如果存在比恢复时间还新的数据库，则无法恢复
	sql_backup="select backup_date,id from BBS_Backup where backup_date>'"& backup_date &"'"
	set rs_backup=bbsconn.execute(sql_backup)
	if not rs_backup.eof then
		old_backup_date=rs_backup("backup_date")
		old_backup_id=rs_backup("id")
		call dperror_admin(true,"系统中存在备份序号为"& old_backup_id &"的数据库["& old_backup_date &"]，比当前需要恢复的数据库还要新，请先删除该数据库，才能进行恢复","")
	end if
	objfso.copyfile do_backup_date,DBPath
	'删除恢复的数据库
	if backup_date<>"reset" then call del_db(backup_date,false) 
end sub

%>