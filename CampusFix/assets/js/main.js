/**
 * TAR UMT - 核心全局 JS 交互驱动引擎
 */

document.addEventListener("DOMContentLoaded", function() {
    // 1. 汉堡菜单展开与折叠控制
    const menuToggle = document.getElementById("menuToggle");
    const sidebar = document.getElementById("sidebar");

    if (menuToggle && sidebar) {
        menuToggle.addEventListener("click", function() {
            sidebar.classList.toggle("collapsed");
        });
    }
});

/**
 * 🌟 解决侧边栏跳转冲突：控制学生仪表盘的区块显隐切换
 * @param {string} tabName - 'new-req' 或 'history'
 */
function switchStudentTab(tabName) {
    const newReqBlock = document.getElementById("new-request-block");
    const receiptBlock = document.getElementById("receipt-block");
    const historyBlock = document.getElementById("history-block");

    const menuNewReq = document.getElementById("menu-new-req");
    const menuHistory = document.getElementById("menu-history");

    if (tabName === 'new-req') {
        // 显隐内容控制
        if(newReqBlock) newReqBlock.style.display = "block";
        if(receiptBlock) receiptBlock.style.display = "none"; // 切换回填表时隐藏上一次的凭证
        if(historyBlock) historyBlock.style.display = "none";

        // 侧边栏高亮样式
        if(menuNewReq) menuNewReq.classList.add("active-menu");
        if(menuHistory) menuHistory.classList.remove("active-menu");

    } else if (tabName === 'history') {
        // 显隐内容控制
        if(newReqBlock) newReqBlock.style.display = "none";
        if(receiptBlock) receiptBlock.style.display = "none";
        if(historyBlock) historyBlock.style.display = "block";

        // 侧边栏高亮样式
        if(menuNewReq) menuNewReq.classList.remove("active-menu");
        if(menuHistory) menuHistory.classList.add("active-menu");
        
        // 可选：如果希望每次点历史记录时刷新数据，可以直接执行 window.location.reload();
    }
}