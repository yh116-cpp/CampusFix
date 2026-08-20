<?php
session_start();

// 权限检查：确保管理员已登录
if(!isset($_SESSION["admin_logged_in"]) || $_SESSION["admin_logged_in"] !== true){
    header("location: auth-login.php");
    exit;
}

require_once "../config/database.php";
/** @var mysqli $link */

// 获取搜索关键词
$search = "";
if(isset($_GET['search'])){
    $search = trim($_GET['search']);
}

// 修改状态的逻辑（保留你原本的 dispatch 分配/更新状态功能）
if($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['update_status'])){
    $request_id = $_POST['request_id'];
    $new_status = $_POST['status'];
    
    $sql_update = "UPDATE repair_requests SET status = ? WHERE id = ?";
    if($stmt_update = mysqli_prepare($link, $sql_update)){
        mysqli_stmt_bind_param($stmt_update, "si", $new_status, $request_id);
        mysqli_stmt_execute($stmt_update);
        mysqli_stmt_close($stmt_update);
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TAR UMT - Admin Dispatch Console</title>
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
                <a href="#" class="active">Dispatch Console</a>
                <a href="auth-logout.php" style="color: #dc3545;">Logout (<?php echo htmlspecialchars($_SESSION["admin_user"]); ?>)</a>
            </nav>
        </div>
    </div>

    <div class="workspace-container" style="max-width: 1200px; margin: 40px auto;">
        <div class="form-container" style="border-top-color: #00829B;">
            <div class="form-header" style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 15px;">
                <div>
                    <h2>Central Maintenance Dispatch Console</h2>
                    <p>Review student reports and dispatch tasks from oldest to newest.</p>
                </div>
                
                <!-- 🌟 重新设计的原生搜索栏（适配你的 global.css 表单样式，不突兀） -->
                <form action="dashboard.php" method="GET" style="display: flex; gap: 10px; align-items: center; margin: 0;">
                    <input type="text" name="search" value="<?php echo htmlspecialchars($search); ?>" placeholder="Search block, category, description..." style="padding: 8px 12px; width: 260px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;">
                    <button type="submit" class="btn-submit" style="margin: 0; padding: 8px 16px; background-color: #00829B; width: auto;">Search</button>
                    <?php if(!empty($search)): ?>
                        <a href="dashboard.php" style="color: #666; text-decoration: none; font-size: 14px; margin-left: 5px;">Clear</a>
                    <?php endif; ?>
                </form>
            </div>

            <div style="overflow-x: auto; margin-top: 20px;">
                <table class="history-table" style="width: 100%; border-collapse: collapse;">
                    <thead>
                        <tr style="background-color: #f4f4f4; text-align: left;">
                            <th>Ticket ID</th>
                            <th>Student ID</th>
                            <th>Location</th>
                            <th>Category</th>
                            <th>Description</th>
                            <th>Date Filed</th>
                            <th>Status Control</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                    // 🌟 1. 动态拼接搜索 SQL 条件
                    if(!empty($search)){
                        // 支持模糊搜索单号、地点、分类、描述
                        $sql_hist = "SELECT id, student_id, block, floor, room, category, description, created_at, status 
                                     FROM repair_requests 
                                     WHERE id LIKE ? OR block LIKE ? OR category LIKE ? OR description LIKE ?
                                     ORDER BY id ASC"; // 🌟 2. 核心要求：按 ID 从小到大排序（ASC）
                        $stmt_hist = mysqli_prepare($link, $sql_hist);
                        $search_param = "%" . $search . "%";
                        mysqli_stmt_bind_param($stmt_hist, "ssss", $search_param, $search_param, $search_param, $search_param);
                    } else {
                        // 无搜索时，直接按 ID 从小到大排序（ASC）
                        $sql_hist = "SELECT id, student_id, block, floor, room, category, description, created_at, status 
                                     FROM repair_requests 
                                     ORDER BY id ASC"; // 🌟 2. 核心要求：按 ID 从小到大排序（ASC）
                        $stmt_hist = mysqli_prepare($link, $sql_hist);
                    }

                    if($stmt_hist){
                        if(!empty($search)){
                            mysqli_stmt_execute($stmt_hist);
                        } else {
                            mysqli_stmt_execute($stmt_hist);
                        }
                        
                        $res = mysqli_stmt_get_result($stmt_hist);
                        if(mysqli_num_rows($res) > 0){
                            while($row = mysqli_fetch_assoc($res)){
                                echo "<tr>";
                                echo "<td>#{$row['id']}</td>";
                                echo "<td>" . htmlspecialchars($row['student_id']) . "</td>";
                                echo "<td>" . htmlspecialchars($row['block']) . " ({$row['floor']}, {$row['room']})</td>";
                                echo "<td>" . htmlspecialchars($row['category']) . "</td>";
                                echo "<td>" . htmlspecialchars($row['description']) . "</td>";
                                echo "<td>{$row['created_at']}</td>";
                                echo "<td>";
                                // 状态修改表单
                                echo "<form action='dashboard.php" . (!empty($search) ? "?search=".urlencode($search) : "") . "' method='POST' style='display:inline-flex; gap:5px; margin:0;'>";
                                echo "<input type='hidden' name='request_id' value='{$row['id']}'>";
                                echo "<select name='status' style='padding:4px; border-radius:4px; border:1px solid #ccc;'>";
                                echo "<option value='Pending'" . ($row['status'] == 'Pending' ? ' selected' : '') . ">Pending</option>";
                                echo "<option value='In Progress'" . ($row['status'] == 'In Progress' ? ' selected' : '') . ">In Progress</option>";
                                echo "<option value='Resolved'" . ($row['status'] == 'Resolved' ? ' selected' : '') . ">Resolved</option>";
                                echo "</select>";
                                echo "<button type='submit' name='update_status' style='padding:4px 8px; background:#00829B; color:#fff; border:none; border-radius:4px; cursor:pointer; font-size:12px;'>Update</button>";
                                echo "</form>";
                                echo "</td>";
                                echo "</tr>";
                            }
                        } else {
                            echo "<tr><td colspan='7' style='text-align:center; color:#999; padding: 20px;'>No maintenance requests found matching your criteria.</td></tr>";
                        }
                        mysqli_stmt_close($stmt_hist);
                    }
                    mysqli_close($link);
                    ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <footer class="footer">
        <p>&copy; 2026 TAR UMT Cloud Computing Assignment. All Rights Reserved.</p>
    </footer>
</body>
</html>