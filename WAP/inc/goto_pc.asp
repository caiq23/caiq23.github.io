<%
pc_url=""
select case this_page
	case "reg"
		pc_url="?r.html"
	case "page"
		pc_url="?p"& topic_no &".html"
	case "index"
		if board_no>0 then pc_url="?b"& board_no &".html"		
end select
%>
        <div class="bottom_tongj"> 
			<a href="index.asp">��ҳ</a> | 
            <a href="../<%=pc_url%>">���԰�</a> |
            <%=bbsset_site_census%>
        </div>