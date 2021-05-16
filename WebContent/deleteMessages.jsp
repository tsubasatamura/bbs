<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>メッセージの削除</title>
<style type="text/css">
<!--
*{padding:5px; margin:0px;}
body{text-align:center;}
table{width:800px; background:white; border:2px black solid; border-collapse:collapse;}
th{border:1px black solid; background:#CCCCFF}
td{border:1px black solid; text-align:left}
td#button{border:1px black solid; text-align:center}
-->
</style>
<script type="text/javascript">
<!--
function passCheck(val){
	var pw=document.frm1.pass.value;
	if(!(pw==val)){
		alert("パスワードが違います。");
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
<h1>メッセージの削除</h1>
<%
request.setCharacterEncoding("utf-8");
int num=Integer.parseInt(request.getParameter("num"));
int mode=Integer.parseInt(request.getParameter("mode"));

InitialContext ic=new InitialContext();
DataSource ds=(DataSource)ic.lookup("java:comp/env/mysql");
Connection con=ds.getConnection();
String sql="SELECT * FROM bbs WHERE bbs_id="+num;
PreparedStatement pst=con.prepareStatement(sql);
ResultSet rs=pst.executeQuery();

while(rs.next()){
	String pass=rs.getString("bbs_pw");
	String messages=rs.getString("bbs_text");
%>

<form id="frm1" name="frm1" method="post" action="PostMessages" onsubmit="return passCheck('<%= pass%>')">
<table>
<tr><th>タイトル</th><td colspan="2"><%=rs.getString("bbs_title") %></td></tr>
<tr><th>名前</th><td colspan="2"><%=rs.getString("bbs_name") %></td></tr>
<tr><th>内容</th><td colspan="2" width="80%"><%= messages%></td></tr>
<tr><th>編集用パスワード</th><td><input type="password" name="pass"/></td>
	<td id="button"><input type="submit" value="削除"/></td>
</tr>
<tr><td colspan="3" id="button"><a href="#" onclick="window.history.back()">掲示板に戻る</a></td></tr>
</table>
<input type="hidden" name="num" value="<%=num%>"/>
<input type="hidden" name="mode" value="<%=mode%>"/>
</form>
<% } %>
</center>
</body>
</html>