/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Insert;

import Conection.MyConection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import static java.time.LocalDateTime.now;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author aris
 */
public class UserToGroup extends HttpServlet{
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
         try (PrintWriter out = response.getWriter()) {
            String sql = "";
            Integer no = 0;
            Object id = request.getSession().getAttribute("username");

            try {
                MyConection cfc = new MyConection();
                Connection conn = cfc.getKoneksi();
                Statement st = conn.createStatement();

                String nmgroup = request.getParameter("group");
                String[] nik = request.getParameterValues("nik");

                sql = "insert into employee.groupuser (group_name_user,nik_user,userinput,input_time,last_update)values ";
                for (int i = 0; i < nik.length; i++) {
                    sql += "('" + nmgroup + "','" + nik[i] + "','" + id + "','" + now() + "','" + now() + "'),";
                    System.out.println(nik[i]);
                    if ((no + 1) == nik.length) {
                        sql = sql.substring(0, sql.length() - 1);
                    }

                    no++;
                }
                System.out.println("Sql " + sql);
                int ss = st.executeUpdate(sql);
// 
                if (ss != 0) {
                    out.print("<script>"
                            + "alert(\"Data Berhasil Ditambahkan..\");"
                            + "window.location.href = 'groupuser';"
                            + "</script>");
                } else {
                    out.print("<script>"
                            + "alert(\"Data Gagal Ditambahkan..\");"
                            + "window.location.href = 'groupuser';"
                            + "</script >");
                }

            } catch (SQLException ex) {
                ex.printStackTrace();
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
            throws ServletException, IOException {
        processRequest(request, response);
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
        processRequest(request, response);
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
