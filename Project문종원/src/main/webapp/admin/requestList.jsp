<%@page import="java.text.DecimalFormat"%>
<%@page import="myPkg.ProductsBean"%>
<%@page import="myPkg.ProductsDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="myPkg.RequestDao"%>
<%@page import="myPkg.RequestBean"%>
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.css" />
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.js"></script>
<style>
	select{
		width: 60px !important;
	}
	#dataTable_filter{
		margin-right:5px;
	}
</style>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>GoPhone || 신청목록</title>
<%@ include file = "main_top.jsp"%>
<%
	RequestDao rdao = RequestDao.getInstance();
	ArrayList<RequestBean> rlist = null;
	String approve = request.getParameter("approve");
	if(approve == null){
		rlist = rdao.getAllRequests();
	} else if (approve.equals("unapproved")){
		rlist = rdao.getUnapprovedRequests();
	} else if(approve.equals("approved")) {
		rlist = rdao.getFinishedRequests();
	}
	ProductsDao pdao = ProductsDao.getInstance();
	DecimalFormat df = new DecimalFormat("###,###");

%>
				
				<div class="container-fluid">
                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">판매 신청 목록</h1>
                    <p class="mb-4">판매 신청번호를 선택한후 신청 정보 검토하시고 결정하시면 됩니다.</p>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">판매 신청 정보</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                    		<th style = "width: 10%;">신청번호</th>
                                            <th>회원번호</th>
                                            <th>모델</th>
                                            <th>브랜드</th>
                                            <th>매입가</th>
                                            <th>결정 상태</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>신청번호</th>
                                            <th>회원번호</th>
                                            <th>모델</th>
                                            <th>브랜드</th>
                                            <th>매입가</th>
                                            <th>결정 상태</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                    <%for(RequestBean rb : rlist){
                                    	ProductsBean pb = pdao.getProductByPnum(String.valueOf(rb.getPnum()));
                                    	%>
                                        <tr>
                                            <td><a href= "viewRequest.jsp?reqno=<%= rb.getReqno() %>"><%= rb.getReqno() %></a></td>
                                            <td><%= rb.getMemno() %></td>
                                            <td><%= pb.getBrand() %></td>
                                            <td><%= pb.getModel() %></td>
                                            <td>&#8361; <%= df.format(rb.getSellPrice()) %>원</td>
                                            <td><%= rb.getApprove() %></td>
                                        </tr>
                                    <%} %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->
<%@ include file = "main_bottom.jsp"%>
<script src="vendor/datatables/jquery.dataTables.min.js"></script>
<script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>
<script src="js/demo/datatables-demo.js"></script>