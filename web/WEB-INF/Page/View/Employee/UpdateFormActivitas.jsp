<%-- 
    Document   : UpdateFormActivitas
    Created on : Aug 18, 2020, 8:41:36 AM
    Author     : aris
--%>

<%@page import="Update.UpdateActivitasEmployee"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="javax.xml.bind.DatatypeConverter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Conection.MyConection"%>
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
                    MyConection cfc = new MyConection();
                    Connection conn = cfc.getKoneksi();
                    Statement st = conn.createStatement();
                    LocalDateTime now = LocalDateTime.now();
                    ResultSet rs = null;
                    String detail = request.getParameter("detail").trim();
                    String aktivitas = request.getParameter("activitas");
                    String durasi = request.getParameter("durasi");
                    String tugas = request.getParameter("tugas");
                    String kegiatan = request.getParameter("kegiatan");
                    String pns = request.getParameter("pns");
                    String approve = request.getParameter("approve");
                    aktivitas = new String(DatatypeConverter.parseBase64Binary(aktivitas));
                    approve = new String(DatatypeConverter.parseBase64Binary(approve));
                    System.out.println("aktivitas " + aktivitas);
//                String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(Calendar.getInstance().getTime());

                    String psn = "", clr = "", p = "", prov = "";
//                
                    if (detail != null || !detail.isEmpty()) {

//                    String appr = prov.equals(1) ? "Disetujui" : "Ditolak";
//                    
                        String query = "update employee.aktivitas SET detail = '" + detail + "', tugas ='"+kegiatan+"', kegiatan ='"+tugas+"', durasi = '" + durasi + "', nip = '" + pns + "',approve = 'Belum Disetujui',last_update = '"+now+"' "
                                + "WHERE aktivitas = '" + aktivitas + "'";
                        System.out.println("Update aktivitas  " + query);
//                        int i = st.executeUpdate(query);
//                        if (i > 0) {
//                            out.print("<script>"
//                                    + "alert('Kegiatan Anda Telah Diubah');"
//                                    + "window.location.href = 'kegiatan';</script>");
//                            out.close();
//                        } else {
//                            out.print("There is a problem in updating Record.");
//                        }

                    } else {
                        out.print("<script>"
                                + "alert('Input Tidak Boleh Kosong');"
                                + "window.location.href = 'kegiatan';</script>");
                        out.close();
                    }

                } catch (SQLException ex) {
                    Logger.getLogger(UpdateActivitasEmployee.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        %>
    </body>
</html>
