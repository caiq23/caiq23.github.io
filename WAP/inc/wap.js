function wap_comfirm(qr_info,qr_text,qr_url){
	
	wap_comfirm_html="<div class=end_error_bg id=end_error_bg onClick=\"window.document.getElementById('end_error_html').style.display='none'\"></div><div id=end_error_div class=end_error_div><div class=end_error_div_2><li class=title>"+ qr_info +"</li><li onClick=\"window.location.href='"+ qr_url +"'\">"+ qr_text +"</li></div><li onClick=\"window.document.getElementById('end_error_html').style.display='none'\" class=cancel>È¡Ïû</li></div>";	
	window.document.getElementById("end_error_html").innerHTML=wap_comfirm_html;
	window.document.getElementById('end_error_html').style.display='block';
}





//µã»÷°æ¿éÇÐ»»
function select_board(see_board_type,see_board_id,select_board_li){
	var liList=document.getElementById("board_left").getElementsByTagName("li");
	for(var i=0;i<liList.length;i++)
	{
		liList[i].className='';
	}
	if(see_board_type>0){
		window.document.getElementById('board_inc_1').src='board_inc.asp?see_board_type='+see_board_type;
		}else{
		window.document.getElementById('board_inc_1').src='board_inc.asp?see_board_id='+see_board_id;			
		}
		window.document.getElementById('select_board_li_'+select_board_li).className='active';
	}	