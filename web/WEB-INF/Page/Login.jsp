<%-- 
    Document   : login
    Created on : Feb 12, 2020, 8:36:12 AM
    Author     : aris
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        
    </head>
    <%@include file="Header/Header.jsp" %>
 <body class="bg-gradient-primary">

  <div class="container">

    <!-- Outer Row -->
    <div class="row justify-content-center">

      <div class="col-xl-10 col-lg-12 col-md-9">

        <div class="card o-hidden border-0 shadow-lg my-5">
          <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
              <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
              <div class="col-lg-6">
                <div class="p-5">
                  <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">E-Kin!</h1>
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
                  <form class="user" action="loginverification" method="post">
                    <div class="form-group">
                      <!-- <input type="email" class="form-control form-control-user" id="exampleInputEmail" aria-describedby="emailHelp" placeholder="Enter Email Address..."> -->
                      <input type="text" name= "username" class="form-control form-control-user" id="exampleInputEmail" aria-describedby="emailHelp" placeholder="Enter NIK Anda...">
                    </div>
                    <div class="form-group">
                      <input type="password" name= "password" class="form-control form-control-user" id="exampleInputPassword" placeholder="Password">
                    </div>
                    <div class="form-group">
                      <div class="custom-control custom-checkbox small">
                        <input type="checkbox" class="custom-control-input" id="customCheck">
                      </div>
                    </div>
                    <button type="submit" class="btn btn-primary col-md-offset-5 btn-user btn-block" id="btn-submit"> LOGIN </button>
                  </form>
                  <hr>
                  <div class="text-center">
                    <a class="small" href="forgot-password.html">Forgot Password?</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>

    </div>

  </div>
    </body>
    <%@include file="Footer/Footer_1.jsp" %>
</html>