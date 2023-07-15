<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="myPkg.ReviewDao"%>
<%@page import="myPkg.ReviewBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String brand = request.getParameter("brand");
	String model = request.getParameter("model");
	String memName = request.getParameter("memName");
	int memNo = Integer.parseInt(request.getParameter("memNo"));
	String revText = request.getParameter("revText");	
	ReviewBean rbean = new ReviewBean();
	rbean.setBrand(brand);
	rbean.setModel(model);
	rbean.setMemName(memName);
	rbean.setMemNo(memNo);
	rbean.setRevText(revText);
	ReviewDao rdao = ReviewDao.getInstance();
	ArrayList<ReviewBean> rlist = rdao.getReviewByProduct(brand, model);
	for(ReviewBean rb : rlist){
		if(rb.getMemNo() == memNo){
			%>
				<script type = "text/javascript">
					alert("이미 리뷰 작성했습니다");
					location.href = "single_Product.jsp?brand=" + "<%= brand %>" + "&model=" + "<%= model%>";
				</script>
			<%
		}
	}
	int cnt = rdao.insertReview(rbean);
	if(cnt > 0){ 
		%>
			<script type = "text/javascript">
				alert("리뷰 작성됬습니다");
				location.href = "single_Product.jsp?brand=" + "<%= brand %>"+ "&model=" + "<%= model%>";
			</script>
		<%
	} else {
		%>
		<script type = "text/javascript">
			alert("리뷰 실패했습니다");
			location.href = "single_Product.jsp?brand=" + "<%= brand %>" + "&model=" + "<%= model%>";
		</script>
	<%
	}
%>