<%@page import="myPkg.MembersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id = "member" class = "myPkg.MembersBean"/>
<jsp:setProperty property="*" name="member"/>
<%
	MembersDao mdao = MembersDao.getInstance();
	int cnt = mdao.insertMember(member);
	String url = "";
	String msg = "";
	if(cnt > -1){
		url = request.getContextPath() + "/login.jsp";
		msg = "회원 가입되었습니다";
	} else {
		url = request.getContextPath() + "/main.jsp";
		msg = "회원 가입 실패했습니다";
	}
%>
	<script type = "text/javascript">
		location.href = "<%= url %>";
		alert("<%= msg %>");
	</script>
