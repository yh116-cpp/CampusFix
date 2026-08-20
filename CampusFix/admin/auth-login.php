<?php
session_start();

// 如果已经登录，直接跳转到 admin 的 dashboard
if(isset($_SESSION["admin_logged_in"]) && $_SESSION["admin_logged_in"] === true){
    header("location: dashboard.php");
    exit;
}

require_once "../config/database.php";
/** @var mysqli $link */

$username = "";
$password = "";
$err = "";

if($_SERVER["REQUEST_METHOD"] == "POST"){
    $username = trim($_POST["username"]);
    $password = trim($_POST["password"]);
    
    if(empty($username) || empty($password)){
        $err = "Please enter both username and password.";
    } else {
        // 🌟 终极直白验证：直接比对用户名和密码字符串
        if($username === "staff_test" && $password === "staff123456"){
            // 登录成功，将管理员会话数据存入 Session
            $_SESSION["admin_logged_in"] = true;
            $_SESSION["admin_id"] = 1; // 模拟一个ID
            $_SESSION["admin_user"] = $username;
            
            header("location: dashboard.php");
            exit;
        } else {
            $err = "Invalid password. Please try again.";
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TAR UMT - Admin Login</title>
    <link rel="stylesheet" href="../assets/css/global.css">
</head>
<body>
    <div class="navbar">
        <div class="nav-container">
            <div class="logo">
                <span class="logo-tar">TAR</span><span class="logo-umt">UMT</span>
                <span class="logo-app">| Admin Central Operations</span>
            </div>
            <nav>
                <a href="../student/auth-login.php">Student Portal</a>
                <a href="#" class="active">Staff / Admin Portal</a>
            </nav>
        </div>
    </div>

    <div class="workspace-container" style="max-width:500px;">
        <div class="form-container">
            <div class="form-header">
                <h2>Admin Operations Sign In</h2>
                <p>Access your central ticket dispatch console.</p>
            </div>

            <?php 
            if(!empty($err)){
                echo "<div class='alert' style='background-color:#f8d7da; color:#721c24; padding:10px; margin-bottom:15px; border-radius:4px;'>$err</div>";
            }
            ?>

            <form action="auth-login.php" method="POST">
                <div class="form-group">
                    <label>Admin Username</label>
                    <input type="text" name="username" value="<?php echo htmlspecialchars($username); ?>" placeholder="Enter admin username" required>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="Enter password" required>
                </div>
                <button type="submit" class="btn-submit">Login as Admin</button>
            </form>
        </div>
    </div>

    <footer class="footer">
        <p>&copy; 2026 TAR UMT Cloud Computing Assignment. All Rights Reserved.</p>
    </footer>
</body>
</html>