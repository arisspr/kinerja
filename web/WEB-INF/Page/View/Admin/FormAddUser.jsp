<%-- 
    Document   : FormAddUser
    Created on : Feb 26, 2020, 12:28:37 PM
    Author     : aris
--%>

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
//    Object prs = request.getParameter("id");
//    session.setAttribute("prs", prs);
%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../../Header/Header.jsp" %>
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
                            <h1 class="h3 mb-0 text-gray-800">Tambah User</h1>
                        </div>
                        <!-- Content Row -->
                        <div class="row">

                            <!-- Content Column -->
                            <div class="col-lg-12 mb-4">

                                <!-- Project Card Example -->

                            </div>
                            <div class="col-lg-12 mb-3">
                                <!-- Illustrations -->
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <span class="float-left"> 
                                            <a href="user" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">
                                                <i class="fas fa-arrow-left"></i> Back</a>
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
                                        <form action="addusers" method="post" >

                                            <div class="form-group">
                                                <label for="name">NIK / NIP User*</label>
                                                <input class="form-control" type="text" name="nik" minlength="16" maxlength="19" placeholder="NIK / NIP" required="NIK / NIP"/>
                                            </div>
                                            <div class="form-group">
                                                <label for="name">Nama User*</label>
                                                <input class="form-control" type="text" name="name" placeholder="Nama User" required="Nama"/>
                                            </div>
                                            <div class="form-group">
                                                <label for="keterangan">Bidang*</label>
                                                <%
                                                    MyConection conn = new MyConection();
                                                    Connection conn1 = conn.getKoneksi();
                                                %>                                               
                                                <select style = "border: 1px solid #d1d3e2; border-radius: .35rem;" class="selectpicker form-control formq" name="bidang" data-live-search="true" required>
                                                    <option value=""> No Selected </option>
                                                    <%
                                                        Statement bd = conn1.createStatement();
                                                        String mybidang = "select * from master.bidang where id != 0";
                                                        System.out.println("id " + mybidang);
                                                        ResultSet bdang = bd.executeQuery(mybidang);
                                                        while (bdang.next()) {
                                                    %>
                                                    <option value="<%= bdang.getString("id")%>"><%= bdang.getString("nama_bidang")%></option>
                                                    <% } %>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="keterangan">Jabatan*</label>                                            
                                                <select style = "border: 1px solid #d1d3e2; border-radius: .35rem;" class="selectpicker form-control formq" name="jabatan" data-live-search="true" required>
                                                    <option value=""> No Selected </option>
                                                    <%
                                                        Statement jb = conn1.createStatement();
                                                        String myjb = "select * from master.jabatan where id != 0";
                                                        System.out.println("id " + myjb);
                                                        ResultSet jbt = jb.executeQuery(myjb);
                                                        while (jbt.next()) {
                                                    %>
                                                    <option value="<%= jbt.getString("id")%>"><%= jbt.getString("nama_jabatan")%></option>
                                                    <% } %>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="keterangan">Level*</label>                                            
                                                <select style = "border: 1px solid #d1d3e2; border-radius: .35rem;" class="selectpicker form-control formq" name="level" data-live-search="true" required>
                                                    <option value=""> No Selected </option>
                                                    <%
                                                        Statement lv = conn1.createStatement();
                                                        String mylv = "select Aris from unnest(enum_range(null::master.login_level)) Aris where Aris <> 'Admin'";
                                                        System.out.println("id " + myjb);
                                                        ResultSet lvl = lv.executeQuery(mylv);
                                                        while (lvl.next()) {
                                                    %>
                                                    <option value="<%= lvl.getString("Aris")%>"><%= lvl.getString("Aris")%></option>
                                                    <% } %>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="keterangan">Status Login*</label>                                            
                                                <select style = "border: 1px solid #d1d3e2; border-radius: .35rem;" class="selectpicker form-control formq" name="status" data-live-search="true" required>
                                                    <option value=""> No Selected </option>
                                                    <%
                                                        Statement sta = conn1.createStatement();
                                                        String mysta = "select Aris from unnest(enum_range(null::master.login_status)) Aris";
                                                        System.out.println("id " + mysta);
                                                        ResultSet status = sta.executeQuery(mysta);
                                                        while (status.next()) {
                                                    %>
                                                    <option value="<%= status.getString("Aris")%>"><%= status.getString("Aris")%></option>
                                                    <% } %>
                                                </select>
                                            </div>
                                                <div class="form-group">
                                            <input class="btn btn-success" type="submit" name="btn" value="Save" /> 
                                            <span class="float-right"> 
                                            <a href="user" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">
                                                <i class="fas fa-chain-broken"></i> Cancel</a>
                                        </span> 
                                                </div>
                                        </form>

                                    </div>
                                    <div class="card-footer small text-muted">
                                        * required fields
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
<% }%>
