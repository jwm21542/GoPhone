<%@page import="myPkg.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	BoardDao bdao = BoardDao.getInstance();
	String pageNum = request.getParameter("pageNum");
	int cnt = bdao.deleteArticle(no);
	if(cnt > -1){
		%>
		<script type = "text/javascript">
			alert("글 삭제됬습니다");
			location.href = "viewBoardList.jsp?pageNum=<%=pageNum%>";
		</script>
		<%
	} else{
		%>
		<script type = "text/javascript">
			alert("글 삭제 실패했습니다");
			location.href = "viewArticle.jsp?no=<%= no%>&pageNum=<%= pageNum%>";
		</script>
		<%
	}
%>