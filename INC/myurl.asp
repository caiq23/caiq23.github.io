<%

if bbsset_open_wap=1 then
	'�ж��Ǵ����û��Ƿ�����ʵ��԰�
	if_mobile_user=InStr(LCase(Request.ServerVariables("HTTP_USER_AGENT")),"mobile")
	if if_mobile_user>0 then
		if instr(LCase(Request.ServerVariables("HTTP_REFERER")),"wap/")>0 then session("i_want_pc")=1
		i_want_pc=chk_num(session("i_want_pc"))
		if i_want_pc>0 then if_mobile_user=0
	end if
end if




temp=myurl
temp=replace(temp,".html","")
temp=replace(temp,"b","")
'���
temp=replace(temp,"p","")
'ҳ��
temp=replace(temp,"u","")
'�û���ҳ
temp=replace(temp,"n","")
'������
temp=replace(temp,"q","")
'�ظ�
temp=replace(temp,"r","")
'ע���»�Ա
temp=replace(temp,"e","")
'�޸Ļ�Ա����
temp=replace(temp,"z","")
'�޸�������
temp=replace(temp,"h","")
'�޸Ļظ���
temp=replace(temp,"t","")
'����TOP
temp=replace(temp,"g","")
'��ʾҳ��
temp=replace(temp,"m","")
'�û��б�
temp=replace(temp,"a","")
'�û�����

if instr(temp,"-")>0 then
	arr=split(temp,"-")
	topic_no=arr(0)
	page_no=arr(1)
else
	topic_no=temp
	page_no=1
end if


keyword=trim(request("keyword"))

if len(keyword)=0 and len(myurl)>0 then
	call dperror("",0,not(isnumeric(topic_no) and isnumeric(page_no)),"��ҳ�����ݣ�����������ҳ","?")
	topic_no=chk_num(topic_no)
	page_no=chk_num(page_no)
	if topic_no<=0 then topic_no=1
	if page_no<=0 then page_no=1	
else
	topic_no=1
	page_no=1	
end if








		
'���濪ʼ����myurl

site_keyword=bbsset_site_keyword
site_description=bbsset_site_description


select case left(myurl,1)
	case "a"		
		board_name=chk_db("BBS_User","user_id",topic_no,"user_name")		
		title=board_name&" ������"		
		if page_no>1 then title=title&"-��"& page_no &"ҳ"
		goto_file="user_alert"
	case "m"
		select case topic_no
			case 1
				title="����ע���û�"
			case 2
				title="�����¼�û�"
			case 3
				title="��Ծ�û�"
			case 4
				title="С����"
			case 5
				title="��������"
			case 6
				title="��ͷ���û�"
			case 7
				title="�Ѱ�QQ��ݵ�¼�û�"
			case 8
				title="VIP�û�"
		end select
		goto_file="user_list"	
	case "g"		
		title="ϵͳ��ʾ"
		goto_file="display_error"
	case "k"		
		title="�����롰"& keyword &"���йص�����"
		goto_file="board"
	case "p"		
		sql="select * from BBS_Topic where topic_id="& topic_no &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then
			topic_title=rs("topic_title")
			board_id=rs("board_id")
			topic_state=chk_num(rs("topic_state"))
		end if		
		topic_title=left(topic_title,20)
		
		call dperror("",0,board_id<=0,"��ҳ������","")
		sql="select board_name from BBS_Board where board_id="& board_id &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then board_name=rs(0)
		topic_title=dis_posttitle(topic_title,topic_state)	
		title=topic_title			
		if page_no>1 then title=title&"-��"& page_no &"ҳ"
		where_now=get_board_class_href(board_id)&" <span>></span> <a href="& index_url &"p"& topic_no &".html>"& topic_title &"</a>"
		goto_file="page"
		site_keyword=topic_title
		mobile_url="page.asp?topic_id="&topic_no		
		call dperror_admin(if_mobile_user>0 and bbsset_open_wap=1,"������ת���������Ӧ��ҳ��",BBS_folder&"wap/page.asp?topic_id="&topic_no)
	case "b"
		sql="select board_name from BBS_Board where board_id="& topic_no &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then board_name=rs(0)
		title=board_name		
		if page_no>1 then title=title&"-��"& page_no &"ҳ"
		where_now=get_board_class_href(topic_no)
		goto_file="board"
		site_keyword=board_name
		mobile_url="index.asp?board_id="&topic_no
		call dperror_admin(if_mobile_user>0 and bbsset_open_wap=1,"������ת���������Ӧ�İ��",BBS_folder&"wap/index.asp?board_id="&topic_no)
	case "u"		
		board_name=chk_db("BBS_User","user_id",topic_no,"user_name")		
		title=board_name&" ������"		
		if page_no>1 then title=title&"-��"& page_no &"ҳ"
		goto_file="board"
	case "q"	
		title="����/�ظ�����"
		goto_file="quote"
	case "n"	
		title="����������"
		goto_file="post"
	case "r"
		if len(session("qq_OpenID"))>0 then	
			title="���ʺ�"
		else
			title="ע���»�Ա"
		end if
		goto_file="reg"
		mobile_url="reg.asp"
		temp_noto_wap=1
	case "e"
		select case topic_no
			case 1			
				title="�޸Ļ�Ա����"
				goto_file="edit_userinfo"
				mobile_url="info.asp"
			case 2
				title="��Ա��ֵ"
				goto_file="../TPay/recharge"
			case 3
				title="֧���б�"
				goto_file="../TPay/pay_log"
		end select
	case "z"	
		title="�༭����"
		goto_file="edit_topic"
	case "h"	
		title="�༭�ظ�"
		goto_file="edit_replay"
	case "t"
		select case topic_no
			case 1
				title="��������"								
			case 2
				title="���»ظ�"
			case 3
				title="��������"
			case 4
				title="��������"
			case 5
				title="һ������"
			case 6
				title="һ������"
			case 7
				title="����ظ�"
		end select
		goto_file="toplist"

	case else		
		title=bbsset_sitename&"-"&bbsset_site_name2
		board_name=""
		where_now=""
		goto_file="main"		
end select

temp_noto_wap=chk_num(temp_noto_wap)

call dperror_admin(if_mobile_user>0 and bbsset_open_wap=1 and temp_noto_wap=0,"�����ֻ��û���������ת���ֻ�����ҳ",BBS_folder&"wap/")





%>