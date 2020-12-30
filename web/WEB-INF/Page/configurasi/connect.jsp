<%@ page import="java.sql.*" %>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Date"%>
<%@page import="javax.servlet.*"%>
<%@include file="prop.jsp" %>
<%    try {
        Class.forName("org.postgresql.Driver");
    } catch (Exception e) {
        out.print("driver tidak ketemu");
    }
    Connection con = DriverManager.getConnection(url, usr, pwd);
    Statement st = con.createStatement();
    ResultSet rs, rs1, rs2;

%>