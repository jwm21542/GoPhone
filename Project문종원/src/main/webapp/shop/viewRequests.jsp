<%@page import="myPkg.RequestBean"%>
<%@page import="myPkg.ProductsDao"%>
<%@page import="myPkg.RequestDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>GoPhone</title>
<%@ include file = "./../header.jsp" %>
<%@ include file = "./../headerBanner.jsp"%>
<%
	if(mb == null){
		%>
			<script type = "text/javascript">
				alert("먼저 로그인해야 됩니다.")
				location.href = "<%= conPath%>" + "/login.jsp";
			</script>	
		<%
	}
	RequestDao rdao = RequestDao.getInstance();
	ProductsDao pdao= ProductsDao.getInstance();
	ArrayList<RequestBean> rlist = rdao.getRequests(sno);
%>
<script type = "text/javascript">
	function deleteCheck(){
		var delCheck = confirm("판매 신청을 취소하겠습니까?");
		if(!delCheck){
			return false;
		}
	}
</script>
   <div class="breadcrumbs-section mb-80 section">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <ol class="breadcrumb p-30">
                                <li><a href="<%= conPath %>/main.jsp"><i class="zmdi zmdi-shield-home"></i>홈 페이지</a></li>
                                <li><%if(sid == null){ %>
                                        <a href="<%= conPath%>/login.jsp">
                                            <i class="zmdi zmdi-account"></i>
                                            계정관리
                                        </a>
                                    <%} else if(!sid.equals("admin")){%>
										<a href="<%= conPath%>/member/myaccount.jsp">
                                            <i class="zmdi zmdi-account"></i>
                                            <%= mb.getName() %>님
                                        </a>
                                    <%} else {%>
                                    	<a href="<%= conPath%>/admin/myaccount.jsp">
                                            <i class="zmdi zmdi-shield-security"></i>
                                            관리자 페이지
                                        </a>
                                    <%} %></li>
                                <li class="active">판매 신청조회</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>	
  <!-- Start page content -->
    <section id="page-content" class="page-wrapper section">
            <div class="shop-section mb-80">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <!-- Tab panes -->
                                <!-- shopping-cart start -->
                                        <div class="message-box box-shadow white-bg">
                                
                                            <div class="table-content table-responsive mb-50">
                                                <table class="text-center">
                                                    <thead>
                                                        <tr>
                                                            <th class="product-thumbnail" style = "width:33%">상품</th>
                                                            <th class="product-price" style = "width:18%;">매입가</th>
                                                            <th class="product-quantity">결정 / 등급</th>
                                                            <th class="product-subtotal">신청 번호</th>
                                                            <th class="product-remove">회원번호</th>
                                                            <th class="product-remove">신청 취소하기</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    <%for(RequestBean rb : rlist){ 
                                                    	ProductsBean pb = pdao.getProductByPnum(String.valueOf(rb.getPnum()));
                                                    	
                                                    %>
	                                                        <tr>
	                                                        	<td class="product-thumbnail">
	                                                                <div class="pro-thumbnail-img">
	                                                                    <img src="<%= conPath %>/images/<%=pb.getPimage() %>" alt="">
	                                                                </div>
	                                                                <div class="pro-thumbnail-info text-start">
	                                                                    <h6 class="product-title-2" style = "color : #8041D9;">
	                                                                        <a href="singleProduct.jsp?brand=<%= pb.getBrand()%>&model=<%= pb.getModel() %>"><%= pb.getBrand() %> <%= pb.getModel() %></a>
	                                                                    </h6>
	                                                                    <p>용량: <%= pb.getStorage() %></p>
	                                                                    <p>등급: <%= pb.getCond() %></p>
	                                                                    <p>색상: <%= pb.getColor() %></p>
	                                                                </div>
	                                                        	<td>
	                                                        		&#8361;<%= df2.format(rb.getSellPrice()) %>원
	                                                        	</td>
	                                                        	<td>
	                                                        		<%= rb.getApprove()%> / <%= pb.getCond() %>급
	                                                        	</td>
	                                                        	<td>
	                                                        		<%= rb.getReqno()%>
	                                                        	</td>
	                                                        	<td>
	                                                        		<%= rb.getMemno()%>
	                                                        	</td>
	                                                        	<td>
	                                                        		<% if(rb.getApprove().equals("미결정")){ %>
	                                                        		<a href = "requestDeleteProc.jsp?reqno=<%= rb.getReqno() %>" onClick = "return deleteCheck()">취소</a>
	                                                        		<%} else {%>
	                                                        		결정/입금 처리 후 취소 불가능합니다.
	                                                        		<%} %> 
	                                                        	</td>
	                                                        </tr>
	                                                <%} %>
                                                    </tbody>
                                                </table>
                                                </div>
                                            </div>
                                    </div>
                                </div>
                                <!-- shopping-cart end -->
                            </div>
                        </div>
            <!-- SHOP SECTION END -->             
        </section>
<%@ include file = "./../footer.jsp"%>
    