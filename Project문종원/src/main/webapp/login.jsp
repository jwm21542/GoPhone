<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type = "text/css">
@font-face {
  font-family: 'password';
  font-style: normal;
  font-weight: 400;
  src: url(https://jsbin-user-assets.s3.amazonaws.com/rafaelcastrocouto/password.ttf);
}

input.key {
  font-family: 'password';
  width: 100px; height: 16px;  
}
input.key::first-letter {
	font-family: arial !important;
}

</style>
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
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/script.js"></script>
<title>GoPhone || Login</title>
<%@ include file = "header.jsp"%>
        <!-- BREADCRUMBS SETCTION START -->
<%
	String[] areaCode = {"010", "02", "053", "032", "062", "042", "052"};
	String[] banks = {"국민은행", "기업은행", "하나은행", "신한은행", "우리은행", "농협은행", "케이뱅크", "카카오뱅크", "한국시티은행",
		"광주은행", "토스뱅크", "경남은행", "부산은행", "SC제일은행", "수협은행", "제주은행"};
%>
   <div class="breadcrumbs-section mb-80 section">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <ol class="breadcrumb p-30">
                                <li><a href="<%= conPath %>/main.jsp"><i class="zmdi zmdi-shield-home"></i>홈 페이지</a></li>
                                <li><%if(sid == null){ %>
                                        <a href="<%= conPath%>/login.jsp">
                                            <i class="zmdi zmdi-account"></i>
                                            로그인/회원가입
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
                        <div class="col-lg-6">
                            <div class="registered-customers">
                                <h6 class="widget-title border-left mb-50">로그인</h6>
                                <form action="loginProc.jsp">
                                    <div class="login-account p-30 box-shadow">
                                        <p>계정 등록 되어있으면 로그인 해주세요.</p>
                                        <input type="text" name="id" placeholder="아이디">
                                        <input type="password" name="lgpassword" placeholder="비밀번호">
                                        <p><small><a href="./member/findIdForm.jsp">아이디 찾기</a> / <a href="./member/findPwForm.jsp">비밀번호 찾기</a></small></p>
                                        <button class="submit-btn-1 btn-hover-1" type="submit" onClick = "return loginCheck()">로그인</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <!--  회원가입! -->
                        <div class="col-lg-6">
                            <div class="new-customers">
                                <form action="./member/signUpProc.jsp" onSubmit = "return check()" method = "post">
                                    <h6 class="widget-title border-left mb-50">회원 가입</h6>
                                    <div class="login-account p-30 box-shadow">
                                        <div class="row">
                                            <div class="col-sm-5">
                                                <input type="text"  name = "name" placeholder="성함">
                                            </div>
                                            <div class="col-sm-7" style="display:flex; justify-content:center;">
                                                <input type="text" name = "userid" placeholder="아이디" onKeyUp = "keycheck()">
                                                <input type = "button" value = "중복확인" class = "submit-btn-1" onClick = "duplicate()" style = "height:40px;">
                                            </div>
                                              <!-- 새줄 -->
                                            <div class="col-sm-6">
                                            <br>
                                            </div>
                                            <div class="col-sm-6"  style = "margin-bottom: 10px;">
                                                <span id = "idMessage"></span>
                                            </div>	
                                            <!-- 새줄 -->
                                            <div class="col-sm-6">
                                                <input type="text" name = "brn1" placeholder="주민등록번호 앞" maxlength = "6">
                                            </div>
                                            <div class="col-sm-6">
                                                <input type="text" class = "key" name = "brn2" placeholder="주민등록번호 뒤" maxlength = "7">
                                            </div>
                                            <!-- 새줄 -->
                                            <div class="col-sm-5">
                                                <select class="custom-select" name = "bankName">
                                                    <option value="">은행 선택</option>
                                                    <%for(String bank : banks){ %>
                                                    	<option value = "<%= bank %>"><%= bank %></option>
                                                    <%} %>
                                                </select>
                                            </div>
                                            <div class="col-sm-7">
                                                <input type="text" name = "bankNum" placeholder="계좌번호 ( - 빼고 입력)" maxlength = "14">
                                            </div>
                                            <!-- 새줄 -->
                                            <div class="col-sm-4">
                                                <select name = "phn1" class="custom-select">
                                                    <option value="default">선택</option>
   													<%for(String area : areaCode){ %>
			                                        	<option value = "<%= area %>"><%= area %></option>
			                                        <%}	 %>
                                                </select>
                                            </div>
                                            <div class="col-sm-4">
                                                <input type="text" name = "phn2" placeholder="전화번호 앞" maxlength = "4">
                                            </div>
                                            <div class="col-sm-4">
                                                <input type="text" name = "phn3" placeholder="전화번호 뒤" maxlength = "4">
                                            </div>
                                            <!-- 새줄 -->
                                            <div class="col-sm-4">
                                         	   <input type="text" id="postcode" maxlength = "5" name = "postCode" placeholder="우편번호">
                                            </div>
                                            <div class="col-sm-4">
												<input type="button" class = "submit-btn-1" style = "height:40px;" onclick="addressSearch()" value="우편번호 찾기"><br>
                                            </div>
                                            <div class="col-sm-4">
                                            </div>
                                            <!-- 새줄 -->
                                            <div class="col-sm-6">
                                            	<input type="text" id="roadAddress" name = "addr1" placeholder="도로명주소">
                                            </div>
                                            <div class="col-sm-6">
                                            	<input type="text" id="jibunAddress" name = "addr2" placeholder="지번주소">
                                            	<span id="guide" style="color:#999;display:none"></span>
                                            </div>
                                            <!-- 새줄 -->
                                            <div class="col-sm-9">
												<input type="text" id="detailAddress" name = "addr3" placeholder="상세주소">
											</div>
												<input type="hidden" id="extraAddress" placeholder="참고항목">                                            </div>
		                                        <input type="text" name = "email" placeholder="이메일 주소">
												<p>영문자, 숫자, 특수문자(!, @, #, +) 최소 하나씩 포함하고 <br>8자리~15자리 길이로 입력해주세요.</p>
		                                        <input type="password"  name = "password" placeholder="비밀번호" onBlur = "pwcheck()" onKeyUp = "passCheck()">
		                                        <input type="password"  name = "password2" onKeyUp = "passCheck()" placeholder="비밀번호 확인">
                                              <div class="col-sm-6">
                                            <br>
                                            </div>
                                            <div class="col-sm-6"  style = "margin-bottom: 10px;">
                                                <span id = "pwMessage"></span>
                                            </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <button class="submit-btn-1 mt-20 btn-hover-1" type="submit" value="가입하기">가입하기</button>
                                            </div>
                                            <div class="col-md-6">
                                                <button class="submit-btn-1 mt-20 btn-hover-1 f-right" type="reset">초기화</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- LOGIN SECTION END -->             

        </div>
        <!-- End page content -->
<%@ include file = "footer.jsp"%>
