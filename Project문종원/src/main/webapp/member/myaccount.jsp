<%@page import="myPkg.OrderHistoryBean"%>
<%@page import="myPkg.ReviewBean"%>
<%@page import="myPkg.ReviewDao"%>
<%@page import="myPkg.MembersBean"%>
<%@page import="myPkg.MembersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>GoPhone || My Account</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function addressSearch() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("roadAddress").value = roadAddr;
                document.getElementById("jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
<%-- <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
 --%><script type="text/javascript" src="<%=request.getContextPath()%>/member/script.js"></script>
<%@ include file = "./../header.jsp"%>
<%
	if(sid == null){
		%>
		<script type = "text/javascript">
			alert("로그인 해셔야됩니다.");
			location.href = "<%=request.getContextPath()%>/login.jsp";
		</script>
		<%
	} else if(sid.equals("admin")){
		%>
		<script type = "text/javascript">
			alert("로그인 해셔야됩니다.");
		</script>
		<%
	}
	MembersBean member = mdao.getMemberByNo(sno);
	String[] areaCode = {"010", "02", "053", "032", "062", "042", "052"};
	String[] banks = {"국민은행", "기업은행", "하나은행", "신한은행", "우리은행", "농협은행", "케이뱅크", "카카오뱅크", "한국시티은행",
			"광주은행", "토스뱅크", "경남은행", "부산은행", "SC제일은행", "수협은행", "제주은행"};
	ArrayList<OrderHistoryBean> oList = mdao.getOrderHistory(sno);
%>
   <!-- BREADCRUMBS SETCTION START -->
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
                                <li class="active">계정관리</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
        <!-- BREADCRUMBS SETCTION END -->

        <!-- Start page content -->
        <div id="page-content" class="page-wrapper section">

            <!-- LOGIN SECTION START -->
            <div class="login-section mb-80">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8 offset-lg-2">
                            <div class="my-account-content" id="accordion">
                                <!-- 개인정보 -->
                                <div class="card mb-15">
                                    <div  class="card-header" id="headingOne">
                                        <h4 class="card-title">
                                            <a data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne" style = "color: #8041D9;">개인정보</a>
                                        </h4>
                                    </div>
                                    <div  id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-bs-parent="#accordion">
                                        <div class="card-body">
                                            <form action="updatePersonalInfo.jsp">
                                                <div class="new-customers">
                                                    <div class="p-30">
                                                        <div class="row">
                                                         	<label style = "color: #8041D9;">성함 / 이메일 주소</label>
                                                         <div class="col-sm-4">
                                                			<input type="text"  name = "name" placeholder="성함" value = "<%= member.getName()%>">
                                         			   	</div>
                                                            <div class="col-sm-8">
		                                        				<input type="text" name = "email" placeholder="이메일 주소" value = "<%= member.getEmail()%>">
                                                            </div>
                                                         	<label style = "color: #8041D9;">전화번호</label>
                                                       	<div class="col-sm-4">
			                                                <select name = "phn1" class="custom-select">
			                                                    <option value="">선택</option>
			                                                    <%for(String area : areaCode){ %>
			                                                    	<option value = "<%= area %>" <%if(member.getPhn1().equals(area)){ %> selected <%} %>)><%= area %></option>
			                                                    <%}	 %>
			                                                </select>
			                                            </div>
			                                            <div class="col-sm-4">
			                                                <input type="text" name = "phn2" placeholder="전화번호 앞" maxlength = "4" value = "<%= member.getPhn2()%>">
			                                            </div>
			                                            <div class="col-sm-4">
			                                                <input type="text" name = "phn3" placeholder="전화번호 뒤" maxlength = "4" value = "<%= member.getPhn3()%>">
			                                            </div>
                                                         	<label style = "color: #8041D9;">주민등록번호</label>
			                                            <div class="col-sm-6">
			                                                <input type="text" name = "brn1" placeholder="주민등록번호 앞" maxlength = "6" value = "<%= member.getBrn1()%>">
			                                            </div>
			                                            <div class="col-sm-6">
			                                                <input type="text" class = "key" name = "brn2" placeholder="주민등록번호 뒤" maxlength = "7" value = "<%= member.getBrn2()%>">
			                                            </div>
						                                            <!-- 새줄 -->
                                                        <label style = "color: #8041D9;">주소</label>
			                                            <div class="col-sm-4">
			                                         	   <input type="text" id="postcode" maxlength = "5" name = "postCode" placeholder="우편번호" value = "<%= member.getPostCode() %>">
			                                            </div>
			                                            <div class="col-sm-4">
															<input type="button" class = "submit-btn-1" style = "height:40px;" onclick="addressSearch()" value="우편번호 찾기"><br>
			                                            </div>
			                                            <div class="col-sm-4">
			                                            </div>
			                                            <!-- 새줄 -->
			                                            <div class="col-sm-6">
			                                            	<input type="text" id="roadAddress" name = "addr1" placeholder="도로명주소" value = "<%= member.getAddr1() %>">
			                                            </div>
			                                            <div class="col-sm-6">
			                                            	<input type="text" id="jibunAddress" name = "addr2" placeholder="지번주소" value = "<%= member.getAddr2() %>">
			                                            	<span id="guide" style="color:#999;display:none"></span>
			                                            </div>
			                                            <!-- 새줄 -->
			                                            <div class="col-sm-9">
															<input type="text" id="detailAddress" name = "addr3" placeholder="상세주소" value = "<%= member.getAddr2() %>">
														</div>
															<input type="hidden" id="extraAddress" placeholder="참고항목">  
                                                        </div>
                                                        <div class = "col-md-8" style = "color: #8041D9; font-size:20px;">
                                                        	<span>포인트 : </span><span> <%= df2.format(mb.getPoint()) %>P</span>
                                                        <div class="row">
                                                            <div class="col-md-6">
                                                                <button class="submit-btn-1 mt-20 btn-hover-1" type="submit"
                                                                    value="register" onClick = "return check()">수정하기</button>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <button class="submit-btn-1 mt-20 btn-hover-1 f-right"
                                                                    type="reset">초기화</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <!-- 비밀번호 변경 -->
                                <div class="card mb-15">
                                    <div class="card-header">
                                        <h4 class="card-title">
                                            <a data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo" style = "color: #8041D9;">비밀번호 변경</a>
                                        </h4>
                                    </div>
                                    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-bs-parent="#accordion">
                                        <div class="card-body">
                                            <form action="updatePassword.jsp" method = "post">
                                            	<label style = "color: #8041D9;">현재 비밀번호 : </label>
                                                         <div class="col-sm-12">
			                                            	<input type = "password" name = "oldpassword" placeholder = "현재 비밀번호">
			                                            	<input type = "hidden" name = "oldpassword2" value = "<%= member.getPassword() %>">
                                         			   	</div>
                                            	<label style = "color: #8041D9;">새로운 비밀번호 : </label>
                                                         <div class="col-sm-12">
														 <p>영문자, 숫자, 특수문자(!, @, #, +) 최소 하나씩 포함하고 <br>8자리~15자리 길이로 입력해주세요.</p>
                                                         
			                                            	<input type = "password" name = "password" placeholder = "새로운 비밀번호" onBlur = "pwcheck()" onKeyUp = "passCheck()">
			                                            	<input type = "password" name = "password2" placeholder = "새로운 비밀번호 다시 입력" onKeyUp = "passCheck()">
                                         			   	</div>
                                         			    <div class = "col-sm-6">
                                         			   		<span id = "pwMessage"></span>
                                         			   	</div>
                                         			   	<div class="row">
                                         			   	<div class = "col-md-1"></div>
                                                        <div class="col-md-5">
                                                            <button class="submit-btn-1" type="submit"
                                                                value="register" onClick = "return passwordCheck()">수정하기</button>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <button class="submit-btn-1 f-right"
                                                                type="reset">초기화</button>
                                                        </div>
                                         			   	<div class = "col-md-1"></div>
                                                    </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <!-- 은행 정보 보기/변경. -->
                                <div class="card mb-15">
                                    <div class="card-header">
                                        <h4 class="card-title">
                                            <a data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree" style = "color: #8041D9;">은행 정보</a>
                                        </h4>
                                    </div>
                                    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-bs-parent="#accordion">
                                        <div class="card-body">
                                            <form action="updateBanking.jsp">
                                                <div class="billing-details p-30">
                                                    <div class="col-sm-5">
                                                <select class="custom-select" name = "bankName">
                                                    <option value="">은행 선택</option>
                                                    <%for(String bank : banks){ %>
                                                    	<option value = "<%= bank %>" <%if(member.getBankName().equals(bank)){ %> selected <%} %>><%= bank %></option>
                                                    <%} %>
                                                </select>
	                                            </div>
	                                            <div class="col-sm-7">
	                                                <input type="text" name = "bankNum" placeholder="계좌번호 ( - 빼고 입력)" maxlength = "14" value = "<%= member.getBankNum() %>">
	                                            </div>
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <button class="submit-btn-1 mt-20 btn-hover-1" type="submit"
                                                                value="register" onClick = "return bankCheck()">수정</button>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <button class="submit-btn-1 mt-20 btn-hover-1 f-right"
                                                                type="reset">초기화</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <%
                                	ReviewDao rdao = ReviewDao.getInstance();
                                	ArrayList<ReviewBean> rlist = rdao.getReviewByMemNo(sno);
                                	
                                %>
                                <!-- 작성한 리뷰 보기 -->
                                <div class="card mb-15">
                                    <div class="card-header">
                                        <h4 class="card-title">
                                            <a data-bs-toggle="collapse" data-bs-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix" style = "color: #8041D9;">작성한 리뷰 보기</a>
                                        </h4>
                                    </div>
                                    <div id="collapseSix" class="collapse" aria-labelledby="headingSix" data-bs-parent="#accordion">
                                        <div class="card-body">
                                                <!-- our order -->
                                                <div class="payment-details p-30">
                                                    	<%if(rlist != null){
                                                    		for(ReviewBean rb : rlist){%> 
                                                    			<div class = "row">
                                                    				<div class = "col-md-6">
                                                    				상품 : <a href = "single_Product.jsp?brand=<%= rb.getBrand() %>&model=<%= rb.getModel() %>" style = "color: #8041D9; !important"><%= rb.getBrand() %> <%= rb.getModel() %></a>&emsp;<%= rb.getRevDate() %>
                                                    				</div>
                                                    				<div class = "col-md-12" style =  "margin-bottom: 20px;">
                                                    				리뷰 내용: <span style = "color: black !important;"><%= rb.getRevText() %></span>	
                                                    				</div>
                                                    			</div>
                                                    			<hr>
                                                        	<%}
                                                    	} else {%>
                                                    		<div class = "row">
                                                    			<div class = "col-md-12">
                                                    				아직 작성한 리뷰 없습니다.
                                                    			</div>
                                                    		</div>
                                                    	<%} %>
                                                </div>
                                        </div>
                                    </div>
                                </div>
                                
                                   <!-- My Order info -->
                                <div class="card mb-15">
                                    <div class="card-header">
                                        <h4 class="card-title">
                                            <a data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour" style = "color: #8041D9;">주문 내역</a>
                                        </h4>
                                    </div>
                                    <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-bs-parent="#accordion">
                                        <div class="card-body">
                                            <form action="#">
                                                <!-- our order -->
                                                <div class="payment-details p-30">
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
                                                            <td class="td-title-2">&#8361; <%= df2.format(ob.getTotalPrice()) %>원</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="td-title-1">주문 날짜</td>
                                                            <td class="td-title-2"><%= String.valueOf(ob.getBuyDate())%></td>
                                                        </tr>
                                                        <%} %>
                                                    </table>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <!-- Payment Method -->
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="card-title">
                                            <a data-bs-toggle="collapse" data-bs-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive" style = "color: #8041D9;">계정 해제</a>
                                        </h4>
                                    </div>
                                    <div id="collapseFive" class="collapse" aria-labelledby="headingFive" data-bs-parent="#accordion">
                                        <div class="panel-body">
                                            <form action="deleteAccount.jsp">
                                                <div class="new-customers p-30">
                                                    <div class="row alert alert-danger">
                                                    	<h3>계정을 해제하시면 복구 불가능합니다!</h3>
                                                    </div>
                                                    <div class="row">
                                                    
                                                        <div class="col-md-6">	
                                                            <button class="submit-btn-1 mt-20 btn-hover-1" type="submit"
                                                                value="register" onClick = "return confirm('계정 삭제하겠습니까?')">계정 해제</button>
                                                        </div>
                                                        <div class="col-md-6">	
                                                            <input type = "button" class="submit-btn-1 mt-20 btn-hover-1" onClick = "location.href='<%= conPath %>/main.jsp'" value = "홈 페이지로 돌아가기">
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- LOGIN SECTION END -->
        </div>
        <!-- End page content -->
<%@ include file = "./../footer.jsp"%>
    