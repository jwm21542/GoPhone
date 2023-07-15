<%@page import="java.text.DecimalFormat"%>
<%@page import="myPkg.OrderHistoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="myPkg.MembersBean"%>
<%@page import="myPkg.MembersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type = "text/css">
@font-face {
  font-family: 'password';
  font-style: normal;
  font-weight: 400;
  src: url(https://jsbin-user-assets.s3.amazonaws.com/rafaelcastrocouto/password.ttf);
}
ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
}
#title{
	color:#4e73df;
}
</style>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	MembersDao mdao = MembersDao.getInstance();
	MembersBean mb = mdao.getMemberByNo(no);
	ArrayList<OrderHistoryBean> oList = mdao.getOrderHistory(no);
	DecimalFormat df = new DecimalFormat("###,###");
%>
<title>GoPhone || 회원정보</title>
<%@ include file = "main_top.jsp"%>

<div class="container-fluid" style = "display:flex; justify-content:center;">
	 			<div class="card shadow mb-4" style = "width: 55%;">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">회원 정보</h6>
                                </div>
                                <div class="card-body" style = "display:flex; justify-content:space-between;">
                 <div class = "col-md-4">
                 	<ul id = "title">
                 		<li>성함 : </li>
                 		<li>아이디 : </li>
                 		<li>주민등록번호 : </li>
                 		<li>은행 정보 : </li>
                 		<li>이메일 주소 : </li>
                 		<li>도로명 주소: </li>
                 		<li>지번 주소: </li>
                 		<li>상세 주소: </li>
                 		<li>우편번호: </li>
                 		<li>가입 날짜: </li>
                 		<li>포인트 : </li>
                 	</ul>
                 </div>
                 <div class = "col-md-8">
                 	<ul>
                 		<li><%= mb.getName() %></li>
                 		<li><%= mb.getUserid() %></li>
                 		<li><%= mb.getBrn1() %>-<span style = "font-family: 'password';"><%= mb.getBrn2() %></span></li>
                 		<li><%= mb.getBankName() %> - <%= mb.getBankNum() %></li>
                 		<li><%= mb.getEmail() %></li>
                 		<li><%= mb.getAddr1() %></li>
                 		<li><%= mb.getAddr2() %></li>
                 		<li><%= mb.getAddr3() %></li> 
                 		<li><%= mb.getPostCode() %></li>
                 		<li><%= mb.getRegdate() %></li>
                 		<li><%= df.format(mb.getPoint()) %>P</li>
                 	</ul>
                 </div>
             </div>
           	 </div>
</div>
<div class="container-fluid" style = "display:flex; justify-content:center;">
	<div class="card shadow mb-4" style = "width: 55%;">
	                                <!-- Card Header - Accordion -->
	    <a href="#collapseCardExample" class="d-block card-header py-3" data-toggle="collapse"
	        role="button" aria-expanded="true" aria-controls="collapseCardExample">
	        <h6 class="m-0 font-weight-bold text-primary"><%= mb.getName() %>님 쇼핑내역</h6>
	    </a>
	    <!-- Card Content - Collapse -->
	    <div class="collapse show" id="collapseCardExample">
	        <div class="card-body">
	            <table>
                 	<tr>
                 		<td>
                 			<mark>주문한 상품 :</mark>		
                 		</td>
                 	</tr>
                 	<%
                 	int j = 1;
                 	for(OrderHistoryBean ob : oList){ %>
                 	<tr>
                 		<td style = "color: #8041D9">
                 		<%=j %> :
                 		<%j++; %> 
                 		</td>
                 	</tr>
                     <tr>
                         <td class="td-title-1"><%=ob.getBrand() + " " + ob.getModel() + " x " + ob.getSqty()%></td>
                         <td class="td-title-2"><%=ob.getColor() + " / " + ob.getStorage() +" / " + ob.getCond()%></td>
                     </tr>
                     <tr>
                         <td class="td-title-1">총 금액</td>
                         <td class="td-title-2">&#8361; <%= df.format(ob.getTotalPrice()) %>원</td>
                     </tr>
                     <tr>
                         <td class="td-title-1">주문 날짜</td>
                         <td class="td-title-2"><%= String.valueOf(ob.getBuyDate())%></td>
                     </tr>
                     <%} %>
                 </table>
	        </div>
	    </div>
	</div>
</div>
      

<%@ include file = "main_bottom.jsp"%>