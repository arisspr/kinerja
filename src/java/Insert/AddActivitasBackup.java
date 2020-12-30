/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Insert;

import Conection.MyConection;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.codec.binary.Base64;

//@MultipartConfig
public class AddActivitasBackup extends HttpServlet {

    private static final long serialVersionUID = 1;
    private String aris = "QXJpcyBTdXByaWFkaQ==";
    String berkas1;
    String berkas;

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        System.out.println("Post Project   " + request.getParameter("tanggal"));
        String file_name = null;
        String date1 = null;
//        String nik=null;
        String tanggal = null;
        String tugas = null;
        String kegiatan = null;
        String pns = null;
        String detail = request.getParameter("detail");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        boolean isMultipartContent = ServletFileUpload.isMultipartContent(request);
        if (!isMultipartContent) {
            return;
        }

        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        Object nik = request.getSession().getAttribute("username");
        if (nik == null || nik.toString().trim().equals("")) {
            out.print("<script>"
                    + "alert('Session Time Out');"
                    + "window.location.href = 'login';</script>");
            out.close();
        } else {
            try {
//            Object nik = request.getSession().getAttribute("username");
                System.out.println("NIK " + nik);
                MyConection cfc = new MyConection();
                Connection conn = cfc.getKoneksi();
                Statement st = conn.createStatement();
//            String wl = new String(Base64.encodeBase64(aris.getBytes())); 
                LocalDateTime now = LocalDateTime.now();
//            String durasi = request.getParameter("durasi");

                List< FileItem> fields = upload.parseRequest(request);
                Iterator< FileItem> it = fields.iterator();
                if (!it.hasNext()) {
                    return;
                }
                String durasi = null;
                while (it.hasNext()) {
                    String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(Calendar.getInstance().getTime());
                    FileItem fileItem = it.next();
                    boolean isFormField = fileItem.isFormField();
                    String root = getServletContext().getRealPath("/");
                    File path = new File(root + "/uploads/Berkas");
                    if (isFormField) {
                        date1 = fileItem.getString();
                        if (file_name == null) {
                            if (fileItem.getFieldName().equals("file_name")) {
                                file_name = fileItem.getString();
                            }

                        }
                        if (fileItem.getFieldName().equals("tanggal")) {
                            tanggal = fileItem.getString();

                        }
                        if (fileItem.getFieldName().equals("tugas")) {
                            tugas = fileItem.getString();

                        }
                        if (fileItem.getFieldName().equals("kegiatan")) {
                            kegiatan = fileItem.getString();

                        }
                        if (fileItem.getFieldName().equals("pns")) {
                            pns = fileItem.getString();

                        }
                        if (fileItem.getFieldName().equals("detail")) {
                            detail = fileItem.getString();

                        }
                        if (fileItem.getFieldName().equals("durasi")) {
                            durasi = fileItem.getString();

                        }

                    } else {

                        if (fileItem.getSize() > 0) {
                            if (!path.exists()) {
                                boolean status = path.mkdirs();
                            }
                            berkas1 = new String(Base64.encodeBase64((timeStamp + fileItem.getName()).getBytes()));
//                        berkas=(wl+ timeStamp + fileItem.getName());
                            berkas = berkas1;
                            fileItem.write(new File(path + "/" + berkas));
                        }
                    }
                }
                System.out.println("File name " + date1);
                String sql = "insert into employee.aktivitas (nik_employee, nip, tanggal_aktivitas, tugas, kegiatan, detail, durasi, berkas_pendukung, tgl_input)"
                        + " values ('" + nik + "','" + pns + "','" + tanggal + "','" + kegiatan + "','" + tugas + "','" + detail + "','" + durasi + "','" + berkas + "','" + now + "')";
                System.out.println("sql " + sql);
                int ss = st.executeUpdate(sql);

                if (ss != 0) {
                    out.print("<script>"
                            + "alert(\"Kegiatan Anda Berhasil Ditambahkan..\");"
                            + "window.location.href = 'kegiatan';</script>");
                } else {
                    out.print("<script>"
                            + "alert(\"Kegiatan Anda Gagal Ditambahkan..\");"
                            + "window.location.href = 'kegiatan';</script >");
                }

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                out.println("<script type='text/javascript'>");
                out.println("window.location.href='kegiatan'");
                out.println("</script>");
                out.close();
            }
        }
    }
}
