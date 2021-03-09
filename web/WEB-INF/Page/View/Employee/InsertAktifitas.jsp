<%-- 
    Document   : InsertAktifitas
    Created on : Aug 12, 2020, 1:33:11 PM
    Author     : aris
--%>

<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.time.LocalDate"%>
<%@page import="javax.xml.bind.DatatypeConverter"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.apache.tomcat.util.codec.binary.Base64"%>
<%@page import="java.io.File"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="Conection.MyConection"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <%        
        System.out.println("Post Project   " + request.getParameter("tanggal"));
            String aris = "QXJpcyBTdXByaWFkaQ==";
            String berkas1;
            String berkas;
            String file_name = null;
            String date1 = null;
//        String nik=null;
            String tanggal = null;
            String tugas = null;
            String kegiatan = null;
            String pns = null;
            String detail = request.getParameter("detail");
            String groupname = null;
            String verificator = "pns";
            System.out.println("group Name "+groupname);
        final long limit = 2 * 1024 * 1024;
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
//            out.close();
        } else {
            try {

                System.out.println("NIK " + nik);
                MyConection cfc = new MyConection();
                Connection conn = cfc.getKoneksi();
                Statement st = conn.createStatement(); 
                LocalDateTime now = LocalDateTime.now();
                 
                String long_time = "select * from employee.long_time";
                ResultSet lt1 = st.executeQuery(long_time);
                String lt = "";
                while (lt1.next()) {
                    lt = lt1.getString("long_time");
                }
                
//                Calendar last_today = Calendar.getInstance();
//                last_today.add(Calendar.DATE, -(Integer.parseInt(lt)));
                
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                
                
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
                            
                            //System.out.println("Tanggal Input" + tanggal);
                            //System.out.println("Tanggal hari ini" + last_today.getTime());
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
                        if (fileItem.getFieldName().equals("groupname")) {
                            groupname = fileItem.getString();
                            System.out.println("groupname aaaa1111 " + groupname);

                        }

                    } else {
                        Date today = new Date();
                        int today1 = today.getDate();
                        int monthtoday1 = today.getMonth();
                        int yeartoday = today.getYear();
                        int yeartoday1 = yeartoday + 1900;
//                        tanggal = dateFormat.format(now1);
                        Date date_input1 = dateFormat.parse(tanggal);
                        int data_input = date_input1.getDate();
                        int last_day = today.getDate()-(Integer.parseInt(lt) - 1);
                        int monthlast_day = date_input1.getMonth();
                        int yearlast_day = date_input1.getYear();
                        int yearlast_day1 = yearlast_day+(1900);
                        long bedaHari = Math.abs(today.getTime() - date_input1.getTime());
                             bedaHari = TimeUnit.MILLISECONDS.toDays(bedaHari);
                             System.out.println(" Math.abs(today.getTime()) " + Math.abs(today.getTime()));
                             System.out.println(" Math.abs(date_input1.getTime()) " + Math.abs(date_input1.getTime()));
//                        Date today = dateFormat.format(now1);
                        System.out.println("Tanggal Input lt " + lt);
                        System.out.println("Tanggal Input " + tanggal);
                        System.out.println("Tanggal Input2 " + today);
                        System.out.println("Tanggal Input3 " + date_input1);
                        System.out.println("Tanggal today1 " + today1);
                        System.out.println("Tanggal data_input " + data_input);
                        System.out.println("Tanggal last_day " + last_day);
                        System.out.println("Tanggal monthtoday1 " + monthtoday1);
                        System.out.println("Tanggal yeartoday1 " + yeartoday1);
                        System.out.println("Tanggal monthlast_day " + monthlast_day);
                        System.out.println("Tanggal yearlast_day " + yearlast_day1);
                        System.out.println("beda HAri " + bedaHari+" lt "+lt );
//if (data_input < last_day || yeartoday1 < yearlast_day1){                        
if (Math.abs(today.getTime()) < Math.abs(date_input1.getTime()) || yeartoday1 < yearlast_day1){                        
//if (today.after(date_input1)) {
//                            out.print("<script>"
//                                                        + "alert(\"Ndak Sopan1\");"
//                                                        + "window.location.href = 'kegiatan';</script>");
                            out.print("Semoga Tuhan Mengampuni Segala Dosa - Dosa Yang Anda Perbuat !!!");
                        }//last
//else if(data_input > today1 || yeartoday1 > yearlast_day1) {
else if(bedaHari > (Integer.parseInt(lt)-1) || yeartoday1 > yearlast_day1) {
    out.print("<script>"
                                                        + "alert(\"Ndak Sopan2\");"
                                                        + "window.location.href = 'kegiatan';</script>");
                                }else{
                                    int index = fileItem.getName().toString().lastIndexOf(".");
                                    if (index > 0) {
                                        file_name = fileItem.getName().toString().substring(index + 1);
                                        file_name = file_name.toLowerCase();
                                    }
                                    if (file_name.equals("jpg") || file_name.equals("jpeg") || file_name.equals("png") || file_name.equals("bmp") || file_name.equals("pdf") || file_name.equals("xls") || file_name.equals("xlsx")) {
                                        if (fileItem.getSize() > 0 && fileItem.getSize() <= limit) {
                                            if (!path.exists()) {
                                                boolean status = path.mkdirs();
                                            }
                                            berkas1 = new String(Base64.encodeBase64((timeStamp + fileItem.getName()).getBytes()));
                                            berkas = berkas1;
                                            System.out.println("File name " + date1);
                                            groupname = new String(DatatypeConverter.parseBase64Binary(groupname));
                                            if (groupname.equals("PENDAMPINGLATTAS")) {
                                                verificator = "koordinator";
                                            }
                                            String sql = "";
//                                String sql = "insert into employee.aktivitas (nik_employee, nip, tanggal_aktivitas, tugas, kegiatan, detail, durasi, berkas_pendukung, verifikasi, tgl_input)"
//                                        + " values ('" + nik + "','" + pns + "','" + tanggal + "','" + kegiatan + "','" + tugas + "','" + detail + "','" + durasi + "','" + berkas + "','" + verificator + "','" + now + "')";
                                            System.out.println("sql22 " + sql);
                                            int ss = st.executeUpdate(sql);

                                            if (ss != 0) {
                                                fileItem.write(new File(path + "/" + berkas));
                                                out.print("<script>"
                                                        + "alert(\"Kegiatan Anda Berhasil Ditambahkan..\");"
                                                        + "window.location.href = 'kegiatan';</script>");
                                            } else {
                                                out.print("<script>"
                                                        + "alert(\"Kegiatan Anda Gagal Ditambahkan..\");"
                                                        + "window.location.href = 'kegiatan';</script >");
                                            }

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

                                }//last
                    }
                }
                

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                out.println("<script type='text/javascript'>");
                out.println("window.location.href='kegiatan'");
                out.println("</script>");
//                out.close();
            }
        }
        %>
    </body>
</html>
