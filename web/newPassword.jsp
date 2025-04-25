<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="home-guest/favicon.png">
    <title>New Password</title>
    <style>
        body {
            background: linear-gradient(135deg, #30BD36, #5A84E6);
            font-family: sans-serif;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            max-width: 400px;
            margin: 10% auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            color: #343a40;
        }

        .title-text {
            font-size: 2rem;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .text-password {
            font-size: 1rem;
            margin-bottom: 5px;
        }

        input {
            width: 100%;
            height: 40px;
            padding: 8px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .note-text {
            font-size: 0.85rem;
            margin-bottom: 20px;
        }

        .reset {
            text-align: center;
        }

        #submitButton {
            background-color: #30BD36;
            color: white;
            font-weight: 600;
            border: none;
            border-radius: 6px;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 1rem;
        }

        .notice-message {
            color: red;
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container"> 
        <div class="title-text">
            Enter your new password
        </div>
        <form action="newPassword" method="POST">
            <div class="form-group">
                <h4 class="text-password">New Password:</h4>
                <input type="password" name="password" id="password" required>
                <div id="passwordError" style="color: red;"></div>
            </div>
            <div class="form-group">
                <h4 class="text-password">Confirm Password:</h4>
                <input type="password" name="confirmPassword" id="confirmPassword" required>
                <div id="confirmPasswordError" style="color: red;"></div>
            </div>
            <input type="hidden" name="email" value="${email}">
            <div class="reset">
                <input type="submit" value="Reset Password" id="submitButton">
            </div>
            <div class="notice-message">
                <h4>${status}</h4>
                <h4>${errorMessage}</h4>
            </div>
        </form>
    </div>              
    <script>
        document.getElementById("submitButton").addEventListener("click", function(event) {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            var passwordError = document.getElementById("passwordError");
            var confirmPasswordError = document.getElementById("confirmPasswordError");

            passwordError.textContent = "";
            confirmPasswordError.textContent = "";

            // Ki?m tra ch? ch?a d?u cách ho?c tr?ng
            if (!password || !confirmPassword || password.trim() === "" || confirmPassword.trim() === "") {
                passwordError.textContent = "Password cannot be empty or only spaces.";
                event.preventDefault();
                return;
            }

            // Ki?m tra d?u cách ? ??u ho?c cu?i
            if (password !== password.trim() || confirmPassword !== confirmPassword.trim()) {
                passwordError.textContent = "Password cannot have leading or trailing spaces.";
                event.preventDefault();
                return;
            }

            // Ki?m tra ??nh d?ng m?t kh?u
            if (!password.match(/^(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$/)) {
                passwordError.textContent = "Password must be at least 8 characters long, include at least one number, one letter, and one special character.";
                event.preventDefault();
                return;
            }

            // Ki?m tra m?t kh?u và xác nh?n m?t kh?u có kh?p không
            if (password !== confirmPassword) {
                confirmPasswordError.textContent = "Passwords do not match.";
                event.preventDefault();
                return;
            }
        });
    </script>
</body>
</html>