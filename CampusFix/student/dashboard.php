<?php
session_start();
if(!isset($_SESSION["student_logged_in"]) || $_SESSION["student_logged_in"] !== true){
    header("location: auth-login.php");
    exit;
}

require_once "../config/database.php";
/** @var mysqli $link */

$student_id = $_SESSION["student_id"];
$show_receipt = false;
$receipt_data = [];

if($_SERVER["REQUEST_METHOD"] == "POST"){
    $block = trim($_POST["block"]);
    $floor = trim($_POST["floor"]);
    $room = trim($_POST["room"]);
    $category = trim($_POST["category"]);
    $description = trim($_POST["description"]);
    
    // 完美的表名：repair_requests
    $sql = "INSERT INTO repair_requests (student_id, block, floor, room, category, description) VALUES (?, ?, ?, ?, ?, ?)";
    if($stmt = mysqli_prepare($link, $sql)){
        mysqli_stmt_bind_param($stmt, "ssssss", $student_id, $block, $floor, $room, $category, $description);
        if(mysqli_stmt_execute($stmt)){
            $show_receipt = true;
            $receipt_data = [
                "id" => mysqli_insert_id($link),
                "block" => $block,
                "floor" => $floor,
                "room" => $room,
                "category" => $category,
                "description" => $description,
                "date" => date("Y-m-d H:i:s")
            ];
        }
        mysqli_stmt_close($stmt);
    }
}

// 包含顶部模板
include "../includes/layout-header.php";
?>

<!-- 1. 新请求表单区块 -->
<div id="new-request-block" style="<?php echo $show_receipt ? 'display:none;' : 'display:block;'; ?>">
    <div class="form-container">
        <div class="form-header">
            <h2>Campus Maintenance Request Form</h2>
            <p>Spotted a broken facility? Fill out this form and our maintenance team will handle it swiftly.</p>
        </div>
        <form action="dashboard.php" method="POST">
            <!-- 🌟 这里已经改成了由学生自己填写的文本输入框 -->
            <div class="form-group">
                <label>Block / Building <span class="required">*</span></label>
                <input type="text" name="block" placeholder="e.g., Block C, Cyber Lab, V4 Hostel" required>
            </div>
            
            <div style="display: flex; gap: 20px;">
                <div class="form-group" style="flex: 1;">
                    <label>Floor Level <span class="required">*</span></label>
                    <input type="text" name="floor" placeholder="e.g., Ground, Level 2" required>
                </div>
                <div class="form-group" style="flex: 1;">
                    <label>Room / Area Number <span class="required">*</span></label>
                    <input type="text" name="room" placeholder="e.g., Room 102, Washroom" required>
                </div>
            </div>
            <div class="form-group">
                <label>Issue Category <span class="required">*</span></label>
                <select name="category" required>
                    <option value="">-- Select Category --</option>
                    <option value="Electrical">Electrical (Lights, AC, Fan, Power Socket)</option>
                    <option value="Plumbing">Plumbing (Leaking, Clogged Toilet, Tap)</option>
                    <option value="Furniture">Furniture (Broken Chair, Desk, Whiteboard)</option>
                    <option value="Structure">Structure (Door, Window, Ceiling, Wall)</option>
                    <option value="Others">Others</option>
                </select>
            </div>
            <div class="form-group">
                <label>Detailed Description <span class="required">*</span></label>
                <textarea name="description" rows="5" placeholder="Please provide details about the problem (e.g., The AC in Block C Room 302 is leaking water heavily)." required></textarea>
            </div>
            <button type="submit" class="btn-submit">Submit Maintenance Request</button>
        </form>
    </div>
</div>

<!-- 2. 提报成功凭证区块 -->
<?php if($show_receipt): ?>
<div id="receipt-block" style="display: block;">
    <div class="form-container" style="border-top-color: #28a745;">
        <div style="text-align: center; margin-bottom: 20px;">
            <div style="font-size: 50px; color: #28a745;">✔️</div>
            <h2 style="color: #28a745; margin-top: 10px;">Submission Successful!</h2>
            <p style="color: #666;">We have successfully logged your report. Below is your reference receipt.</p>
        </div>
        <div style="background: #f9f9f9; padding: 20px; border-radius: 6px; border: 1px solid #ddd; line-height: 2;">
            <strong>Ticket ID:</strong> #<?php echo $receipt_data["id"]; ?><br>
            <strong>Date Submitted:</strong> <?php echo $receipt_data["date"]; ?><br>
            <strong>Location:</strong> <?php echo "{$receipt_data['block']}, {$receipt_data['floor']}, {$receipt_data['room']}"; ?><br>
            <strong>Category:</strong> <?php echo $receipt_data["category"]; ?><br>
            <strong>Description:</strong> <?php echo nl2br(htmlspecialchars($receipt_data["description"])); ?><br>
            <strong>Current Status:</strong> <span class="badge-status" style="background-color: #ffc107; color: #212529;">Pending Allocation</span>
        </div>
        <button onclick="window.location.href='dashboard.php';" class="btn-submit" style="margin-top:20px; background-color:#6c757d;">Submit Another Request</button>
    </div>
</div>
<?php endif; ?>

<!-- 3. 历史记录列表区块 -->
<div id="history-block" style="display: none;">
    <div class="form-container" style="border-top-color: #00829B;">
        <div class="form-header">
            <h2>My Historical Requests</h2>
            <p>Track the real-time processing status of all your submitted complaints.</p>
        </div>
        <div style="overflow-x: auto;">
            <table class="history-table">
                <thead>
                    <tr>
                        <th>Ticket ID</th>
                        <th>Location</th>
                        <th>Category</th>
                        <th>Description</th>
                        <th>Date Filed</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                <?php
                // 完美的表名：repair_requests
                $sql_hist = "SELECT id, block, floor, room, category, description, created_at, status FROM repair_requests WHERE student_id = ? ORDER BY id DESC";
                if($stmt_hist = mysqli_prepare($link, $sql_hist)){
                    mysqli_stmt_bind_param($stmt_hist, "s", $student_id);
                    mysqli_stmt_execute($stmt_hist);
                    $res = mysqli_stmt_get_result($stmt_hist);
                    if(mysqli_num_rows($res) > 0){
                        while($row = mysqli_fetch_assoc($res)){
                            $status_color = "#ffc107"; // Pending
                            if($row['status'] == 'In Progress') $status_color = "#17a2b8";
                            if($row['status'] == 'Resolved') $status_color = "#28a745";
                            
                            echo "<tr>";
                            echo "<td>#{$row['id']}</td>";
                            echo "<td>{$row['block']} ({$row['floor']}, {$row['room']})</td>";
                            echo "<td>{$row['category']}</td>";
                            echo "<td>" . htmlspecialchars(substr($row['description'], 0, 40)) . (strlen($row['description']) > 40 ? "..." : "") . "</td>";
                            echo "<td>{$row['created_at']}</td>";
                            echo "<td><span class='badge-status' style='background-color:{$status_color};'>{$row['status']}</span></td>";
                            echo "</tr>";
                        }
                    } else {
                        echo "<tr><td colspan='6' style='text-align:center; color:#999;'>You haven't submitted any repair requests yet.</td></tr>";
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

<?php include "../includes/layout-footer.php"; ?>