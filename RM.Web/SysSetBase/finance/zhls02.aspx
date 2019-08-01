﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="zhls02.aspx.cs" Inherits="RM.Web.SysSetBase.finance.zhls02" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>账户流水</title>
    <meta name="viewport" content="width=device-width, user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" />
    <meta content="always" name="referrer">
    <link href="/SysSetBase/css/reset.css" rel="stylesheet" type="text/css" />
    <link href="/SysSetBase/css/backer.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="gtall gmkf clearfix">
        <div class="gmkfNav">
            <dl>
                <dd class="">
                    <b>美思柏丽酒店</b>
                    <ul style="display: none;">
                        <li><span>鹤山前进南路店</span> </li>
                        <li><span>佛山文华北路店</span> </li>
                        <li><span>恩平鳌峰广场店</span> </li>
                        <li><span>鹤山中心店</span> </li>
                    </ul>
                </dd>
            </dl>
        </div>
        <div class="shareright">
            <div class="zhls">
                <div class="zhlst">
                    <span class="s1">酒店总收入</span><em>￥</em><span class="s2">93,620.00</span>
                </div>
                <div class="zhlsb">
                    <span>
                        <em>客房销售收入</em>
                        <b>15，947.00</b>
                    </span>
                    <span>
                        <em>会员卡充值收入</em>
                        <b>15，947.00</b>
                    </span>
                </div>
                
            </div>
            <div class="ptb8 clearfix">
                <div class="sharedate">
                    <input type="text" placeholder="2018-01-13 00:00">
                    <input type="text" placeholder="2018-01-14 00:00">
                </div>
                <div class="zhls01">
                    期间：<span><b>总收入（元）</b><em>2,563.00</em><b>（客房销售 <em>3,000.00</em>， 会员卡充值收入 <em>300,000.00</em>）</b></span>
                </div>
                <div class="wdyhd" style="padding-right: 12px;">
                    <div class="r">
                        <span onclick="">导出</span>
                    </div>
                </div>
            </div>
            
            <div class="sharetabs" style="display:none;">
                <ul class="clearfix">
                    <li class="act">
                        总收入
                    </li>
                    <li>
                        总支出
                    </li>
                </ul>
            </div>
        </div>
    </div>
    </form>
    <script src="/SysSetBase/css/jquery.js" type="text/javascript"></script>
    <script type="text/javascript">
        //左边导航
        $('.gmkfNav').on('click', 'b', function () {
            $(this).siblings('ul').slideToggle(120);
            $(this).parents('dd').toggleClass('down');
        });
        $(".gmkfNav").panel({ iWheelStep: 80 });
    </script>
</body>
</html>
