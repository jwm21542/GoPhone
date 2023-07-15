<%@page import="myPkg.ProductsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "./../header.jsp"%>
<%@ include file = "./../headerBanner.jsp"%>
<style type = "text/css">
.input-group-text{
	 height: 40px;
	 font-size: 15px;
	 width: 64px;
	 text-align: center;
}
.form-select{
	width:50% !important;
	font-size: 15px;
}
#priceBlock{
	font-size:22px;
	color: black;
	margin-left: 14px;
}
</style>
<title>GoPhone || 아이디 찾기</title>
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
                                <li class="active">아이디 찾기</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>	
<%
	String myName = request.getParameter("name");
	String email = request.getParameter("email");
	String id = "";
	if(myName != null && email != null){
		id = mdao.findId(myName, email);
	}
%>

<script type= "text/javascript">
	function check(){
		if($('input[name=name]').val() == ""){
			alert("성함 입력해주세요");
			$('input[name=name]').focus();
			return false;
		}
		if($('input[name=email]').val() == ""){
			alert("이메일 입력해주세요");
			$('input[name=email]').focus();
			return false;
		}
	}
</script>
            <!-- MESSAGE BOX SECTION START -->
            <div class="message-box-section mt-50 mb-80">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="message-box box-shadow white-bg">
                                <form id="myform" action="findIdForm.jsp">
                                	<div class = "col-md-12" style = "display: flex;">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <h4 class="blog-section-title border-left mb-30">아이디 찾기</h4>
                                        </div>
										<div class="input-group mb-3">
										  <label class="input-group-text" for="inputGroupSelect04">성함 : </label>
										  <input type = "text" name = "name" placeholder = "성함 입력하세요" style = "width: 80%;">
										</div>
										<div class="input-group mb-3">
										  <label class="input-group-text" for="inputGroupSelect04">이메일 : </label>
										  <input type = "text" name = "email" placeholder = "이메일 입력하세요" style = "width: 80%;">
										</div>
                                        <div class="col-lg-12">
                                            <button class="submit-btn-1 mt-30 btn-hover-1" type="submit" onclick = "return check()">아이디 찾기</button>
 											<span id = "idBlock" style = "color:black; margin-left: 20px;"><%if(id != ""){ %>아이디 : <%= id %><%} else if(myName != null && email != null && id == ""){%>입력한 성함/이메일에 해당되는 아이디 없습니다.<%} %></span>
                                        </div>
                                    </div>
                                    <div class = "col-lg-5">
                                    	<img src = "<%= conPath%>/img/banner/findID.jpg" style = "width: 90%; height:auto;margin-left: 40px; margin-top:46px;">
                                    </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
<%@ include file = "./../footer.jsp"%>