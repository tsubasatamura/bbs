<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>新規投稿</title>
<style>
<!--
*{padding:5px; margin:0px;}
body{text-align:center;}
table{width:800px; background:white; border:2px black solid; border-collapse:collapse;}
th{border:1px black solid; background:#CCCCFF}
td{border:1px black solid;}
td#button{border:1px black solid; text-align:center;}
-->
</style>
<script>
<!--
function frmCheck(){
	if(document.frm1.title.value==""){
		alert("タイトルを入力してください。");
		document.frm1.title.focus();
		return false;
	}else if(document.frm1.name.value==""){
		alert("名前を入力してください。");
		document.frm1.name.focus();
		return false;
	}else if(document.frm1.pass.value==""){
		alert("パスワードを入力してください。");
		document.frm1.pass.focus();
		return false;
	}
}
//-->
</script>
<noscript>
	<meta http-equiv="refresh" content="0;URL=noscript.jsp">
</noscript>
</head>
<body>
<center>
<h1>新規投稿</h1>
<% int mode=Integer.parseInt(request.getParameter("mode")); %>
<form id="frm1" name="frm1" method="post" action="PostMessages" onsubmit="return frmCheck()">

<table>
<tr><th>タイトル</th><td><input type="text" name="title" maxlength="20" size="50"/></td></tr>
<tr><th>名前</th><td><input type="text" name="name" maxlength="15" size="30"/></td></tr>
<tr><th>編集用パスワード</th><td><input type="password" name="pass" maxlength="10" size="20"/></td></tr>
<tr><th>内容</th><td><textarea name="messages" cols="70" rows="20"></textarea></td></tr>
<tr><td colspan="2"><input type="submit" value="新規投稿"/><input type="reset" value="消去"/></td></tr>
<tr><td colspan="2" id="button"><a href="#" onclick="window.history.back()">掲示板に戻る</a></td></tr>
</table>
<input type="hidden" name="mode" value="<%=mode%>"/>
</form>
</center>
</body>
</html>