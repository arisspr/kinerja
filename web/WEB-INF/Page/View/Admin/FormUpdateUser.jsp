<%-- 
    Document   : FormUser
    Created on : Feb 26, 2020, 10:28:50 AM
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
                                        <%
                                            String A = request.getParameter("update");
                                            String L = request.getParameter("L");
                                            A = new String(DatatypeConverter.parseBase64Binary(A));
                                            L = new String(DatatypeConverter.parseBase64Binary(L));
                                            MyConection cfc1 = new MyConection();
                                            Connection conn1 = cfc1.getKoneksi();
                                            Statement com1 = conn1.createStatement();
                                            String pass = "SELECT username, alias FROM public.login where username = '" + A + "'";
                                            System.out.println("Username Update" + pass);
                                            System.out.println("Username Update  L " + L);
                                            ResultSet mypass = com1.executeQuery(pass);
                                            String User = "";
                                            String alias = "";
                                            while (mypass.next()) {
//                                                User = DatatypeConverter.printBase64Binary(mypass.getString("username").getBytes());
                                                User = mypass.getString("username");
                                                alias = mypass.getString("alias");
                                            }
                                            
                                            if(L.equals("update")){
                                        %>
                                        
                                        <form action="passwordupdate" method="post" >

                                            <div class="form-group">
                                                <label for="name">Username*</label>
                                                <input class="form-control" type="text" name="username" value="<% out.print(User);%>" readonly/>
                                            </div>
                                            <div class="form-group">
                                                <label for="name">Nama Pemilik*</label>
                                                <input class="form-control" type="text" name="name" value="<% out.print(alias);%>" readonly/>
                                            </div>
                                            <div class="form-group">
                                                <label for="keterangan">New Password*</label>
                                                <input class="form-control" type="text" name="password" placeholder="New Password" required="Wajib Diisi"/>
                                                <div class="invalid-feedback">
                                                </div>
                                            </div>
                                            <input class="btn btn-success" type="submit" name="btn" value="Update" /> 

                                        </form>
                                          <% } else {  %>
                                          <form action="activeuser" method="post" >

                                            <div class="form-group">
                                                <label for="name">Username*</label>
                                                <input class="form-control" type="text" name="user" value="<% out.print(User);%>" readonly/>
                                            </div>
                                            <div class="form-group">
                                                <label for="name">Nama Pemilik*</label>
                                                <input class="form-control" type="text" name="name" value="<% out.print(alias);%>" readonly/>
                                            </div>
                                            <div class="form-group">
                                                <label for="keterangan">Aktifiasi User*</label>
                                                <div>
                                                        <select style = "border: 1px solid #d1d3e2; border-radius: .35rem;" class="selectpicker form-control formq" name="active" data-live-search="true" data-live-search-style="startsWith" required>
                                                            <option value=""> No Selected </option>
                                                            <%
                                                                Statement group = conn1.createStatement();
                                                                String ak = "select unnest(enum_range(null::master.login_status)) Aris";
                                                                ResultSet aktif = group.executeQuery(ak);
                                                                String status ="";
                                                                while (aktif.next()) {
                                                                    status = aktif.getString("Aris");
                                                            %>
                                                            <option value="<%= aktif.getString("Aris")%>"><% out.print(status.toUpperCase());%></option>
                                                            <% } %>
                                                        </select>
                                                </div>
                                            </div>
                                            <input class="btn btn-success" type="submit" name="btn" value="Update" /> 

                                        </form>
                                        <% } %>  

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