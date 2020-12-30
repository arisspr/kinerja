<%-- 
    Document   : UpdateActivitasPNS
    Created on : Aug 13, 2020, 1:15:17 PM
    Author     : aris
--%>

<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Conection.MyConection"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <%
            Object id = request.getSession().getAttribute("username");
            if (id == null || id.toString().trim().equals("")) {
                out.print("<script>"
                        + "alert('Session Time Out');"
                        + "window.location.href = 'login';</script>");
                out.close();
            } else {
                try {
//                Object User = request.getSession().getAttribute("ID");
                    LocalDateTime now = LocalDateTime.now();
                    MyConection cfc = new MyConection();
                    Connection conn = cfc.getKoneksi();
                    Statement st = conn.createStatement();
                    ResultSet rs = null;
                    String app = request.getParameter("approve");
                    String info = request.getParameter("information");
                    String aktivitas = request.getParameter("activitas");
                    String verificator = request.getParameter("verificator");
                    System.out.println("app " + app);
                    System.out.println("info " + info);
                    System.out.println("id " + id);
                    
                    System.out.println("aktivitas " + aktivitas);
//                String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(Calendar.getInstance().getTime());

                    String psn = "", clr = "", p = "", prov = "";

                    if (app != null && !info.isEmpty()) {

                        app = app.equals("1") ? "Disetujui" : "Ditolak";

                        String query = "update employee.aktivitas SET approve = '" + app + "' "
                                + ", note = '" + info + "', tgl_approve = '" + now + "', verifikasi = '" + verificator + "' "
                                + "WHERE aktivitas = '" + aktivitas + "'";
                        System.out.println("company filter  " + query);
                        int i = st.executeUpdate(query);
                        if (i > 0) {
                         String history ="INSERT INTO employee.history (aktivitas,status,detail_aktivitas,verificator,user_input) "
                                 + "VALUES ('"+aktivitas+"','"+app+"','"+info+"','"+verificator+"','"+id+"')";
                                st.executeUpdate(history);
                            out.print("<script>"
                                    + "alert('Approved succes');"
                                    + "window.location.href = 'verification';</script>");
                            out.close();
                        } else {
                            out.print("There is a problem in updating Record.");
                        }

                    } else {
                        out.print("<script>"
                                + "alert('Input Tidak Boleh Kosong');"
                                + "window.location.href = 'verification';</script>");
                    }

                } catch (SQLException ex) {
//                Logger.getLogger(UpdateActivitasPns.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        %>
    </body>
</html>
