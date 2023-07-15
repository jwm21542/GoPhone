<%@page import="myPkg.MembersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mb" class = "myPkg.MembersBean"></jsp:useBean>
<jsp:setProperty property="*" name="mb"/>
<%
	MembersDao mdao = MembersDao.getInstance();
	String pw = mdao.findPw(mb);
	if(pw.equals("")){
		%>
			<script type = "text/javascript">
				alert("입력하신 정보 다신 확인해주세요");
				history.go(-1);
			</script>
		<%
	} else {
		%>
		<script type = "text/javascript">
			alert("비밀번호는 <%= pw %>입니다.");
			location.href = "./../login.jsp";
			</script>
	<%
	}
%>