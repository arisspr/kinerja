<%-- 
    Document   : form_activitas_update
    Created on : Feb 20, 2020, 9:27:12 AM
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
                            <h1 class="h3 mb-0 text-gray-800">Update Biodata</h1>
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
                                         <form action="biodata" method="post" >
                                             <!-- enctype="multipart/form-data" -->
                                             <% 
                                                 String b = request.getParameter("update");
                                                 b = new String(DatatypeConverter.parseBase64Binary(b));
                                                 System.out.println("b "+b);
                                                 MyConection conn = new MyConection();
                                                 Connection conn1 = conn.getKoneksi();
                                                 Statement profi = conn1.createStatement();
                                                 String Profil = "SELECT * FROM employee.biodata "
                                                             + "LEFT JOIN master.pendidikan ON biodata.pendidikan = pendidikan.id "
                                                             + "LEFT JOIN master.bidang ON biodata.bidang = bidang.id "
                                                             + "LEFT JOIN master.jabatan ON biodata.jabatan = jabatan.id "
                                                     + "LEFT JOIN master.kota ON biodata.tempat_lahir = kota.id WHERE nik = '"+b+"'";
                                                  System.out.println("Profil "+Profil);
                                                 ResultSet profile = profi.executeQuery(Profil);
                                                 while (profile.next()){ 
                                             %>
                                             <div class="form-group">
                                                 <label class="col-lg-4 control-label">Nama : </label>
                                                 <div class="col-lg-12">
                                                     <div >
                                                         <input type="text" class="form-control formq" name="name" autocomplete="off"  value = "<%=profile.getString("nama") %>" readonly required />
                                                     </div>
                                                 </div>
                                             </div>
                                             
                                                 <div class="form-group">
                                                     <label class="col-lg-2 control-label">Tempat Lahir : </label>
                                                     <div class="col-md-12">
                                                         <select style = "border: 1px solid #d1d3e2; border-radius: .35rem;" class="selectpicker form-control formq" name="tempat_lahir" data-live-search="true" required>
                                                             <option value="<%=profile.getString("tempat_lahir") %> "> <%=profile.getString("nama_kota") %> </option>
                                                             <% 
                                                                Statement tmpt_lhir = conn1.createStatement();
                                                                String tmpat_lhir = "SELECT * FROM master.kota where id != 0 ";
                                                                System.out.println("id "+tmpat_lhir);
                                                                ResultSet tmpt_lahir = tmpt_lhir.executeQuery(tmpat_lhir);
                                                                 while (tmpt_lahir.next()) {
                                                             %>
                                                             <option value="<%= tmpt_lahir.getString("id") %>"><%= tmpt_lahir.getString("nama_kota") %></option>
                                                             <% } %>
                                                         </select>
                                                     </div>
                                                 </div>
                                                 <div class="form-group"> 
                                                     <label class="col-lg-2 control-label">Tanggal Lahir : </label>
                                                     <div class="col-md-12">
                                                         <input type="text" id="tanggal" class="form-control datepicker formq" name="tgl_lahir" value = "<%=profile.getString("tanggal_lahir")%>" autocomplete="off" required>
                                                     </div>
                                                 </div>
                                                 <div class="form-group"> 
                                                     <label class="col-lg-2 control-label">Jenis Kelamin : </label>
                                                     <div class="col-md-12">
                                                         <select style = "border: 1px solid #d1d3e2; border-radius: .35rem;" class="selectpicker form-control formq" name="gender" data-live-search="true" required>
                                                             <option value="<%=profile.getString("jenis_kelamin") %>"> <%=profile.getString("jenis_kelamin") %> </option>
                                                             <% 
                                                               Statement gender = conn1.createStatement();
                                                                String gend = "SELECT unnest(enum_range(NULL::master.jenis_kelamin))";
                                                                System.out.println("id "+tmpat_lhir);
                                                                ResultSet gende = gender.executeQuery(gend);
                                                                 while (gende.next()) {
                                                             %>
                                                             <option value="<%= gende.getString("unnest") %>"><%= gende.getString("unnest") %></option>
                                                             <% } %>
                                                         </select>
                                                     </div>
                                                 </div>
                                                 <div class="form-group">
                                                     <label class="col-lg-2 control-label">Status Pernikahan : </label>
                                                     <div class="col-lg-12">
                                                         <select style = "border: 1px solid #d1d3e2; border-radius: .35rem;" class="selectpicker form-control formq" name="status" data-live-search="true" required>
                                                             <option value="<%=profile.getString("status_pernikahan") %>"> <%=profile.getString("status_pernikahan") %> </option>
                                                             <% 
                                                               Statement stat = conn1.createStatement();
                                                                String statu = "SELECT unnest(enum_range(NULL::master.status_pernikahan))";
                                                                System.out.println("id "+statu);
                                                                ResultSet status = stat.executeQuery(statu);
                                                                 while (status.next()) {
                                                             %>
                                                             <option value="<%= status.getString("unnest") %>"><%= status.getString("unnest") %></option>
                                                             <% } %>
                                                         </select>
                                                     </div>
                                                 </div>
                                                 <div class="form-group">
                                                     <label class="col-lg-2 control-label">Pendidikan dan jurusan: </label>
                                                     <div class="col-lg-12 form-inline">
                                                         <select style = "border: 1px solid #d1d3e2; border-radius: .35rem;" class="selectpicker form-control formq" name="education" data-live-search="true" required>
                                                             <option value="<%=profile.getString("pendidikan") %>"> <%=profile.getString("nama_pendidikan") %> </option>
                                                             <% 
                                                               Statement edu = conn1.createStatement();
                                                                String educ = "SELECT * from master.pendidikan where id != 0 ";
                                                                System.out.println("id "+statu);
                                                                ResultSet education = edu.executeQuery(educ);
                                                                 while (education.next()) {
                                                             %>
                                                             <option value="<%= education.getString("id") %>"><%= education.getString("nama_pendidikan") %></option>
                                                             <% } %>
                                                         </select>
                                                         <div class="col-lg-8">
                                                         <input type="text" class="form-control formq" name="prodi" value = "<%=profile.getString("jurusan")%>" autocomplete="off" required>
                                                     </div>
                                                     </div>
                                                 </div>        
                                                 <div class="form-group">
                                                     <label class="col-md-2 control-label" style="justify-content: left;">Nomer Hp : </label>
                                                     <div class="col-lg-12">
                                                         <input type="text" class="form-control formq" name="hp" placeholder="0" value="<%=profile.getString("hp")%>" required>
                                                     </div>
                                                 </div>                                                     
                                                 <div class="form-group">
                                                     <label class="col-md-2 control-label" style="justify-content: left;">Alamat : </label>
                                                     <div class="col-lg-12">
                                                         <input type="text" class="form-control formq" name="address" placeholder="0" value="<%=profile.getString("alamat")%>" required>
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
<% } %>