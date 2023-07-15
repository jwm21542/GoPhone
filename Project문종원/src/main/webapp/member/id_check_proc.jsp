<%@page import="myPkg.MembersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userId = request.getParameter("userid");
	MembersDao mdao = MembersDao.getInstance();
	boolean result = mdao.searchId(userId); 
	if(result){
		out.print("NO");
	} else{
		out.print("YES");
	}
%>