<%@page import="myPkg.BoardBean"%>
<%@page import="myPkg.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	BoardDao bdao = BoardDao.getInstance();
	String pageNum = request.getParameter("pageNum");
	String title = request.getParameter("title");
	int memno = Integer.parseInt(request.getParameter("no"));
	int ref = Integer.parseInt(request.getParameter("ref"));
	int re_step = Integer.parseInt(request.getParameter("re_step"));
	int re_level = Integer.parseInt(request.getParameter("re_level"));
	String content = request.getParameter("content");
	BoardBean bb = new BoardBean();
	bb.setTitle(title);
	bb.setMemno(memno);
	bb.setRef(ref);
	bb.setRe_step(re_step);
	bb.setRe_level(re_level);
	bb.setContent(content);
	int cnt = bdao.replyArticle(bb);
	if(cnt > -1) {
		response.sendRedirect("viewBoardList.jsp");
	}
	
%>