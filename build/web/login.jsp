<% String error = (String) request.getAttribute("error"); %>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
    <head>
        <meta charset="UTF-8">
        <title>Login</title>
        <link rel="shortcut icon" href="images/favicon.png">
        <link rel="stylesheet" href="css/login.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
        <style>
            .error-message { color: #FF0E0E; font-size: 0.9em; margin-top: 5px; display: block; }
        </style>
    </head>
    <body>
        <div class="container1">
            <div class="title">Login</div>
            <% if (error != null) { %>
            <h3 style="color: #FF0E0E; margin-top: 20px;"><%= error %></h3>
            <% } %>
            <h3 style="color: #FF0E0E; margin-top: 20px;">${message}</h3>
            <div class="content">
                <form id="loginForm" action="login" method="post">
                    <div class="user-details1">
                        <div class="input-box">
                            <span class="details">Email</span>
                            <input type="email" name="email" placeholder="Enter your Email" required>
                            <span id="emailError" class="error-message"></span>
                        </div>
                        <div class="input-box">
                            <span class="details">Password</span>
                            <input type="password" name="password" placeholder="Enter your Password" required>
                            <span id="passwordError" class="error-message"></span>
                        </div>
                        <br/>
                        <span class="details">
                            Don't have an account?
                            <a href="register.jsp" style="text-decoration: none; font-weight: 600;">Register now</a>
                        </span>
                    </div>
                    <div class="button">
                        <input type="submit" value="Login" style="width: 400px; height: 45px">
                    </div>
                    <input type="radio" name="yea" value="" />
                </form>

               <div class="form1">
                    <div class="button">
                        <a href="forgotPassword.jsp"><input type="button" value="Forgot password"></a>
                    </div>
                </div>
                <div class="form1">
                    <div class="button">
                        <a href="GuestController"><input type="button" value="Back to Home"></a>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const form = document.getElementById('loginForm');
                const emailInput = document.querySelector('input[name="email"]');
                const passwordInput = document.querySelector('input[name="password"]');

                form.addEventListener('submit', function (event) {
                    let isValid = true;

                    // Kiểm tra email chỉ chứa dấu cách
                    if (emailInput.value && emailInput.value.trim() === "") {
                        document.getElementById("emailError").textContent = "Email is invalid";
                        isValid = false;
                    } else {
                        document.getElementById("emailError").textContent = "";
                    }

                    // Kiểm tra password chỉ chứa dấu cách
                    if (passwordInput.value && passwordInput.value.trim() === "") {
                        document.getElementById("passwordError").textContent = "Password is incorrect";
                        isValid = false;
                    }
                    // Kiểm tra password có dấu cách ở đầu hoặc cuối
                    else if (passwordInput.value && hasLeadingOrTrailingSpaces(passwordInput.value)) {
                        document.getElementById("passwordError").textContent = "Password is incorrect";
                        isValid = false;
                    } else {
                        document.getElementById("passwordError").textContent = "";
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