﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SalesMoneysp.aspx.cs" Inherits="RM.Web.SysSetBase.superAdmin.SalesMoneysp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>设置商品奖金</title>
    <meta name="viewport" content="width=device-width, user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" />
    <meta content="always" name="referrer">
     <link href="/SysSetBase/css/reset.css" rel="stylesheet" type="text/css" />
    <link href="/SysSetBase/css/backer.css" rel="stylesheet" type="text/css" />
    <script src="/Themes/Scripts/jquery-1.8.2.min.js" type="text/javascript"></script>
    <script src="/Themes/Scripts/artDialog/artDialog.source.js" type="text/javascript"></script>
    <script src="/Themes/Scripts/artDialog/iframeTools.source.js" type="text/javascript"></script>
    <script src="/Themes/Scripts/FunctionJS.js" type="text/javascript"></script>
    <style type="text/css">
        .gtall
        {
            height: calc(100% - 45px);
        }
        .gmkf .gmkfNav
        {
            float: left;
            width: 200px;
            background-color: #f6f6f6;
            height: calc(100%);
            line-height: 18px;
            box-sizing: border-box;
            overflow: auto;
        }
        td,th
        {
            border: 1px solid #ebebeb;
            padding:5px 8px;
            }
            input[type="text"]
            {
                height:30px;
                line-height:30px;
                }
                tr td.one:first-child
                {
                    border-right:none;
                    }
    </style>
        <script type="text/javascript">

            $(function () {
                ProductList();
                //左边导航
                $('.gmkfNav').on('click', 'b', function () {
                    $(this).siblings('ul').slideToggle(120);
                    $(this).parents('dd').toggleClass('down');
                });
                $('.gmkfNav ul').on('click', 'li', function () {
                    $(this).addClass("active").siblings().removeClass("active");
                    $("#Hdhoteladmin").val($(this).attr("AdminHotelId"));
                    $("#hdHotelId").val($(this).attr("HotelId"));
                    ProductList();
                });
                $("#tbProductList").on("blur", ".one input", function () {
                    var vl = $(this).val();
                    if (vl != "" && vl != "-1") {
                        $(this).parents("tr:eq(0)").find(".one input").val("0");
                    }
                    if (vl == "") {
                        vl = "0";
                    }
                    $(this).val(vl);
                });
          
            });

            function ProductList() {
                var hid = $("#hdHotelId").val();
                if (hid == "" || hid == "-1") {
                    return;
                }
                $.ajax({
                    type: 'post',
                    dataType: "json",
                    url: "MarketingConfigure.ashx",
                    data: { action: "GetProductList", HotelId: hid },
                    cache: false,
                    async: false,
                    success: function (data) {
                        $("#tbProductList").html("");
                        if (data == null || data == "") {
                            return;
                        }
                        var trHtml = "";
                        for (var i = 0; i < data.length; i++) {
                            var product = data[i];
                            trHtml += "<tr dataid='" + product.Id + "'>";
                            trHtml += "<td>" + product.Name + "</td>";
                            trHtml += "<td class = 'one' style='border-right:1px solid #fff;'><span style='margin-right:5px;'>固定</span><input type='text' class='gd' maxlength='5' onkeyup=\"value=value.replace(/[^\\d.-]/g,'')\" value='" + product.PromoteMoney + "' style='width:60px;'/> 元</td>";
                            trHtml += "<td class = 'one'><span style='margin-right:5px;'>比例</span><input type='text' class='bl' maxlength='5' onkeyup=\"value=value.replace(/[^\\d.-]/g,'')\" value='" + product.PromoteProportion + "' style='width:60px;'/> %</td>";
                            trHtml += "</tr>";
                        }
                        $("#tbProductList").html(trHtml);
                    }
                });
            }

            //保存设置
            function SaveInfo() {
                var HotelID = $("#hdHotelId").val();
                if (HotelID == "" || HotelID == "-1") {
                    showTipsMsg('请选择酒店！', '5000', '5');
                    return false;
                }

                var objInfo = [];
                $("#tbProductList tr").each(function () {
                    var productid = $(this).attr("dataid");
                    var obj_product = new Object();
                    obj_product.ProductId = productid;
                    obj_product.PromoteMoney = $(this).find(".gd").val();
                    obj_product.PromoteProportion = $(this).find(".bl").val();
                    objInfo.push(obj_product);
                });

                var jsonDate = JSON.stringify(objInfo);
                $.ajax({
                    url: "MarketingConfigure.ashx",
                    data: {
                        action: "SaveProductMoney",
                        HotelId: HotelID,
                        JsonDate: jsonDate
                    },
                    type: "POST",
                    dataType: "text",
                    async: false,
                    success: function (data) {
                        if (data == "1") {
                            showTipsMsg('保存成功！', '5000', '5');
                        } else {
                            showTipsMsg('保存失败！', '5000', '3');
                        }
                    }
                });
            }

            function Loading(bl) { return false; }
    </script>


</head>
<body>
    <form id="form1" runat="server">
    <input runat="server" type="hidden" id="Hdhoteladmin" value="1" />
    <input runat="server" type="hidden" id="hdHotelId" value="-1" />
    <input runat="server" type="hidden" id="htHotelTree" value="true" />
    <div class="gtall gmkf clearfix" style="height: 360px;margin:20px;">
        <div id="HotelTree" runat="server" class="gmkfNav">
            <dl>
                <%=hotelTreeHtml.ToString()%>
            </dl>
        </div>
        <div class="shareright" style="overflow: auto;">
            <div class="div_table">
                <table>
                    <thead>
                    <tr>
                    <th rowspan="2">
                    商品名称
                    </th>
                    <th colspan="2">
                    奖金
                    </th>
                    </tr>
                    </thead>
                    <tbody id="tbProductList">
	  <%--                  <tr dataid="582">
	                        <td>康师傅香辣牛肉味方便面</td>
	                        <td class="one"style="border-right:1px solid #fff;"><span style="margin-right:5px;">固定</span><input type="text" class="gd" maxlength="5" onkeyup="value=value.replace(/[^\d.-]/g,'')" value="3" style="width:60px;"> 元</td>
	                        <td class="one"><span style="margin-right:5px;">比例</span><input type="text" class="bl" maxlength="5" onkeyup="value=value.replace(/[^\d.-]/g,'')" value="0" style="width:60px;"> %</td>
	                    </tr>
	                    <tr dataid="582">
	                        <td>康师傅香辣牛肉味方便面</td>
	                        <td class="one"style="border-right:1px solid #fff;"><span style="margin-right:5px;">固定</span><input type="text" class="gd" maxlength="5" onkeyup="value=value.replace(/[^\d.-]/g,'')" value="3" style="width:60px;"> 元</td>
	                        <td class="one"><span style="margin-right:5px;">比例</span><input type="text" class="bl" maxlength="5" onkeyup="value=value.replace(/[^\d.-]/g,'')" value="0" style="width:60px;"> %</td>
	                    </tr>
	                    <tr dataid="582">
	                        <td>康师傅香辣牛肉味方便面</td>
	                        <td class="one"style="border-right:1px solid #fff;"><span style="margin-right:5px;">固定</span><input type="text" class="gd" maxlength="5" onkeyup="value=value.replace(/[^\d.-]/g,'')" value="3" style="width:60px;"> 元</td>
	                        <td class="one"><span style="margin-right:5px;">比例</span><input type="text" class="bl" maxlength="5" onkeyup="value=value.replace(/[^\d.-]/g,'')" value="0" style="width:60px;"> %</td>
	                    </tr>--%>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

        <div class="adifoliBtn">
        <div class="SubmitButton" style="float: right;">
            <a class="bbgg" href="javascript:void(0)" onclick="SaveInfo();"><span class="bbgg bbgg1">
                保 存</span></a> <a class="bbgg" href="javascript:void(0)" onclick="OpenClose();"><span>
                    关 闭</span></a>
        </div>
    </div>
    </form>
</body>
</html>
