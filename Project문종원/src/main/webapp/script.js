/**
 * 
 */
var use = "";
var isCheck = false;
var pwCheck = false;

 function check(){
	
	if($('input[name=name]').val() == ""){
		alert("성함을 입력해주세요.");
		$('input[name=name]').focus();
		return false;
	}
	if($('input[name=userid]').val() == ""){
		alert("아이디를 입력해주세요.");
		$('input[name=userid]').focus();
		return false;
	}
	if(use == "missing"){
		alert("아이디를 입력해주세요.");
		$('input[name=userid]').focus();
		return false;
	}
	if(use == "impossible"){
		alert("이미 등록된 아이디입니다");
		$('input[name=userid]').select();
		return false;
	}
	if(isCheck == false){
		alert("아이디 중복체크하세요.");
		$('input[name=userid]').select();
		return false;
	}
	if($('input[name=brn1]').val() == ""){
		alert("주민등록번호 입력해주세요");
		$('input[name=brn1]').focus();
		return false;
	}
	if(isNaN($('input[name=brn1]').val())){
		alert("주민등록번호는 숫자형식으로 입력해주세요");
		$('input[name=brn1]').select();
		return false;
	}
	if($('input[name=brn2]').val() == ""){
		alert("주민등록번호 입력해주세요");
		$('input[name=brn2]').focus();
		return false;
	}
	if(isNaN($('input[name=brn2]').val())){
		alert("주민등록번호는 숫자형식으로 입력해주세요");
		$('input[name=brn2]').select();
		return false;
	}
	if($('select[name=bankName]').find(":selected").val() == ""){
		alert("은행 선택해주세요");
		return false;
	}
	if($('input[name=bankNum]').val() == ""){
		alert("계좌번호 입력해주세요");
		$('input[name=bankNum]').focus();
		return false;
	}
	if(isNaN($('input[name=bankNum]').val())){
		alert("계좌번호는 숫자형식으로 입력해주세요");
		$('input[name=bankNum]').select();
		return false;
	}
	if($('select[name=phn1]').find(":selected").val() == ""){
		alert("지역번호 선택해주세요");
		return false;
	}
	if($('input[name=phn2]').val() == ""){
		alert("전화번호 입력해주세요");
		$('input[name=phn2]').focus();
		return false;
	}
	if(isNaN($('input[name=phn2]').val())){
		alert("전화번호는 숫자형식으로 입력해주세요");
		$('input[name=phn2]').select();
		return false;
	}
	if($('input[name=phn3]').val() == ""){
		alert("전화번호 입력해주세요");
		$('input[name=phn3]').focus();
		return false;
	}
	if(isNaN($('input[name=phn3]').val())){
		alert("전화번호는 숫자형식으로 입력해주세요");
		$('input[name=phn3]').select();
		return false;
	}
	if($('input[name=postCode]').val() == ""){
		alert("우편번호 입력해주세요");
		$('input[name=postCode]').focus();
		return false;
	}
	if($('input[name=addr1]').val() == ""){
		alert("도로명주소 입력해주세요");
		$('input[name=addr1]').focus();
		return false;
	}
	if($('input[name=addr2]').val() == ""){
		alert("지번주소 입력해주세요");
		$('input[name=addr2]').focus();
		return false;
	}
	if($('input[name=addr3]').val() == ""){
		alert("상세주소 입력해주세요");
		$('input[name=addr3]').focus();
		return false;
	}
	if($('input[name=email]').val() == ""){
		alert("이메일주소 입력해주세요");
		$('input[name=email]').focus();
		return false;
	}
	var snail = "@";
	if($('input[name=email]').val().indexOf(snail) == -1){
		alert("이메일주소 다시 확인해주세요");
		$('input[name=email]').select();
		return false;
	}
	if(pwCheck == false){
		alert("비밀번호 일치 하지 않습니다");
		$('input[name=password2]').select();
		return false;
	}
	if(pwuse=="pwerror"){
		alert("비밀번호 형식이 잘못됐습니다.");
		return false;
	}
}

function pwcheck(){
	pw = $('input[name=password]').val();
	var regexp = /^[a-z0-9!#+@]{6,15}$/i;
	if(!regexp.test(pw)){
		alert('비밀번호 형식이 틀렸습니다.');
		pwuse = "pwerror";
		return ;
	}
	var chk_num = pw.search(/[0-9]/);
	var chk_eng = pw.search(/[a-z]/i);
	var chk_spcl = pw.search(/[!#+@]/);
	
	if(chk_num < 0 || chk_eng < 0 || chk_spcl < 0){
		alert('비밀번호는 영문자, 숫자, 특수문자의 조합으로 작성하세요');
		pwuse = "pwerror";
	}else{
		pwuse = "";
	}
	
}

function duplicate(){ 
	isCheck = true;
    $.ajax({
		url : "./member/id_check_proc.jsp",
		data : ({
			userid : $('input[name=userid]').val()
		}),
		success : function(data){
			if($('input[name=userid]').val()==""){
				alert("아이디를 입력하세요");
				$('input[name=userid]').focus();
				use = "missing";
			}
			else if($.trim(data) == "NO"){
				$("#idMessage").html('<font color=red>이미 등록된 아이디입니다<font>').show();
				$('input[name=userid]').select();
				use = "impossible";
			}
			else if($.trim(data) == "YES"){
				$("#idMessage").html('<font color=blue>사용가능한 아이디입니다<font>').show();
				use = "possible";
			}
			$('#idMesage').show();
		}
	});//ajax
}//duplicate

function keycheck(){
	$('#idMessage').css('display','none');
	isCheck = false;
	use = "";
}

function passCheck(){

	if($('input[name=password]').val() != "" && $('input[name=password2]').val() != ""){
		if($('input[name=password]').val() == $('input[name=password2]').val()){
			pwCheck = true;
			$("#pwMessage").html('<font color=blue>비밀번호 일치합니다<font>').show();
		} else {
			pwCheck = false;
			$("#pwMessage").html('<font color=red>비밀번호 다시 확인해주세요<font>').show();
		}
	}
}

function loginCheck(){
	if($('input[name=id]').val() == ""){
		alert("아이디 입력해주세요");
		$('input[name=id]').focus();
		return false;
	}
	if($('input[name=lgpassword]').val() == ""){
		alert("비밀번호 입력해주세요");
		$('input[name=lgpassword]').focus();
		return false;
	}
}
