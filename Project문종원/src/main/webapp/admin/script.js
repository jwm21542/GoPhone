/**
 * 
 */
 
 function check(){
	if($('select[name=brand] option').filter(':selected').val() == ""){
		alert("브랜드 선택해주세요");
		return false;
	}
	if($('input[name=model]').val() == ""){
		alert("모델명 입력해주세요.");
		$('input[name=model]').focus()
		return false;
	}
	var str = "";
	$('select[name=storage] option:selected').each(function(){
		str += $(this).val();
	})
	if(str == ""){
		alert("용량 최소 하나 선택해주세요");
		return false;
	}
	str = "";
	$('select[name=color] option:selected').each(function(){
		str += $(this).val();
	})
	if(str == ""){
		alert("색상 최소 하나 선택해주세요");
		return false;
	}
	if($('select[name=osList] option').filter(':selected').val() == ""){
		alert("운영체제 선택해주세요");
		return false;
	}
	if($('input[name=releaseDate]').val() == ""){
		alert("출고일 입력해주세요.");
		return false;
	}
	if($('input[name=releasePrice]').val() == ""){
		alert("출고가 입력해주세요.");
		$('input[name=releasePrice]').focus()
		return false;
	}
	if(isNaN($('input[name=releasePrice]').val())){
		alert("숫자 형식으로 입력해주세요.");
		$('input[name=releasePrice]').select()
		return false;
	}
	if($('input[name=screenSize]').val() == ""){
		alert("화면크기 입력해주세요.");
		$('input[name=screenSize]').focus()
		return false;
	}
	if($('select[name=cpuList] option').filter(':selected').val() == ""){
		alert("CPU 선택해주세요");
		return false;
	}
	if($('select[name=ram] option').filter(':selected').val() == ""){
		alert("램 선택해주세요");
		return false;
	}
	str = "";
	$('input[name=network]:checked').each(function(){
		str += $(this).val();
	})
	if(str == ""){
		alert("네트워크 선택해주세요");
		return false;
	}
	str = "";
	$('input[name=security]:checked').each(function(){
		str += $(this).val();
	})
	if(str == ""){
		alert("보안 기능 선택해주세요");
		return false;
	}
	if($('input[name=security]').val() == ""){
		alert("보안기능 선택해주세요");
		return false;
	}
}
 function check2(){
	if($('select[name=osList] option').filter(':selected').val() == ""){
		alert("운영체제 선택해주세요");
		return false;
	}
	if($('input[name=releaseDate]').val() == ""){
		alert("출고일 입력해주세요.");
		return false;
	}
	if($('input[name=releasePrice]').val() == ""){
		alert("출고가 입력해주세요.");
		$('input[name=releasePrice]').focus()
		return false;
	}
	if($('input[name=price]').val() == ""){
		alert("판매가격 입력해주세요.");
		$('input[name=releasePrice]').focus()
		return false;
	}
	if(isNaN($('input[name=releasePrice]').val())){
		alert("숫자 형식으로 입력해주세요.");
		$('input[name=releasePrice]').select()
		return false;
	}
	if($('input[name=screenSize]').val() == ""){
		alert("화면크기 입력해주세요.");
		$('input[name=screenSize]').focus()
		return false;
	}
	if($('select[name=cpuList] option').filter(':selected').val() == ""){
		alert("CPU 선택해주세요");
		return false;
	}
	if($('select[name=ram] option').filter(':selected').val() == ""){
		alert("램 선택해주세요");
		return false;
	}
	str = "";
	$('input[name=network]:checked').each(function(){
		str += $(this).val();
	})
	if(str == ""){
		alert("네트워크 선택해주세요");
		return false;
	}
	str = "";
	$('input[name=security]:checked').each(function(){
		str += $(this).val();
	})
	if(str == ""){
		alert("보안 기능 선택해주세요");
		return false;
	}
	if($('input[name=security]').val() == ""){
		alert("보안기능 선택해주세요");
		return false;
	}
}
function priceCheck(num){
	var i = 0;
	$('input[name=price]').each(function(){
		if($(this).val() != ""){
			i++;
		}
	});
	if(num != i){
		alert("가격 입력해주세요");
		return false;
	}
	var flag = false;
	$('input[name=price]').each(function(){
		if(isNaN($(this).val())){
			alert("숫자만 입력해주세요.")
			flag = true;
			return false;
		}
	});
	if(flag == true){
		return false;
	}
}

function photoCheck(){
	var pimage = $('#file1').val();
	var pimage2 = $('#file2').val();
	if(pimage == "" && pimage2 == ""){
		alert("사진 올려주세요.");
		return false;
	}
}