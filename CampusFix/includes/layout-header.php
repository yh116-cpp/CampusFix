<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TAR UMT - Campus Repair Request</title>
    <!-- 引入规范分类后的全局 CSS -->
    <link rel="stylesheet" href="../assets/css/global.css">
    <!-- Font Awesome 图标库 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

    <!-- 顶部导航栏 -->
    <div class="navbar">
        <div class="nav-container">
            <div class="nav-left-group">
                <!-- 汉堡菜单按钮 -->
                <button class="nav-menu-toggle" id="menuToggle">
                    <i class="fa-solid fa-bars"></i>
                </button>
                <div class="logo">
                    <span class="logo-tar">TAR</span>
                    <span class="logo-umt">UMT</span>
                    <span class="logo-app">| Student Portal</span>
                </div>
            </div>
            <nav>
                <span>👤 <?php echo htmlspecialchars($_SESSION["student_id"]); ?></span>
                <a href="auth-logout.php">Logout</a>
            </nav>
        </div>
    </div>

    <!-- 核心弹性双栏容器开始 -->
    <div class="workspace-container">
        
        <!-- 左侧边栏 -->
        <div class="left-sidebar" id="sidebar">
            <!-- 🌟 冲突解决：点击时直接通过前端 JS 切换单页视图，并高亮菜单 -->
            <div class="sidebar-menu-item active-menu" id="menu-new-req" onclick="switchStudentTab('new-req')">
                📝 New Request
            </div>
            <div class="sidebar-menu-item" id="menu-history" onclick="switchStudentTab('history')">
                📋 My History Status
            </div>
        </div>

        <!-- 右侧主内容视窗开始 -->
        <div class="right-content-area">