<%@page import="myPkg.MembersBean"%>
<%@page import="myPkg.MembersDao"%>
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
<title>GoPhone || 회원목록</title>
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
	
	MembersDao mdao = MembersDao.getInstance();
	ArrayList<MembersBean> mlist = mdao.getAllMembers();
	
%>
				
				<div class="container-fluid">
                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">회원 목록</h1>
                    <p class="mb-4">회원번호 클릭하시면 자세한 회원 정보 볼수있습니다.</p>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">GoPhone 회원 목록</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                    		<th style = "width: 10%;">회원번호</th>
                                            <th>성함</th>
                                            <th>아이디</th>
                                            <th>이메일 주소</th>
                                            <th>전화번호</th>
                                            <th>가입 날짜</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>회원번호</th>
                                            <th>성함</th>
                                            <th>아이디</th>
                                            <th>이메일 주소</th>
                                            <th>전화번호</th>
                                            <th>가입 날짜</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                    <%for(MembersBean mb : mlist){
                                    	%>
                                        <tr>
                                            <td><a href= "viewMember.jsp?no=<%= mb.getNo() %>"><%= mb.getNo() %></a></td>
                                            <td><%= mb.getName()%></td>
                                            <td><%= mb.getUserid() %></td>
                                            <td><%= mb.getEmail() %></td>
                                            <td><%= mb.getPhn1() + "-" + mb.getPhn2() + "-" + mb.getPhn3() %></td>
                                            <td><%= mb.getRegdate() %></td>
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