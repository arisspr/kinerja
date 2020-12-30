/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Update;

import Conection.MyConection;
import static Encrypt.MD5.getMd5;
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
public class AdminUpdatePassword extends HttpServlet{
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
                    String username = request.getParameter("username");
                    System.out.println("username" + username);
                    String password = request.getParameter("password");
                    System.out.println("password" + password.length());
                  
                    if (username != null && !username.isEmpty() && password != null && !password.isEmpty() && password.length() > 0) {
                        String query1 = "Select username, password "
                                + "from public.login where username = '" + username + "'";
                        System.out.println("query122 " + query1);
                        ResultSet ss1 = st.executeQuery(query1);
                        String pass = "";
                        while (ss1.next()) {
                            pass = ss1.getString("username");
                        }
                        if (pass.equals(username)) {
//                            if (passnew.equals(confirm)) {
                                String query = "update public.login SET password = md5 ('" + password + "'), user_input = '" + id + "', last_update = '" + now() + "' "
                                        + "WHERE username = '" + username + "'";
                                System.out.println("company aktivitas  " + query);
                                int i = st.executeUpdate(query);
                                if (i > 0) {
                                    out.print("<script>"
                                            + "alert('Password Berhasil Diubah');"
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
                                    + "alert('Username Anda Tidak Sesuai');"
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
                    Logger.getLogger(AdminUpdatePassword.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(AdminUpdatePassword.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(AdminUpdatePassword.class.getName()).log(Level.SEVERE, null, ex);
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
