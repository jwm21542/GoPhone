<%@page import="myPkg.BoardDao"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="myPkg.BoardBean"%>
<%@page import="myPkg.MembersBean"%>
<%@page import="myPkg.MembersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	if(id == null) {
		%> 
			<script type = "text/javascript">
				alert("로그인 해주세요");
				location.href = "./../login.jsp";
			</script>
		<%
	}
	String password = request.getParameter("password");
	MembersDao mdao = MembersDao.getInstance();
	MembersBean mbean = mdao.getMemberInfo(id, password);
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	BoardBean bb = new BoardBean();
	bb.setMemno(mbean.getNo());
	bb.setTitle(title);
	bb.setContent(content);
	BoardDao bdao = BoardDao.getInstance();
	int cnt = bdao.writeBoard(bb);
	if(cnt > -1){
		%>
		<script type = "text/javascript">
			alert("글 등록됬습니다");
			location.href = "viewBoardList.jsp"
		</script>
		<%
	} else{
		%>
		<script type = "text/javascript">
			alert("글 등록 실패했습니다");
			location.href = "viewBoardList.jsp"
		</script>
		<%
	}
%>