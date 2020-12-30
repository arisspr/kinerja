<%-- 
    Document   : User
    Created on : Feb 26, 2020, 7:38:47 AM
    Author     : aris
--%>

<%@page import="javax.xml.bind.DatatypeConverter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import ="Conection.MyConection" %>
<%  
    Object id = session.getAttribute("username");
    Object bidang = session.getAttribute("bidang");
    Object jabatan = session.getAttribute("jabatan");
    Object level = session.getAttribute("level");
    if (id == null || id.toString().trim().equals("") || level == null || level.toString().trim().equals("") || !level.toString().equals("Admin")) {
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
        .formq {
            padding-left: 0;
            padding-right: 0;
            border-width: 1px 0;
            border-color: transparent;
            border-bottom-color: #4e73df;
            border-radius: 3px;
            -webkit-box-shadow: none;
            box-shadow: none;
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
                            <h1 class="h3 mb-0 text-gray-800">Data User</h1>
                        </div>
                        <!-- Content Row -->
                        <div class="row">

                            <!-- Content Column -->
                            <div class="col-lg-12 mb-4">

                                <!-- Project Card Example -->

                            </div>
                            <div class="col-lg-12 mb-3">
                                <!-- Illustrations -->
                                <div class="card shadow mb-4 NH">
                                    <div class="card-header py-3">
                                        <span class="float-left"> 
                                            <a href="adduser" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">
                                                <i class="fas fa-plus fa-sm text-white-50"></i> User</a>
                                        </span>
                                        <%
                                            Object logStat = request.getParameter("LoginStatus");
                                            if (logStat != null) {
                                                out.print("<div class=\"alert bg-danger\" style=\"color: white;\">"
                                                        + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>"
                                                        + " <strong>Login Gagal!</strong><br/>"
                                                        + " Periksa kembali username / password anda!"
                                                        + "</div>");
                                            }
                                        %>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover" id="dataTable" width="100%" cellspacing="0">
                                                <thead>
                                                    <tr>
                                                        <th>Nomor</th>
                                                        <th>Pemilik User</th>
                                                        <th>Bidang</th>
                                                        <th>Username</th>
                                                        <th>Password</th>
                                                        <th>Status</th>
                                                        <th>Level</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="show_data">
                                                     <%
                                                        int no = 1;
                                                        MyConection conn = new MyConection();
                                                        Connection conn1 = conn.getKoneksi();
                                                        Statement com1 = conn1.createStatement();
                                                        String myuser = "Select * from public.login "
                                                                + "join master.bidang on bidang.id = login.bidang where username != '281020160656'";
                                                        ResultSet user = com1.executeQuery(myuser);
                                                        String app = "";
                                                        String note = "";
                                                        String aktif = "";
                                                        while (user.next()) {
                                                           aktif = user.getString("login_status");
                                                    %>
                                                    <tr>
                                                        <td><% out.println(no); %></td>
                                                        <td><%= user.getString("alias")%></td>
                                                        <td><%= user.getString("nama_bidang")%></td>
                                                        <td><%= user.getString("username")%></td>
                                                        <td><%= user.getString("password")%></td>
                                                        <td><%if(aktif.equals("yes")){
                                                            out.print("Aktif");
                                                        } else { 
                                                            out.print("Non Aktif");
                                                                }%></td>
                                                        <td><%= user.getString("level")%></td>
                                                        <td width="250">
                                                            <a href="updateuser?update=<%= DatatypeConverter.printBase64Binary(user.getString("username").getBytes())%>&&L=<%= DatatypeConverter.printBase64Binary("update".getBytes())%>"
                                                               class="btn btn-small" title="Reset Password User"><i class="fas fa-edit"></i></a>
                                                            <a href="updateuser?update=<%= DatatypeConverter.printBase64Binary(user.getString("username").getBytes())%>&&L=<%= DatatypeConverter.printBase64Binary("aris supriadi".getBytes())%>"
                                                               class="btn btn-small" title="Aktif/ Non Aktif User"><i class="fas fa-edit"></i></a>
                                                            <a onclick="deleteConfirm('<% %>')"
                                                               href="#!" class="btn btn-small text-danger" title="Hapus User"><i class="fas fa-trash"></i></a>
                                                        </td>
                                                    </tr>
                                                    <% no++;} %>
                                                </tbody>
                                            </table>
                                        </div>

                                    </div>
                                </div>


                                <!-- Form Add-->
                                 <!-- form -->
                                 <div class="card mb-3 myform">
                                     <div class="card-header">
                                         <a href="#" class="back"><i class="fas fa-arrow-left"></i> Back</a>
                                     </div>

                                     <div class="card-body">
                                         <div class="alert bg-warning alert-styled-left" id="peringatan-tanggal">
                                             <span class="text-semibold">Error!</span> Anda tidak dapat mengisi hari setelah hari ini
                                         </div>
                                         <form action="add" method="post" enctype="multipart/form-data">
                                             <!-- enctype="multipart/form-data" -->
                                             <input type="hidden" name="nik" value="<?php echo $this->session->userdata('myusername'); ?>">
                                             <div class="form-group">
                                                 <label class="col-lg-4 control-label">Tanggal : </label>
                                                 <div class="col-lg-12">
                                                     <div >
                                                         <input type="text" id="tanggal" class="form-control datepicker formq" name="tanggal" autocomplete="off" required>
                                                         <span class="input-group-addon" data-popup="tooltip" title="Anda hanya bisa mengisi Aktivitas hari ini dan hari- hari sebelum tanggal hari ini"> <i class="icon-question3"> </i> </span>
                                                     </div>
                                                 </div>
                                             </div>
                                             <div id="aris">
                                                 <div class="form-group">
                                                     <label class="col-lg-2 control-label">Tugas : </label>
                                                     <div class="col-md-12">
                                                         <select style = "border: 1px solid #d1d3e2; border-radius: .35rem;" class="selectpicker form-control formq" name="tugas" data-live-search="true" required>
                                                             <option value=""> No Selected </option>
                                                             <% 
                                                                System.out.println("id "+id);
                                                                Statement tugas = conn1.createStatement();
                                                                String mytugas = "select * from master.tupoksi where bidang IN ( "+bidang+", 0 ) and jabatan IN ( "+jabatan+" , 0)";
                                                                System.out.println("id "+mytugas);
                                                                ResultSet tugasnegara = tugas.executeQuery(mytugas);
                                                                 while (tugasnegara.next()) {
                                                             %>
                                                             <option value="<%= tugasnegara.getString("kode") %>"><%= tugasnegara.getString("nama_aktifitas") %></option>
                                                             <% } %>
                                                         </select>
                                                     </div>
                                                 </div>
                                                 <div class="form-group"> 
                                                     <label class="col-lg-2 control-label">Kegiatan : </label>
                                                     <div class="col-md-12">
                                                         <select style = "border: 1px solid #d1d3e2; border-radius: .35rem;" class="selectpicker form-control formq" name="kegiatan" data-live-search="true" required>
                                                             <option value=""> No Selected </option>
                                                              <% 
                                                                Statement kegiatan = conn1.createStatement();
                                                                String mykegiatan = "select * from master.kegiatan where bidang IN ( "+bidang+" , 0)";
                                                                ResultSet kegiatannegara = kegiatan.executeQuery(mykegiatan);
                                                                 while (kegiatannegara.next()) {
                                                             %>
                                                             <option value="<%= kegiatannegara.getString("kode") %>"><%= kegiatannegara.getString("nama_aktifitas") %></option>
                                                             <% } %>
                                                         </select>
                                                     </div>
                                                 </div>
                                                 <div class="form-group"> 
                                                     <label class="col-lg-2 control-label">Pemberi Tugas : </label>
                                                     <div class="col-md-12">
                                                         <select style = "border: 1px solid #d1d3e2; border-radius: .35rem;" class="selectpicker form-control formq" name="pns" data-live-search="true" required>
                                                             <option value=""> No Selected </option>
                                                             <% 
                                                                Statement pn = conn1.createStatement();
                                                                String pns = "select * from login where level = 'Pns'";
                                                                ResultSet pnss = kegiatan.executeQuery(pns);
                                                                 while (pnss.next()) {
                                                             %>
                                                             <option value="<%= pnss.getString("username") %>"><%= pnss.getString("alias") %></option>
                                                             <% } %>
                                                         </select>
                                                     </div>
                                                 </div>
                                                 <div class="form-group">
                                                     <label class="col-lg-2 control-label">Catatan : </label>
                                                     <div class="col-lg-12">
                                                         <textarea name="detail" style="width:100%; height:80px;" id="catatan"  placeholder="Isi aktivitas anda disini secara detail. . ." required></textarea>
                                                     </div>
                                                 </div>
                                                 <div class="form-group form-inline">
                                                     <label class="col-md-2 control-label" style="justify-content: left;">Lama Pengerjaan : </label>
                                                     <div class="col-lg-4 form-group mx-sm-3 mb-2">
                                                         <input type="number" class="form-control formq" name="durasi" id="durasi" placeholder="0" required>
                                                     </div>
                                                     <div class="col-lg-4 form-group mx-sm-3 mb-2">
                                                         <select class="form-control formq" name="satuan_waktu" id="satuan_waktu" required>
                                                             <option value="aduh">menit </option>
                                                         </select>
                                                     </div>
                                                 </div>
                                                 <div class="form-group form-inline">
                                                     <label class="col-md-2 control-label" style="justify-content: left;">Berkas Pendukung : </label>
                                                     <div class="col-lg-2 form-group mb-2"  style="justify-content: left;">
                                                         <input type="file" class="form-control formq" name="file_name" placeholder="Upload Berkas Pendukung Anda" required>
                                                     </div>
                                                 </div>
                                                 <!-- <div class="form-group"> -->
                                                 <button type="submit" class="btn btn-primary col-md-offset-5" id="btn-submit"> SIMPAN </button>
                                                 <!-- </div> -->
                                             </div>
                                         </form>	

                                     </div>

                                     <div class="card-footer small text-muted">
                                         * required fields
                                     </div>
                                 </div>
                                 <!-- end form -->
                                <!--end Form Add-->
                            </div>
                        </div>

                        <!-- End Content Row -->
                    </div>
                    <!-- /.container-fluid -->

                </div>
                <!-- End of Main Content -->
                <%@include file = "../../Footer/Footer.jsp" %>
            </div>
<script>
    $('.myform').css('display','none');
    $(".sh").click(function(){
        $('.myform').animate({
           opacity: "show"
        },2000,"linear").removeAttr("style");
        $(".NH").animate({
//            opacity: 0.25           
        },2000,"linear").css('display','none');
    });
    $(".back").click(function(){
        $('.myform').animate({
//           opacity: 0.25 
        },2000,"linear").css('display','none');
        $(".NH").animate({
            opacity: "show"
        },2000,"linear").removeAttr("style");
    });
</script>
    </body>
</html>
<% } %>
