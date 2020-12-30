<%-- 
    Document   : UpdatePassword
    Created on : Feb 24, 2020, 1:35:28 PM
    Author     : aris
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  
    Object id = session.getAttribute("username");
    Object bidang = session.getAttribute("bidang");
    Object jabatan = session.getAttribute("jabatan");
    Object level = session.getAttribute("level");
    if (id == null || id.toString().trim().equals("") || level == null || level.toString().trim().equals("") || !level.toString().equals("Employee") && !level.toString().equals("Pns")) {
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
                            <h1 class="h3 mb-0 text-gray-800">Reset Password</h1>
                        </div>
                        <!-- <div class="card shadow mb-4"> -->
                        <!-- aris -->     <!-- Content Row -->
                        <div class="col-lg-12 mb-3">
                            <!-- Content Column -->				
                            <div class="card mb-3">
                                <div class="card-header">
                                    <a href="home"><i class="fas fa-arrow-left"></i> Back</a>
                                </div>
                                <div class="card-body">
                                    <form action="updatepassword" method="post" >

                                        <div class="form-group">
                                            <label for="old">Password Lama*</label>
                                            <input class="form-control"
                                                   type="text" name="old" placeholder="Input Password Lama Anda" required="Wajib Diisi Bos"/>
                                            <div class="invalid-feedback">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="new password">New Password*</label>
                                            <input class="form-control"
                                                   type="password" name="new" placeholder="Password Baru Anda" required="Wajib Diisi Bos"/>
                                            <div class="invalid-feedback">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="confirm">Confirm New Password*</label>
                                            <input class="form-control"
                                                   type="password" name="confirm" placeholder="Ulangi Password Baru Anda" required="Wajib Diisi Bos"/>
                                            <div class="invalid-feedback">
                                            </div>
                                        </div>

                                        <input class="btn btn-success" type="submit" name="btn" value="Save" />
                                    </form>

                                </div>

                                <div class="card-footer small text-muted">
                                    * required fields
                                </div>
                            </div>
                        </div>
                        <!-- aris -->
                        <!-- </div> -->
                                                
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