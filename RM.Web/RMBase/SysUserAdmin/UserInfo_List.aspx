﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserInfo_List.aspx.cs"
    Inherits="RM.Web.RMBase.SysUserAdmin.UserInfo_List" %>

<%@ Register Src="~/UserControl/smallhead2.ascx" TagName="head" TagPrefix="UC" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="/Themes/Styles/Site.css" rel="stylesheet" type="text/css" />
    <link href="/Themes/Scripts/PqGrid/style.css" rel="stylesheet" type="text/css" />
    <script src="/Themes/Scripts/jquery-1.8.2.min.js" type="text/javascript"></script>
    <script src="/Themes/Scripts/PqGrid/jquery-ui.min.js" type="text/javascript"></script>
    <script src="/Themes/Scripts/PqGrid/pqgrid.min.js" type="text/javascript"></script>
    <link href="/Themes/Scripts/PqGrid/pqgrid.min.css" rel="stylesheet" />    <link href="/SysSetBase/css/reset.css" rel="stylesheet" type="text/css" />    <link href="/SysSetBase/css/backer.css" rel="stylesheet" type="text/css" />
    <script src="/Themes/Scripts/FunctionJS.js" type="text/javascript"></script>
    <script src="/Themes/Scripts/jquery.pullbox.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            ListGrid();

            $(".pq-cont table").live('dblclick', function () {//双击编辑
                edit();
            });
        });

        function GetWhere() {
            var strwhere = "";
            var Search = "";
            var svl = $("#txtSearch").val();
            if ($.trim(svl) != '') {
                Search += "User_Account@" + svl + "|";
            }          

            if (Search != "") {
                strwhere += "&Search=" + Search.substr(0, Search.length - 1);
            }
            return strwhere;
        }
        /**加载表格函数**/
        function ListGrid() {
            //url：请求地址
            var url = "/RMBase/SysUserAdmin/UserInfo.ashx?action=GetInfoList" + GetWhere();
            //colM：表头名称
            var colM = [
                { title: "checkbox", width: 60, align: "center", sortable: false, hidden: true,
                    render: function (ui) {
                        var rowData = ui.rowData;
                        return "<div onclick='CheckAllLine3(this)' class='xuanxuan' dateId='" + rowData[0] + "' name='checkbox'></div>";
                    }
                },               
                { title: "登录账号", width: 100, align: "center" },
                { title: "用户姓名", width: 100, align: "center" },
                { title: "联系电话", width: 100, align: "center" },
                { title: "邮箱", width: 120, align: "center" },
                { title: "操作", editable: false, width: 120, align: "center", sortable: false,
                    render: function (ui) {
                        var rowData = ui.rowData;
                        var px = "<div class='caozuo'>";
                        px += "<a class='icon-edit4' title='' onclick=\"editById('" + rowData[0] + "')\">修改</a>"
                        px += "<a class='icon-lbx' title='' onclick=\"DeleteById('" + rowData[0] + "')\">删除</a></div>";
                        return px;
                    }
                }
            ];

            //sort：要显示字段,数组对应   
            var sort = [
               "User_ID",
               "User_Account",
               "User_Name",
               "Theme",
               "Email"
            ];
            PQLoadGrid("#grid_paging", url, colM, sort, 10, false);
            //                $("#grid_paging").pqGrid({
            //                    freezeCols: 7, //固定前面列
            //                    title: false
            //                });
            pqGridResize("#grid_paging", 0, 0);
        }
    </script>
    <script type="text/javascript">
        //添加
        function add() {
            var url = "/RMBase/SysUserAdmin/UserInfo_Form.aspx";
            top.art.dialog.open(url, {
                id: 'UserInfo_Forms',
                title: '用户管理 > 添加用户',
                width: 600,
                height: 400,
                close: function () {
                    ListGrid();
                }
            }, false);
        }
        //修改
        function edit() {
            var key = GetPqGridRowValue("#grid_paging", 0);
            if (IsEditdata(key)) {
                editById(key);
            }
        }
        function editById(key) {
            var url = "/RMBase/SysUserAdmin/UserInfo_Form.aspx?key=" + key;
            top.art.dialog.open(url, {
                id: 'UserInfo_Form',
                title: '用户管理 > 编辑用户',
                width: 600,
                height: 400,
                close: function () {
                    ListGrid();
                }
            }, false);
        }

        // 删除
        function Delete() {
            var key = CheckboxValue();
            if (IsDelData(key)) {
                DeleteById(key)
            }
        }
        function DeleteById(key) {
            var delparm = 'action=ISDelete&module=用户管理系统&tableName=ABase_UserInfo&pkName=User_ID&pkVal=' + key;
            delConfig('/Ajax/Common_Ajax.ashx', delparm);
        }


    </script>
    <style type="text/css">
        .seach
        {
            margin-top: -8px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="tools_bar btnbartitle btnbartitlenr">
        <%--<div>
            当前位置：
            <asp:SiteMapPath ID="SiteMapPath1" runat="server">
            </asp:SiteMapPath>
        </div>--%>
        <div>
            当前位置：<span><a title="系统首页" href="/Frame/HomeIndex.aspx">系统首页</a></span><span> &gt;
            </span><span id="lmmc">用户管理</span>
        </div>
        <%--<div class="gjss">
            <p class="sss2">
                <asp:TextBox runat="server" ID="txtSearch" Style="width: 160px;" placeholder="请输入关键字..."
                    CssClass="txtSearch SearchImg"></asp:TextBox>
                <a class="cx" onclick="ListGrid()" id="btn_search"></a>
            </p>
        </div>--%>
    </div>
    <%--<div class="btnbarcontetn2">
        <div class="niuniu">
            <ul>
                <li><a class="tz" onclick="add()"></a></li>
                <li><a class="xg" onclick="edit()"></a></li>
                <li><a class="sc" onclick="Delete()"></a></li>
            </ul>
        </div>
        <div class="niuniu_ym">
        </div>
    </div>--%>
    <div class="bonusrecord03 clearfix" style="background: #fff;">
        <div class="sharedate" style="display:none;">
        </div>
        <div class="sharesearch">
            <input type="text" name="name" value="" id="txtSearch" placeholder="请输入关键字..." autocomplete="off">
            <i class="icon-search" onclick="ListGrid()" id="btn_search"></i>
        </div>
        <div class="wdyhd" style="padding-right: 12px;">
            <div class="r">     
                <span onclick="add()" id="tj">添加</span><span onclick="edit()" id="xg">修改</span><span onclick="Delete()" id="lz">删除</span>
            </div>
        </div>
    </div>
    <div id="grid_paging" style="margin-top: 1px;">
    </div>
    </form>
</body>
</html>
