<%-- 
    Document   : ErrorLogin
    Created on : Feb 14, 2020, 5:42:19 PM
    Author     : aris
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <center><p style="color:red">Sorry, your record is not available.</p></center>
    <%
    getServletContext().getRequestDispatcher("/login").include(request, response);
    %>
    </body>
</html>
