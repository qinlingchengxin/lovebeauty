<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>

<script type="text/javascript" src="${rootPath}/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${rootPath}/js/rootPath.js"></script>
<script type="text/javascript" src="${rootPath}/js/common_operation.js"></script>
<script type="text/javascript" src="${rootPath}/js/jquery-ui-1.10.2.custom.js"></script>

<link href="${rootPath}/css/frame_table.css" type="text/css" rel="stylesheet"/>
<link href="${rootPath}/css/jquery-ui-1.10.2.custom.css" type="text/css" rel="stylesheet"/>
<link href="${rootPath}/css/ui_skin.css" type="text/css" rel="stylesheet"/>

<link type="text/css" rel="stylesheet" href="${rootPath}/css/colorbox.css"/>
<script type="text/javascript" src="${rootPath}/js/jquery.colorbox.js"></script>

<script type="text/javascript">
    $(function () {
        $(".btn_add_img").click(function () {
            location.href = getRootPath() + "employee/addInit.do";
        });

        $(".img_class_a").colorbox({rel: 'img_class_a', photo: true});
    });

    //第一页
    function firstPage() {
        if ($("#currentPage").text() != "1") {
            var url = "queryEmployeeByPage.do";
            pageing(1, url, page_callback);
        }
    }

    //上一页
    function prePage() {
        if ($("#currentPage").text() != "1") {
            var curPage = parseInt($("#currentPage").text()) - 1;
            var url = "queryEmployeeByPage.do";
            pageing(curPage, url, page_callback);
        }
    }
    //下一页
    function nextPage() {
        if ($("#currentPage").text() != $("#totalPage").text()) {
            var curPage = parseInt($("#currentPage").text()) + 1;
            var url = "queryEmployeeByPage.do";
            pageing(curPage, url, page_callback);
        }
    }

    //最后一页
    function lastPage() {
        if ($("#currentPage").text() != $("#totalPage").text()) {
            var lastPage = $("#totalPage").text();
            var url = "queryEmployeeByPage.do";
            pageing(lastPage, url, page_callback);
        }
    }

    //跳转到第几页
    function btnGo() {
        var go_page = $("#go_page").val();
        var totalPage = $("#totalPage").text();
        if (go_page != undefined && $.trim(go_page) != "" && totalPage != "") {
            if ((parseInt(go_page) <= parseInt(totalPage)) && parseInt(go_page) > 0) {
                var url = "queryEmployeeByPage.do";
                pageing(go_page, url, page_callback);
            }
        }
    }

    //编辑员工
    function employee_edit(node) {
        var employeeId = $(node).attr("employeeId");
        location.href = getRootPath() + "employee/editEmployee.do?employeeId=" + employeeId;
    }

    //删除员工
    function employee_delete(node) {
        var employeeId = $(node).attr("employeeId");
        var url = getRootPath() + "employee/deleteEmployee.do?employeeId=" + employeeId + "&headImg=" + $(node).attr("headImg");
        deleteRecord(node, url);
    }

    function page_callback(data) {
        $(".frame_table tr:gt(0)").remove();
        var tabTag = $(".frame_table");
        var employees = data.employees;
        var trTag;
        for (var i = 0, j = employees.length; i < j; i++) {
            trTag = ' <tr class="tr_body">'
                    + '<td><input class="select_inp2" type="checkbox" employeeId="' + employees[i].id + '"/></td>'
                    + ' <td>' + i + '</td>'
                    + '<td>' + employees[i].nickname + '</td>'
                    + '<td>' + employees[i].sex + '</td>'
                    + '<td>' + employees[i].majorScore + '</td>'
                    + '<td>' + employees[i].comScore + '</td>'
                    + '<td>' + employees[i].punctualScore + '</td>'
                    + '<td>' + employees[i].avgPrice + '</td>'
                    + '<td>' + employees[i].state + '</td>'
                    + '<td>' + employees[i].serverScope + '</td>'
                    + '<td>'
                    + ' <a href="${rootPath}/fileUpload/' + employees[i].headImg + '" class="img_class_a">预览</a> '
                    + '<a href="javascript:void(0);" employeeId="' + employees[i].id + '" onclick="employee_edit(this);">编辑</a> '
                    + '<a href="${rootPath}/employee/getEmployeeDetail.do?employeeId=' + employees[i].id + '">详情</a> '
                    + '<a href="javascript:void(0);" employeeId="' + employees[i].id + '" headImg="' + employees[i].headImg + '" onclick="employee_delete(this);">删除</a> '
                    + ' </td>'
                    + '</tr>';
            tabTag.append($(trTag));
        }
        $(".img_class_a").colorbox({rel: 'img_class_a', photo: true});
    }
</script>

<div class="tab_header">
    <span class="fontStyle_bold cur_pos">你当前的位置：</span>[业务中心]-[员工列表]
    <span class="btn_pos">
        <span class="btn_bg_img btn_add_img">添加</span>
    </span>

</div>
<div id="tb_body">
    <table class="frame_table" cellspadding=0 cellspacing=0>
        <tr class="tr_header">
            <td><input class="select_inp" type="checkbox"/></td>
            <td>序号</td>
            <td>名称</td>
            <td>性别</td>
            <td>专业得分</td>
            <td>沟通得分</td>
            <td>守时得分</td>
            <td>均价</td>
            <td>在职状态</td>
            <td>服务范围</td>
            <td>操作</td>
        </tr>
        <c:forEach var="employee" items="${employees}" varStatus="vst">
            <tr class="tr_body">
                <td><input class="select_inp2" type="checkbox" employeeId="${employee.id}"/></td>
                <td>${vst.index}</td>
                <td>${employee.nickname}</td>
                <td>${employee.sex}</td>
                <td>${employee.majorScore}</td>
                <td>${employee.comScore}</td>
                <td>${employee.punctualScore}</td>
                <td>${employee.avgPrice}</td>
                <td>${employee.state}</td>
                <td>${employee.serverScope}</td>
                <td>
                    <a href="${rootPath}/fileUpload/${employee.headImg}" class="img_class_a">预览</a>
                    <a href="javascript:void(0);" employeeId="${employee.id}" onclick="employee_edit(this);">编辑</a>
                    <a href="${rootPath}/employee/getEmployeeDetail.do?employeeId=${employee.id}">详情</a>
                    <a href="javascript:void(0);" employeeId="${employee.id}" headImg="${employee.headImg}" onclick="employee_delete(this);">删除</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<div id="tb_body_footer">
        <span class="footer_text footer_text_align_one">
            <span>共有 ${employeeCount} 条记录，当前第 <span id="currentPage">${curPage}</span>/<span id="totalPage">${totalPage}</span> 页</span>
        </span>
        <span class="footer_text_align_two">
            <button class="footer_text_two" onclick="firstPage();">首页</button>
            <button class="footer_text_two" onclick="prePage();">上一页</button>
            <button class="footer_text_two" onclick="nextPage();">下一页</button>
            <button class="footer_text_two" onclick="lastPage();">尾页</button>
            转到第<input id="go_page" type="text" size="8"/>页
            <button class="footer_text_two" onclick="btnGo();">&nbsp;</button>
        </span>
</div>