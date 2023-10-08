<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Song API</title>

    <!-- Custom fonts for this template-->
    
    <link href="<c:url value='vendor/fontawesome-free/css/all.min.css' />" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    
    <link href="<c:url value='css/sb-admin-2.min.css' />" rel="stylesheet">
    <link rel="icon" href="<c:url value='img/favicon.png' />">
    <link rel="stylesheet" href="<c:url value='css/mycss.css' />">
    
    <script src="js/jquery-3.6.0.min.js"></script>
    <!-- .js請從此後寫 -->
    
	<script>
	
	let addId = 0;
	
	let segment="";
	
	window.onload = function(){
			
		$("#loadAllFavorite").click(function () {
			console.log("In loadAllFavorite function");			
			
			let xhr = new XMLHttpRequest();
			xhr.open("GET", "<c:url value='/loadAllFavorite' />", true);
			xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			xhr.send();
			console.log("send data");
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					
					let tableInfo = JSON.parse(xhr.responseText);					
					
					for(const key in tableInfo){
						let id = "#" + key;
						segment += "<tr id='" + tableInfo[key].id + "'><td class='search_name'>" + tableInfo[key].name + "</td><td class='search_artist'>" + tableInfo[key].artist + "</td><td><button onclick='remove(" + tableInfo[key].id + ")'>remove</button></td><td class='search_url'>" + tableInfo[key].url + "</td></tr>";				
					}
					$("#table1").html(segment);
				}
			}
			segment="";
		});
		
		$("#search").click(function () {
			console.log("In search function");
			let searchSong = $("#inputSongName").val();
			
			let xhr = new XMLHttpRequest();
			xhr.open("POST", "<c:url value='/searchBySongName' />", true);
			xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			
			const search = encodeURI(searchSong);
			
			console.log(search);
			xhr.send("searchSong=" + search);
			console.log("send data");
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					
					let tableInfo = JSON.parse(xhr.responseText);					
					
					for(const key in tableInfo){
						let id = "#" + key;
						segment += "<tr id='" + addId + "'><td class='add_name'>" + tableInfo[key].name + "</td><td class='add_artist'>" + tableInfo[key].artist + "</td><td><button onclick='add(" + addId + ")'>add</button></td><td class='add_url'>" + tableInfo[key].url + "</td></tr>";
						addId --;
					}
					$("#table0").html(segment);
				}
			}
			segment="";
		});
	}	
	
	function add(input){
		console.log("add method triggered " + input);
		let add = document.getElementById(input);
		let name;
		let artist;
		let url;
		
		let items = add.children;
		
		for(let i = 0; i < add.childElementCount; i++){
			const ele = items[i];
			
			console.log(ele.innerHTML);
			console.log(ele.className);
			if(ele.className === "add_name"){
				
				name = ele.innerHTML;
			}
			if(ele.className === "add_artist"){
						
				artist = ele.innerHTML;
			}
			if(ele.className === "add_url"){
				
				url = ele.innerHTML;
			}
		}

		let obj = {
				'name' : name,
				'artist' : artist,
				'url' : url
		}
		
		console.log(obj);
		
		let json = JSON.stringify(obj);
		let xhrInner = new XMLHttpRequest();
		xhrInner.open("POST", "<c:url value='/addFavorite'/>", true);
		xhrInner.setRequestHeader("Content-Type", "application/json;charset=UTF-8"); 		
		xhrInner.send(json);
		xhrInner.onreadystatechange = function() {
			if (xhrInner.readyState == 4 && xhrInner.status == 200) {	
				
				let tableInfo = JSON.parse(xhrInner.responseText);
				segment += "<tr id='" + tableInfo.id + "'><td class='search_name'>" + tableInfo.name + "</td><td class='search_artist'>" + tableInfo.artist + "</td><td><button onclick='remove(" + tableInfo.id + ")'>remove</button></td><td class='search_url'>" + tableInfo.url + "</td></tr>";				

				$("#table1").append(segment);
				add.remove()
			}
    	}
		segment="";
	}
	
	function remove(input){
		console.log("remove method triggered " + input);
		let remove = document.getElementById(input);
		let name;
		let artist;
		let url;
		
		let items = remove.children;
		console.log(remove.childElementCount);
		
		for(let i = 0; i < remove.childElementCount; i++){
			const ele = items[i];
			
			console.log(ele.innerHTML);
			console.log(ele.className);
			if(ele.className === "search_name"){
				
				name = ele.innerHTML;
			}
			if(ele.className === "search_artist"){
						
				artist = ele.innerHTML;
			}
			if(ele.className === "search_url"){
				
				url = ele.innerHTML;
			}
		}			
		
		let obj = {
				'name' : name,
				'artist' : artist,
				'url' : url,
				'id' : input
		}
		console.log(obj);
		let json = JSON.stringify(obj);
		let xhrInner = new XMLHttpRequest();
		xhrInner.open("DELETE", "<c:url value='/removeFavorite'/>", true);
		xhrInner.setRequestHeader("Content-Type", "application/json;charset=UTF-8"); 		
		xhrInner.send(json);
		xhrInner.onreadystatechange = function() {
			if (xhrInner.readyState == 4 && xhrInner.status == 200) {	
				let tableInfo = JSON.parse(xhrInner.responseText);			
				segment += "<tr id='" + addId + "'><td class='add_name'>" + tableInfo.name + "</td><td class='add_artist'>" + tableInfo.artist + "</td><td><button onclick='add(" + addId + ")'>add</button></td><td class='add_url'>" + tableInfo.url + "</td></tr>";		
				
				
				$("#table0").append(segment);
				addId--;
				remove.remove();
			}
    	}
		segment = "";
	}
	</script>
	<style>
		.button{
			opacity: 0.4;
			background-color: #7878FF;
		}
	</style>
</head>

<body id="page-top">

	<jsp:include page="header.jsp"></jsp:include>

	<div id="bgcolor" class="container-fluid">
		<div class="row">
			<div class="col-12">
				<div>
	            	<h4>Song search</h4>
	            	<input type="text" id="inputSongName" maxlength="60"/><button id='search'>search</button>
	            </div>
	            <div>
	            	<table class='table table-bordered table-hover table-hover-color dataTable no-footer'>
						<thead>
							<tr><th>Song name</th><th>Artist</th><th>function</th><th>URL</th></tr>
						</thead>
						<tbody id='table0'>
							
						</tbody>
					</table>
					
	            </div>        
	            <div>
	            	<h4>Favorite</h4>
	            	<button id='loadAllFavorite'>load</button>
	            	<table class='table table-bordered table-hover table-hover-color dataTable no-footer'>
						<thead>
							<tr><th>Song name</th><th>Artist</th><th>function</th><th>URL</th></tr>
						</thead>
						<tbody id='table1'>
							
						</tbody>
					</table>
	            </div>
			</div>

		</div>

	</div>
	<!-- /.container-fluid -->

	</div>
	<!-- End of Main Content -->


	<jsp:include page="footer.jsp"></jsp:include>


	<!-- Bootstrap core JavaScript-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="js/sb-admin-2.min.js"></script>


</body>

</html>