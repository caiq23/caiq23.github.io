<%
function get_hy_id(user_num,admin_num)
	get_hy_id=0
	if len(user_num)>0 then
		sql_hy_id="select * from BBS_User where user_num='"& user_num &"'"		
		set rs_hy_id=bbsconn.execute(sql_hy_id)
		call dperror_admin(rs_hy_id.eof,"�Ҳ�����Ӧ�Ļ�Ա������","")
		temp_hy_id=rs_hy_id("user_id")
		'����û�Ա�Ѿ��ǹ���Ա
		sql_hy_id="select * from BBS_Admin where user_id="& temp_hy_id &" and admin_num<>'"& admin_num &"'"		
		set rs_hy_id=bbsconn.execute(sql_hy_id)
		call dperror_admin(not rs_hy_id.eof,"�û�Ա�Ѿ��ǹ���Ա������","")		
		get_hy_id=temp_hy_id
	end if
	
end function

'ɾ���û��������ӵ�ͼƬ
function del_user_all_postimg(modid)
	Set MyFileObject=Server.CreateObject("Scripting.FileSystemObject")
	foldername=server.mappath("../UPLOAD/image/"& modid)
	if MyFileObject.FolderExists(foldername)=true then
		Set MyFolder=MyFileObject.GetFolder(foldername)
		i=0
		For Each thing in MyFolder.subfolders
		  if MyFileObject.FolderExists(thing) then 
			 MyFileObject.DeleteFolder(thing)
			 i=i+1
		  end if	
		Next
		MyFileObject.DeleteFolder(foldername)			
		del_user_all_postimg="��ɾ����"& i &"��ͼƬ�ļ���"		
	else
		del_user_all_postimg="���û�û���ϴ�ͼƬ"
	end if
end function


'ɾ��ͷ��
sub del_userimg(user_img)
	'ɾ���û���ͷ��
	if len(user_img)>0 then
		user_img=BBS_folder&user_img
		Set objfso = Server.CreateObject("Scripting.FileSystemObject")
		del_fileurl=server.mappath(user_img)	
		if objfso.fileexists(del_fileurl) then objfso.DeleteFile(del_fileurl)
	end if
end sub



'ɾ���ظ�
sub del_replay(replay_id)
	sql_del="select * from BBS_Reply where id="& replay_id &""
	set rs_del=server.CreateObject("adodb.recordset")
	rs_del.open sql_del,bbsconn,1,3
	do while not rs_del.eof 
		topic_id=rs_del("topic_id")
		sql_del2="update BBS_Topic set replay_count=replay_count-1 where topic_id="& topic_id &""
		set rs_del2=bbsconn.execute(sql_del2)
		rs_del.delete
		rs_del.update
	rs_del.movenext
	loop
end sub

'ɾ������
sub del_topic(topic_id)	
	sql_del="select * from BBS_Topic where topic_id="& topic_id &""
	set rs_del=server.CreateObject("adodb.recordset")
	rs_del.open sql_del,bbsconn,1,3
	if not rs_del.eof then
		topic_id=rs_del("topic_id")
		sql_del2="delete * from BBS_Reply where topic_id="& topic_id &""
		set rs_del2=bbsconn.execute(sql_del2)
		sql_del2="delete * from BBS_Alert where alert_about_id="& topic_id &""
		set rs_del2=bbsconn.execute(sql_del2)
		rs_del.delete
		rs_del.update
	end if
end sub

'ɾ����Ա
sub del_user(user_id)
	call del_user_post(user_id)
	sql_del="delete * from BBS_User where user_id="& user_id &""
	set rs_del=bbsconn.execute(sql_del)
end sub
'ɾ����������
sub del_user_post(user_id)
	
	sql_del="select * from BBS_Topic where user_id="& user_id &""
	set rs_del=server.CreateObject("adodb.recordset")
	rs_del.open sql_del,bbsconn,1,3
	do while not rs_del.eof 
		topic_id=rs_del("topic_id")
		sql_del2="delete * from BBS_Reply where topic_id="& topic_id &""
		set rs_del2=bbsconn.execute(sql_del2)
		rs_del.delete
		rs_del.update
	rs_del.movenext
	loop
	'ɾ�����Ļظ�
	sql_del="select * from BBS_Reply where user_id="& user_id &""
	set rs_del=server.CreateObject("adodb.recordset")
	rs_del.open sql_del,bbsconn,1,3
	do while not rs_del.eof 
		topic_id=rs_del("topic_id")
		sql_del2="update BBS_Topic set replay_count=replay_count-1 where topic_id="& topic_id &""
		set rs_del2=bbsconn.execute(sql_del2)
		rs_del.delete
		rs_del.update
	rs_del.movenext
	loop
end sub

'������ʾδ���ı������	
sub display_blanktr(i,page_size,colspan)
	if i>1 and i<page_size then 
	  do while i<=page_size
	  response.Write("<tr><td colspan="""& colspan &""" style=""background-color:#fff;"">&nbsp;</td></tr>")
	  i=i+1
	  loop
	end if
end sub	
%>