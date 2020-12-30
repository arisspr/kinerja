<%-- 
    Document   : Logout
    Created on : Feb 14, 2020, 10:03:16 AM
    Author     : aris
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type = "text/javascript" >
            function preventBack(){window.history.forward();}
            setTimeout("preventBack()", 0);
            window.onunload=function(){null};
        </script>
    </head>
<body onload="noBack();"onpageshow="if (event.persisted) noBack();" onunload="">
        <%
            
            session.removeAttribute("nik_user");
            session.removeAttribute("pass"); 
            session.invalidate();
            response.sendRedirect("login");
            
        %>
       </body>
</html>
