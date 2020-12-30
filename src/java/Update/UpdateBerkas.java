/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Update;

import Conection.MyConection;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.codec.binary.Base64;

/**
 *
 * @author aris
 */
public class UpdateBerkas extends HttpServlet{
    private static final long serialVersionUID = 1;
    private String aris="QXJpcyBTdXByaWFkaQ==";
    String foto1;
    String foto;
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
     
        String file_name = null;
        String date1=null;
        final long limit = 2 * 1024 * 1024;
//        String nik=null;

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
                String oldfoto = null;
                String activitas = null;
                String approve = null;
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
//                    
                        if (fileItem.getFieldName().equals("berkas")) {
                            oldfoto = new String(DatatypeConverter.parseBase64Binary(fileItem.getString()));
                            System.out.println("oldfoto From Form "+oldfoto);
                        }
                        
                        if (fileItem.getFieldName().equals("activitas")) {
                            activitas = new String(DatatypeConverter.parseBase64Binary(fileItem.getString()));
                            System.out.println("Activitas From Form "+activitas);
                        }
                        if (fileItem.getFieldName().equals("approve")) {
                            approve = new String(DatatypeConverter.parseBase64Binary(fileItem.getString()));
                            System.out.println("Activitas From Form "+activitas);
                        }

                    } else {
                        System.out.println("file_name "+file_name);
                        int index = fileItem.getName().toString().lastIndexOf(".");
                        if (index > 0) {
                            file_name = fileItem.getName().toString().substring(index + 1);
                            file_name = file_name.toLowerCase();
                         }
                         System.out.println("file_name "+file_name);
                        if (file_name.equals("jpg") || file_name.equals("jpeg") || file_name.equals("png") || file_name.equals("bmp") || file_name.equals("pdf")|| file_name.equals("xls")|| file_name.equals("xlsx")) {
                            if (fileItem.getSize() > 0 && fileItem.getSize() <= limit) {
                                if (!path.exists()) {
                                    boolean status = path.mkdirs();
                                }
                                foto1 = new String(Base64.encodeBase64((timeStamp + fileItem.getName()).getBytes()));
//                        berkas=(wl+ timeStamp + fileItem.getName());
                                foto = foto1;
                                String sql = "update employee.aktivitas SET berkas_pendukung = '" + foto + "', approve ='Belum Disetujui' "
                                        + "WHERE aktivitas = '" + activitas + "'";
                                System.out.println("sql " + sql);

                                System.out.println("OLD FOTO " + oldfoto);
                                int ss = st.executeUpdate(sql);
                                File oldfile = new File(path + "/" + oldfoto);
                                System.out.println("oldfile " + oldfile);
                                if (oldfile.delete()) {
                                    System.out.println("Delete Berkas Old = " + oldfile);
                                }
                                if (ss != 0) {
                                    fileItem.write(new File(path + "/" + foto));
                                    out.print("<script>"
                                            + "alert(\"Berkas Berhasil Diubah..\");"
                                            + "window.location.href = 'kegiatan';</script>");
                                } else {
                                    out.print("<script>"
                                            + "alert(\"Berkas Gagal Diubah..\");"
                                            + "window.location.href = 'kegiatan';</script >");
                                }
                                fileItem.write(new File(path + "/" + foto));
                            } else {
                                out.print("<script>"
                                        + "alert(\"Ukuran Berkas Tidak Boleh Melebihi dari 2Mb ..\");"
                                        + "window.location.href = 'kegiatan';</script>");
                            }
                       } else {
                            out.print("<script>"
                                    + "alert(\"Format Berkas Harus .JPG, .JPEG, .PNG, .PDF ..\");"
                                    + "window.location.href = 'kegiatan';</script>");
                        }
                    }
                }
//            System.out.println("File name " + date1);

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                out.println("<script type='text/javascript'>"
                        + "alert(\"Foto Gagal Diubah..\");");
                out.println("window.location.href='kegiatan'");
                out.println("</script>");
                out.close();
            }
        }
    }    
}
