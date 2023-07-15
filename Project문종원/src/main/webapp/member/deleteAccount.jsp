<%@page import="myPkg.MembersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String sid = (String)session.getAttribute("sid");
	int sno = 0;
	MembersDao mdao = MembersDao.getInstance();
	if(sid != null){
		sno = (Integer)session.getAttribute("sno");
	}
	int cnt = mdao.deleteAccount(sno);
	String msg = "";
	if(cnt > 0) {
		msg = "계정 삭제 됬습니다";
		session.invalidate();
	} else {
		msg = "계정 삭제 실패했습니다";
	}
%>
<script type = "text/javascript">
	alert("<%= msg %>");
	location.href= "<%= request.getContextPath() %>/main.jsp";
</script>
%>