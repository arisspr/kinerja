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
public class UpdateBiodata extends HttpServlet{
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
//                Object id = request.getSession().getAttribute("username");
//                Object User = request.getSession().getAttribute("ID");
                    MyConection cfc = new MyConection();
                    Connection conn = cfc.getKoneksi();
                    Statement st = conn.createStatement();
                    ResultSet rs = null;
                    String tempat_lahir = request.getParameter("tempat_lahir");
                    String tgl_lahir = request.getParameter("tgl_lahir");
                    String gender = request.getParameter("gender");
                    String status = request.getParameter("status");
                    String education = request.getParameter("education");
                    String prodi = request.getParameter("prodi");
                    String hp = request.getParameter("hp");
                    String address = request.getParameter("address");
//                aktivitas = new String(DatatypeConverter.parseBase64Binary(aktivitas));
                    System.out.println("aktivitas " + tempat_lahir);
//                String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(Calendar.getInstance().getTime());

                    String psn = "", clr = "", p = "", prov = "";
//                
                    if (tempat_lahir != null && !tempat_lahir.isEmpty()) {

//                    String appr = prov.equals(1) ? "Disetujui" : "Ditolak";
//                    
                        String query = "update employee.biodata SET tempat_lahir = '" + tempat_lahir + "',tanggal_lahir = '" + tgl_lahir + "',jenis_kelamin = '" + gender + "',status_pernikahan = '" + status + "', "
                                + "hp = '" + hp + "',alamat = '" + address + "', pendidikan = '" + education + "', jurusan = '" + prodi + "', user_input = '" + id + "', last_update = '" + now() + "' "
                                + "WHERE nik = '" + id + "'";
                        System.out.println("company aktivitas  " + query);
                        int i = st.executeUpdate(query);
                        if (i > 0) {
                            out.print("<script>"
                                    + "alert('Data Berhasil Diubah');"
                                    + "window.location.href = 'profile';</script>");
                            out.close();
                        } else {
                            out.print("There is a problem in updating Record.");
                        }

                    } else {
                        out.print("<script>"
                                + "alert('Input Tidak Boleh Kosong');"
                                + "window.location.href = 'profile';</script>");
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
