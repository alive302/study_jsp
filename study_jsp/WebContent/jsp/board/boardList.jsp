<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	ResultSet rs1 = null; // 게시물 총 갯수 카운트 rs
	PreparedStatement pstmt1 = null; // 게시물 총 갯수 카운트 pstmt

	try{
	
		//DB 접속 설정
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		String url = "jdbc:oracle:thin:@220.76.203.39:1521:UCS";
		String id = "UCS_STUDY";
		String pwd = "qazxsw";
		
		conn = DriverManager.getConnection(url,id,pwd);
		
		// *********** 페이징 ********** //
		int perpage = 10; // 한페이지에 보여줄 게시물 수
		int nowpage = 0; // 현재 보여지는 페이지 [1] [2] [3] 등등
		
		int maxpage = 10; // 한페이지에 보여줄 페이지 갯수 저장할 변수
		
		int datacount = 0; // 총 게시물수 저장할 변수
		int pagecount = 0; // 총 페이지수(datacount/perpage)
		
		
		// 게시물 총 갯수 조회
		String board_count = "SELECT COUNT(SEQ) FROM BOARD";
		
		// 게시물 총 갯수 처리
		pstmt1 = conn.prepareStatement(board_count);
		rs1 = pstmt1.executeQuery();
		rs1.next();
		
		datacount = rs1.getInt(1);
		
		out.print("총 게시물 수 : "+datacount);
		
		pagecount = datacount/perpage+1; // 10이하의 게시물이 있을경우 페이지 처리를 위한 +1
		
		out.print("총 페이지 수 : "+pagecount);
		
		// 게시물 목록 조회(최근 등록된 게시물을 먼저 보이게 조회)
		//String board_List = "SELECT SEQ, TITLE, REG_ID, REG_DATE FROM BOARD WHERE ROWNUM BETWEEN ? AND ? ORDER BY SEQ DESC";
		String board_List = "select board.seq, board.title, board.reg_id, board.reg_date, cm_user.user_id, cm_user.user_nm from ((SELECT SEQ, TITLE, REG_ID, REG_DATE FROM (SELECT * FROM BOARD ORDER BY SEQ DESC) WHERE ROWNUM BETWEEN 1 AND 10))board inner join cm_user on board.reg_id = cm_user.user_id order by board.reg_date desc";
		pstmt = conn.prepareStatement(board_List);
		//pstmt.setString(1, "1");
		//pstmt.setString(2, "10");
		rs = pstmt.executeQuery();
		
%>
<html>
<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#w_btn").on("click", function(e){
			e.preventDefault();
			fn_w_btn();
		});
		$("#out_btn").on("click", function(e){
			e.preventDefault();
			fn_out_btn();
		});
	});

	function fn_w_btn(){
		location.href="boardWrite.jsp";
	}
	function fn_out_btn(){
		location.href="../../index.jsp";
	}
</script>	
<style type="text/css">
	.paging_css{
		border: 1px solid black; background-color: white;
		width: 30px; display: inline-block;
		text-align: center;
	}
	.btn_css{
		border: 1px solid black; background-color: white;
		width: 70px; display: inline-block;
		text-align: center;
	}
	.search_div{
		margin-right: 205px;
	}
	.h_div{
		margin-right: 430px;
	}
	
	#list_div{
		margin-top: 50px;
		margin-left: 450px;
	}
	#page_div{
		margin-top: 20px;
		margin-left: 150px;
	}

</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form>
	<table>
		<tr>
			<td>아이디</td>
			<td><%=request.getParameter("user_id") %></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><%=request.getParameter("user_nm") %></td>
		</tr>
	</table>
</form>

<div id="list_div">
<h3 class="h_div">게시판 목록</h3>
	<div id="search_div" class="search_div">
		<form>
			<select name="search">
				<option selected value="s_title">제목</option>
				<option value="s_no">글번호</option> 
				<option value="s_content">내용</option>
				<option value="s_no_con">제목+내용</option>
			</select>
			<input type="text" id="s_text"/>
			<input type="button" id="s_btn" value="검색" class="btn_css"/>
			<input type="button" id="w_btn" value="글쓰기" class="btn_css"/>
			<input type="button" id="out_btn" value="로그아웃" class="btn_css"/>
		</form>	
	</div>
		
	<div id="list_form">
		<table border="1">
			<colgroup>
				<col width="10%"/>
				<col width="*"/>
				<col width="15%"/>
				<col width="20%"/>
			</colgroup>
			<thead>
				<tr>
					<th scope="col">글번호</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">작성일</th>
				</tr>
			</thead>
			
			<% while(rs.next()){
				
				// 게시글 목록
				String seq = rs.getString("SEQ");
				String title = rs.getString("TITLE");
				String user_nm = rs.getString("USER_NM");
				String reg_date = rs.getString("REG_DATE").substring(0,10);
				
			%>
			<tbody>
				<tr>
					<td align="center"><%=seq%></td>
					<td align="left"><a href="boardRead.jsp"><%=title%></a></td> 					
 					<td align="center"><%=user_nm%></td>
					<td align="center"><%=reg_date%></td>
				</tr>	
			</tbody>
			<% 
			} 
			%>
		</table>
	</div>
	
	<div id="page_div">
		<div>
			<a href="#" class="paging_css"> << </a>
			<a href="#" class="paging_css">  < </a>
			<a href="#">1</a>
			<a href="#">2</a>
			<a href="#">3</a>
			<a href="#">4</a>
			<a href="#">5</a>
			<a href="#">6</a>
			<a href="#">7</a>
			<a href="#">8</a>
			<a href="#">9</a>
			<a href="#">10</a>
			<a href="#" class="paging_css"> > </a>
			<a href="#" class="paging_css"> >> </a>
		</div>
	</div>

</div>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
		out.println("*** Exception : "+e);
	}finally{
		try{
			if(conn != null){
				conn.close();
			}
			if(pstmt != null){
				pstmt.close();
			}
		}catch(Exception e){
			e.printStackTrace();
			out.println("*** Exception : "+e);
		}
	}
%>