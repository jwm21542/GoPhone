<%@page import="myPkg.MembersBean"%>
<%@page import="myPkg.MembersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String password = request.getParameter("lgpassword");
	
	MembersDao mdao = MembersDao.getInstance();
	MembersBean member = mdao.getMemberInfo(id, password);
	String viewPage = null;
	if(member != null){
		String _id = member.getUserid();
		int no = member.getNo();
		if(id.equals("admin")){ //관리자.
			viewPage = request.getContextPath() + "/admin/main.jsp";
			%>
			<script type = "text/javascript">
				var test = confirm("관리자 홈 페이지로 이동하시겠습니까?");
				if(test == true){
					location.href = "<%= viewPage%>";
				} else{
					location.href = "main.jsp";
				}
			</script>
			<%
		}else{
			viewPage = request.getContextPath() + "/main.jsp";
		}
		session.setAttribute("sid", _id);
		session.setAttribute("sno", no);
	} else {
		viewPage = request.getContextPath() + "/main.jsp";
		%>
		<script type = "text/javascript">
			alert("가입하지 않은 회원입니다.");
		</script>
		<%
	}
%>
	<script type = "text/javascript">
		location.href = "<%= viewPage %>";
	</script>
%>