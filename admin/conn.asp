<%
Access="data/data.mdb"     '数据库路径
on error resume next
connstr="DBQ="+server.mappath(Access)+";DefaultDir=;DRIVER={Microsoft Access Driver (*.mdb)};"
set conn=server.createobject("ADODB.CONNECTION")
conn.open connstr
If err Then
err.clear
Set Conn = nothing
response.write "数据库连接出错，请检查连接字串。"
response.end
end If
%>