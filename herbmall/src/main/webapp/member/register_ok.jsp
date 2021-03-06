<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>register_ok</title>
</head>
<body>
<jsp:useBean id="memberService" class="com.herbmall.member.model.MemberService"
 scope="session"></jsp:useBean>
<jsp:useBean id="memVo" class="com.herbmall.member.model.MemberVO"
 scope="page"></jsp:useBean>
 
	<%
	//1
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String userid = request.getParameter("userid");
	String pwd = request.getParameter("pwd");
	String email1 = request.getParameter("email1");
	String email2= request.getParameter("email2");
	String email3 = request.getParameter("email3");
	String hp1 = request.getParameter("hp1");
	String hp2 = request.getParameter("hp2");
	String hp3 = request.getParameter("hp3");
	String zipcode = request.getParameter("zipcode");
	String address = request.getParameter("address");
	String addressDetail = request.getParameter("addressDetail");
	
	String hp="", email="";
	if(hp2!=null && !hp2.isEmpty()&&hp3!=null&&!hp3.isEmpty()){
		hp = hp1+"-"+hp2+"-"+hp3;
	}
	
	if(email1!=null && !email1.isEmpty()){
		if(email2.equals("etc")){
			if(email3!=null && !email3.isEmpty()){
				email=email1+"@"+email3;
			}
		}else{
				email=email1+"@"+email2;
		}
	}
	memVo.setName(name);
	memVo.setUserid(userid);
	memVo.setPwd(pwd);
	memVo.setEmail(email);
	memVo.setHp(hp);
	memVo.setZipcode(zipcode);
	memVo.setAddress(address);
	memVo.setAddressDetail(addressDetail);
	//2.
	String msg="가입실패", url="register.jsp";
	try{
		int cnt=memberService.insertMember(memVo);
	//3
		if(cnt>0){
			msg="가입 성공";
			url="../index.jsp";
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
	%>
	<!-- forward하면 request를 공유하므로 현재 페이지와 message.jsp는 같은 request를 갖는다  -->
	<jsp:forward page="../common/message.jsp"></jsp:forward>
</body>
</html>