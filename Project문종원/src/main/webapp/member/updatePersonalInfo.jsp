<%@page import="myPkg.MembersBean"%>
<%@page import="myPkg.MembersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String sid = (String)session.getAttribute("sid");
	int sno = 0;
	MembersDao mdao = MembersDao.getInstance();
	if(sid != null){
		sno = (Integer)session.getAttribute("sno");
	}
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String phn1 = request.getParameter("phn1");
	String phn2 = request.getParameter("phn2");
	String phn3 = request.getParameter("phn3");
	String brn1 = request.getParameter("brn1");
	String brn2 = request.getParameter("brn2");
	String postCode = request.getParameter("postCode");
	String addr1 = request.getParameter("addr1");
	String addr2 = request.getParameter("addr2");
	String addr3 = request.getParameter("addr3");
	
	MembersBean mb = new MembersBean();
	mb.setNo(sno);
	mb.setName(name);
	mb.setEmail(email);
	mb.setPhn1(phn1);
	mb.setPhn2(phn2);
	mb.setPhn3(phn3);
	mb.setBrn1(brn1);
	mb.setBrn2(brn2);
	mb.setPostCode(postCode);
	mb.setAddr1(addr1);
	mb.setAddr2(addr2);
	mb.setAddr3(addr3);
	int cnt = mdao.updatePersonalInfo(mb);
	String msg = "";
	if(cnt > 0) {
		msg = "수정 성공했습니다";
	} else {
		msg = "수정 실패했습니다";
	}
%>
<script type = "text/javascript">
	alert("<%= msg %>");
	location.href= "myaccount.jsp";
</script>