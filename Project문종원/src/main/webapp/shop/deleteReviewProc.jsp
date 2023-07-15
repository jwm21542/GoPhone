<%@page import="myPkg.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int memNo = Integer.parseInt(request.getParameter("memNo"));
	String brand = request.getParameter("brand");
	String model = request.getParameter("model");
	ReviewDao rdao = ReviewDao.getInstance();
	int cnt = rdao.deleteReview(memNo, brand, model);
	if(cnt > 0){ 
		%>
			<script type = "text/javascript">
				alert("리뷰 삭제 성공했습니다");
				location.href = "single_Product.jsp?brand=" + "<%= brand %>"+ "&model=" + "<%= model%>";
			</script>
		<%
	} else {
		%>
		<script type = "text/javascript">
			alert("리뷰 삭제 실패했습니다");
			location.href = "single_Product.jsp?brand=" + "<%= brand %>" + "&model=" + "<%= model%>";
		</script>
	<%
	}
%>