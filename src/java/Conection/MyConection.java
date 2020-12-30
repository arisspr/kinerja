/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Conection;

import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author aris
 */
public class MyConection {

    private Connection connect;

//    private String host = "172.20.5.150";
//   private String host = "127.0.0.1";
//    private String host = "172.18.1.72";
    private String host = "10.255.221.150";
    private String port = "2552";
    private String database = "activity";
    private String username = "disnaker";
    private String password = "heavenorhell";
//   private String password = "disnaker321";  

    public Connection getKoneksi() throws SQLException {
        if (connect == null) {
            try {
                Class.forName("org.postgresql.Driver").newInstance();
                System.out.println("Class Driver Ditemukan");
                try {
                    connect = DriverManager.getConnection("jdbc:postgresql://" + host + ":" + port + "/" + database, username, password);
                    System.out.println("Koneksi Database Sukses");
                } catch (SQLException se) {
                    System.out.println("Koneksi Database Gagal : " + se);
                    out.print("<script>"
                            + "alert('Maaf Server Lagi Istirahat, Capek Tau Kerja Terus...');"
                            + "window.location.href = 'login';</script>");
                    out.close();
//           System.exit(0);  
                }
            } catch (InstantiationException e) {
//           System.exit(0);
                out.print("<script>"
                        + "alert('Maaf Server Lagi Istirahat, Capek Tau Kerja Terus...');"
                        + "window.location.href = 'login';</script>");
                out.close();
            } catch (IllegalAccessException e) {
                System.exit(0);
            } catch (ClassNotFoundException cnfe) {
                System.out.println("Class Driver Tidak Ditemukan, Terjadi Kesalahan Pada : " + cnfe);
//         System.exit(0);
                out.print("<script>"
                        + "alert('Maaf Server Lagi Istirahat, Capek Tau Kerja Terus...');"
                        + "window.location.href = 'login';</script>");
                out.close();
            }
        }
        return connect;
    }
}
