<%-- 
    Document   : LoginVerification
    Created on : Feb 14, 2020, 4:56:55 PM
    Author     : aris
--%>

<%@page import="javax.xml.bind.DatatypeConverter"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import ="Conection.MyConection" %>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <%    
    String usernameDb;
    String passDb;
    String cred;
    String alias;
    String level;
    String bidang;
    String jabatan;
    String groupuser;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    MyConection cfc1 = new MyConection();
    Connection conn1 = cfc1.getKoneksi();
    if(conn1 == null){
    System.out.println("Koneksi Putus");
        out.print("<script>"
                + "alert('Maaf Server Lagi Istirahat, Capek Tau Kerja Terus...');"
                + "window.location.href = 'login';</script>");
        out.close();
    }
    else{
//    Statement st = conn1.createStatement();
    String query = "select * from login WHERE username = ? and password = md5(?) and login_status = 'yes'";
//    String query = "SELECT l.username,l.password, l.kode_credential, l.alias, l.level, l.bidang, l.jabatan,  egu.group_name_user from login as l "
//            + "JOIN employee.groupuser as egu ON egu.nik_user = l.username "
//            + "WHERE l.username = ? and l.password = md5(?) and l.login_status = 'yes'";
    System.out.println(" Query "+query);
    String user = request.getParameter("username");
    String pass = request.getParameter("password");
    System.out.println("user "+user);
    System.out.println("pass "+pass);
   if(user == null){
       user ="";
   }
   if(pass == null){
       pass ="";
   }
    
    
        try {
            ps = conn1.prepareStatement(query);
           
            ps.setString(1, user);
            ps.setString(2, pass);
            
            rs = ps.executeQuery();
            if(rs.next()){
                usernameDb = rs.getString("username");               
                passDb = rs.getString("password");
                cred = rs.getString("kode_credential");
                alias = rs.getString("alias");
                level = rs.getString("level");
                bidang = rs.getString("bidang");
                jabatan = rs.getString("jabatan");
//                groupuser = rs.getString("group_name_user");
//                System.out.println("login "+groupuser);
                
                if(user.equals(usernameDb) && cred.equals("a") && level.equals("Admin")) {
                    session.setAttribute("username",usernameDb);
                    session.setAttribute("Cred",cred);
                    session.setAttribute("alias",alias);
                    session.setAttribute("level",level);
                    session.setAttribute("bidang",bidang);
                    session.setAttribute("jabatan",jabatan);
//                    session.setAttribute("group_name_user",groupuser);
                    response.sendRedirect("home"); 
                } else if (user.equals(usernameDb) && cred.equals("E") && level.equals("Employee")){
                    session.setAttribute("username",usernameDb);
                    session.setAttribute("Cred",cred);
                    session.setAttribute("alias",alias);
                    session.setAttribute("level",level);
                    session.setAttribute("bidang",bidang);
                    session.setAttribute("jabatan",jabatan);
//                    session.setAttribute("group_name_user",groupuser);
                    response.sendRedirect("home");
                }else if (user.equals(usernameDb) && cred.equals("P") && level.equals("Pns")){
                    session.setAttribute("username",usernameDb);
                    session.setAttribute("Cred",cred);
                    session.setAttribute("alias",alias);
                    session.setAttribute("level",level);
//                    session.setAttribute("bidang",bidang);
                    session.setAttribute("jabatan",jabatan);
                    response.sendRedirect("home");
                }
                else {
                    response.sendRedirect("login");
                }
            } else {%>
                <script type="text/javascript">
            window.location.href = "login?LoginStatus=<%= DatatypeConverter.printBase64Binary("invalid".getBytes())%>";
        </script>
        <%
                rs.close();
                ps.close(); 
            }
            
        } catch (SQLException sqe){
//            out.println(sqe); 
        }  
}  
   %>
    </body>
</html>
