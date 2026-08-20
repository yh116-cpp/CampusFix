<?php
session_start();

// 如果已经登录过了，直接去仪表盘
if(isset($_SESSION["student_logged_in"]) && $_SESSION["student_logged_in"] === true){
    header("location: dashboard.php");
    exit;
}

$student_id = "";
$err = "";

if($_SERVER["REQUEST_METHOD"] == "POST"){
    $student_id = strtoupper(trim($_POST["student_id"]));
    
    // 验证 TAR UMT 学生证号格式
    if(preg_match('/^\d{2}[A-Z]{3}\d{5}$/', $student_id)){
        $_SESSION["student_logged_in"] = true;
        $_SESSION["student_id"] = $student_id;
        
        header("location: dashboard.php");
        exit;
    } else {
        $err = "Invalid Student ID format. (e.g., 25PMD03976)";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TAR UMT Portal - Student Login</title>
    <link rel="stylesheet" href="../assets/css/global.css">
</head>
<body>
    <header class="navbar">
        <div class="nav-container">
            <div class="logo">
                <span class="logo-tar">TAR</span><span class="logo-umt">UMT</span>
                <span class="logo-app">| Student Portal</span>
            </div>
            <nav>
                <a href="auth-login.php" class="active">Student Login</a>
                <a href="../admin/auth-login.php" style="color: #f4b251; font-weight: bold;">Staff / Admin Login</a>
            </nav>
        </div>
    </header>

    <main class="main-content" style="flex: 1 0 auto; display: flex; align-items: center; justify-content: center; padding: 40px 0;">
        <div class="form-container" style="max-width: 500px; margin: 0 auto;">
            <div class="form-header">
                <h2>Student Sign In</h2>
                <p>Please enter your TAR UMT Student ID to submit a maintenance request.</p>
            </div>

            <?php if(!empty($err)): ?>
                <div class="alert error"><?php echo $err; ?></div>
            <?php endif; ?>

            <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
                <div class="form-group">
                    <label for="student_id">Student ID <span class="required">*</span></label>
                    <input type="text" id="student_id" name="student_id" required placeholder="e.g., 25PMD03976" value="<?php echo htmlspecialchars($student_id); ?>">
                </div>    
                
                <button type="submit" class="btn-submit">Verify & Login</button>
                
                <div style="text-align: center; margin-top: 20px;">
                    <p style="font-size: 14px; color: #666;">Are you a campus administrator? <a href="../admin/auth-login.php" style="color: #00829B; font-weight: bold; text-decoration: underline;">Login here</a></p>
                </div>
            </form>
        </div>
    </main>

    <footer class="footer">
        <p>&copy; 2026 TAR UMT Cloud Computing Assignment. All Rights Reserved.</p>
    </footer>
</body>
</html>