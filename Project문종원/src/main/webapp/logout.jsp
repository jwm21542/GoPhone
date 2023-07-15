<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
logout.jsp<br>
<%
	session.invalidate();
%>
<script type = "text/javascript">
	location.href="main.jsp";
</script>