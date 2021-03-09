<%-- 
    Document   : Footer
    Created on : Feb 12, 2020, 10:59:20 AM
    Author     : aris
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../configurasi/connect.jsp" %>
<!DOCTYPE html>
<html>
    <!-- Footer -->
    <footer class="sticky-footer bg-white">
        <div class="container my-auto">
            <div class="copyright text-center my-auto">
                <span>Copyright &copy; My Activity Disnaker 2019</span>
            </div>
        </div>
    </footer>
    <!-- End of Footer -->
    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <!--<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>-->
                    <a class="btn btn-secondary" type="button" data-dismiss="modal" style="color: #fdfdfe">Cancel</a>
                    <a class="btn btn-primary" href="logout">Logout</a>
                </div>
            </div>
        </div>
    </div>
    <%
         
        String long_time = "select * from employee.long_time";
        ResultSet lt1 = st.executeQuery(long_time);
        String lt = "";
        while (lt1.next()) {
            lt = lt1.getString("long_time");
        }
    %>
    <!-- Bootstrap core JavaScript-->
    <script src="Include/assets/jquery/jquery.min.js"></script>
    <script src="Include/assets/js/jquery.min.js"></script>
    <script src="Include/assets/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="Include/assets/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="Include/assets/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins
    <script src="Include/assets/chart.js/Chart.min.js "></script> -->
    <script src="Include/assets/datatables/jquery.dataTables.min.js"></script>
    <script src="Include/assets/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="Include/assets/js/demo/datatables-demo.js"></script>
    <script src="Include/assets/js/demo/chart-area-demo.js"></script>
    <script src="Include/assets/js/demo/chart-pie-demo.js"></script>
    <!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/bootstrap-select.min.js"></script> -->
    <script src="Include/assets/bootstrap/js/bootstrap-select.min.js"></script>
    <script src="Include/assets/bootstrap/js/bootstrap-datepicker.min.js"></script>
    <script type="text/javascript">
        $("#peringatan-tanggal").hide();
        $("#peringatan-tanggal2").hide();
        $("#aktivitas").hide();
        $("#aris").hide();
        $("#aktivitas-warning").hide();
        $("#warning-aktivitas").hide();
        $('#cuti-group').hide();
        $("#cuti-info").hide();
        //const last = <%out.print(lt);%>;
        const last = 5;
        console.log(last);
        $(document).on('change keydown paste input', '#tanggal', function () {
            var today = new Date();
            console.log(today);
            var lst_today = new Date();
            lst_today.setDate(lst_today.getDate() - last);
            var date_input = new Date($(this).val());
            console.log(date_input);
//        var date_month_fix = date_input.getMonth();
//        var date_input_fix = date_input.getFullYear();
//        var month_before = today.getFullYear() - 1;
            if (date_input > today) {
                /*$("#btn-submit").hide();
                $("#peringatan-tanggal").show();
                $("#peringatan-tanggal2").hide();
                $("#cuti-group").hide();
                $("#cuti-info").hide();
                $("#aktivitas-warning").hide();
                $("#aris").hide();*/
             $("#btn-submit").show();
                $("#cuti-group").show();
                $("#aris").show();
                $("#peringatan-tanggal").hide();
                $("#peringatan-tanggal2").hide();
                $("#cuti-info").hide();
                $("#aktivitas-warning").hide();
            } else if (date_input < lst_today) {
                $("#btn-submit").hide();
                $("#peringatan-tanggal2").show();
                $("#peringatan-tanggal").hide();
                $("#cuti-group").hide();
                $("#cuti-info").hide();
                $("#aktivitas-warning").hide();
                $("#aris").hide();
            } else {
                $("#btn-submit").show();
                $("#cuti-group").show();
                $("#aris").show();
                $("#peringatan-tanggal").hide();
                $("#peringatan-tanggal2").hide();
                $("#cuti-info").hide();
                $("#aktivitas-warning").hide();
            }

            $('#aktivitas').hide()
        });
    </script>

    <script type="text/javascript">
//        $("#peringatan-tanggal").hide();
//        $("#aktivitas").hide();
//        $("#aris").hide();
//        $("#aktivitas-warning").hide();
//        $("#warning-aktivitas").hide();
//        $('#cuti-group').hide();
//        $("#cuti-info").hide();
//        $(document).on('change keydown paste input', '#tanggal', function() {
//
//        var today = new Date();
//        var date_input = new Date($(this).val());
//        var date_month_fix = date_input.getMonth();
//        var date_input_fix = date_input.getFullYear();
//        var month_before = today.getFullYear() - 1;
//        if (date_input > today) {
//        $("#btn-submit").hide();
//        $("#peringatan-tanggal").show();
//        $("#cuti-group").hide();
//        $("#cuti-info").hide();
//        $("#aktivitas-warning").hide();
//        $("#aris").hide();
//        }
//        else {
//        $("#btn-submit").show();
//        // $("#cuti-group").show();
//        $("#aris").show();
//        $("#peringatan-tanggal").hide();
//        $("#cuti-info").hide();
//        $("#aktivitas-warning").hide();
//        }
//
//        $('#aktivitas').hide()
//        });
    </script>
    <script type="text/javascript">

        $('.datepicker').datepicker({
            format: 'yyyy-mm-dd',
            todayHighlight: true,
            daysOfWeekHighlighted: [0, 6],
            datesDisabled: ['2018-01-01', '2018-02-16', '2018-03-30', '2018-04-14', '2018-05-01', '2018-05-10', '2018-05-29', '2018-06-01',
                '2018-06-11', '2018-06-11', '2018-06-12', '2018-06-13', '2018-06-14', '2018-06-15', '2018-06-16', '2018-06-17', '2018-06-18', '2018-06-19', '2018-06-20',
                '2018-06-27', '2018-08-17', '2018-08-22', '2018-09-11', '2018-11-20', '2018-12-24', '2018-12-25', '2019-01-01', '2019-02-05', '2019-03-07', '2019-04-03', '2019-04-19', '2019-05-01', '2019-05-19', '2019-06-01', '2019-06-03', '2019-06-03', '2019-06-04', '2019-06-05', '2019-06-06', '2019-06-07', '2019-08-11', '2019-08-17', '2019-11-09', '2019-12-24', '2019-12-25']
        });
        $('.datepicker-standard').datepicker({
            format: 'yyyy-mm-dd',
            todayHighlight: true,
            daysOfWeekHighlighted: [0, 6],
        });
        $('.datatable-basic').DataTable({
            searching: false,
        });
        $('.datatable-index').DataTable({
            searching: false,
            ordering: false
        });
        $(function () {

            // Default file input style

            $(".file-styled").uniform({
                fileButtonClass: 'action btn btn-default'
            });
            // Primary file input
            $(".file-styled-primary").uniform({
                fileButtonClass: 'action btn bg-blue'
            });
            $(".styled, input").uniform({
                radioClass: 'choice'
            });
        });
        // Image lightbox
        $('[data-popup="lightbox"]').fancybox({
            padding: 2
        });
        $('.select-search').select2();</script>
    <script type="text/javascript">
        $("form :input").attr("autocomplete", "off");</script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.tanggal').datepicker({
                format: "dd-mm-yyyy",
                autoclose: true
            });
        });
    </script>
</html>
