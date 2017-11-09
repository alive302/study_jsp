<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>

<style type="text/css">
	.btn_css{
		border: 1px solid black; background-color: white;
		width: 70px; display: inline-block;
		text-align: center;
	}
	.sign_In{
		position:fixed;
		
		width: 300px;
		height: 125px;
	}
	.login_form{
		position: relative;
		border: 1px solid #c4c4c4;
		width: 100%;
		height: 40px;
	}
	.login_key{
		position: absolute;
		border-right: solid #c4c4c4;	
		width: 33%;
		height: 100%;
	}
	.login_value{
		position: absolute;
		top: 10px;
		width: 50%;
		left: 38%;
		height: 100%;
	}
	.btn_div{
		position: relative;
		top: 10px;
		width: 100%;
		height: 40px;
		margin-left: 80px;
	}
	
	#login_div{
		margin-top: 300px;
		margin-left: 600px;
	}
	
</style>

<script type="text/javascript">
	function fn_sign_btn(){
		location.href = "signUp.jsp";
	}
	
	function check_login(){
		if(in_frm.user_id.value == ""){
			alert("아이디를 입력해주세요.");
			in_frm.user_id.focus();
			return false;
		}
		if(in_frm.user_pw.value == ""){
			alert("비밀번호를 입력해주세요.");
			in_frm.user_pw.focus();
			return false;
		}
	}
</script>	
<title>로그인</title>
</head>
<body>
	<div id="login_div">
		<h3>로그인</h3>
		<form id="in_frm" name="in_frm" method="post" action="signProcess.jsp" onsubmit="return check_login()">
			<div class="sign_In">
				<div class="login_form">
					<div class="login_key">
						<label for="user_id">아이디*</label>
					</div>
					<div class="login_value">
						<input type="text" id="user_id" name="user_id"/>
					</div>
				</div>
				
				<div class="login_form">
					<div class="login_key">
						<label for="user_pw">비밀번호</label>
					</div>
					<div class="login_value">
						<input type="password" id="user_pw" name="user_pw"/>
					</div>
				</div>
				
				<div class="btn_div">
						<input type="submit" id="login_btn" value="로그인" class="btn_css"/>
						<input type="button" id="sign_btn" value="회원가입" class="btn_css" onclick="fn_sign_btn()"/>
				</div>
				
				<input type="hidden" id="process" name="process" value="signin">
			</div>
		</form>
	</div>
	</body>
</html>