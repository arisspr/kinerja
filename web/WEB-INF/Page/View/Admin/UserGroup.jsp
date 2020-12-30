<%-- 
    Document   : Group
    Created on : Feb 28, 2020, 12:37:40 PM
    Author     : aris
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import ="Conection.MyConection" %>
<%@page import="javax.xml.bind.DatatypeConverter"%>

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
                            <h1 class="h3 mb-0 text-gray-800">Data Group</h1>
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
                                    <div class="card-header py-3">
                                        <span class="float-left"> 
                                            <a href="groupforuser" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">
                                                <i class="fas fa-plus fa-sm text-white-50"></i> Group</a>
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
                                        <div class="table-responsive">
                                            <table class="table table-hover" id="dataTable" width="100%" cellspacing="0">
                                                <thead>
                                                    <tr>
                                                        <th>Nomor</th>
                                                        <th>Nama Group</th>
                                                        <th>Nama User</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="show_data">
                                                    <%
                                                        int no = 1;
                                                        MyConection conn = new MyConection();
                                                        Connection conn1 = conn.getKoneksi();
                                                        Statement com1 = conn1.createStatement();
                                                        String group = "Select * from employee.groupuser as g "
                                                                + "join employee.biodata as b on b.nik = g.nik_user ";
                                                        ResultSet mygroup = com1.executeQuery(group);
                                                        String app = "";
                                                        String note = "";
                                                        while (mygroup.next()) {

                                                    %>
                                                    <tr>
                                                        <td><% out.println(no);%></td>
                                                        <td><%= mygroup.getString("group_name_user")%></td>
                                                        <td><%= mygroup.getString("nama")%></td>
                                                        <td width="250">
                                                            <a href="updateuser?update=<%= DatatypeConverter.printBase64Binary(mygroup.getString("id").getBytes())%>"
                                                               class="btn btn-small"><i class="fas fa-edit"></i> Reset</a>
                                                            <a onclick="deleteConfirm('<% %>')"
                                                               href="#!" class="btn btn-small text-danger"><i class="fas fa-trash"></i> Hapus</a>
                                                        </td>
                                                    </tr>
                                                    <% no++;
                                                        } %>
                                                </tbody>
                                            </table>
                                        </div>

                                    </div>
                                </div>


                                <!-- Form Add-->
                                
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
