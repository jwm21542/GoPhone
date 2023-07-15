<%@page import="myPkg.ProductsDao"%>
<%@page import="myPkg.MembersDao"%>
<%@page import="myPkg.OrderDao"%>
<%@page import="myPkg.ProductsBean"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id = "shopCart" class = "myPkg.CartBean" scope = "session"/>
<%
	request.setCharacterEncoding("UTF-8");
	String pointsUsed = request.getParameter("pointsused");
	Vector<ProductsBean> clist = shopCart.getAllProducts();
	OrderDao odao = OrderDao.getInstance();
	int sno = (Integer)session.getAttribute("sno");
    int totalPrice = 0;
    int delivery = 0;
    int points = 0;
    for(ProductsBean pb : clist){ 
    	totalPrice += pb.getPrice() * pb.getSqty();
    }
	if(totalPrice < 700000){ 
		delivery =  3000;
	}
	if(pointsUsed != null){
		try{
			points = Integer.parseInt(pointsUsed);
		} catch(NumberFormatException e){
			points = 0;
		}
	}
	int pointrcvd = (int)((totalPrice - delivery + points)*0.05);
 	int cnt2 = odao.addPoints(pointrcvd, sno);
	int cnt3 = odao.deductPoints(points, sno);
	int cnt = odao.insertOrder(sno, clist, delivery, points);
	response.sendRedirect("orderSuccess.jsp?points=" + points);
%>