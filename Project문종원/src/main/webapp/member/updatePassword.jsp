<%@page import="myPkg.MembersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String password = request.getParameter("password");
	String sid = (String)session.getAttribute("sid");
	int sno = 0;
	MembersDao mdao = MembersDao.getInstance();
	if(sid != null){
		sno = (Integer)session.getAttribute("sno");
	}
	int cnt = mdao.updatePassword(sno, password);
	String msg = "";
	if(cnt > -1) {
		msg = "수정 성공했습니다";
	} else {
		msg = "수정 실패했습니다";
	}
%>
<script type = "text/javascript">
	alert("<%= msg %>");
	location.href= "myaccount.jsp";
</script>
