<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 引用SweetAlert2 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/11.1.4/sweetalert2.all.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/11.1.4/sweetalert2.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.0.0/sweetalert2.all.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />

<%
	request.setCharacterEncoding("UTF-8");
	HttpSession httpSession = request.getSession(true);

	Double sumHours = (Double)httpSession.getAttribute("sumHours");
	
	Double remainingHours =(Double)httpSession.getAttribute("remainingHours");
%>


    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <div class="sidebar-brand-icon">
            </div>
          

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Pages Collapse Menu -->
           
        </ul>
        <!-- End of Sidebar -->



        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            <!-- Main Content -->
            <div id="content">
                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>
                    <!-- Topbar Search -->                    
                        <div class="narbar-brand">
                            <h1 class="font-weight-bold mb-3">Song API</h1>
                        </div>  

                        <!-- 0419 alert to do -->

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">                   
                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="###" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">${sessionScope.loginModel.name}</span>
                                <img class="img-profile rounded-circle" src="img/undraw_profile.svg">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                </a>
                            </div>
                        </li>
                    </ul>
                </nav>
                <!-- End of Topbar -->                
<script>
	let recruitD = new Date("${sessionScope.loginModel.employedDate}");
	var todayD = new Date().toISOString().slice(0,10);
	let annivD = new Date("${sessionScope.loginModel.employedDate}");
	annivD.setFullYear(new Date().getFullYear());

	var diff = Math.ceil(Math.round((annivD.setTime(annivD.getTime())-recruitD.setTime(recruitD.getTime()))/1000/60/60/24/365));
	annivLDay = diff*7;
	$("#annivLDay").text(annivLDay);
	if(new Date > annivD){

		annivD.setFullYear(annivD.getFullYear()+1);
	} else{

	}
	var due = annivD.toISOString().slice(0,10);
	$("#anniDate").text(due);
	$("#annivCD").click(function(){
		let sD = new Date(todayD);
		let eD = new Date(due);
		let dD = Math.ceil(Math.round((eD.getTime()-sD.getTime())/1000/60/60/24));
		Swal.fire({
			  title: '再'+dD+'天!',
			  html: '就是第'+diff+'個里程碑了! 想想年假怎麼安排好~~',
			  imageUrl: '<c:url value="/img/work-anniversary.png" />',
			  imageWidth: 400,
			  imageHeight: 300,
			  imageAlt: 'Custom image',
			  confirmButtonText:
				    '<i class="fa fa-thumbs-up"></i> 超棒的!'
			})
	});
</script>