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
	String bankName = request.getParameter("bankName");
	String bankNum = request.getParameter("bankNum");
	int cnt = mdao.updateBanking(sno, bankName, bankNum);
	String msg = "";
	if(cnt > 0) {
		msg = "수정 성공했습니다";
	} else {
		msg = "수정 실패했습니다";
	}
%>
<script type = "text/javascript">
	alert("<%= msg %>");
	location.href= "myaccount.jsp";
</script>
%>
