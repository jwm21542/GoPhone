<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id = "shopCart" class = "myPkg.CartBean" scope = "session"/>
<%
	String pnum = request.getParameter("pnum");
	shopCart.cartDelete(pnum);
	response.sendRedirect("viewCart.jsp");
%>