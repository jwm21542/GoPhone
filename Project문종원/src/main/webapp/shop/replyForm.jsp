<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file = "./../header.jsp"%>
<title>답글쓰기</title>
<%
	request.setCharacterEncoding("UTF-8");
	String ref = request.getParameter("ref");
	String re_step = request.getParameter("re_step");
	String re_level = request.getParameter("re_level");
	String pageNum = request.getParameter("pageNum");
%>
<script type = "text/javascript">
function writeCheck(){
	if($('input[name=email]').val() == ""){
		alert("이메일 입력하세요");
		$('input[name=email]').focus();
		return false;
	}
	if($('input[name=email]').val() != "<%= mb.getEmail() %>"){
		alert("이메일 틀렸습니다");
		$('input[name=이메일]').select();
		return false;
	}
	if($('input[name=password]').val() == ""){
		alert("비밀번호 입력하세요");
		$('input[name=password]').focus();
		return false;
	}
	if($('input[name=password]').val() != "<%= mb.getPassword() %>"){
		alert("비밀번호 틀렸습니다");
		$('input[name=password]').select();
		return false;
	}
	if($('input[name=title]').val() == ""){
		alert("제목 작성하세요");
		$('input[name=title]').focus();
		return false;
	}
	if($('textarea[name=content]').val() == ""){
		alert("내용 작성하세요");
		$('input[name=content]').focus();
		return false;
	}
}
</script>
<div class="breadcrumbs-section mb-80 section">
	<div class="container">
	    <div class="row">
	        <div class="col-lg-12">
	            <ol class="breadcrumb p-30">
	                <li><a href="<%= conPath %>/main.jsp"><i class="zmdi zmdi-home"></i>홈 페이지</a></li>
	                <li><a href="<%= conPath %>/shop/viewBoardList.jsp"><i class="zmdi zmdi-comments">게시판 보기</i></a>
	                <li class = "active"><i class="zmdi zmdi-mail-reply">답글 작성</i></li>
	            </ol>
	        </div>
	    </div>
	</div>
</div>	
<section>
<div class="message-box-section mt--50 mb-80">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="message-box box-shadow white-bg">
                                <form id="writeBoard" action="replyProc.jsp">
	                                	<input type = "hidden" value = "<%= sid %>" name = "id">
	                                	<input type = "hidden" value = "<%= sno %>" name = "no">
	                                	<input type = "hidden" name = "ref" value = "<%= ref%>">
										<input type = "hidden" name = "re_step" value = "<%= re_step%>">
										<input type = "hidden" name = "re_level" value = "<%=re_level %>">
										<input type = "hidden" name = "pageNum" value = "<%= pageNum%>">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <h4 class="blog-section-title border-left mb-30">글작성</h4>
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" name="name" readonly value = "<%= mb.getName()%>">
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" name="phone" readonly value = "<%= mb.getPhn1() + "-" + mb.getPhn2() + "-" + mb.getPhn3()%>">
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="text" name="email" placeholder="계정 이메일">
                                        </div>
                                        <div class="col-lg-6">
                                            <input type="password" name="password" placeholder="계정 비밀번호">
                                        </div>
                                        <div class="col-lg-12">
                                            <input type="text" name="title" placeholder="제목">
                                        </div>
                                        <div class="col-lg-12" style = "height: 220px !important;">
                                            <textarea class="custom-textarea" name="content"
                                                placeholder="내용" style = "height:200px;"></textarea>
                                        </div>
                                        <div class = "col-lg-12">
                                            <button class="submit-btn-1 mt-30 btn-hover-1" type="submit" style = "margin-bottom : 30px;" onClick = "return writeCheck()">글쓰기</button>
											<input class="submit-btn-1 mt-30 btn-hover-1" type = "button" value = "목록" onClick = "location.href = 'viewBoardList.jsp'">
										</div>
                                    </div>
                                    <p class="form-message"></p>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- MESSAGE BOX SECTION END -->
        </section>
<%@ include file = "./../footer.jsp"%>