<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>GoPhone || 주문완료</title>
<%@ include file = "./../header.jsp"%>

<%
	Vector<ProductsBean> clist = shopCart.getAllProducts();
	String points = request.getParameter("points");
    int delivery = 0;
    int subTotal = totalPrice;
	if(totalPrice < 700000){ 
		delivery =  3000;
		totalPrice -= delivery;
	}
	int pointsUsed = 0;
	if(points != null){
		pointsUsed = Integer.parseInt(points);
		totalPrice += pointsUsed;
	}
%>

	<div class="tab-pane active" id="order-complete">
									<div class = "col-lg-12" style = "text-align:center;">
                                    	<img src = "<%= conPath%>/img/banner/banner5.jpg" style = "width: 50%; height:auto;">
                                    </div>
                                    <div class="order-complete-content box-shadow">
                                        <div class="thank-you p-30 text-center">
                                            <h3 class="text-black-5 mb-0"><mark>주문 완료됬습니다.</mark></h3>
                                        </div>
                                        <div class="row" style = "justify-content: space-evenly;">
                                            <!-- our order -->
                                            <div class="col-md-6">
                                                <div class="payment-details p-30">
                                                    <h6 class="widget-title border-left mb-20">주문 정보</h6>
                                                    <table>
                                                    	<%for(ProductsBean pb : clist){%>
                                                        <tr>
                                                            <td class="td-title-1"><%=pb.getBrand() %> <%= pb.getModel() %> - <%= pb.getColor() %>/<%=pb.getStorage() %>/<%= pb.getCond() %></td>
                                                            <td class="td-title-2">x <%= pb.getSqty() %></td>
                                                        </tr>
                                                        <%} %>
                                                        <tr>
                                                            <td class="td-title-1">금액</td>
                                                            <td class="td-title-2">&#8361; <%= df2.format(subTotal) %>원</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="td-title-1">배송비</td>
                                                            <td class="td-title-2"><%= df2.format(delivery) %>P</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="td-title-1">포인트 사용</td>
                                                            <td class="td-title-2"><%= df2.format((int)(totalPrice*0.05)) %>P</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="td-title-1">새로 받은 포인트</td>
                                                            <td class="td-title-2"><%= df2.format(pointsUsed) %></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="order-total">최종 금액</td>
                                                            <td class="order-total-price">&#8361; <%= df2.format(totalPrice) %></td>
                                                        </tr>
                                                    </table>
                                                </div>         
                                            </div>
                                            <div class="col-md-4">
                                                <div class="bill-details p-30">
                                                    <h6 class="widget-title border-left mb-20">회원 정보</h6>
                                                    <ul class="bill-address">
                                                        <li>
                                                            <span>주소:</span>
                                                            <p>도로명주소 : <%= mb.getAddr1() %></p>
                                                            <p>지번주소 : <%= mb.getAddr2() %></p>
                                                            <p>우편번호 : <%= mb.getPostCode() %> </p>
                                                            <p><%= mb.getName() %> </p>
                                                        </li>
                                                        <li>
                                                            <span>이메일:</span>
															<%= mb.getEmail() %>
                                                        </li>
                                                        <li>
                                                            <span>phone : </span>
                                                            <%= mb.getPhn1() + "-" + mb.getPhn2() + "-" + mb.getPhn3() %>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
<%
	clist.removeAllElements();
%>
<%@ include file = "./../footer.jsp"%>