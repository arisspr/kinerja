<%-- 
    Document   : Repot
    Created on : Feb 24, 2020, 5:27:19 PM
    Author     : aris
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="javax.xml.bind.DatatypeConverter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import ="Conection.MyConection" %>
<% 
Object id = session.getAttribute("username");
Object Cread = session.getAttribute("Cred");
Object bidang = session.getAttribute("bidang");
Object jabatan = session.getAttribute("jabatan");
Object level = session.getAttribute("level");
if (id == null || id.toString().trim().equals("") || level == null || level.toString().trim().equals("") || !level.toString().equals("Pns") || !jabatan.toString().equals("16") && !jabatan.toString().equals("10")) {
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
                            <h1 class="h3 mb-0 text-gray-800"><label class="control-label">Nama Pegawai : <% 
                                String namapegawai = "";
                                 String nik1 = request.getParameter("id");
                                                String month = request.getParameter("month");
                                                nik1 = new String(DatatypeConverter.parseBase64Binary(nik1));
                                                month = new String(DatatypeConverter.parseBase64Binary(month));
                                                System.out.println("a and b " + nik1 + " " + month);
                                                MyConection conn = new MyConection();
                                                Connection conn1 = conn.getKoneksi();
                                                Statement user = conn1.createStatement();
                                                Statement com1 = conn1.createStatement();
                                                String employee ="select nama from employee.biodata where nik = '"+nik1+"'";
                                                ResultSet nameemployee = com1.executeQuery(employee);
                                                while(nameemployee.next()){
                                                    namapegawai = nameemployee.getString("nama");
                                                }
                                out.print(namapegawai);
                                     %> </label></h1>
                        </div>
                        <!-- <div class="card shadow mb-4"> -->                      
                        <!-- Show -->     
                        <div class="col-lg-12 mb-3">                                
                                <!-- Form Add-->
                                <!-- form -->
                                <div class="card mb-3">
<!--                                    <div class="card-header">
                                        <a href="home" class="back"><i class="fas fa-arrow-left"></i> Cetak</a>
                                    </div>-->
                                                                        
                                        <%  
                                            Calendar now = Calendar.getInstance();
                                                int year = now.get(Calendar.YEAR);
                                                int day = now.get(Calendar.DAY_OF_MONTH);
                                                int hour = now.get(Calendar.HOUR_OF_DAY);
                                                int minute = now.get(Calendar.MINUTE);
                                                int millis = now.get(Calendar.MILLISECOND);
                                                
                                            String Report = "Select a.aktivitas, a.tanggal_aktivitas, a.note, a.durasi, a.approve, a.detail, a.berkas_pendukung, t.nama_aktifitas as tupoksi, k.nama_aktifitas as kegiatan, "
                                                        + "b.nama from employee.aktivitas as a "
                                                        + "Join employee.biodata as b on a.nip = b.nik "
                                                        + "Join master.kegiatan as k on a.tugas = k.kode "
                                                        + "Join master.tupoksi as t on a.kegiatan = t.kode "
                                                        + "WHERE a.nik_employee = '" + nik1 + "' and EXTRACT(MONTH FROM a.tanggal_aktivitas) ='" + month + "' and EXTRACT(Year FROM a.tanggal_aktivitas) ='" + year + "' "
                                                        + "order by a.approve ='Belum Disetujui' desc, a.tgl_input asc";
                                                ResultSet report = com1.executeQuery(Report);
                                                System.out.println("Activitas Report " + Report);                                              
                                        %>
                                        <div class="card-body">    
                                        <div >
                                            <table class="table table-hover table-responsive" id="dataTable" width="100%" cellspacing="0">                                                
                                                <thead>
                                                    <tr>
                                                        <th>Nomor</th>
                                                        <th>Tanggal aktifitas</th>
                                                        <th>Tugas</th>
                                                        <th>Detail Pekerjaan</th>
                                                        <th>Lama Pekerjaan</th>
                                                        <th>Pemberi Tugas</th>
                                                        <th>Status</th>
                                                        <th>Berkas</th>
                                                    </tr>
                                                </thead>
                                                <tbody>  
                                                    <%                                                        
                                                        int i = 1;
                                                        while (report.next()){                                                           
                                                        
                                                    %>
                                                    <tr>
                                                        <td><%out.print(i);%></td>
                                                        <td><%=report.getString("tanggal_aktivitas")%></td>
                                                        <td><%=report.getString("tupoksi")%></td>
                                                        <td><%=report.getString("detail")%></td>
                                                        <td><%=report.getString("durasi")%> Menit</td>
                                                        <td><%=report.getString("nama")%></td>
                                                        <td><%=report.getString("approve")%></td>
                                                        <td><a href='uploads/Berkas/<%= report.getString("berkas_pendukung")%>' target='_blank'>View Berkas</a></td>
                                                    </tr>
                                                    <% i++; } %>
                                                </tbody>
                                            </table>                                       
                                        </div>
                                    </div>                                   
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