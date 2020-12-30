/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Insert;

import Conection.MyConection;
import static Encrypt.MD5.getMd5;
import Update.UpdateActivitasEmployee;
import Update.UpdateActivitasPns;
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

/**
 *
 * @author aris
 */
public class User extends HttpServlet{
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
                    String nik = request.getParameter("nik");
                    String pass = getMd5(nik);
                    System.out.println("username " + nik);
                    String name = request.getParameter("name").toUpperCase();
                    System.out.println("name " + name);
                    String bidang = request.getParameter("bidang");
                    System.out.println("bidang " + bidang);
                    String jabatan = request.getParameter("jabatan");
                    System.out.println("jabatan " + jabatan);
                    String level = request.getParameter("level");
                    String kc = Character.toString(level.charAt(0));;
                    System.out.println("level " + level);
                    System.out.println("kc " + kc);
                    String status = request.getParameter("status");
                    System.out.println("password" + name.length());
                  
                    if (nik != null && !nik.isEmpty() && name != null && !name.isEmpty() && name.length() > 0) {
                        String query1 = "Select count(*) as num "
                                + "from public.login where username = '" + nik + "'";
                        System.out.println("query122 " + query1);
                        ResultSet ss1 = st.executeQuery(query1);
                        Integer num = 0;
                        while (ss1.next()) {
                            num = ss1.getInt("num");
                        }
                        System.out.println("num1 "+num);
                        if (num == 0) {
                            System.out.println("num "+num);
//                            if (passnew.equals(confirm)) {
                                String query = "insert into public.login (username, password, kode_credential, login_status, level, alias, bidang, jabatan, tgl_input, user_input) values ("
                                        + "'" + nik + "','" + pass + "','" + kc + "','" + status + "','" + level + "','" + name + "','" + bidang + "','" + jabatan + "','" + now() + "','" + id + "')";
                                System.out.println("company aktivitas  " + query);
                                int i = st.executeUpdate(query);
                                if (i > 0) {
                                    out.print("<script>"
                                            + "alert('Alhamdulillah Wes Mlebu');"
                                            + "window.location.href = 'user';</script>");
                                    out.close();
                                } else {
                                    out.print("There is a problem in updating Record.");
                                }
//                            } else {
//                                out.print("<script>"
//                                        + "alert('Confirm Tidak Sama Dengan Password Baru');"
//                                        + "window.location.href = 'password';</script>");
//                                out.close();
//                            }
                        } else {
                            out.print("<script>"
                                    + "alert('Username Sudah Ada Yang Menggunakan');"
                                    + "window.location.href = 'user';</script>");
                            out.close();
                        }
                
                    
                    

                    } else {
                        out.print("<script>"
                                + "alert('Input Tidak Boleh Kosong');"
                                + "window.location.href = 'user';</script>");
                        out.close();
                    }

                } catch (SQLException ex) {
                    Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
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
