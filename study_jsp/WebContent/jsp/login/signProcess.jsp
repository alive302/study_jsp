<%@page import="java.net.URLEncoder"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE unspecified PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	// 입력정보 가져오기. 
	String user_id = request.getParameter("user_id");
	String user_nm = request.getParameter("user_nm");
	String user_pw = request.getParameter("user_pw");
	String email = request.getParameter("email");
	
	// 로그인, 회원가입 처리 구분
	String process = request.getParameter("process");
	
	// 아이디 중복체크
	int check = 1;
	
	Connection conn = null; // db접속
    PreparedStatement pstmt = null; // sql 실행
    ResultSet rs = null; // select 결과 처리
	
	try{
		
		//DB 접속 설정
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		String url = "jdbc:oracle:thin:@220.76.203.39:1521:UCS";
		String id = "UCS_STUDY";
		String pwd = "qazxsw";
		
		conn = DriverManager.getConnection(url,id,pwd);
		
		// **** 중복체크  **** //
		//String sql_checkId = "SELECT COUNT(*),USER_ID,USER_NM FROM CM_USER WHERE USER_ID = ? GROUP BY USER_ID,USER_NM";
		String sql_checkId = "SELECT COUNT(*) FROM CM_USER WHERE USER_ID = ?";
		pstmt = conn.prepareStatement(sql_checkId);
		pstmt.setString(1, user_id);
		rs = pstmt.executeQuery(); // rs 에 실행결과 리턴함.
		
		
		if(rs.next()){
			check = rs.getInt(1);
			if(process.equals("signup")){
				// 회원가입페이지에서 넘어온 id값이 사용 할수 없는 경우
				if(check > 0){
					//out.println("아이디 사용불가");
					out.println("<script>");
					out.println("alert('입력하신 아이디는 사용할수 없습니다.')");
					out.println("location.href='signUp.jsp'");
					out.println("</script>");
				}else{
					// id 값이 중복이 아닌경우.
					//out.println("가입완료");
					pstmt.close(); // 기존 pstmt 닫기
					
					// **** 회원가입 **** //
					String sql_signup = "insert into CM_USER (USER_ID, USER_PW, USER_NM, EMAIL) values (?, ?, ?, ?)";
					
					pstmt = conn.prepareStatement(sql_signup);
					
					pstmt.setString(1, user_id);
					pstmt.setString(2, user_pw);
					pstmt.setString(3, user_nm);
					pstmt.setString(4, email);
					
					pstmt.executeUpdate();
					
					out.println("<script>");
					out.println("alert('회원가입 되었습니다.')");
					out.println("location.href='/study_jsp/index.jsp'");
					out.println("</script>");
				}
			}else if(process.equals("signin")){
				if(check > 0){
					
					pstmt.close(); // 기존 pstmt 닫기
					
					String sql_login = "SELECT USER_ID,USER_NM,USER_PW FROM CM_USER WHERE USER_ID = ? AND USER_PW = ?";
					pstmt = conn.prepareStatement(sql_login);
					pstmt.setString(1, user_id);
					pstmt.setString(2, user_pw);
					rs = pstmt.executeQuery();
					
					// 로그인정보를 가지고 게시판 목록 화면으로 이동.
					if(rs.next()){
						if(rs.getString(1).equals(user_id) && rs.getString(3).equals(user_pw)){
							out.println("<script>");
							out.println("alert('["+rs.getString(2)+"] 님 환영합니다.')");
							out.println("location.href = '../board/boardList.jsp?user_id="+rs.getString(1)+"&user_nm="+rs.getString(2)+"'");
							out.println("</script>");
						} else {
							// 왜 동작을 안할까 ㅠㅠ
							out.println("아이디 또는 비밀번호가 틀렸습니다.");
							//out.println("<script>");
							//out.println("alert('아이디 또는 비밀번호가 틀렸습니다.')");
							//out.println("location.href='/study_jsp/index.jsp'");
							//out.println("</script>");
						}
					}
					// ** request.setAttribute(key, value);
					//request.setAttribute("user_id", user_id);
					//request.setAttribute("user_nm", user_nm);
					
				}else{
					// id 가 없는 경우.
					//out.println("가입페이지로 이동");
					
					out.println("<script>");
					out.println("alert('등록되지 않은 ID 입니다. 가입페이지로 이동합니다.')");
					out.println("location.href='./jsp/login/signUp.jsp'");
					out.println("</script>");
				}
			}
		}
		
		
	}catch(Exception e){
		e.printStackTrace();
		out.print("********* Exception : "+e);
	}finally {
		try {
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
%>