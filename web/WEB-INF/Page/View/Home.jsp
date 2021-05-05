<%-- 
    Document   : Home
    Created on : Feb 12, 2020, 10:33:58 AM
    Author     : aris
--%>

<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Locale"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import ="Conection.MyConection" %>
<%
    Object use = session.getAttribute("username");
    Object Cread = session.getAttribute("Cred");
    Object nm = session.getAttribute("alias");
    Object lvl = session.getAttribute("level");
    if (use == null || use.toString().trim().equals("") || lvl == null || lvl.toString().trim().equals("") || !lvl.toString().equals("Employee") && !lvl.toString().equals("Pns") && !lvl.toString().equals("Admin")) {
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
        <%@include file = "../Header/Header.jsp" %>
    </head>
    <body id="page-top">
        <!-- Page Wrapper -->
        <div id="wrapper">
            <!-- Sidebar -->
            <%@include file = "../Sidebar/Sidebar.jsp" %>
            <!-- End of Sidebar -->
            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">
                <!-- Main Content -->
                <div id="content">
                    <!-- Topbar -->
                    <!-- Topbar Navbar -->
                    <%@include  file = "../Navbar/Navbar.jsp" %>
                    <!-- End of Topbar -->

                    <!-- Begin Page Content -->
                    <div class="container-fluid">

                        <!-- Content Row -->
                        <%
                            MyConection cfc1 = new MyConection();
                            Connection conn1 = cfc1.getKoneksi();
                            Statement com1 = conn1.createStatement();
                            String company = "SELECT * FROM employee.biodata where nik = '" + use + "'";
                            ResultSet comp = com1.executeQuery(company);
                            String c = "";
                            String d = "";
                            while (comp.next()) {
                                c = comp.getString("nama");
                                d = comp.getString("nik");
                            }
                        %>
                        <div class="row">
                            <div class="col-lg-12 mb-3">
                                <!-- Illustrations -->
                                <!--<div class="card shadow mb-4">-->
                                <!--<div class="card-header py-3">-->
                                <div class="alert alert-primary" role="alert">
                                    <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>
                                    <h1 class="h3 mb-0 text-gray-800">Selamat Datang</h1>
                                    Sahabat <b><% out.print(nm);%> </b> disistem informasi E- Kinerja
                                </div>
                                <!--                                        <span class="float-left"> 
                                                                             <a href="#" data-toggle="modal" data-target="#addEdu" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-plus fa-sm text-white-50"></i> Pendidikan</a> 
                                                                            <h1 class="h3 mb-0 text-gray-800">Selamat Datang</h1>
                                                                        </span>-->
                                <!--</div>-->
                                <!--                                    <div class="card-body">
                                                                        Haloo Sahabat <b><% //out.print(c);%> </b> disistem informasi E- Kinerja
                                                                    </div>-->
                                <!--</div>-->
                                <!-- Content Column -->
                                <div class="col-lg-12 mb-4">

                                    <!-- Project Card Example -->
                                    <div class="row">
                                        <%
                                            Statement co1 = conn1.createStatement();
                                            Statement co2 = conn1.createStatement();
                                            Statement co3 = conn1.createStatement();
                                            Statement co4 = conn1.createStatement();
                                            Statement co5 = conn1.createStatement();
                                            Statement co6 = conn1.createStatement();
                                            String jum = "SELECT count(*) as ds FROM employee.aktivitas where approve ='Disetujui' and nik_employee = '" + d + "' ";
                                            String jumdt = "SELECT count(*) as dt FROM employee.aktivitas where approve ='Ditolak' and nik_employee = '" + d + "' ";
                                            String jumbd = "SELECT count(*) as bd FROM employee.aktivitas where approve ='Belum Disetujui' and nik_employee = '" + d + "' ";
                                            System.out.println("bd " + jumbd);
                                            String jumpn = "SELECT count(*) as dspn FROM employee.aktivitas where approve ='Disetujui' and nip = '" + d + "' ";
                                            String jumdtpn = "SELECT count(*) as dtpn FROM employee.aktivitas where approve ='Ditolak' and nip = '" + d + "' ";
                                            String jumbdpn = "SELECT count(*) as bdpn FROM employee.aktivitas where approve ='Belum Disetujui' and nip = '" + d + "' ";
                                            System.out.println("bd " + jumbd);
                                            ResultSet jmds = co1.executeQuery(jum);
                                            ResultSet jmdt = co2.executeQuery(jumdt);
                                            ResultSet jmbd = co3.executeQuery(jumbd);
                                            ResultSet jmdspn = co4.executeQuery(jumpn);
                                            ResultSet jmdtpn = co5.executeQuery(jumdtpn);
                                            ResultSet jmbdpn = co6.executeQuery(jumbdpn);
                                            System.out.println("ds" + jum);
                                            String ds = "";
                                            String dt = "";
                                            String bd = "";
                                            String dspn = "";
                                            String dtpn = "";
                                            String bdpn = "";
                                            while (jmds.next()) {
                                                ds = jmds.getString("ds");
                                            }
                                            while (jmdt.next()) {
                                                dt = jmdt.getString("dt");
                                            }
                                            while (jmbd.next()) {
                                                bd = jmbd.getString("bd");
                                            }
                                            while (jmdspn.next()) {
                                                dspn = jmdspn.getString("dspn");
                                            }
                                            while (jmdtpn.next()) {
                                                dtpn = jmdtpn.getString("dtpn");
                                            }
                                            while (jmbdpn.next()) {
                                                bdpn = jmbdpn.getString("bdpn");
                                            }
                                        %>
                                        <!-- Earnings (Monthly) Card Example -->
                                        <div class="col-xl-4 col-md-6 mb-4">
                                            <div class="card border-left-info shadow h-100 py-2">
                                                <div class="card-body">
                                                    <div class="row no-gutters align-items-center">
                                                        <div class="col mr-2">
                                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Belum Disetujui</div>
                                                            <div class="row no-gutters align-items-center">
                                                                <div class="col-auto">
                                                                    <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800"><% if (!Cread.toString().equals("P")) {
                                                                            out.println(bd);
                                                                        } else { %>
                                                                        <a href="verification"> <%out.println(bdpn);%></a>
                                                                        <%} %>
                                                                    </div>
                                                                </div>
                                                                <div class="col">
                                                                    <div class="progress progress-sm mr-2">
                                                                        <%
                                                                            Integer dur = 0;
                                                                            Integer dur1 = 0;
                                                                            Integer dur2 = 0;
                                                                            int time = 8;
                                                                            int second = 60;
                                                                            String dur22 = null;

                                                                            Statement con1 = conn1.createStatement();
                                                                            Statement con2 = conn1.createStatement();
                                                                            Statement con3 = conn1.createStatement();
                                                                            String approved = "select sum(durasi) as tot_app from employee.aktivitas where nik_employee = '" + use + "' and "
                                                                                    + "approve = 'Disetujui'";
                                                                            String notapproved = "select sum(durasi) as tot_app from employee.aktivitas where nik_employee = '" + use + "' and "
                                                                                    + "approve = 'Belum Disetujui'";
                                                                            String notapproved2 = "select sum(durasi) as tot_app from employee.aktivitas where nik_employee = '" + use + "' and "
                                                                                    + "approve = 'Ditolak'";
                                                                            ResultSet approved1 = con1.executeQuery(approved);
                                                                            ResultSet notapproved1 = con2.executeQuery(notapproved);
                                                                            ResultSet not = con3.executeQuery(notapproved2);
                                                                            while (approved1.next()) {
                                                                                dur22 = approved1.getString("tot_app");
                                                                                try {
                                                                                    if (dur22 != null) {
                                                                                        dur = Integer.parseInt(approved1.getString("tot_app"));
                                                                                    }
                                                                                } catch (NumberFormatException nfe) {
                                                                                    nfe.printStackTrace();
                                                                                }
                                                                            }
                                                                            while (notapproved1.next()) {
                                                                                dur22 = notapproved1.getString("tot_app");
                                                                                try {
                                                                                    if (dur22 != null) {
                                                                                        dur1 = Integer.parseInt(notapproved1.getString("tot_app"));
                                                                                    }
                                                                                } catch (NumberFormatException nfe) {
                                                                                    nfe.printStackTrace();
                                                                                }
                                                                            }
                                                                            while (not.next()) {
                                                                                dur22 = not.getString("tot_app");
                                                                                try {
                                                                                    if (dur22 != null) {
                                                                                        dur2 = Integer.parseInt(not.getString("tot_app"));
                                                                                    }
                                                                                } catch (NumberFormatException nfe) {
                                                                                    nfe.printStackTrace();
                                                                                }
                                                                            }
                                                                            LocalDate today = LocalDate.now();
                                                                            int month = today.getMonthValue();
                                                                            double capaian;
                                                                            switch (month) {
                                                                                case 1:
                                                                                    int efective = 22;
                                                                                    double jan = time * second * efective;
                                                                                    capaian = (dur1 / jan) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                case 2:
                                                                                    efective = 20;
                                                                                    double feb = time * second * efective;
                                                                                    capaian = (dur1 / feb) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                case 3:
                                                                                    efective = 21;
                                                                                    double mar = time * second * efective;
                                                                                    capaian = (dur1 / mar) * 100; %>
                                                                        <div class="progress-bar bg-info" role="progressbar" style="width: <% out.println(String.format(Locale.US, "%.2f", capaian) + "%");%>" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                                                                        <%

                                                                                System.out.println(" Capaian " + capaian);
                                                                                break;
                                                                            case 4:
                                                                                efective = 22;
                                                                                double apr = time * second * efective;
                                                                                capaian = (dur1 / apr) * 100;
//                                                                                        out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                        %>
                                                                        <div class="progress-bar bg-info" role="progressbar" style="width: <% out.println(String.format(Locale.US, "%.2f", capaian) + "%");%>" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                                                                        <%
                                                                                break;
                                                                            case 5:
                                                                                efective = 12;
                                                                                double mei = time * second * efective;
                                                                                capaian = (dur1 / mei) * 100;
                                                                                out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                break;
                                                                            case 6:
                                                                                efective = 21;
                                                                                double juni = time * second * efective;
                                                                                capaian = (dur1 / juni) * 100;
                                                                        %>
                                                                        <div class="progress-bar bg-info" role="progressbar" style="width: <% out.println(String.format(Locale.US, "%.2f", capaian) + " %");%>" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                                                                        <%
                                                                                    break;
                                                                                case 7:
                                                                                    efective = 22;
                                                                                    double juli = time * second * efective;
                                                                                    capaian = (dur1 / juli) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                case 8:
                                                                                    efective = 18;
                                                                                    double ags = time * second * efective;
                                                                                    capaian = (dur1 / ags) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                case 9:
                                                                                    efective = 22;
                                                                                    double sept = time * second * efective;
                                                                                    capaian = (dur1 / sept) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                case 10:
                                                                                    efective = 20;
                                                                                    double okt = time * second * efective;
                                                                                    capaian = (dur1 / okt) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                case 11:
                                                                                    efective = 21;
                                                                                    double nov = time * second * efective;
                                                                                    capaian = (dur1 / nov) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                default:
                                                                                    efective = 21;
                                                                                    double des = time * second * efective;
                                                                                    capaian = (dur1 / des) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                            }
                                                                        %>
                                                                        <!--                                                                        <div class="progress-bar bg-info" role="progressbar" style="width: 20%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>-->
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-auto">
                                                            <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Earnings (Monthly) Card Example -->
                                        <div class="col-xl-4 col-md-6 mb-4">
                                            <div class="card border-left-info shadow h-100 py-2">
                                                <div class="card-body">
                                                    <div class="row no-gutters align-items-center">
                                                        <div class="col mr-2">
                                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Disetujui</div>
                                                            <div class="row no-gutters align-items-center">
                                                                <div class="col-auto">
                                                                    <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">
                                                                        <% if (!Cread.toString().equals("P")) {
                                                                                out.println(ds);
                                                                            } else {
                                                                                out.println(dspn);
                                                                            } %>
                                                                    </div>
                                                                </div>
                                                                <div class="col">
                                                                    <div class="progress progress-sm mr-2">
                                                                        <%
                                                                            switch (month) {
                                                                                case 1:
                                                                                    int efective = 22;
                                                                                    double jan = time * second * efective;
                                                                                    capaian = (dur / jan) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                case 2:
                                                                                    efective = 20;
                                                                                    double feb = time * second * efective;
                                                                                    capaian = (dur / feb) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                case 3:
                                                                                    efective = 21;
                                                                                    double mar = time * second * efective;
                                                                                    capaian = (dur / mar) * 100; %>
                                                                        <div class="progress-bar bg-info" role="progressbar" style="width: <% out.println(String.format(Locale.US, "%.2f", capaian) + "%");%>" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                                                                        <%

                                                                                System.out.println(" Capaian " + capaian);
                                                                                break;
                                                                            case 4:
                                                                                efective = 22;
                                                                                double apr = time * second * efective;
                                                                                capaian = (dur / apr) * 100;
//                                                                                        out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                        %>
                                                                        <div class="progress-bar bg-info" role="progressbar" style="width: <% out.println(String.format(Locale.US, "%.2f", capaian) + "%");%>" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                                                                        <%
                                                                                break;
                                                                            case 5:
                                                                                efective = 12;
                                                                                double mei = time * second * efective;
                                                                                capaian = (dur / mei) * 100;
                                                                                out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                break;
                                                                            case 6:
                                                                                efective = 21;
                                                                                double juni = time * second * efective;
                                                                                capaian = (dur / juni) * 100;
                                                                        %>
                                                                        <div class="progress-bar bg-info" role="progressbar" style="width: <% out.println(String.format(Locale.US, "%.2f", capaian) + " %");%>" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                                                                        <%
                                                                                    break;
                                                                                case 7:
                                                                                    efective = 22;
                                                                                    double juli = time * second * efective;
                                                                                    capaian = (dur / juli) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                case 8:
                                                                                    efective = 18;
                                                                                    double ags = time * second * efective;
                                                                                    capaian = (dur / ags) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                case 9:
                                                                                    efective = 22;
                                                                                    double sept = time * second * efective;
                                                                                    capaian = (dur / sept) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                case 10:
                                                                                    efective = 20;
                                                                                    double okt = time * second * efective;
                                                                                    capaian = (dur / okt) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                case 11:
                                                                                    efective = 21;
                                                                                    double nov = time * second * efective;
                                                                                    capaian = (dur / nov) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                default:
                                                                                    efective = 21;
                                                                                    double des = time * second * efective;
                                                                                    capaian = (dur / des) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                            }
                                                                        %>
                                                                        <!--<div class="progress-bar bg-info" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>-->
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="col-auto">
                                                            <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <% if (!Cread.toString().equals("P")) { %>
                                        <!-- Earnings (Monthly) Card Example -->
                                        <div class="col-xl-4 col-md-6 mb-4">
                                            <div class="card border-left-info shadow h-100 py-2">
                                                <div class="card-body">
                                                    <div class="row no-gutters align-items-center">
                                                        <div class="col mr-2">
                                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Ditolak</div>
                                                            <div class="row no-gutters align-items-center">
                                                                <div class="col-auto">
                                                                    <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">
                                                                        <% out.println(dt); %>
                                                                    </div>
                                                                </div>
                                                                <div class="col">
                                                                    <div class="progress progress-sm mr-2">
                                                                        <!--<div class="progress-bar bg-info" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>-->
                                                                        <%
                                                                            switch (month) {
                                                                                case 1:
                                                                                    int efective = 22;
                                                                                    double jan = time * second * efective;
                                                                                    capaian = (dur2 / jan) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                case 2:
                                                                                    efective = 20;
                                                                                    double feb = time * second * efective;
                                                                                    capaian = (dur2 / feb) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                case 3:
                                                                                    efective = 21;
                                                                                    double mar = time * second * efective;
                                                                                    capaian = (dur2 / mar) * 100; %>
                                                                        <div class="progress-bar bg-info" role="progressbar" style="width: <% out.println(String.format(Locale.US, "%.2f", capaian) + "%");%>" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                                                                        <%

                                                                                    System.out.println(" Capaian " + capaian);
                                                                                    break;
                                                                                case 4:
                                                                                    efective = 22;
                                                                                    double apr = time * second * efective;
                                                                                    capaian = (dur2 / apr) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                case 5:
                                                                                    efective = 12;
                                                                                    double mei = time * second * efective;
                                                                                    capaian = (dur2 / mei) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                case 6:
                                                                                    efective = 21;
                                                                                    double juni = time * second * efective;
                                                                                    capaian = (dur2 / juni) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                case 7:
                                                                                    efective = 22;
                                                                                    double juli = time * second * efective;
                                                                                    capaian = (dur2 / juli) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                case 8:
                                                                                    efective = 18;
                                                                                    double ags = time * second * efective;
                                                                                    capaian = (dur2 / ags) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                case 9:
                                                                                    efective = 22;
                                                                                    double sept = time * second * efective;
                                                                                    capaian = (dur2 / sept) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                case 10:
                                                                                    efective = 20;
                                                                                    double okt = time * second * efective;
                                                                                    capaian = (dur2 / okt) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                case 11:
                                                                                    efective = 21;
                                                                                    double nov = time * second * efective;
                                                                                    capaian = (dur2 / nov) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                                    break;
                                                                                default:
                                                                                    efective = 21;
                                                                                    double des = time * second * efective;
                                                                                    capaian = (dur2 / des) * 100;
                                                                                    out.println(String.format(Locale.US, "%.2f", capaian) + " %");
                                                                            }
                                                                        %>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-auto">
                                                            <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <% } else { %>
                                        <div class="col-xl-4 col-md-6 mb-4">
                                            <div class="card border-left-info shadow h-100 py-2">
                                                <div class="card-body">
                                                    <div class="row no-gutters align-items-center">
                                                        <div class="col mr-2">
                                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Menolak</div>
                                                            <div class="row no-gutters align-items-center">
                                                                <div class="col-auto">
                                                                    <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800"><% out.println(dtpn); %></div>
                                                                </div>
                                                                <div class="col">
                                                                    <div class="progress progress-sm mr-2">
                                                                        <div class="progress-bar bg-info" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-auto">
                                                            <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <% } %>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- End Content Row -->
                    </div>
                    <!-- /.container-fluid -->

                </div>
                <!-- End of Main Content -->
                <%@include file = "../Footer/Footer.jsp" %>
            </div>
    </body>
</html>
<% if (conn1 != null) {
        conn1.close();
    }}%>