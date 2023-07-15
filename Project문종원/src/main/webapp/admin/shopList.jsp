<%@page import="myPkg.ProductsBean"%>
<%@page import="myPkg.ProductsDao"%>
<%@page import="myPkg.MembersBean"%>
<%@page import="myPkg.MembersDao"%>
<%@page import="myPkg.OrderBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="myPkg.OrderDao"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>GoPhone || 주문내역</title>
<%@ include file = "main_top.jsp"%>
<%
	OrderDao odao = OrderDao.getInstance();
	ArrayList<OrderBean> olist = odao.getOrders();
	DecimalFormat df = new DecimalFormat("###,###");
	MembersDao mdao = MembersDao.getInstance();
	ProductsDao pdao = ProductsDao.getInstance();
%>
				
				<div class="container-fluid">
                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">모든 쇼핑내역</h1>
                    <p class="mb-4">검색 기능으로 필터 가능하고 회원 아이디/성함 클릭하면 회원 정보페이지로 이동합니다.</p>

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
                                    		<th style = "width: 10%;">주문번호</th>
                                            <th>회원 아이디 / 성함</th>
                                            <th>상품</th>
                                            <th>구매수량</th>
                                            <th>총 가격</th>
                                            <th>구매 날짜</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>주문번호</th>
                                            <th>회원 아이디 / 성함</th>
                                            <th>상품</th>
                                            <th>구매수량</th>
                                            <th>총 가격</th>
                                            <th>구매 날짜</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                    <%for(OrderBean ob : olist){
                                    	MembersBean mb = mdao.getMemberByNo(ob.getMemNo());
                                    	ProductsBean pb = pdao.getProductByPnum(String.valueOf(ob.getPnum()));
                                    	%>
                                        <tr>
                                            <td><%= ob.getOrderNo() %></td>
                                            <td><a href = "viewMember.jsp?no=<%= mb.getNo()%>"><%= mb.getUserid() %> / <%= mb.getName() %></a></td>
                                            <td><%= pb.getBrand() %> <%= pb.getModel() %> - <%= pb.getColor() %> / <%= pb.getStorage() %> / <%= pb.getCond() %></td>
                                            <td><%= ob.getQty() %></td>
                                            <td>&#8361; <%= df.format(ob.getTotalPrice()) %>원</td>
                                            <td><%= ob.getSellDate() %></td>
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