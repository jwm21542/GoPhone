<%@page import="myPkg.ProductsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id = "shopCart" class = "myPkg.CartBean" scope = "session"/>
<%
	request.setCharacterEncoding("UTF-8");
	String sid = (String)session.getAttribute("sid");
	if(sid == null){ //로그인 안 되어있으면 장바구니 담기 불가능.
		%> 
			<script type = "text/javascript">
				alert("로그인 해주세요");
				location.href = "./../login.jsp";
			</script>
		<%
	} else if(sid.equals("admin")){ //관리자로서 장바구니 담기 불가능.
		%>
			<script type = "text/javascript">
				alert("관리자는 구매 불가능합니다");
				location.href = "./../main.jsp";
			</script>
		<%
	} else { //로그인 되어 있으면 장바구니 담기 불가능.
		String storage = request.getParameter("storage");
		String color = request.getParameter("color");
		String cond = request.getParameter("cond");
		String pmodel = request.getParameter("model");
		String pbrand = request.getParameter("brand");
		String pqty = request.getParameter("pqty");
		String sqty = request.getParameter("sqty");
		String price = request.getParameter("price");
		if(Integer.parseInt(sqty) < Integer.parseInt(pqty)){
			%>
				<script type = "text/javascript">
					alert("재고 수량이 부족합니다");
					location.href = "viewCart.jsp"
				</script>
			<%
		} else {
		ProductsDao pdao = ProductsDao.getInstance();
		shopCart.addProduct(pbrand, pmodel, cond, storage, color, pqty);
		response.sendRedirect(request.getContextPath() + "/shop/viewCart.jsp");
		}
	}
%>