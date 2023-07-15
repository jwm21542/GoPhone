<%@page import="myPkg.RequestDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int reqno = Integer.parseInt(request.getParameter("reqno"));
	RequestDao rdao = RequestDao.getInstance();
	int cnt = rdao.deleteRequest(reqno);
	if(cnt > -1){
		%>
			<script type = "text/javascript">
				alert("신청 취소 됬습니다");
				location.href = "<%= request.getContextPath() %>/main.jsp"
			</script>
		<%
	} else {
		%>
		<script type = "text/javascript">
			alert("신청 취소 실패했습니다");
			history.go(-1);
		</script>
	<%
	}
%>