/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Update;

import Conection.MyConection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import static java.time.LocalDateTime.now;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;

/**
 *
 * @author aris
 */
public class UpdateActivitasEmployee extends HttpServlet{
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
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
                    ResultSet rs = null;
                    String detail = request.getParameter("detail");
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
                        String query = "update employee.aktivitas SET detail = '" + detail + "',durasi = '" + durasi + "', nip = '" + pns + "',approve = 'Belum Disetujui',last_update = '"+now()+"' "
                                + "WHERE aktivitas = '" + aktivitas + "'";
                        System.out.println("company aktivitas  " + query);
                        int i = st.executeUpdate(query);
                        if (i > 0) {
                            out.print("<script>"
                                    + "alert('Kegiatan Anda Telah Diubah');"
                                    + "window.location.href = 'kegiatan';</script>");
                            out.close();
                        } else {
                            out.print("There is a problem in updating Record.");
                        }

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
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(UpdateActivitasPns.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(UpdateActivitasPns.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    
}
