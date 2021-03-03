<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/check_admin_session.asp" -->
<!-- #include file="../inc/fun-admin.asp" -->
<!Doctype html>
<html>
<head>
<meta charset="gb2312">
<title>清除缓存</title>   
<link href="../inc/wdiii/common.css" rel="stylesheet">
   <link href="../inc/wdiii/table.css" rel="stylesheet">
   <script src="../inc/wdiii/index.js" type="text/javascript"></script>
   
    

<script src="../inc/index.js" type="text/javascript"></script>
<style>

</style>

</head>
<body>
<div class="table-topmenu" >

    <div class="table-topmenu-left">
        <a href="javascript:void(0)" class="btn btn-gray">缓存管理</a>
    </div>
    
    <div class="table-topmenu-right">
        *此操作将会清除当前系统所有缓存
    </div>
    
</div>

<div class="single-form">
<a class="btn btn-danger" style="margin-top:250px;" href="clear_cache.asp" id="computerToadymoney"  onClick="return makesure('是否清除所有缓存?');" title="点击清除所有缓存">
        清除所有缓存
        </a>
</div>


</body>
</html>
