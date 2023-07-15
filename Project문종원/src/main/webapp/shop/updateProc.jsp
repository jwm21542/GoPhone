<%@page import="myPkg.BoardBean"%>
<%@page import="myPkg.MembersBean"%>
<%@page import="myPkg.MembersDao"%>
<%@page import="myPkg.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	BoardDao bdao = BoardDao.getInstance();
	String id = request.getParameter("id");
	int no = Integer.parseInt(request.getParameter("no"));
	String pageNum = request.getParameter("pageNum");
	String password = request.getParameter("password");
	MembersDao mdao = MembersDao.getInstance();
	MembersBean mbean = mdao.getMemberInfo(id, password);
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	BoardBean bb = new BoardBean();
	bb.setMemno(mbean.getNo());
	bb.setTitle(title);
	bb.setContent(content);
	bb.setNo(no);
	int cnt = bdao.updateArticle(bb);
	if(cnt > -1){
		%>
		<script type = "text/javascript">
			alert("글 수정됬습니다");
			location.href = "viewBoardList.jsp?pageNum=<%=pageNum%>";
		</script>
		<%
	} else{
		%>
		<script type = "text/javascript">
			alert("글 수정 실패했습니다");
			location.href = "viewArticle.jsp?no=<%= no%>&pageNum=<%= pageNum%>";
		</script>
		<%
	}
%>