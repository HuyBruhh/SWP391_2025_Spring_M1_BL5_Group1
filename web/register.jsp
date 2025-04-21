<% String error = (String) request.getAttribute("error"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <link rel="shortcut icon" href="images/favicon.png">
    <link rel="stylesheet" href="css/register.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        .error-message { color: #FF0E0E; font-size: 0.9em; margin-top: 5px; display: block; }
        .password-input { position: relative; }
        .password-input::after {
            content: attr(data-placeholder);
            position: absolute;
            top: 50%;
            left: 10px;
            transform: translateY(-50%);
            pointer-events: none;
            color: gray;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="title">Register</div>
        <div class="content">
            <% if (error != null) { %>
            <h3 id="message" style="color: #FF0E0E; margin-top: 20px;"><%= error %></h3>
            <% } %>
            <h3 id="message" style="color: #FF0E0E; margin-top: 20px;">${message}</h3>
            <form id="registerForm" action="emailSender" method="post">
                <div class="user-details">
                    <div class="input-box">
                        <span class="details">Full Name</span>
                        <input type="text" placeholder="Enter your full name" name="username" id="username" required maxlength="30">
                        <span id="usernameError" class="error-message"></span>
                    </div>
                    <div class="input-box">
                        <span class="details">Gender</span>
                        <select name="gender" style="width: 300px; height: 44px; border-radius: 5px; padding-left: 15px; font-size: 16px;">
                            <option value="Male" selected="selected">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                    <div class="input-box">
                        <span class="details">Email</span>
                        <input type="email" placeholder="Enter your email" name="email" id="email" required maxlength="100">
                        <span id="emailError" class="error-message"></span>
                    </div>
                    <div class="input-box">
                        <span class="details">Phone Number</span>
                        <input type="text" placeholder="Enter your number" name="phone" id="phone" required maxlength="12">
                        <span id="phoneError" class="error-message"></span>
                    </div>
                    <div class="input-box">
                        <span class="details">Birth Day</span>
                        <input type="date" name="dob" id="dob">
                        <span id="dobError" class="error-message"></span>
                    </div>
                    <div class="input-box">
                        <span class="details">Password</span>
                        <input type="password" placeholder="Enter your password" name="password" id="password" required maxlength="50">
                        <span id="passwordError" class="error-message"></span>
                    </div>
                    <div class="input-box">
                        <span class="details">Address</span>
                        <input type="text" placeholder="Enter your Address" name="address" id="address" required maxlength="50">
                        <span id="addressMessage" class="error-message"></span>
                    </div>
                    <div class="input-box">
                        <span class="details">Confirm Password</span>
                        <input type="password" placeholder="Confirm your password" name="repassword" id="repassword" required maxlength="50">
                        <span id="repasswordError" class="error-message"></span>
                    </div>
                    <div class="input-box">
                        <span class="details">Role</span>
                        <select name="role" style="width: 300px; height: 44px; border-radius: 5px; padding-left: 15px; font-size: 16px;">
                            <option value="renter" selected="selected">Renter</option>
                            <option value="owner">Owner</option>
                        </select>
                    </div>
                </div>
                <div class="button">
                    <input type="submit" value="Register" style="width: 650px;">
                </div>
                ${message}
            </form>
            <div class="form1">
                <div class="button">
                    <a href="login.jsp"><input type="submit" value="Back to Login" style="width: 650px;"></a>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const form = document.getElementById('registerForm');
            const usernameInput = document.querySelector('input[name="username"]');
            const emailInput = document.querySelector('input[name="email"]');
            const phoneInput = document.querySelector('input[name="phone"]');
            const dobInput = document.querySelector('input[name="dob"]');
            const passwordInput = document.querySelector('input[name="password"]');
            const repasswordInput = document.querySelector('input[name="repassword"]');
            const addressInput = document.querySelector('input[name="address"]');
            const messageElement = document.querySelector('#message');

            let timeoutId;

            // Set max date for dob
            document.getElementById('dob').max = new Date().toISOString().split("T")[0];

            // Validate on input
            usernameInput.addEventListener("input", () => validateField(usernameInput, "usernameError", validateUsername));
            emailInput.addEventListener("input", () => validateField(emailInput, "emailError", validateEmail));
            phoneInput.addEventListener("input", () => validateField(phoneInput, "phoneError", validatePhone));
            dobInput.addEventListener("input", () => validateField(dobInput, "dobError", validateDob));
            passwordInput.addEventListener("input", () => {
                clearTimeout(timeoutId);
                timeoutId = setTimeout(validatePasswords, 1000);
            });
            repasswordInput.addEventListener("input", () => {
                clearTimeout(timeoutId);
                timeoutId = setTimeout(validatePasswords, 1000);
            });
            addressInput.addEventListener("input", () => validateField(addressInput, "addressMessage", validateAddress));

            // Validate on form submit
            form.addEventListener('submit', function (event) {
                let isValid = true;
                if (!validateUsername(usernameInput.value)) {
                    document.getElementById("usernameError").textContent = "please input a valid name";
                    isValid = false;
                }
                if (!validateEmail(emailInput.value)) {
                    document.getElementById("emailError").textContent = "Invalid email format";
                    isValid = false;
                }
                if (!validatePhone(phoneInput.value)) {
                    document.getElementById("phoneError").textContent = "Phone must be in Vietnamese format (e.g., 0123456789 or +84123456789)";
                    isValid = false;
                }
                if (dobInput.value && !validateDob(dobInput.value)) {
                    document.getElementById("dobError").textContent = "You must be at least 18 years old";
                    isValid = false;
                }
                if (!isPasswordValid(passwordInput.value)) {
                    document.getElementById("passwordError").textContent = "Password must be at least 8 characters long and include at least one uppercase letter and one special character";
                    isValid = false;
                }
                if (passwordInput.value !== repasswordInput.value) {
                    document.getElementById("repasswordError").textContent = "Password and Confirm-Password do not match";
                    isValid = false;
                }
                if (!validateAddress(addressInput.value)) {
                    document.getElementById("addressMessage").textContent = "address is not valid";
                    isValid = false;
                }

                if (!isValid) {
                    event.preventDefault();
                }
            });

            function validateField(input, errorId, validateFunc) {
                clearTimeout(timeoutId);
                timeoutId = setTimeout(() => {
                    const errorElement = document.getElementById(errorId);
                    if (!validateFunc(input.value)) {
                        errorElement.textContent = getErrorMessage(errorId);
                    } else {
                        errorElement.textContent = "";
                    }
                }, 1000);
            }

            function getErrorMessage(errorId) {
                switch (errorId) {
                    case "usernameError": return "please input a valid name";
                    case "emailError": return "Invalid email format";
                    case "phoneError": return "Phone must be in Vietnamese format (e.g., 0123456789 or +84123456789)";
                    case "dobError": return "You must be at least 18 years old";
                    case "addressMessage": return "address is not valid";
                    default: return "";
                }
            }

            function validateUsername(username) {
                return username && username.trim() !== "";
            }

            function validateEmail(email) {
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                return email && emailRegex.test(email);
            }

            function validatePhone(phone) {
                const phoneRegex = /^(0|\+84)[0-9]{9}$/;
                return phone && phoneRegex.test(phone);
            }

            function validateDob(dob) {
                if (!dob) return true; // Not required
                const dobDate = new Date(dob);
                const today = new Date("2025-04-21"); // Ngày hiện tại
                const age = today.getFullYear() - dobDate.getFullYear();
                const monthDiff = today.getMonth() - dobDate.getMonth();
                if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < dobDate.getDate())) {
                    return age - 1 >= 18;
                }
                return age >= 18;
            }

            function validatePasswords() {
                const password = passwordInput.value;
                const repassword = repasswordInput.value;

                if (repassword !== "" && password !== repassword) {
                    document.getElementById("repasswordError").textContent = "Password and Confirm-Password do not match";
                } else if (!isPasswordValid(password)) {
                    document.getElementById("passwordError").textContent = "Password must be at least 8 characters long and include at least one uppercase letter and one special character";
                } else {
                    document.getElementById("passwordError").textContent = "";
                    document.getElementById("repasswordError").textContent = "";
                }
            }

            function validateAddress(address) {
                return address && address.trim() !== "";
            }

            function isPasswordValid(password) {
                const regex = /^(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}$/;
                return regex.test(password);
            }
        });
    </script>
</body>
</html>