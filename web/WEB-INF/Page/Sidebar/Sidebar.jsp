<%-- 
    Document   : Sidebar
    Created on : Feb 12, 2020, 10:29:03 AM
    Author     : aris
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Conection.MyConection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%  
    Object uName = session.getAttribute("username");
    Object Cred = session.getAttribute("Cred");
    Object jb1 = session.getAttribute("jabatan");
    
//    String jb1 = "";
//    MyConection koneksi = new MyConection();
//    Connection koneksi1 = koneksi.getKoneksi();
//    Statement st1 = koneksi1.createStatement();
//    String query = "SELECT jabatan from employee.biodata where nik = '"+uName+"'";
//    ResultSet qw = st1.executeQuery(query);
//    
//    while (qw.next()){
//        jb1 = qw.getString("jabatan");
//    }
%>
<html>
    <%-- Sidebar --%>
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar" class = "navbar-nav bg-gradient-primary sidebar sidebar-dark accordion toggled">

        <%-- Sidebar - Brand --%>
        <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
            <div class="sidebar-brand-icon">
                <!--<i class="rotate-n-15 fas fa-laugh-wink"></i>-->
                <img class="img-profile" width="50" height="57" src="Include/assets/images/logo-kota-surabaya.ico"/>
            </div>
            <!--Disnaker Kota Surabaya-->
            <div class="sidebar-brand-text mx-2" style="font-size:13px;">Disnaker <br>Kota Surabaya<sup></sup></div> 
        </a>

        <%-- Divider --%>
        <hr class="sidebar-divider my-0">

        <%-- Nav Item - Dashboard --%>
        <li class="nav-item active">
            <a class="nav-link" href="home">
                <i class="fas fa-fw fa-tachometer-alt"></i>
                <span>Dashboard</span></a>
        </li>
        <%-- Heading --%>
       
        <% if (Cred == null || Cred.toString().trim().equals("") || !Cred.toString().equals("E") && !Cred.toString().equals("P")) { %>
        <hr class="sidebar-divider">
        <div class="sidebar-heading">
            Master
        </div>
        <%-- Nav Item - Tables --%>
        <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUser" aria-expanded="true" aria-controls="collapseUser">
          <i class="fas fa-fw fa-wrench"></i>
          <span>User</span>
        </a>
        <div id="collapseUser" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Manage User:</h6>
            <a class="collapse-item" href="user">Data User</a>
            <a class="collapse-item" href="adduser">Tambah User</a>
<!--            <a class="collapse-item" href="utilities-animation.html">Animations</a>
            <a class="collapse-item" href="utilities-other.html">Other</a>-->
          </div>
        </div>
      </li>
        <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseGroup" aria-expanded="true" aria-controls="collapseGroup">
          <i class="fas fa-fw fa-wrench"></i>
          <span>Group</span>
        </a>
        <div id="collapseGroup" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Manage Group:</h6>
            <a class="collapse-item" href="group">Data Group</a>
            <a class="collapse-item" href=""></a>
            <a class="collapse-item" href="utilities-animation.html">Animations</a>
            <a class="collapse-item" href="utilities-other.html">Other</a>
          </div>
        </div>
      </li>
<!--        <li class="nav-item">
            <a class="nav-link" href="user">
                <i class="fas fa-fw fa-user"></i>
                <span>User</span></a>
            <a class="nav-link" href="groupforuser">
                <i class="fas fa-fw fa-user"></i>
                <span>Group User</span></a>
        </li>-->
        <li class="nav-item">
            <a class="nav-link" href="education">
                <i class="fas fa-fw fa-user"></i>
                <span>Pendidikan</span></a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="<?php echo base_url('index.php/bidang') ?>">
                <i class="fas fa-fw fa-user"></i>
                <span>Bidang</span></a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="<?php echo base_url('index.php/jabatan') ?>">
                <i class="fas fa-fw fa-user"></i>
                <span>Jabatan</span></a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="<?php echo base_url('index.php/tupoksi') ?>">
                <i class="fas fa-fw fa-user"></i>
                <span>Tupoksi</span></a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="<?php echo base_url('index.php/tugas') ?>">
                <i class="fas fa-fw fa-user"></i>
                <span>Kegiatan</span></a>
        </li>
        <%-- Divider --%>
        <% } else if (Cred == null || Cred.toString().trim().equals("") || !Cred.toString().equals("P")){ %>
        <%-- Heading --%>
        <hr class="sidebar-divider">
        <div class="sidebar-heading">
            Private person
        </div>
        <%-- Nav Item - Tables --%>
        <li class="nav-item">
            <a class="nav-link" href="profile">
                <i class="fas fa-fw fa-user"></i>
                <span>Biodata</span></a>
        </li>
        <%-- Divider --%>
        <hr class="sidebar-divider">
        <%-- Heading --%>
        <div class="sidebar-heading">
            Activity
        </div>
        <li class="nav-item">
            <a class="nav-link" href="kegiatan">
                <i class="fas fa-fw fa-book"></i>
                <span>My Activity</span></a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="report">
                <i class="fas fa-fw fa-book"></i>
                <span>Laporan</span></a>
        </li>
       <% } else if(Cred == null || Cred.toString().trim().equals("") || !Cred.toString().equals("E")) {%>
        <div class="sidebar-heading">
            Activity
        </div>
        <li class="nav-item">
            <a class="nav-link" href="verification">
                <i class="fas fa-fw fa-book"></i>
                <span>My Activity</span></a>
        </li>
        <% } 
//        if(Cred == null || Cred.toString().trim().equals("") || !Cred.toString().equals("E") && jb1.toString().equals("16") && uName.toString().equals("198501152009022006")) {
        if(Cred == null || Cred.toString().trim().equals("") || !Cred.toString().equals("E") && jb1.toString().equals("16") ||jb1.toString().equals("10")||jb1.toString().equals("11")) {
        %>
        

<li class="nav-item">
            <a class="nav-link" href="reportcapaiandetails">
                <i class="fas fa-fw fa-book"></i>
                <span>Laporan Pegawai</span></a>
        </li>
        <% } %>
        <%-- Divider --%>
        <hr class="sidebar-divider d-none d-md-block">
        <%-- Sidebar Toggler (Sidebar) --%>
        <div class="text-center d-none d-md-inline">
            <button class="rounded-circle border-0" id="sidebarToggle"></button>
        </div>
    </ul>
    <%-- End of Sidebar --%>
</html>