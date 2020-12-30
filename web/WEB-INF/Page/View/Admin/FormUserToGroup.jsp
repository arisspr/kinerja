<%-- 
    Document   : FormUserToGroup
    Created on : Feb 29, 2020, 12:33:59 PM
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
                            <h1 class="h3 mb-0 text-gray-800">Tambah Group</h1>
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
                                            <a href="groupuser" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">
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
                                        <form action="useraddgroup" method="post" >

                                            <div class="form-group">
                                                <label for="name">Nama Group*</label>
                                                <%
                                                    MyConection conn = new MyConection();
                                                    Connection conn1 = conn.getKoneksi();
                                                %>                                               
                                                <select style = "border: 1px solid #d1d3e2; border-radius: .35rem;" class="selectpicker form-control formq" name="group" data-live-search="true" required>
                                                    <option value=""> No Selected </option>
                                                    <%
                                                        System.out.println("id " + id);
                                                        Statement gr = conn1.createStatement();
                                                        String gro = "select DISTINCT(REPLACE((group_name), ' ','')) from master.group order by REPLACE((group_name), ' ','') asc";
//                                                        String gro = "select DISTINCT(group_name) from master.group order by group_name asc";
                                                        System.out.println("id " + gro);
                                                        ResultSet grou = gr.executeQuery(gro);
                                                        String nm = "";
                                                        while (grou.next()) {
                                                            nm = grou.getString("replace");
                                                    %>
                                                    <option value="<%out.print(nm); %>"><%= grou.getString("replace")%></option>
                                                    <% } %>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="keterangan">Nama Pegawai*</label>
                                            </div>
                                            <div class="form-group">
                                               
                                                    <%
                                                        Statement bd = conn1.createStatement();
                                                        String tupoksi = "select * from employee.biodata where nik !='281020160656' and level !='Pns'";
                                                        System.out.println("tupoksi group " + tupoksi);
                                                        ResultSet mytupoksi = bd.executeQuery(tupoksi);
                                                        int no = 0;
                                                        while (mytupoksi.next()) {
                                                    %>
                                                    <input type="checkbox" name="nik" value="<%= mytupoksi.getString("nik")%>">
                                                    <label for="tupoksi"> <%= mytupoksi.getString("nama")%></label><br>
                                                    <!--<option value="></option>-->
                                                    <% no ++; } %>
                                                <!--</select>-->
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
