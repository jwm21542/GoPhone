<%@page import="myPkg.ProductsBean"%>
<%@page import="myPkg.ProductsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id = "shopCart" class = "myPkg.CartBean" scope = "session"/>
<%
	request.setCharacterEncoding("UTF-8");
	String sqty = request.getParameter("sqty");
	String pnum = request.getParameter("pnum");
	ProductsDao pdao = ProductsDao.getInstance();
	ProductsBean pb = pdao.getProductByPnum(pnum);
	if(Integer.parseInt(sqty) > pb.getSqty()){
		%>
		<script type = "text/javascript">
			alert("재고 수량이 부족합니다");
			history.go(-1);
		</script>
		<%
	} else {
		shopCart.updateCart(pnum, sqty);
		response.sendRedirect("viewCart.jsp");
	}
%>