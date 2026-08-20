<?php
session_start();

// 清空所有管理解相关的 Session 变量
$_SESSION = array();

// 销毁 Session 会话
session_destroy();

// 安全重定向回管理员登录页面
header("location: auth-login.php");
exit;