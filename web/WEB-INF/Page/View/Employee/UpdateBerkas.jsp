<%-- 
    Document   : UpdateBerkas
    Created on : Mar 23, 2020, 8:31:05 AM
    Author     : aris
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.xml.bind.DatatypeConverter"%>
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
                                         <form action="ubahberkas" method="post" enctype="multipart/form-data">
                                             <!-- enctype="multipart/form-data" -->
                                             <% 
                                                 String a = request.getParameter("update");
                                                 a = new String(DatatypeConverter.parseBase64Binary(a));
                                                 MyConection conn = new MyConection();
                                                 Connection conn1 = conn.getKoneksi();
                                                 Statement com1 = conn1.createStatement();
                                                 String Activitas = "Select aktivitas, tanggal_aktivitas, note, durasi, approve, detail, nip, berkas_pendukung "
                                                                + "from employee.aktivitas as a "
                                                                + "WHERE a.aktivitas = '"+a+"'";
                                                 String berkas = "";
                                                 ResultSet aktifitasku = com1.executeQuery(Activitas);
                                                 System.out.println("Activitas update "+Activitas);
                                                 while(aktifitasku.next()){
                                                     berkas = aktifitasku.getString("berkas_pendukung");                                                
                                             %>
                                                <input type="hidden" name="activitas" value="<%= DatatypeConverter.printBase64Binary(aktifitasku.getString("aktivitas").getBytes())%>">
                                                <input type="hidden" name="approve" value="<%= DatatypeConverter.printBase64Binary(aktifitasku.getString("approve").getBytes())%>">
                                                 <div class="form-group">
                                                 <label for="Berkas Pendukung">Berkas Pendukung Yang Akan Diubah</label>
                                                 <div style="max-width:100%; overflow: auto;">
                                                     <embed src="uploads/Berkas/<% out.print(berkas); %>" type="application/pdf"   height="700px" width="500">
                                                      <% } %>
                                                 </div>
                                                 </div>
                                                      <input type="hidden" name="berkas" value="<%= DatatypeConverter.printBase64Binary(berkas.toString().getBytes())%>">
                                                      <div class="form-group">
                                                          <label class="col-md-5 control-label" style="justify-content: left;">Upload Berkas Pendukung Yang Baru : </label>
                                                          <div style="overflow: auto;">
                                                              <input type="file" class="form-control formq" name="file_name" placeholder="Upload Foto Anda" required>
                                                          </div>
                                                      </div>
                                                 <!-- <div class="form-group"> -->
                                                 <button type="submit" class="btn btn-primary col-md-offset-5" id="btn-submit"> SAVE </button>
                                                 <!-- </div> -->   
                                                
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
<% } %>