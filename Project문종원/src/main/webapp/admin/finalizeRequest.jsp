<%@page import="myPkg.RequestBean"%>
<%@page import="myPkg.ProductsDao"%>
<%@page import="myPkg.RequestDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String decision = request.getParameter("approve");
	int reqno = Integer.parseInt(request.getParameter("reqno"));
	RequestDao rdao = RequestDao.getInstance();
	ProductsDao pdao = ProductsDao.getInstance();
	RequestBean rb = rdao.getRequestByNo(reqno);
	
	int cnt = -1;
	if(decision.equals("approved")){
		cnt = rdao.updateRequest(reqno, "y");
		pdao.addSqty(rb.getPnum());
	} else if(decision.equals("unapproved")){
		cnt = rdao.updateRequest(reqno, "n");
	}
	if(cnt > -1){
		%>
		<script type = "text/javascript">
			alert("결정 등록됬습니다.");
		</script>
		<%
	}
%>
		<script type = "text/javascript">
			location.href = "requestList.jsp";
		</script>