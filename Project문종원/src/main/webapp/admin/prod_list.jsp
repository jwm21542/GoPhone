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
<%@page import="myPkg.ProductsBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="myPkg.ProductsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ProductsDao pdao = ProductsDao.getInstance();
	ArrayList<ProductsBean> plist = pdao.getProdList();
%>
<title>GoPhone || 상품목록</title>
<%@ include file = "main_top.jsp"%>
<div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">등록된 상품 목록</h1>
                    <p class="mb-4">현재 판매중인 중고폰 목록입니다. 모델명을 선택하면 더 자세한 정보를 볼수 있습니다.</p>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">현재 판매중인 중고폰</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                    		<th>모델</th>
                                            <th>브랜드</th>
                                            <th>용량</th>
                                            <th>등급</th>
                                            <th>가격</th>
                                            <th>총 수량</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>모델</th>
                                            <th>브랜드</th>
                                            <th>용량</th>
                                            <th>등급</th>
                                            <th>가격</th>
                                            <th>총 수량</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                    <%for(ProductsBean pb : plist){ 
                                    	%>
                                        <tr>
                                            <td><a href= "content.jsp?model=<%=pb.getModel()%>&brand=<%=pb.getBrand()%>&pimage=<%= pb.getPimage()%>&pimage2=<%= pb.getPimage2()%>"><%= pb.getModel() %></a></td>
                                            <td><%= pb.getBrand() %></td>
                                            <td><%= pb.getStorage() %></td>
                                            <td><%= pb.getCond() %></td>
                                            <td><%= pb.getPrice() %></td>
                                            <td><%= pb.getSqty() %></td>
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
