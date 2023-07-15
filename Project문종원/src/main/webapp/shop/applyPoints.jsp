<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String point = request.getParameter("point");
	if(point != null){
		response.sendRedirect("viewCart.jsp?point=" + point);
	} else {
		response.sendRedirect("viewCart.jsp");
	}
%>