<%@page import="myPkg.WishBean"%>
<%@page import="myPkg.WishDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String sid = (String)session.getAttribute("sid");
	int sno = 0;
	if(sid != null){
		sno = (Integer)session.getAttribute("sno");
	} else {
		%>
			<script type = "text/javascript">
				alert("로그인 해주세요");
				location.href = "<%= request.getContextPath() %>/login.jsp";
			</script>
		<%
	}
	String brand = request.getParameter("brand");
	String model = request.getParameter("model");
	WishDao wdao = WishDao.getInstance();
	WishBean wb = new WishBean();
	wb.setMemno(sno);
	wb.setBrand(brand);
	wb.setModel(model);
	int cnt = wdao.removeWish(wb);
	if(cnt > -1){
		%>
		<script type = "text/javascript">
			alert("찜 상품 제거 성공했습니다");
			location.href = "single_Product.jsp?brand=<%= brand%>&model=<%= model %>"
		</script>
		<%
	} else{
		%>
		<script type = "text/javascript">
			alert("찜 상품 제거 실패했습니다");
			location.href = "single_Product.jsp?brand=<%= brand%>&model=<%= model %>"
		</script>
		<%
	}
%>
