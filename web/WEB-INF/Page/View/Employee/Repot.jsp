<%-- 
    Document   : Repot
    Created on : Feb 24, 2020, 5:27:19 PM
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
String urlLoc = "report";
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
            .center {
                text-align: center;
                font-weight: bold;
                font-weight: 900;
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
                            <h1 class="h3 mb-0 text-gray-800">Report</h1>
                        </div>
                        <!-- <div class="card shadow mb-4"> -->
                        <!-- aris -->     
                        <div class="col-lg-12 mb-3">
                                <!-- Illustrations -->
                                <!-- Form Add-->
                                <!-- form -->
                                <div class="card mb-3">
                                    <div class="card-header">
                                        <a href="home" class="back"><i class="fas fa-arrow-left"></i> Back</a>
                                    </div>

                                    <div class="card-body">                                        
                                        <form action="report" method="post">
                                            <!-- enctype="multipart/form-data" -->
                                            
                                          <div class="form-group">
                                                 <label class="col-lg-4 control-label">Tanggal Awal: </label>
                                                 <div class="col-lg-12">
                                                     <div >
                                                         <input type="text" class="form-control datepicker formq" name="first" autocomplete="off"  required />
                                                         <span class="input-group-addon" data-popup="tooltip" title="Anda hanya bisa mengisi Aktivitas hari ini dan hari- hari sebelum tanggal hari ini"> <i class="icon-question3"> </i> </span>
                                                     </div>
                                                 </div>
                                             </div>
                                            <div class="form-group">
                                                 <label class="col-lg-4 control-label">Tanggal Akhir: </label>
                                                 <div class="col-lg-12">
                                                     <div >
                                                         <input type="text" class="form-control datepicker formq" name="last" autocomplete="off"  required />
                                                         <span class="input-group-addon" data-popup="tooltip" title="Anda hanya bisa mengisi Aktivitas hari ini dan hari- hari sebelum tanggal hari ini"> <i class="icon-question3"> </i> </span>
                                                     </div>
                                                 </div>
                                             </div>
                                            <div class="form-group">                                                
                                                 <div class="col-lg-12">
                                                     <div >
                                                          <button type="submit" class="btn btn-primary col-md-offset-5" id="btn-submit" name="sub" value ='true'> SUBMIT </button>
                                                     </div>
                                                 </div>
                                             </div> 
                                           
                                        </form>	

                                    </div>

                                    <div class="card-footer small text-muted">
                                        * required fields
                                    </div>
                                </div>
                                <!-- end form 
                                <!--end Form Add-->
                            </div>
                        <!-- aris -->
                        <!-- Show -->     
                        <div class="col-lg-12 mb-3" >                                
                                <!-- Form Add-->
                                <!-- form -->
                                <div class="card mb-3">
                                    <div class="card-header center">
                                        <a class="back" > Laporan</a>
                                    </div>
                                    <div class="card-body">                                        
                                        <%
                                            boolean sub = Boolean.parseBoolean(request.getParameter("sub"));
                                            if (sub){
                                            String first = request.getParameter("first");
                                            String last = request.getParameter("last");
                                            MyConection conn = new MyConection();
                                                Connection conn1 = conn.getKoneksi();
                                                Statement com1 = conn1.createStatement();
                                                String Report = "Select a.aktivitas, a.tanggal_aktivitas, a.note, a.durasi, a.approve, a.detail, a.nip, a.berkas_pendukung, "
                                                        + "t.nama_aktifitas as tupoksi, k.nama_aktifitas as kegiatan, "
                                                        + "b.nama, k.kode as kodekegiatan, t.kode as kodetupoksi from employee.aktivitas as a "
                                                        + "Join employee.biodata as b on a.nip = b.nik "
                                                        + "Join master.kegiatan as k on a.tugas = k.kode "
                                                        + "Join master.tupoksi as t on a.kegiatan = t.kode "
                                                        + "WHERE a.nik_employee = '" + id + "' and a.tanggal_aktivitas >='"+first+"' and a.tanggal_aktivitas <='"+last+"'";
                                                ResultSet report = com1.executeQuery(Report);
                                                System.out.println("Activitas Report " + Report);                                                
                                        %>
                                        <div class="table-responsive">
                                            <table class="table table-hover" id="dataTable" width="100%" cellspacing="0">
                                                <thead>
                                                    <tr>
                                                        <th>Nomor</th>
                                                        <th>Tanggal aktifitas</th>
                                                        <th>Tugas</th>
                                                        <th>Detail</th>
                                                        <th>Lama Pekerjaan</th>
                                                        <th>Pemberi Tugas</th>
                                                        <th>Status</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="show_data">  
                                                    <% 
                                                        int no = 1;
                                                        while (report.next()) {

                                                    %>       <tr>                        
                                                        <td><%out.println(no);%></td>
                                                        <td><%=report.getString("tanggal_aktivitas")%></td>
                                                        <td><%=report.getString("tupoksi")%></td>
                                                        <td><%=report.getString("detail")%></td>
                                                        <td><%=report.getString("durasi")%></td>
                                                        <td><%=report.getString("nama")%></td>
                                                        <td><%=report.getString("approve")%></td>
                                                    </tr>
                                                    <%  
                                                        no++; }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <%  }
                                    %>
                                </div>
                                <!-- end form 
                                <!--end Form Add-->
                            </div>
                        <!-- Show -->
                                              
                        <!-- End Content Row -->
                    </div>
                    <!-- /.container-fluid -->

                </div>
                <!-- End of Main Content -->
                <%@include file = "../../Footer/Footer.jsp" %>
                <script>
                    $(document).ready(function() {
                        var table = $('#dataTable').DataTable( {
                            lengthChange: false,
                            buttons: [ 'copy', 'excel', 'pdf', 'colvis' ]
                        } );

                        table.buttons().container()
                            .appendTo( '#example_wrapper .col-md-6:eq(0)' );
                    } );
                    </script>
            </div>
    </body>
</html>

<% } %>