<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>scope3.jsp</title>
</head>
<body>
<jsp:useBean id="cvo" class="com.herbmall.test.CounterVO" scope="session"></jsp:useBean>
<jsp:setProperty property="count" name="cvo"/>
<h1>scope3.jsp 페이지</h1>
count : <jsp:getProperty property="count" name="cvo"/>
<hr>
<a href="result3.jsp">result3.jsp 이동</a>

<hr>
<p>session id : <%=session.getId() %></p>
</body>
</html>