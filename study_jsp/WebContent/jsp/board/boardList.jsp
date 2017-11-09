<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
</body>
</html>