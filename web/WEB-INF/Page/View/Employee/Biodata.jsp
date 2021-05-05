<%-- 
    Document   : Biodata
    Created on : Feb 21, 2020, 8:44:18 AM
    Author     : aris
--%>

<%@page import="javax.xml.bind.DatatypeConverter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import ="Conection.MyConection" %>
<% 
Object id = session.getAttribute("username");
Object Cread = session.getAttribute("Cred");
Object bidang = session.getAttribute("bidang");
Object jabatan = session.getAttribute("jabatan");
Object level = session.getAttribute("level");
if (id == null || id.toString().trim().equals("") || level == null || level.toString().trim().equals("")) {
%>
<script type="text/javascript">
    alert('Access Denied!');
    window.location.href = "login";
</script>
<%
} else {
%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../../Header/Header.jsp" %>
        <style> 
            img {
                max-width: 100%;
                height: auto;
                width: auto\9; /* ie8 */
            }
            .image-container {
                display: flex;
                justify-content: center;
            }
        </style>
    </head>
    <body id="page-top">
        <!-- Page Wrapper -->
        <div id="wrapper">
            <!-- Sidebar -->
            <%@include file = "../../Sidebar/Sidebar.jsp" %>
            <!-- End of Sidebar -->
            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">
                <!-- Main Content -->
                <div id="content">
                    <!-- Topbar -->
                    <!-- Topbar Navbar -->
                    <%@include  file = "../../Navbar/Navbar.jsp" %>
                    <!-- End of Topbar -->

                    <!-- Begin Page Content -->
                    <div class="container-fluid">

                        <!-- Content Row -->
                        <div class="d-sm-flex align-items-center justify-content-between mb-4">
                            <h1 class="h3 mb-0 text-gray-800">Biodata</h1>
                        </div>
                        <!-- <div class="card shadow mb-4"> -->
                        <!-- aris -->                      

                        <div class="row">

                            <!-- Area Chart -->
                            <div class="col-xl-8 col-lg-7">
                                <div class="card shadow mb-4">
                                    <!-- Card Header - Dropdown -->
                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="m-0 font-weight-bold text-primary">Detail Biodata</h6>
                                        <div class="dropdown no-arrow">
                                            <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                                            </a>
                                            <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                                                <div class="dropdown-header">Dropdown Header:</div>
                                                
                                                <a class="dropdown-item" href="myprofile?update=<%= DatatypeConverter.printBase64Binary(id.toString().getBytes())%>">Update</a>
                                                
                                                <!-- <div class="dropdown-divider"></div>
                                                <a class="dropdown-item" href="#">Something else here</a> -->
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Card Body -->
                                    <div class="card-body">
                                        <% 
                                            MyConection conn = new MyConection();
                                            Connection conn1 = conn.getKoneksi();
                                            Statement prof = conn1.createStatement();
                                            String Profil = "SELECT * ,to_char(tgl_masuk_disnaker,'dd-MM-yyyy') as tgl_masuk,to_char(tanggal_lahir,'dd-MM-yyyy') as tgl_lahir FROM employee.biodata "
                                                     + "LEFT JOIN master.pendidikan ON biodata.pendidikan = pendidikan.id "
                                                     + "LEFT JOIN master.bidang ON biodata.bidang = bidang.id "
                                                     + "LEFT JOIN master.jabatan ON biodata.jabatan = jabatan.id "
                                                     + "LEFT JOIN master.kota ON biodata.tempat_lahir = kota.id WHERE nik = '"+id+"'";
                                            System.out.println("profile "+ Profil);
                                            String Foto = "";
                                            String tgl_masuk = "";
                                            ResultSet profile = prof.executeQuery(Profil);
                                            while (profile.next()){
                                                tgl_masuk = profile.getString("tgl_masuk");                                                
                                                Foto = profile.getString("foto");                          
                                        %>
                                        <div>
                                            Nama : <%=profile.getString("nama") %>
                                        </div>
                                        <div class="dropdown-divider"></div>
                                        <div>
                                            Tempat Tanggal Lahir  : <%=profile.getString("nama_kota")%> , <%=profile.getString("tgl_lahir")%>
                                        </div>
                                        <div class="dropdown-divider"></div>
                                        <div>
                                            Jenis Kelamin : <%=profile.getString("jenis_kelamin")%>
                                        </div>
                                        <div class="dropdown-divider"></div>
                                        <div>
                                            Status Pernikahan : <%=profile.getString("status_pernikahan")%>
                                        </div>
                                        <div class="dropdown-divider"></div>
                                        <div>
                                            Pendidikan Terakhir : <%=profile.getString("nama_pendidikan")%>,  Jurusan : <%=profile.getString("jurusan")%>
                                        </div>
                                        <div class="dropdown-divider"></div>
                                        <div>
                                            Nama Bidang : <%=profile.getString("nama_bidang")%>
                                        </div>
                                        <div class="dropdown-divider"></div>
                                        <div>
                                            Jabatan : <%=profile.getString("nama_jabatan")%>
                                        </div>
                                        <div class="dropdown-divider"></div>
                                        <div>
                                            Nomer HP : <%=profile.getString("hp")%>
                                        </div>
                                        <div class="dropdown-divider"></div>
                                        <div>
                                            Alamat : <%=profile.getString("alamat")%>
                                        </div>
                                        <div class="dropdown-divider"></div>
                                        <div>
                                            Tanggal Masuk Disnaker : <% out.println(tgl_masuk); %>
                                        </div>
                                        <!--<div class="dropdown-divider"></div>-->
<!--                                        <div>
                                                                                        Foto : <img src="<?php
                                                        //$byte_array = pg_fetch_object($biodata ['foto']);
                                                        //print pg_unescape_bytea($reg -> field_bytea);?>"/>
                                        </div>
                                        <div class="dropdown-divider"></div>-->
                                        <% } %>   
                                    </div>
                                </div>
                            </div>

                            <!-- Pie Chart -->
                            <div class="col-xl-4 col-lg-5">
                                <div class="card shadow mb-4">
                                    <!-- Card Header - Dropdown -->
                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="m-0 font-weight-bold text-primary">Foto Anda</h6>
                                        <div class="dropdown no-arrow">
                                            <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                                            </a>
                                            <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                                                <div class="dropdown-header">Dropdown Header:</div>
                                                <a class="dropdown-item" href="upload?foto=<%= DatatypeConverter.printBase64Binary(id.toString().getBytes())%>">Update Foto</a>
                                                <div class="dropdown-divider"></div>
                                                <a class="dropdown-item" href="#">^_^</a>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Card Body -->
                                    <div class="card-body">
                                        <div style="max-width:500px;" class="image-container">
                                            <%
                                               /* String root = getServletContext().getRealPath("/");
                                                File file = new File(root + "uploads/" + Foto);
//                            System.out.println("uploads "+dir);
//                            File[] files = dir.listFiles();
                                                if (!file.exists()) {
                                                    boolean status = file.mkdirs();
                                                    System.out.println("Status " + status);
                                                }
                                                if (file.isDirectory() && file.exists()) {*/
                                                    // Get list of file in the directory. When its length is not zero
                                                    // the folder is not empty.
                                                    /*String[] files = file.list();
                                                         System.out.println("Files " + file.exists());   
                                                         if (files != null && files.length > 0 ) {
                                                             System.out.println("The myfoto in here " + file.getPath() + " is not empty!");
                                                         } else {
                                                             System.out.println("The myfoto in here " + file.getPath() + " is empty!");*/
                                            %>
                                            <!--<img class="img-fluid px-3 px-sm-4 mt-3 mb-4" src="Include/assets/images/pp.jpeg">-->
                                            <%
/*}*/
                                            /*} else {
                                                System.out.println("The myfoto in here " + file.getPath() + " is not empty122!");*/
                                            %>
                                            <!--<img class="img-fluid px-3 px-sm-4 mt-3 mb-4" src="uploads/<% out.print(Foto); %>"/>-->
                                            <%
                                               /* }*/
                                            %>
<!--                                            <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" src="uploads/<% out.print(Foto); %>"/>-->
                                            
                                            <!--server-->
                                            <%
//                                                String root = request.getRealPath("/");
//                                                File file = new File(root+"/uploads/Profile/"+Foto);
//
//
//                                            if (Foto.equals("-") || Foto.equals("\\x2d") || Foto == null || Foto.isEmpty()) { %>
<!--//                                               <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" src="Include/assets/images/pp.jpeg">-->
//                                            <% //} else {
//                                                if (!file.isDirectory() && !file.exists()) {
//                                            %>
<!--//                                                <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" src="Include/assets/images/pp.jpeg">-->
//                                            <% //} else {
//                                                %>
<!--//                                                <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" src="uploads/Profile/<% //out.println(Foto); %>"/>-->
//                                            <% // }
//
//                                                } %>

                                            <!--End Server-->
                                            <%
                                                String root = getServletContext().getRealPath("/");
                                                File file = new File(root + "uploads/Profile/" + Foto);

                                            if (Foto.equals("-") || Foto.equals("\\x2d") || Foto == null || Foto.isEmpty()) { %>
                                            <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" src="Include/assets/images/pp.jpeg">
                                            <% } else {
                                                    if (!file.isDirectory() && !file.exists()) {
                                                        out.println("file "+file);
                                                        out.println("file.isDirectory() "+file.isDirectory());
                                                        out.println("file.exists() "+file.exists());
                                                        System.out.println(" file.isDirectory() && file.exists() "+file.isDirectory()+" "+file.exists());
                                                        %>
                                                            <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" src="Include/assets/images/pp.jpeg">
                                                 <% } else { 
                                                 out.println("file "+file);
                                                 out.println("file.isDirectory() "+file.isDirectory());
                                                 out.println("file.exists() "+file.exists());
                                                 %>
                                                            <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" src="uploads/Profile/<% out.println(Foto); %>"/>
                                                        <% }

                                                } %>
                                           
                                        </div>
                                        <div class="mt-4 text-center small">
                                            <span class="mr-2">
                                                <i class="fas fa-circle text-primary"></i> Direct
                                            </span>
                                            <span class="mr-2">
                                                <i class="fas fa-circle text-success"></i> Social
                                            </span>
                                            <span class="mr-2">
                                                <i class="fas fa-circle text-info"></i> Referral
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- aris -->
                        <!-- </div> -->
                        <!-- modal delete -->
                        <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Are you sure?</h5>
                                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">×</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">Data yang dihapus tidak akan bisa dikembalikan.</div>
                                    <div class="modal-footer">
                                        <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                                        <a id="btn-delete" class="btn btn-danger" href="#">Delete</a>
                                    </div>
                                </div>
                            </div>
                        </div>                        
                        <!-- End Content Row -->
                    </div>
                    <!-- /.container-fluid -->

                </div>
                <!-- End of Main Content -->
                <%@include file = "../../Footer/Footer.jsp" %>
            </div>
    </body>
</html>

<% if (conn1 != null) {
        conn1.close();
    }} %>