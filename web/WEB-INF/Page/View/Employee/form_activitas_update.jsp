<%-- 
    Document   : form_activitas_update
    Created on : Feb 20, 2020, 9:27:12 AM
    Author     : aris
--%>

<%@page import="javax.xml.bind.DatatypeConverter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import ="Conection.MyConection" %>
<!DOCTYPE html>
<html>
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
    %>

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
            img {
                max-width: 100%;
                height: auto;
                width: auto\9; /* ie8 */
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
                                <!-- Form Add-->
                                <!-- form -->
                                <div class="card mb-3 myform">
                                    <div class="card-header">
                                        <a href="kegiatan" class="back"><i class="fas fa-arrow-left"></i> Back</a>
                                    </div>

                                    <div class="card-body">
                                        <!--<form action="ubahkegiatan" method="post" >-->
                                        <form action="ubahaktifitas" method="post" >
                                            <!-- enctype="multipart/form-data" -->
                                            <%
                                                String a = request.getParameter("update");
                                                a = new String(DatatypeConverter.parseBase64Binary(a));
                                                MyConection conn = new MyConection();
                                                Connection conn1 = conn.getKoneksi();
                                                Statement com1 = conn1.createStatement();
                                                String Activitas = "Select a.aktivitas, a.tanggal_aktivitas, a.note, a.durasi, a.approve, a.detail, a.nip, a.berkas_pendukung, t.nama_aktifitas as tupoksi, k.nama_aktifitas as kegiatan, "
                                                        + "b.nama, k.kode as kodekegiatan, t.kode as kodetupoksi from employee.aktivitas as a "
                                                        + "Join employee.biodata as b on a.nip = b.nik "
                                                        + "Join master.kegiatan as k on a.tugas = k.kode "
                                                        + "Join master.tupoksi as t on a.kegiatan = t.kode "
                                                        + "WHERE a.aktivitas = '" + a + "'";
                                                ResultSet aktifitasku = com1.executeQuery(Activitas);
                                                System.out.println("Activitas update " + Activitas);
                                                while (aktifitasku.next()) {
                                            %>
                                            <input type="hidden" name="activitas" value="<%= DatatypeConverter.printBase64Binary(aktifitasku.getString("aktivitas").getBytes())%>">
                                            <input type="hidden" name="approve" value="<%= DatatypeConverter.printBase64Binary(aktifitasku.getString("approve").getBytes())%>">
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">Tanggal : </label>
                                                <div class="col-lg-12">
                                                    <div >
                                                        <input type="text" class="form-control datepicker formq" name="tanggal" autocomplete="off"  value = "<%=aktifitasku.getString("tanggal_aktivitas")%>" readonly required />
                                                        <span class="input-group-addon" data-popup="tooltip" title="Anda hanya bisa mengisi Aktivitas hari ini dan hari- hari sebelum tanggal hari ini"> <i class="icon-question3"> </i> </span>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-lg-2 control-label">Tugas : </label>
                                                <div class="col-md-12">
                                                    <p><%//=aktifitasku.getString("tupoksi")%></p>
                                                    <select style = "border: 1px solid #d1d3e2; border-radius: .35rem;" class="selectpicker form-control formq" name="tugas" data-live-search="true" required>
                                                        <option value="<%=aktifitasku.getString("kodetupoksi")%>"> <%=aktifitasku.getString("tupoksi")%> </option>
                                                        <%
                                                            Statement group = conn1.createStatement();
                                                            String gro = "select * from employee.groupuser where nik_user = '" + id + "'";
                                                            String groupname = "";
                                                            ResultSet mygroup = group.executeQuery(gro);
                                                            while (mygroup.next()) {
                                                                groupname = mygroup.getString("group_name_user").replace(" ", "");
                                                            }
//                                                                System.out.println("id "+id);
                                                            Statement tugas = conn1.createStatement();
//                                                                String mytugas = "select * from master.tupoksi where bidang IN ( "+bidang+", 0 ) and jabatan IN ( "+jabatan+" , 0)";

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
                                                    <p><%//=aktifitasku.getString("kegiatan")%></p> 
                                                    <select style = "border: 1px solid #d1d3e2; border-radius: .35rem;" class="selectpicker form-control formq" name="kegiatan" data-live-search="true" required>
                                                        <option value="<%=aktifitasku.getString("kodekegiatan")%>"> <%=aktifitasku.getString("kegiatan")%> </option>
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
                                                    <!--<p><%//=aktifitasku.getString("nama")%></p>-->
                                                    <select style = "border: 1px solid #d1d3e2; border-radius: .35rem;" class="selectpicker form-control formq" name="pns" data-live-search="true" required>
                                                        <option value="<%= aktifitasku.getString("nip")%>"> <%= aktifitasku.getString("nama")%> </option>
                                                         <%
                                                                if(!groupname.equals("PENDAMPINGLATTAS")){
                                                                Statement pn = conn1.createStatement();
                                                                    String pns = "select username, alias from public.login where bidang = '"+bidang+"' and level = 'Pns' order by case when jabatan = '16' then 1 "
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
                                                        <%
                                                           /* OLD
                                                            Statement pn = conn1.createStatement();
                                                            String pns = "select * from login where level = 'Pns'";
                                                            ResultSet pnss = pn.executeQuery(pns);
                                                            while (pnss.next()) {*/
                                                        %>
                                                        <!--<option value="<%//= pnss.getString("username")%>"><%//= pnss.getString("alias")%></option>-->
                                                        <% //}%>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-2 control-label">Catatan/Detail Aktifitas : </label>
                                                <div class="col-lg-12">
                                                    <textarea name="detail" style="width:100%; height:80px; white-space: pre-line;" id="catatan"  placeholder="Isi aktivitas anda disini secara detail. . ." required>
                                                        <%=aktifitasku.getString("detail")%>
                                                    </textarea>
                                                </div>
                                            </div>
                                            <div class="form-group form-inline">
                                                <label class="col-md-2 control-label" style="justify-content: left;">Lama Pengerjaan : </label>
                                                <div class="col-lg-4 form-group mx-sm-3 mb-2">
                                                    <input type="number" class="form-control formq" name="durasi" id="durasi" placeholder="0" value="<%=aktifitasku.getString("durasi")%>" required>
                                                </div>
                                                <div class="col-lg-4 form-group mx-sm-3 mb-2">
                                                    <select class="form-control formq" name="satuan_waktu" id="satuan_waktu" required>
                                                        <option value="aduh">menit </option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <!--<label class="col-md-2 control-label" style="justify-content: left;">Berkas Pendukung : </label>
                                                <div class="col-lg-2 form-group mb-2"  style="justify-content: left;">
                                                    <input type="file" class="form-control formq" name="file_name" placeholder="Upload Berkas Pendukung Anda" required>
                                                </div>
                                                -->
                                                <label for="Berkas Pendukung">Berkas Pendukung</label>
                                                <div style="max-width:500px;">
                                                    <!--<img src="uploads/Berkas/<%=aktifitasku.getString("berkas_pendukung")%>" alt="----">-->
                                                    <%
                                                        String format = "none";
                                                        String fileName = aktifitasku.getString("berkas_pendukung");
                                                        int index = fileName.lastIndexOf(".");
                                                        if (index > 0) {
                                                            format = fileName.substring(index + 1);
                                                            format = format.toLowerCase();
                                                        }
                                                        if (format.equals("JPG") || format.equals("PNG") || format.equals("JEPG")) {
                                                    %>
                                                    <img src="uploads/Berkas/<%=aktifitasku.getString("berkas_pendukung")%>" alt="----">
                                                    <% } else {%>
                                                    <!--<embed src="uploads/Berkas/<%=aktifitasku.getString("berkas_pendukung")%>" type="application/pdf"   height="700px" width="500">-->
                                                    <!--<object  data="uploads/Berkas/<%=aktifitasku.getString("berkas_pendukung")%>" width="100%" height="500" style="height: 85vh;">^_^</object>-->
                                                    <% } %>
                                                </div>
                                            </div>
                                            <!-- <div class="form-group"> -->
                                            <button type="submit" class="btn btn-primary col-md-offset-5" id="btn-submit"> SAVE </button>
                                            <!-- </div> -->   
                                            <% } %>
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

    </body>
</html>
<% }%>