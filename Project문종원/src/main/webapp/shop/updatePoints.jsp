<%@page import="myPkg.MembersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int sno = (Integer)session.getAttribute("sno");
	int pointused = Integer.parseInt(request.getParameter("pointused"));	
	int pointrcvd = Integer.parseInt(request.getParameter("pointrcvd"));
	/* MembersDao mdao = MembersDao.getInstance();
	int cnt = mdao.addPoints(pointrcvd, sno);
	int cnt2 = mdao.deductPoints(pointused, sno);
	System.out.println(cnt);
	System.out.println(cnt2); */
	
%>