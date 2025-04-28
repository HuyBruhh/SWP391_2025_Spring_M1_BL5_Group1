<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="author" content="Untree.co">
        <link rel="shortcut icon" href="favicon.png">

        <meta name="description" content="" />
        <meta name="keywords" content="bootstrap, bootstrap5" />

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="fonts/icomoon/style.css">
        <link rel="stylesheet" href="fonts/flaticon/font/flaticon.css">
        <link rel="stylesheet" href="css/tiny-slider.css">
        <link rel="stylesheet" href="css/aos.css">
        <link rel="stylesheet" href="css/style.css">

        <style>
            .error-message { color: red; font-size: 0.9em; margin-top: 5px; display: block;
            .required-asterisk { color: red; font-weight: bold; margin-left: 2px;}
        </style>
    </head>
    <body>
        <section class="preloader">
            <div class="spinner">
                <span class="sk-inner-circle"></span>
            </div>
        </section>

        <main>
            <section class="sign-in-form section-padding">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8 mx-auto col-12">
                            <h1 class="hero-title text-center mb-5">Change password ${x}</h1>
                            <h5 class="text-center mb-5" style="color: red">${message}</h5>
                            <div class="row">
                                <div class="col-lg-8 col-11 mx-auto">
                                    <form method="post" action="changePassword">
                                        <div class="form-floating mb-4 p-0">
                                            <h6>Old Password <span class="required-asterisk">*</span></h6>
                                            <input type="password" name="oldPassword" id="oldPassword" class="form-control" placeholder="Old password" required>
              
                                            <span id="oldPasswordError" class="error-message"></span>
                                        </div>

                                        <div class="form-floating p-0">
                                             <h6>New Password <span class="required-asterisk">*</span></h6>
                                            <input type="password" name="password" id="password" class="form-control" placeholder="New password" required>
                    
                                            <span id="passwordError" class="error-message"></span>
                                        </div>
                                        <br>
                                        <div class="form-floating p-0">
                                            <h6>Confirm New Password <span class="required-asterisk">*</span></h6>
                                            <input type="password" name="rePassword" id="rePassword" class="form-control" placeholder="Repeat new password" required>
                                            <span id="rePasswordError" class="error-message"></span>
                                        </div>
                                        <br>

                                        <button type="submit" class="btn custom-btn form-control mt-4 mb-3">
                                            Change Password
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>

        <div class="site-footer">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4">
                        <div class="widget">
                            <h3>Contact</h3>
                            <address>43 Raymouth Rd. Baltemoer, London 3910</address>
                            <ul class="list-unstyled links">
                                <li><a href="tel://11234567890">+1(123)-456-7890</a></li>
                                <li><a href="tel://11234567890">+1(123)-456-7890</a></li>
                                <li><a href="mailto:info@mydomain.com">info@mydomain.com</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="widget">
                            <h3>Sources</h3>
                            <ul class="list-unstyled float-start links">
                                <li><a href="#">About us</a></li>
                                <li><a href="#">Services</a></li>
                                <li><a href="#">Vision</a></li>
                                <li><a href="#">Mission</a></li>
                                <li><a href="#">Terms</a></li>
                                <li><a href="#">Privacy</a></li>
                            </ul>
                            <ul class="list-unstyled float-start links">
                                <li><a href="#">Partners</a></li>
                                <li><a href="#">Business</a></li>
                                <li><a href="#">Careers</a></li>
                                <li><a href="#">Blog</a></li>
                                <li><a href="#">FAQ</a></li>
                                <li><a href="#">Creative</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="widget">
                            <h3>Links</h3>
                            <ul class="list-unstyled links">
                                <li><a href="#">Our Vision</a></li>
                                <li><a href="#">About us</a></li>
                                <li><a href="#">Contact us</a></li>
                            </ul>
                            <ul class="list-unstyled social">
                                <li><a href="#"><span class="icon-instagram"></span></a></li>
                                <li><a href="#"><span class="icon-twitter"></span></a></li>
                                <li><a href="#"><span class="icon-facebook"></span></a></li>
                                <li><a href="#"><span class="icon-linkedin"></span></a></li>
                                <li><a href="#"><span class="icon-pinterest"></span></a></li>
                                <li><a href="#"><span class="icon-dribbble"></span></a></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="row mt-5">
                    <div class="col-12 text-center">
                        <p>Copyright ©<script>document.write(new Date().getFullYear());</script>. All Rights Reserved. — Designed with love by <a href="https://untree.co">Untree.co</a></p>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const form = document.querySelector('form[action="changePassword"]');
                const oldPasswordInput = document.getElementById('oldPassword');
                const passwordInput = document.getElementById('password');
                const rePasswordInput = document.getElementById('rePassword');

                form.addEventListener('submit', function (event) {
                    let isValid = true;

                    // Kiểm tra oldPassword
                    if (oldPasswordInput.value && oldPasswordInput.value.trim() === "") {
                        document.getElementById("oldPasswordError").textContent = "Password cannot be only spaces";
                        isValid = false;
                    } else if (oldPasswordInput.value && hasLeadingOrTrailingSpaces(oldPasswordInput.value)) {
                        document.getElementById("oldPasswordError").textContent = "Password is incorrect";
                        isValid = false;
                    } else {
                        document.getElementById("oldPasswordError").textContent = "";
                    }

                    // Kiểm tra password
                    if (passwordInput.value && passwordInput.value.trim() === "") {
                        document.getElementById("passwordError").textContent = "Password cannot be only spaces";
                        isValid = false;
                    } else if (passwordInput.value && hasLeadingOrTrailingSpaces(passwordInput.value)) {
                        document.getElementById("passwordError").textContent = "Password must be at least 8 characters long and include at least one uppercase letter and one special character.";
                        isValid = false;
                    } else if (passwordInput.value && passwordInput.value === oldPasswordInput.value) {
                        document.getElementById("passwordError").textContent = "New password cannot be the same as the old password.";
                        isValid = false;
                    } else {
                        document.getElementById("passwordError").textContent = "";
                    }

                    // Kiểm tra rePassword
                    if (rePasswordInput.value && rePasswordInput.value.trim() === "") {
                        document.getElementById("rePasswordError").textContent = "Password cannot be only spaces";
                        isValid = false;
                    } else if (rePasswordInput.value && hasLeadingOrTrailingSpaces(rePasswordInput.value)) {
                        document.getElementById("rePasswordError").textContent = "Password must be at least 8 characters long and include at least one uppercase letter and one special character.";
                        isValid = false;
                    } else {
                        document.getElementById("rePasswordError").textContent = "";
                    }

                    if (!isValid) {
                        event.preventDefault();
                    }
                });

                // Hàm kiểm tra dấu cách ở đầu hoặc cuối
                function hasLeadingOrTrailingSpaces(value) {
                    return value !== value.trim();
                }
            });
        </script>
    </body>
</html>