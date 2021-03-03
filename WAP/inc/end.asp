	
	<%
    select case this_page
		case "mywallet_wap","recharge_wap","pay_log_wap"
            %><!-- #include file="../../tpay/wap_end_recharge.asp" --><%
        case "login","reg"
		case "edit_info"
            %><!-- #include file="end_edit.asp" --><%
        case "msg_page"
            %><!-- #include file="end_msg.asp" --><%
        case "page"
            %><!-- #include file="end_page.asp" --><%
        case "post"		
            %><!-- #include file="end_post.asp" --><%
        case else
            %><!-- #include file="end_index.asp" --><%	
    end select
    %>	
<!-- #include file="goto_pc.asp" -->

