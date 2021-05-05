<%-- 
    Document   : Activitas
    Created on : Feb 12, 2020, 3:45:27 PM
    Author     : aris
--%>
<%@page import="java.time.ZonedDateTime"%>
<%@page import="javax.xml.bind.DatatypeConverter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import ="Conection.MyConection" %>
<%
    Object id = session.getAttribute("username");
    Object bidang = session.getAttribute("bidang");
    Object jabatan = session.getAttribute("jabatan");
    Object level = session.getAttribute("level");
    if (id == null || id.toString().trim().equals("") || level == null || level.toString().trim().equals("") || !level.toString().equals("Employee")) {
%>
<script type="text/javascript">
    alert('Access Denied!');
    window.location.href = "login";
</script>
<%
} else {
//    Object prs = request.getParameter("id");
//    session.setAttribute("prs", prs);
MyConection conn2 = new MyConection();
Connection conn1 = conn2.getKoneksi();
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
                            <h1 class="h3 mb-0 text-gray-800">Data Aktifitas</h1>
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
                                            <button href="#" class="d-sm-inline-block btn btn-sm btn-primary shadow-sm sh" >
                                                <i class="fas fa-plus fa-sm text-white-50"></i> Aktifitas</button>
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
                                        <div>
 					  <%
                                                int years = ZonedDateTime.now().getYear();
                                                int month = ZonedDateTime.now().getMonthValue();
                                                int day = ZonedDateTime.now().getDayOfMonth();
                                            %>
                                            <table class="table-responsive table table-hover" id="dataTable" width="100%" cellspacing="0">
                                                <thead>
                                                    <tr>
                                                        <th>Nomor</th>
                                                        <th>Tanggal aktifitas</th>
                                                        <th>Tugas</th>
                                                        <th>Kegiatan</th>
                                                        <th>Detail</th>
                                                        <th>Lama Pekerjaan</th>
                                                        <th>Pemberi Tugas</th>
                                                        <th>Status</th>
                                                        <th>Aksi</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="show_data">
                                                    <%
                                                        int no = 1;                                                        
                                                        Statement com1 = conn1.createStatement();
                                                        String Activitas = "Select a.aktivitas, a.tanggal_aktivitas, a.note, a.durasi, a.approve, a.detail, t.nama_aktifitas as tupoksi, k.nama_aktifitas as kegiatan, "
                                                                + "b.nama from employee.aktivitas as a "
                                                                + "Join employee.biodata as b on a.nip = b.nik "
                                                                + "Join master.kegiatan as k on a.tugas = k.kode "
                                                                + "Join master.tupoksi as t on a.kegiatan = t.kode "
                                                                + "WHERE a.nik_employee = '" + id + "' and EXTRACT(YEAR FROM a.tanggal_aktivitas)='"+years+"' order by a.approve desc, a.tgl_input asc";
                                                        ResultSet aktifitasku = com1.executeQuery(Activitas);
                                                        System.out.println("Activitas " + Activitas);
                                                        String app = "";
                                                        String note = "";
                                                        while (aktifitasku.next()) {
                                                            app = aktifitasku.getString("approve");
                                                            note = aktifitasku.getString("note");
                                                    %>
                                                    <tr>                        
                                                        <td><% out.print(no);%></td>
                                                        <td><%= aktifitasku.getString("tanggal_aktivitas")%></td>
                                                        <td><%= aktifitasku.getString("tupoksi")%></td>
                                                        <td><%= aktifitasku.getString("kegiatan")%></td>
                                                            <td><%= aktifitasku.getString("detail") //if (note == null ) {out.print("-"); }else{ out.print(app); }
                                                                %></td>
                                                        <td><%= aktifitasku.getString("durasi")%> Menit</td>
                                                        <td><%= aktifitasku.getString("nama")%></td>
                                                            <td><% out.println(app);
                                                            out.println("<br>");
                                                            if (app.equals("Ditolak")) {
                                                                out.println("<b> Note : </b>" + note);
                                                            } else {
                                                            }%></td>
                                                        <td> 
                                                            <% if (app.equals("Ditolak")) {%>
                                                            <!--                                                            <a href="<?php echo base_url('index.php/aktifitasku/edit/'.$aktifitas->aktivitas) ?>"
                                                                                                                           class="btn btn-small"><i class="fas fa-info-circle"></i> Detail</a>-->
                                                            <a href="detail?update=<%= DatatypeConverter.printBase64Binary(aktifitasku.getString("aktivitas").getBytes())%>"
                                                               class="btn btn-small"><i class="fas fa-edit"></i> Edit</a>
                                                               <a href="berkas?update=<%= DatatypeConverter.printBase64Binary(aktifitasku.getString("aktivitas").getBytes())%>"
                                                               class="btn btn-small"><i class="fas fa-edit"></i> Edit Berkas</a>

                                                            <% } else { %>
                                                            -
                                                            <% } %>

                                                        </td>
                                                    </tr>
                                                    <%
                                                            no++;
                                                        }
                                                    %>
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
                                            <span class="text-semibold">Error!</span> Anda tidak dapat mengisi hari setelah hari ini, Karena Anda Bukan Dukun....
                                        </div>
                                        <div class="alert bg-warning alert-styled-left" id="peringatan-tanggal2">
                                            <span class="text-semibold">Error!</span> Batas Pengisian Anda sudah lebih dari 3 Hari... Maaf Ya Teman-Teman Saya Hanya Menjalankan Tugas....
                                        </div>
                                        <form action="inserthandle" method="post" enctype="multipart/form-data">
                                            <!-- enctype="multipart/form-data" -->
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">Tanggal : </label>
                                                <div class="col-lg-12">
                                                    <div >
                                                        <input type="text" id="tanggal" class="form-control datepicker formq" name="tanggal" autocomplete="off" required >
                                                        <span class="input-group-addon" data-popup="tooltip" title="Anda hanya bisa mengisi Aktivitas hari ini dan hari- hari sebelum tanggal hari ini"> <i class="icon-question3"> </i> </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="aris" >
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Tugas : </label>
                                                    <div class="col-md-12 " >
                                                        <select style = "border: 1px solid #d1d3e2; border-radius: .35rem;" class="form-control formq" name="tugas" data-live-search="true" data-live-search-style="startsWith" required>
                                                            <option value=""> No Selected </option>
                                                            <%
                                                                Statement group = conn1.createStatement();
                                                                String gro = "select * from employee.groupuser where nik_user = '" + id + "'";
                                                                String groupname = "";
                                                                ResultSet mygroup = group.executeQuery(gro);
                                                                while (mygroup.next()) {
                                                                    groupname = mygroup.getString("group_name_user").replace(" ", "");
                                                                }
                                                                System.out.println("groupname " + groupname);
                                                                System.out.println("Jabatan " + jabatan);
                                                                System.out.println("Bidang " + bidang);

                                                                Statement tugas = conn1.createStatement();
                                                                String mytugas = "select * from master.group as g "
                                                                        + "join master.tupoksi as t on t.kode = g.tupoksi where t.bidang IN ( " + bidang + ", 0 ) "
                                                                        + "and g.group_name IN ('" + groupname + "','Umum')"
                                                                        + "order by kode asc";
                                                                System.out.println("id " + mytugas);
                                                                ResultSet tugasnegara = tugas.executeQuery(mytugas);
                                                                while (tugasnegara.next()) {
                                                            %>
                                                            <option value="<%= tugasnegara.getString("kode")%>"><%= tugasnegara.getString("nama_aktifitas")%></option>
                                                            <% } %>
                                                        </select>
							<input type="hidden" name="groupname" value="<%out.print(DatatypeConverter.printBase64Binary(groupname.getBytes()));%>" >
                                                    </div>
                                                </div>
                                                <div class="form-group"> 
                                                    <label class="col-lg-2 control-label">Kegiatan : </label>
                                                    <div class="col-md-12">
                                                        <select style = "border: 1px solid #d1d3e2; border-radius: .35rem;" class="form-control formq" name="kegiatan" required>
                                                            <option value=""> No Selected </option>
                                                            <%
                                                                Statement kegiatan = conn1.createStatement();
                                                                String mykegiatan = "select * from master.kegiatan where bidang IN ( " + bidang + " , 0)";
                                                                ResultSet kegiatannegara = kegiatan.executeQuery(mykegiatan);
                                                                while (kegiatannegara.next()) {
                                                            %>
                                                            <option value="<%= kegiatannegara.getString("kode")%>"><%= kegiatannegara.getString("nama_aktifitas")%></option>
                                                            <% } %>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group"> 
                                                    <label class="col-lg-2 control-label">Pemberi Tugas : </label>
                                                    <div class="col-md-12">
                                                        <select style = "border: 1px solid #d1d3e2; border-radius: .35rem;" class="form-control formq" name="pns" data-live-search="true" required>
                                                            <option value=""> No Selected </option>
<%
                                                                if(!groupname.equals("PENDAMPINGLATTAS")){
                                                                Statement pn = conn1.createStatement();
                                                                   // String pns = "select username, alias from public.login where level = 'Pns' order by case when jabatan = '16' then 1 "
                                                                     //       + "when jabatan = '9' then 2 "
                                                                       //     + "when jabatan = '10' then 3 "
                                                                         //   + "when jabatan = '11' then 4 "
                                                                           // + "else 5 "
                                                                            //+ "end  ";
									    String pns = "select username, alias from public.login where bidang = '"+bidang+"' "
                                                                            + "and level = 'Pns' or username IN('196502091991032011') order by case when jabatan = '16' then 1 "
                                                                            + "when jabatan = '9' then 2 "
                                                                            + "when jabatan = '10' then 3 "
                                                                            + "when jabatan = '11' then 4 "
                                                                            + "else 5 "
                                                                            + "end  ";
                                                                    ResultSet pnss = kegiatan.executeQuery(pns);
                                                                    while (pnss.next()) {
                                                            %>
                                                            <option value="<%= pnss.getString("username")%>"><%= pnss.getString("alias")%></option>
                                                            <% } 

                                                                }else{
                                                                Statement pn = conn1.createStatement();
//                                                                String pns = "select * from login where level = 'Pns' ";
//                                                                String pns = "select username, alias from public.login where level = 'Pns' order by case when jabatan = '16' then 1 "
//                                                                        + "when jabatan = '9' then 2 "
//                                                                        + "when jabatan = '10' then 3 "
//                                                                        + "when jabatan = '11' then 4 "
//                                                                        + "else 5 "
//                                                                        + "end  ";
                                                                        String wilayah = "";
                                                                            String wil = "SELECT  wp.kecamatan, k.wilayah FROM employee.wilayah_pendamping as wp "
                                                                                    + "JOIN master.kecamatan as k ON k.id = wp.kecamatan WHERE wp.nik = '" + id + "'";
                                                                            ResultSet Wil = kegiatan.executeQuery(wil);
                                                                            while (Wil.next()) {
                                                                                wilayah = Wil.getString("wilayah");
                                                                            }
                                                                String pns = "SELECT b.nama, b.nik, b.level, b.jabatan, ek.wilayah FROM employee.biodata as b "
                                                                            + "LEFT JOIN employee.koordinatorwilayah as ek ON ek.nip = b.nik "
                                                                            + "WHERE b.level='Pns' and ek.wilayah = '"+wilayah+"' "
                                                                            + "or nik IN('198003102010011010','196502091991032011','196309011992111003','196808161997032005') order by case WHEN b.jabatan = '16' then 1 "
                                                                            + "WHEN b.jabatan = '9' then 2 "
                                                                            + "WHEN b.jabatan = '10' then 3 "
                                                                            + "when jabatan = '11' then 4 "
                                                                            + "else 5 "
                                                                            + "end ";
                                                                    System.out.println("PNS PETUGAS " + pns);
//                                                                    System.out.println("OBJECT GROUP  " + groupuser);
                                                                ResultSet pnss = kegiatan.executeQuery(pns);
                                                                while (pnss.next()) {
                                                            %>
                                                            <option value="<%= pnss.getString("nik")%>"><%= pnss.getString("nama")%></option>
                                                            <% }
                                                                }
                                                            %>
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
                                                <button type="submit" class="btn btn-primary col-md-offset-5" id="btn-submit"> SAVE </button>
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
                $('.myform').css('display', 'none');
                $(".sh").click(function () {
                    $('.myform').animate({
                        opacity: "show"
                    }, 2000, "linear").removeAttr("style");
                    $(".NH").animate({
                        //            opacity: 0.25           
                    }, 2000, "linear").css('display', 'none');
                });
                $(".back").click(function () {
                    $('.myform').animate({
                        //           opacity: 0.25 
                    }, 2000, "linear").css('display', 'none');
                    $(".NH").animate({
                        opacity: "show"
                    }, 2000, "linear").removeAttr("style");
                });
            </script>
    </body>
</html>
<% if (conn1 != null) {
        conn1.close();
    }
}
%>
