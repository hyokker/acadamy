<%@page import="com.herbmall.zipcode.model.ZipcodeVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<jsp:useBean id="zipcodeService"
   class="com.herbmall.zipcode.model.ZipcodeService" scope="session"></jsp:useBean>

<%
   //[1] register.jsp에서 우편번호찾기 클릭하면 open=>새창 열림, get
   //[2] zipcode.jsp에서 찾기 클릭하면 post방식으로 서브밋
   //1
   request.setCharacterEncoding("utf-8");
   String dong = request.getParameter("dong");
   
   //2
   List<ZipcodeVO> list = null;
   if (dong != null && !dong.isEmpty()) {
      list = zipcodeService.selectByAll(dong);
   }
   
   //3
   if(dong==null) dong="";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>zipcode.jsp</title>
<link rel="stylesheet" type="text/css" href="../css/mainstyle.css" />
<style type="text/css">
   .error{
      color:red;
      display:none;
   }
</style>
<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
   $(function(){
      $('#submit').click(function(){
         if($('#dong').val().length<1){
            $('form[name=frmZipcode] .error').show();
            event.preventDefault();
         }
      });
      
   });
   
   function setZipcode(zipcode,address){
      $(opener.document).find("#zipcode").val(zipcode);
      $(opener.document).find("input[name=address]").val(address);
      
      self.close();
   }
</script>
</head>
<body>
   <h2>우편번호 검색</h2>
   <p style="font-size: 1em">찾고 싶으신 주소의 동(읍/면)을 입력하세요</p>
   <form name="frmZipcode" method="post" action="zipcode.jsp">
      <label for="dong">지역명 : </label> 
      <input type="text" name="dong"
         id="dong" style="ime-mode: active" value="<%=dong%>"> <input type="submit"
         id="submit" value="찾기">
      <span class="error">지역명을 입력하세요</span>
   </form>
   <br>
   <%if(list!=null){ %>
   <table style="width: 470px" class="box2"
      summary="우편번호 검색 결과에 관한 표로써, 우편번호, 주소에 대한 정보를 제공합니다.">
      <colgroup>
         <col style="width: 20%" />
         <col style="width: *" />
      </colgroup>
      <thead>
         <tr>
            <th scope="col">우편번호</th>
            <th scope="col">주소</th>
         </tr>
      </thead>
      <tbody>
         <% if(list.isEmpty()){%>
               <tr>
                  <td colspan="2" class="align_center">
                     해당 주소가 존재하지 않습니다.
                  </td>
               </tr>               
            <% }else{
               for(int i=0;i<list.size();i++){
                  ZipcodeVO vo=list.get(i); 
                  String bunji=vo.getStartbunji();
                  String endBunji=vo.getEndbunji();
                  if(endBunji!=null &&!endBunji.isEmpty()){
                     bunji+="~"+endBunji;
                  }
                  String address=vo.getSido()+" "+vo.getGugun()+" "
                        +vo.getDong();
                  %>
                  <tr>
                     <td><%=vo.getZipcode() %></td>
                     <td>
                        <a href="#" onclick
                        ="setZipcode('<%=vo.getZipcode()%>','<%=address%>')">                     
                           <%=address %> <%=bunji %>
                        </a>
                     </td>
                  </tr>
               
            <% }
            } %>
      </tbody>
   </table>
   <%} %>
</body>
</html>