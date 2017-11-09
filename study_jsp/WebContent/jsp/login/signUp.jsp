<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<style type="text/css">
	#signUp_div{
		margin-top: 300px;
		margin-left: 600px;
	}
	.btn_css{
		border: 1px solid black; background-color: white;
		width: 70px; display: inline-block;
		text-align: center;
	}
	.btn_div{
		position: relative;
		top: 10px;
		width: 100%;
		height: 40px;
		margin-left: 80px;
	}
	.td_css{
		border: 1px solid #c4c4c4;
	}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입 페이지</title>
</head>
<body>

<div id="signUp_div">
	<h3>회원가입</h3>
	<form id="sign_frm" name="sign_frm" method="post" action="signProcess.jsp" onsubmit="return check_form()">
		<div>
			<table style="border: 1px solid black">
				<tr>
					<td class="td_css">아이디*</td>
					<td class="td_css"><input type="text" id="user_id" name="user_id"></td>
				</tr>
				<tr>
					<td class="td_css">이름*</td>
					<td class="td_css"><input type="text" id="user_nm" name="user_nm"></td>
				</tr>
				<tr>
					<td class="td_css">비밀번호*</td>
					<td class="td_css"><input type="password" id="user_pw" name="user_pw"></td>
				</tr>
				<tr>
					<td class="td_css">비밀번호확인*</td>
					<td class="td_css"><input type="password" id="user_rpw" name="user_rpw">
					</td>
				</tr>
				<tr>
					<td class="td_css">이메일*</td>
					<td class="td_css"><input type="text" id="email" name="email"></td>
				</tr>
			</table>
		</div>	
		<div class="btn_div">
			
			<input type="submit" id="sign_btn" value="가입" class="btn_css"/>
			<input type="button" id="cancel_btn" value="취소" class="btn_css" onclick="login()"/>
		</div>
		
		<input type="hidden" id="process" name="process" value="signup">
	</form>
</div>

<script type="text/javascript">

function login(){
	// 취소 버튼 클릭시 로그인 화면으로 이동.
	location.href = "signIn.jsp";
}

function check_form(){
	
	if(sign_frm.user_id.value == ""){
		alert("아이디 입력하세요.");
		sign_frm.user_id.focus();
		return false;
	}
	if(sign_frm.user_nm.value == ""){
		alert("이름을 입력하세요.");
		sign_frm.user_nm.focus();
		return false;
	}
	if(sign_frm.user_pw.value == ""){
		alert("비밀번호 입력하세요.");
		sign_frm.user_pw.focus();
		return false;
	}
	if(sign_frm.user_rpw.value == ""){
		alert("비밀번호 확인이 필요합니다.");
		sign_frm.user_rpw.focus();
		return false;
	}
	if(sign_frm.email.value == ""){
		alert("이메일을 입력하세요.");
		sign_frm.email.focus();
		return false;
	}
	if(sign_frm.user_pw.value != sign_frm.user_rpw.value){
		alert("비밀번호 확인이 필요합니다.");
		sign_frm.user_pw.focus();
		return false;
	}
}

</script>
</body>
</html>