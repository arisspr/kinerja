<%-- 
    Document   : Activitas
    Created on : Feb 12, 2020, 3:45:27 PM
    Author     : aris
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import ="Conection.MyConection" %>
<%
    Object id = session.getAttribute("username");
    Object bidang = session.getAttribute("bidang");
    Object jabatan = session.getAttribute("jabatan");
    Object level = session.getAttribute("level");
    if (id == null || id.toString().trim().equals("") || level == null || level.toString().trim().equals("") || !level.toString().equals("Pns")) {
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
                                    <!--                                    <div class="card-header py-3">
                                                                            <span class="float-left"> 
                                                                                <button href="#" class="d-sm-inline-block btn btn-sm btn-primary shadow-sm" >
                                                                                    <i class="fas fa-plus fa-sm text-white-50"></i> Aktifitas</button>
                                                                            </span>-->
                                    <%
//                        Object logStat = request.getParameter("LoginStatus");
//                            if (logStat != null) {
//                                out.print("<div class=\"alert bg-danger\" style=\"color: white;\">"
//                                        + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>"
//                                        + " <strong>Login Gagal!</strong><br/>"
//                                        + " Periksa kembali username / password anda!"
//                                        + "</div>");
//                            }
                                    %>
                                    <!--</div>-->
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover" id="dataTable" width="100%" cellspacing="0">
                                                <thead>
                                                    <tr>
                                                        <th>Nomor</th>
                                                        <th>Tanggal aktifitas</th>
                                                        <th>Nama</th>
                                                        <th>Tugas</th>
                                                        <th>Kegiatan</th>
                                                        <th>Detail</th>
                                                        <th>Lama Pekerjaan</th>
                                                        <th>Berkas</th>
                                                        <th>Status</th>
                                                        <th>Aksi</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="show_data">
                                                    <%                                                        int no = 1;
                                                        MyConection conn = new MyConection();
                                                        Connection conn1 = conn.getKoneksi();
                                                        Statement com1 = conn1.createStatement();
                                                        String id_kasie = "SELECT id_kasie FROM master.kasie where nip = '" + id + "'";
                                                        ResultSet ksie = com1.executeQuery(id_kasie);
                                                        String kasie = "";
                                                        while (ksie.next()) {
                                                            kasie = ksie.getString("id_kasie");
                                                        }
                                                        System.out.println("ID KASIE " + kasie);
                                                        System.out.println("Jabtan " + jabatan);

//                                                        String Activitas = "Select a.aktivitas, a.tanggal_aktivitas, a.note, a.durasi, a.approve, a.detail, a.berkas_pendukung, t.nama_aktifitas as tupoksi, k.nama_aktifitas as kegiatan, "
//                                                                + "b.nama from employee.aktivitas as a "
//                                                                + "Join employee.biodata as b on a.nik_employee = b.nik "
//                                                                + "Join master.kegiatan as k on a.tugas = k.kode "
//                                                                + "Join master.tupoksi as t on a.kegiatan = t.kode "
//                                                                + "where a.nip = '" + id + "' and k.kasie ='"+kasie+"' and a.tanggal_aktivitas <= a.tanggal_aktivitas + INTERVAL '1' MONTH "
//                                                                + "and a.tanggal_aktivitas <= a.tanggal_aktivitas + Interval '1' year "
//                                                                //                                                                + "order by a.tgl_input desc ";
//                                                                + "order by a.approve ='Belum Disetujui' desc, a.tgl_input asc ";
                                                        String where = "";
                                                        String join = "";
                                                        if (jabatan == "10" && bidang == "3") {
                                                            where = "and k.kasie = " + kasie;
                                                        }
                                                        String Activitas = "Select a.aktivitas, a.tanggal_aktivitas, a.note, a.durasi, a.approve, a.detail, a.berkas_pendukung, t.nama_aktifitas as tupoksi, k.nama_aktifitas as kegiatan, "
                                                                + "b.nama from employee.aktivitas as a "
                                                                + "Join employee.biodata as b on a.nik_employee = b.nik "
                                                                + "Join master.kegiatan as k on a.tugas = k.kode "
                                                                + "Join master.tupoksi as t on a.kegiatan = t.kode "
                                                                + "where a.nip = '" + id + "' and a.tanggal_aktivitas <= a.tanggal_aktivitas + INTERVAL '1' MONTH "
                                                                + "and a.tanggal_aktivitas <= a.tanggal_aktivitas + Interval '1' year "
                                                                + where
                                                                //                                                                + "order by a.tgl_input desc ";
                                                                + "order by a.approve ='Belum Disetujui' desc, a.tgl_input asc ";
                                                        System.out.println("Activitas " + Activitas);
                                                        ResultSet aktifitasku = com1.executeQuery(Activitas);
                                                        String app = "";
                                                        String note = "";
                                                        while (aktifitasku.next()) {
                                                            app = aktifitasku.getString("approve");
                                                            note = aktifitasku.getString("note");
                                                    %>
                                                    <tr>                        
                                                        <td><% out.print(no);%></td>
                                                        <td><%= aktifitasku.getString("tanggal_aktivitas")%></td>
                                                        <td><%= aktifitasku.getString("nama")%></td>
                                                        <td><%= aktifitasku.getString("tupoksi")%></td>
                                                        <td><%= aktifitasku.getString("kegiatan")%></td>
                                                        <td><%= aktifitasku.getString("detail") //if (note == null ) {out.print("-"); }else{ out.print(app); }
                                                            %></td>
                                                        <td><%= aktifitasku.getString("durasi")%> Menit</td>
                                                        <td><a href='uploads/Berkas/<%= aktifitasku.getString("berkas_pendukung")%>' target='_blank'>View Berkas</a></td>
                                                        <td><% out.print(app);
                                                            out.println("<br>");
                                                            if (app.equals("Ditolak")) {
                                                                out.println("<b> Note : </b>" + note);
                                                            } else {
                                                            }%></td>
                                                        <td> 
                                                            <% if (app.equals("Ditolak") || app.equals("Belum Disetujui")) {%>
                                                            <!--                                                            <a href="<?php echo base_url('index.php/aktifitasku/edit/'.$aktifitas->aktivitas) ?>"
                                                                                                                           class="btn btn-small"><i class="fas fa-info-circle"></i> Detail</a>-->
                                                            <a class="btn btn-xs btn-info" data-toggle="modal" 
                                                               data-target="#modal_edit<%= aktifitasku.getString("aktivitas")%>">
                                                                <i class="fas fa-edit"></i> Verifikasi</a>

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
                            </div>
                        </div>

                        <!-- End Content Row -->
                    </div>
                    <!-- /.container-fluid -->

                </div>
                <!-- End of Main Content -->
                <%@include file = "../../Footer/Footer.jsp" %>
            </div>
            <%
                Statement com2 = conn1.createStatement();
                String usergroup = "";
                String detail = "Select a.aktivitas, a.detail, a.berkas_pendukung, gu.group_name_user from employee.aktivitas as a "
                        + "join employee.groupuser as gu ON gu.nik_user = a.nik_employee where a.nip = '" + id + "'";
                ResultSet detailq = com2.executeQuery(detail);
                while (detailq.next()) {
                    usergroup = detailq.getString("group_name_user").replace(" ", "");
            %>
            <!-- Form Add-->
            <!-- form -->
            <!-- modal edit Aktifitas -->
            <div class="modal fade" id="modal_edit<%=detailq.getString("aktivitas")%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">Update Aktifitas</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <form class="form-horizontal" method="post" action="update">
                            <div class="modal-body">
                                <div class="form-group">
                                    <input class="form-control" type="hidden" name="activitas" value="<%=detailq.getString("aktivitas")%>" readonly />
                                    <label for="Aktivitas">Aktivitas Yang dilakukan</label>
                                    <!--                        <textarea class="form-control" rows="4" cols="50" readonly style="padding: 0px !important; margin: 0px !important;text-align: left;">-->
                                    <p> <%= detailq.getString("detail") //if (note == null ) {out.print("-"); }else{ out.print(app); }
                                        %></p>
                                    <!--</textarea>-->
                                </div>
                                <div class="form-group">
                                    <label for="Berkas Pendukung">Berkas Pendukung</label>
                                    <div style="max-width:500px;">
                                        <!--<img src="uploads/Berkas/<%//= detailq.getString("berkas_pendukung")%>" alt="----">-->
                                        <object  data="uploads/Berkas/<%=detailq.getString("berkas_pendukung")%>" width="100%" height="500" style="height: 85vh;">^_^</object>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="Aktivitas">Approved*</label>
                                    <div style="max-width:500px;">
                                        <% //out.print(jabatan);%>
                                        <label class="radio-inline" style="margin: 0 10px 0 10px;">
                                            <input style ="transform:scale(1.9);" type="radio" name="approve" value="1" required>&ensp;&ensp;&ensp;
                                            <% if (!usergroup.equals("PENDAMPINGLATTAS")) { %>
                                            Disetujui
                                            <input type="hidden" name="verificator" value="finish">
                                            <% } else {
                                                if (jabatan.equals("12")) {%>
                                            Kasie
                                            <input type="hidden" name="verificator" value="kasie">
                                            <% } else if (jabatan.equals("10")) {
                                            %>
                                            Finish
                                            <input type="hidden" name="verificator" value="finish">
                                            <% } else if (jabatan.equals("9")) {%>
                                            Finish
                                            <input type="hidden" name="verificator" value="finish">
                                            <% }
                                                } %>
                                        </label>
                                        <label class="radio-inline" style="margin: 0 10px 0 10px;">
                                            <input style ="transform:scale(1.9);" type="radio" name="approve" value="2">&ensp;&ensp;&ensp;Ditolak
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="information">Keterangan*</label>
                                    <input class="form-control"
                                           type="text" name="information" placeholder="Keterangan" required/>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
                                <input class="btn btn-success" type="submit" name="btn" value="Save" />
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- end form -->
            <!--end Form Add-->
            <% }%>
    </body>
</html>
<% }%>
