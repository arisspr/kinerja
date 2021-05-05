<%-- 
    Document   : Navbar
    Created on : Feb 12, 2020, 10:23:35 AM
    Author     : aris
--%>

<%@page import="java.io.File"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="Conection.MyConection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  
    Object nik = session.getAttribute("username");
    Object bidang1 = session.getAttribute("bidang");
    Object jabatan1 = session.getAttribute("jabatan");
    Object level1 = session.getAttribute("level");
    if (nik == null || nik.toString().trim().equals("") || level1 == null || level1.toString().trim().equals("") ) {
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
    <%-- Topbar --%>
    <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

        <%-- Sidebar Toggle (Topbar) --%>
        <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
        </button>
        <%-- Topbar Navbar --%>
        <ul class="navbar-nav ml-auto">

            <%-- Nav Item - Search Dropdown (Visible Only XS) --%>
<!--            <li class="nav-item dropdown no-arrow d-sm-none">
                <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fas fa-search fa-fw"></i>
                </a>
                <%-- Dropdown - Messages --%>
                <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in" aria-labelledby="searchDropdown">
                    <form class="form-inline mr-auto w-100 navbar-search">
                        <div class="input-group">
                            <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="button">
                                    <i class="fas fa-search fa-sm"></i>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </li>-->
            <%--  --%>
            <div class="topbar-divider d-none d-sm-block"></div>
            <%-- Nav Item - User Information --%>
            <li class="nav-item dropdown no-arrow">
                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="mr-2 d-none d-lg-inline text-gray-600 small">
                        <%
                            MyConection cfc = new MyConection();
                            Connection conn = cfc.getKoneksi();
                            Statement com1 = conn.createStatement();
                            String query1 = "Select nama,foto "
                                          + "from employee.biodata where nik = '" + nik + "'";
                            System.out.println("query1" + query1);
                            ResultSet ss1 = com1.executeQuery(query1);
                            String nama = "", foto = "";
                            
                            while (ss1.next()) {
                                      nama = ss1.getString("nama");
                                      foto = ss1.getString("foto");
//                                      System.out.println("File : "+files);
                                  }
                            out.println(nama);
                        %>
                       </span>
                        <%
                            /* File file = new File("/uploads/"+foto);
//                            System.out.println("uploads "+dir);
//                            File[] files = dir.listFiles();
                              if (file.isDirectory()) {
                                      // Get list of file in the directory. When its length is not zero
                                      // the folder is not empty.
                                      String[] files = file.list();

                                      if (files != null && files.length > 0) {
                                          System.out.println("The myfoto in here " + file.getPath() + " is not empty!");
                                      } else {
                                          System.out.println("The myfoto in here is empty!");
                                      }
                                  }*/
                            String root = getServletContext().getRealPath("/");
                            File file = new File(root + "uploads/Profile/" + foto);

                            if (foto.equals("-") || foto.equals("\\x2d") || foto == null || foto.isEmpty()) { %>
                        <img class="img-profile rounded-circle" src="Include/assets/images/pp.jpeg">
                        <% } else {
                            if (!file.isDirectory() && !file.exists()) { %>
                        <img class="img-profile rounded-circle" src="Include/assets/images/pp.jpeg">
                        <% } else { %>
                        <img class="img-profile rounded-circle" src="uploads/Profile/<% out.println(foto); %>"/>
                        <% }

                        } %>
                </a>
                <%-- Dropdown - User Information --%>
                <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                    <a class="dropdown-item" href="profile">
                        <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                        Profile
                    </a>

                    <a class="dropdown-item" href="password">
                        <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                        Settings
                    </a>

                    <a class="dropdown-item" href="#">
                        <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                        Activity Log
                    </a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                        <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                        Logout
                    </a>
                </div>
            </li>

        </ul>

    </nav>
    <%-- End of Topbar --%>
</html>
<% if (conn != null) {
        conn.close();
    }} %>