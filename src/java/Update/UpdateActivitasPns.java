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
import java.text.SimpleDateFormat;
import static java.time.LocalDateTime.now;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author aris
 */
public class UpdateActivitasPns extends HttpServlet{
   
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
                                + ", note = '" + info + "', tgl_approve = '" + now() + "', verifikasi = '" + verificator + "' "
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
//                    
//                            if (tot.trim().length() > 0 && Integer.parseInt(tot) > 0) {
//                                String fltr = "update perusahaan.lowongan_pencaker a set status='Melamar', "
//                                        + " last_tgl_update = now(), last_user_update = '" + User + "' "
//                                        + " from perusahaan.lowongan_perusahaan b "
//                                        + " inner join jmf.jmf_all c on b.jobfair=c.id "
//                                        + " where a.nik='" + fltr2 + "' and a.perusahaan='" + id + "' and c.tanggal_akhir >= current_date and b.status_aktif = true and a.jobfair = " + jmf;
//                                System.out.println("company filter  " + fltr);
//                                int i = st.executeUpdate(fltr);
//                                if (i > 0) {
//                                    out.print("<script>"
//                                            + "alert('Berkas atas nama "+ nama +" Berhasil diinput');"
//                                            + "window.location.href = 'homecompany';</script>");
//                                    out.close();
//                                } else {
//                                    out.print("There is a problem in updating Record.");
//                                }
//                            } else {
//                                out.print("<script>"
//                                        + "alert('Pencaker atas nama "+ nama +" Belum Melamar Di Perusahaan Anda..');"
//                                        + "window.location.href = 'homecompany';</script>");
//                            }
                    } else {
                        out.print("<script>"
                                + "alert('Input Tidak Boleh Kosong');"
                                + "window.location.href = 'verification';</script>");
//                            out.close();
                    }

                } catch (SQLException ex) {
//                Logger.getLogger(UpdateActivitasPns.class.getName()).log(Level.SEVERE, null, ex);
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
