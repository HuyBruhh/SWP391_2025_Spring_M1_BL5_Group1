<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html> 
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="images/favicon.png">
        <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css'>
        <title>Add Room</title>
        <link href='https://api.mapbox.com/mapbox-gl-js/v2.6.1/mapbox-gl.css' rel='stylesheet' />
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">


        <script src='https://api.mapbox.com/mapbox-gl-js/v2.7.0/mapbox-gl.js'></script>
        <link href='https://api.mapbox.com/mapbox-gl-js/v2.7.0/mapbox-gl.css' rel='stylesheet' />

        <link rel="stylesheet" href="fonts/icomoon/style.css">
        <link rel="stylesheet" href="fonts/flaticon/font/flaticon.css">

        <link rel="stylesheet" href="css/tiny-slider.css">
        <link rel="stylesheet" href="css/aos.css">
        <link rel="stylesheet" href="css/style.css">

        <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css'>

        <style>
            #map {
                height: 400px;
                width: 100%;
            }
            body{
                background: #f7f7ff;
                margin-top:20px;
            }
            .card {
                position: relative;
                display: flex;
                flex-direction: column;
                min-width: 0;
                word-wrap: break-word;
                background-color: #fff;
                background-clip: border-box;
                border: 0 solid transparent;
                border-radius: .25rem;
                margin-bottom: 1.5rem;
                box-shadow: 0 2px 6px 0 rgb(218 218 253 / 65%), 0 2px 6px 0 rgb(206 206 238 / 54%);
            }
            .me-2 {
                margin-right: .5rem!important;
            }


            .file-input-wrapper {
                position: relative;
                overflow: hidden;
                display: inline-block;
                margin-top: 10px;
            }
            .file-input-wrapper input[type="file"] {
                position: absolute;
                top: 0;
                right: 0;
                margin: 0;
                padding: 0;
                font-size: 20px;
                cursor: pointer;
                opacity: 0;
                filter: alpha(opacity=0);
            }
            .file-input-wrapper button {
                background-color: #007bff;
                border: none;
                color: white;
                padding: 10px 20px;
                font-size: 16px;
                cursor: pointer;
                border-radius: 4px;
                font-weight: normal;
            }
            .file-input-wrapper button:hover {
                background-color: #0056b3;
            }
            .file-input-info {
                font-size: 14px;
                color: #6c757d;
                margin-top: 5px;
            }
            .error-message {
                color: red;
                margin-top: 5px;
                display: none;
            }

            .switch {
                position: relative;
                display: inline-block;
                width: 60px;
                height: 34px;
            }

            .switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }

            .slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                transition: .4s;
                border-radius: 34px;
            }

            .slider:before {
                position: absolute;
                content: "";
                height: 26px;
                width: 26px;
                left: 4px;
                bottom: 4px;
                background-color: white;
                transition: .4s;
                border-radius: 50%;
            }

            input:checked + .slider {
                background-color: #4CAF50;
            }

            input:checked + .slider:before {
                transform: translateX(26px);
            }

            .button-group {
                text-align: center;
                margin-top: 20px;
            }

            .under-repair-form {
                margin: 20px auto;
                padding: 15px;
                border: 1px solid #ddd;
                border-radius: 5px;
                background-color: #f9f9f9;
                width: 400px;
            }

            .under-repair-form select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
                box-sizing: border-box;
            }

            .under-repair-form input[type="submit"] {
                margin-top: 20px;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                background-color: #007bff;
                color: #fff;
                font-size: 16px;
                cursor: pointer;
                display: block;
                width: 100%;
            }

            .under-repair-form input[type="submit"]:hover {
                background-color: #0056b3;
            }

            .under-repair-form .form-group {
                margin-bottom: 15px;
            }

            .under-repair-form .form-group label {
                font-weight: bold;
                margin-bottom: 5px;
                display: block;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="main-body">
                <div>
                    <nav class="site-nav" style="width: 73%">
                        <div class="container" >
                            <div class="menu-bg-wrap">
                                <div class="site-navigation">
                                    <a href="OwnerController?service=OwnerHome" 
                                       class="logo m-0 float-start" 
                                       style="text-decoration: none;"
                                       >Owner</a>
                                    <jsp:include page="navbar.jsp"></jsp:include>
                                        <a href="#" class="burger light me-auto float-end mt-1 site-menu-toggle js-menu-toggle d-inline-block d-lg-none" data-toggle="collapse" data-target="#main-navbar">
                                            <span></span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </nav>
                    </div>
                    <div class="row" style="margin-top: 120px;">                        
                        <div class="col-lg-8 mx-auto">                       
                            <div class="card">
                                <p style="
                                   margin: 0px;
                                   text-align: center;
                                   color: red;
                                   margin: 10px 0px;
                                   background: beige"
                                   >${error}</p>

                            <form 
                                id="addRoomForm"
                                action="OwnerController" 
                                method="post" 
                                enctype="multipart/form-data">
                                <div class="card-body">                                    
                                    <div class="row mb-3">
                                        <div class="col-sm-3">
                                            <h6 class="mb-0">Room Number</h6>
                                        </div>
                                        <div class="col-sm-9 text-secondary">
                                            <input type="text" class="form-control" name="roomNumber" value="" required>
                                            <span class="text-danger" id="roomNumberError"></span>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3">
                                            <h6 class="mb-0">Room Floor</h6>
                                        </div>
                                        <div class="col-sm-9 text-secondary">
                                            <input type="text" class="form-control" name="roomFloor" value="" required>
                                            <span class="text-danger" id="roomFloorError"></span>
                                        </div>
                                    </div> 
                                    <div class="row mb-3">
                                        <div class="col-sm-3">
                                            <h6 class="mb-0">Room Fee (VND)</h6>
                                        </div>
                                        <div class="col-sm-9 text-secondary">
                                            <input type="text" class="form-control" name="roomFee" value="" required>
                                            <span class="text-danger" id="roomFeeError"></span>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3">
                                            <h6 class="mb-0">Room Size</h6>
                                        </div>
                                        <div class="col-sm-9 text-secondary">
                                            <input type="text" class="form-control" name="roomSize" value="" required>
                                            <span class="text-danger" id="roomSizeError"></span>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3">
                                            <h6 class="mb-0">Room Image</h6>
                                        </div>
                                        <div class="col-sm-9 text-secondary">                                           
                                            <input type="file" class="form-control" name="roomImg" id="roomImgInput" required>
                                            <span class="text-danger" id="roomImgError"></span>
                                            <img id="roomImgPreview" style="max-width: 100%; margin-top: 10px; display: none;" alt="Preview ảnh phòng">
  </div>
                                        </div>
                                    </div>
                                    <div class="row button-group">
                                        <div class="col-sm-12">
                                            <div class="status-container">
                                                <label class="switch">
                                                    <input type="checkbox" id="toggle" checked disabled>
                                                    <span class="slider"></span>
                                                </label>
                                                <p>Status: <span id="status">Available</span></p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-3"></div>
                                        <div class="col-sm-9 text-secondary mg-auto">
                                            <input type="submit" class="btn btn-success px-4" value="Add room">                                           
                                        </div>
                                    </div>
                                    <input type="hidden" name="flag" value="1">
                                    <input type="hidden" name="service" value="addRoom">
                                </div>               
                            </form>
                        </div>
                    </div>                                              
                </div>
            </div>
        </div>
        <script>
              const roomImgInput = document.getElementById("roomImgInput");
  const roomImgPreview = document.getElementById("roomImgPreview");

  roomImgInput.addEventListener("change", function () {
    const file = this.files[0];
    if (file) {
      // Chỉ cho phép JPG/PNG
      const allowedExtensions = /(\.jpg|\.jpeg|\.png)$/i;
      if (!allowedExtensions.exec(file.name)) {
        document.getElementById("roomImgError").textContent = "Chỉ cho phép JPG, JPEG hoặc PNG.";
        this.value = "";
        roomImgPreview.style.display = "none";
      } else {
        document.getElementById("roomImgError").textContent = ""; 
        // Dùng FileReader để đọc và hiển thị
        const reader = new FileReader();
        reader.onload = function (e) {
          roomImgPreview.src = e.target.result;
          roomImgPreview.style.display = "block";
        };
        reader.readAsDataURL(file);
      }
    } else {
      roomImgPreview.style.display = "none";
    }
  });

            document.getElementById("addRoomForm").addEventListener("submit", function (event) {
                let roomNumber = document.querySelector('input[name="roomNumber"]').value.trim();
                let roomFloor = document.querySelector('input[name="roomFloor"]').value.trim();
                let roomSize = document.querySelector('input[name="roomSize"]').value.trim();
                let roomFee = document.querySelector('input[name="roomFee"]').value.trim();
                let roomImg = document.querySelector('input[name="roomImg"]').value.trim();

                // Reset lỗi
                document.getElementById("roomNumberError").textContent = "";
                document.getElementById("roomFloorError").textContent = "";
                document.getElementById("roomFeeError").textContent = "";
                document.getElementById("roomImgError").textContent = "";
                document.getElementById("roomSizeError").textContent = "";

                let valid = true;
                
                // Validate Room Number
                if (!/^\d+$/.test(roomNumber)) {
                    document.getElementById("roomNumberError").textContent = "Room number must be numeric.";
                    valid = false;
                }

                if (roomFloor === "" || isNaN(roomFloor) || parseInt(roomFloor) <= 0) {
                    document.getElementById("roomFloorError").textContent = "Room floor must be a number greater than 0.";
                    valid = false;
                }

                if (roomFee === "" || isNaN(roomFee) || parseFloat(roomFee) <= 0) {
                    document.getElementById("roomFeeError").textContent = "Room fee must be a number greater than 0.";
                    valid = false;
                }

                if (roomSize === "" || isNaN(roomSize) || parseInt(roomSize) <= 0) {
                    document.getElementById("roomSizeError").textContent = "Room size must be a number greater than 0.";
                    valid = false;
                }
                // Validate Room Image
                if (roomImg === "") {
                    document.getElementById("roomImgError").textContent = "Please upload a room image.";
                    valid = false;
                } else {
                    const allowedExtensions = /(\.jpg|\.jpeg|\.png)$/i;
                    if (!allowedExtensions.exec(roomImg)) {
                        document.getElementById("roomImgError").textContent = "Only JPG, JPEG, or PNG files are allowed.";
                        valid = false;
                    }
                }

                if (!valid) {
                    event.preventDefault();
                }
            });
        </script>
    </body>
</html>
