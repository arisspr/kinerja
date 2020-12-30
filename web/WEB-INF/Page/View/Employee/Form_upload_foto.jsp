<%-- 
    Document   : Form_upload_foto
    Created on : Feb 21, 2020, 10:16:07 AM
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
                            <h1 class="h3 mb-0 text-gray-800">Upload Foto Profile</h1>
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
                                <div class="card mb-3">
                                    <div class="card-header">
                                        <a href="profile" class="back"><i class="fas fa-arrow-left"></i> Back</a>
                                    </div>

                                    <div class="card-body">                                        
                                        <form action="myfoto" method="post" enctype="multipart/form-data">
                                            <!-- enctype="multipart/form-data" -->
                                            <%
                                                String foto = request.getParameter("foto");
                                                foto = new String(DatatypeConverter.parseBase64Binary(foto));
//                                                System.out.println("Foto "+ foto);
                                                MyConection conn = new MyConection();
                                                Connection conn1 = conn.getKoneksi();
                                                Statement com1 = conn1.createStatement();
                                                String ft = "select foto from employee.biodata where nik = '"+id+"'";
//                                                String Activitas = "Select a.aktivitas, a.tanggal_aktivitas, a.note, a.durasi, a.approve, a.detail, a.berkas_pendukung, t.nama_aktifitas as tupoksi, k.nama_aktifitas as kegiatan, "
//                                                        + "b.nama from employee.aktivitas as a "
//                                                        + "Join employee.biodata as b on a.nip = b.nik "
//                                                        + "Join master.kegiatan as k on a.tugas = k.kode "
//                                                        + "Join master.tupoksi as t on a.kegiatan = t.kode "
//                                                        + "WHERE a.aktivitas = '" + foto + "'";
                                                ResultSet fto = com1.executeQuery(ft);
                                                String myfto = "";
                                                while (fto.next()) {
                                                myfto = fto.getString("foto");
                                                }
                                                System.out.println("myfto "+myfto);
                                            %>
                                            <input type="hidden" name="oldfoto" value="<%= DatatypeConverter.printBase64Binary(myfto.toString().getBytes())%>">
                                            <div class="form-group">
                                                <label class="col-md-2 control-label" style="justify-content: left;">Upload Foto : </label>
                                                <div>
                                                    <input type="file" class="form-control formq" name="file_name" placeholder="Upload Foto Anda" required>
                                                </div>
                                            </div>
                                            <!-- <div class="form-group"> -->
                                            <button type="submit" class="btn btn-primary col-md-offset-5" id="btn-submit"> SAVE </button>
                                            <!-- </div> -->   
                                            <% //} %>
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
