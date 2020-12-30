<%-- 
    Document   : indexRe
    Created on : Jun 11, 2019, 9:48:18 AM
    Author     : aris
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta http-equiv="" content="0" url="disnaker">
<!DOCTYPE html>

<%
//    String urlHead = "http://" + "disnaker.surabaya.go.id" + request.getContextPath();
    String urlHead = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();
%>

<script type="text/javascript">
   window.location.href = "<%= urlHead%>/login";
</script>