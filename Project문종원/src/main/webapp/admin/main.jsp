<%@page import="java.text.DecimalFormat"%>
<%@page import="myPkg.RequestDao"%>
<%@page import="myPkg.ReviewDao"%>
<%@page import="myPkg.OrderDao"%>
<%@page import="myPkg.MembersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "main_top.jsp"%>
<%
	MembersDao mdao = MembersDao.getInstance();
	int memCount = mdao.getMembersCount();
	OrderDao odao = OrderDao.getInstance();
	int ordCount = odao.getOrderCount();
	ReviewDao rdao = ReviewDao.getInstance();
	int revCount = rdao.getReviewCount();
	RequestDao revDao = RequestDao.getInstance();
	int reqCount = revDao.getRequestCount();
	DecimalFormat df = new DecimalFormat("###,###");
	int salesCount = odao.getSalesCount();
%>
 
<div class="d-sm-flex align-items-center justify-content-between mb-4">
	<h1 class="h3 mb-0 text-gray-800" style = "margin-left: 30px;">GoPhone 관리자 홈</h1>
</div>

<div class="row" style = "justify-content: space-evenly; margin-top:100px;">

    <!-- Earnings (Monthly) Card Example -->
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-primary shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                            현재 가입된 회원 수</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= memCount %>명</div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-user fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-success shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                            받은 주문</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= ordCount %>개</div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-truck fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class = "row" style = "justify-content: space-evenly">

    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-warning shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                            중고폰 판매 신청</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= reqCount %>개</div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-question fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-danger shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                            등록된 상품 후기</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= revCount %>개</div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-pen fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
<div class = "row" style = "justify-content: space-evenly;">

    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-secondary shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                            총 매출 금액</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800">&#8361; <%= df.format(salesCount/10000) %>만원</div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-won-sign fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-md-6 mb-4">
    	<img src = "<%= request.getContextPath() %>/img/logo/logo.png" style = "margin-top:20px;">
    </div>
    </div>
<%@ include file = "main_bottom.jsp"%>
