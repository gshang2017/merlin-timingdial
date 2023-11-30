<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
		<meta HTTP-EQUIV="Expires" CONTENT="-1"/>
		<link rel="shortcut icon" href="images/favicon.png"/>
		<link rel="icon" href="images/favicon.png"/>
		<title>软件中心 - 定时拨号</title>
		<link rel="stylesheet" type="text/css" href="index_style.css"/>
		<link rel="stylesheet" type="text/css" href="form_style.css"/>
		<link rel="stylesheet" type="text/css" href="usp_style.css"/>
		<link rel="stylesheet" type="text/css" href="ParentalControl.css">
		<link rel="stylesheet" type="text/css" href="css/icon.css">
		<link rel="stylesheet" type="text/css" href="css/element.css">
		<script type="text/javascript" src="/state.js"></script>
		<script type="text/javascript" src="/popup.js"></script>
		<script type="text/javascript" src="/help.js"></script>
		<script type="text/javascript" src="/validator.js"></script>
		<script type="text/javascript" src="/js/jquery.js"></script>
		<script type="text/javascript" src="/general.js"></script>
		<script type="text/javascript" src="/switcherplugin/jquery.iphone-switch.js"></script>
		<script type="text/javascript" src="/dbconf?p=timingdial_&v=<% uptime(); %>"></script>
        <script type="text/javascript" src="/res/rsa.js"></script>
        <script type="text/javascript" src="/res/md5.js"></script>
		<script type="text/javascript" src="/res/sha1.js"></script>
		<style>
		.timingdial_btn {
			border: 1px solid #222;
			background: linear-gradient(to bottom, #003333  0%, #000000 100%); /* W3C */
			font-size:10pt;
			color: #fff;
			padding: 5px 5px;
			border-radius: 5px 5px 5px 5px;
			width:16%;
		}
		.timingdial_btn:hover {
			border: 1px solid #222;
			background: linear-gradient(to bottom, #27c9c9  0%, #279fd9 100%); /* W3C */
			font-size:10pt;
			color: #fff;
			padding: 5px 5px;
			border-radius: 5px 5px 5px 5px;
			width:16%;
		}
		.timingdial_btn_update {
			font-size:10pt;
			  color: #FC0;
		}
		.timingdial_btn_update:hover  {
			font-size:10pt;
			  color: #FC0;
		}

		input[type=button]:focus {
			outline: none;
		}
		.show-btn1, .show-btn2, .show-btn3 {
			border: 1px solid #222;
			border-bottom:none;
			background: linear-gradient(to bottom, #919fa4  0%, #67767d 100%); /* W3C */
			font-size:10pt;
			color: #fff;
			padding: 10px 3.75px;
			border-radius: 5px 5px 0px 0px;
			width:8.45601%;
		}
		.show-btn1:hover, .show-btn2:hover, .show-btn3:hover, .active {
			background: #2f3a3e;
		}
		.input_timingdial_table{
			margin-left:2px;
			padding-left:0.4em;
			height:21px;
			width:158.2px;
			line-height:23px \9;	/*IE*/
			font-size:13px;
			font-family: Lucida Console;
			background-image:none;
			background-color: #576d73;
			border:1px solid gray;
			color:#FFFFFF;
		}
		.SimpleNote { padding:5px 10px;}
		.input_option{
			height:25px;
			background-color:#576D73;
			border-top-width:1px;
			border-bottom-width:1px;
			border-color:#888;
			color:#FFFFFF;
			font-family: Lucida Console;
			font-size:13px;
		}
		</style>		
        <script type="text/javascript">
		var _responseLen;
		var noChange = 0;
		var x = 5;
		function init() {
			show_menu();
			buildswitch();		
			conf2obj();		
			timingdial_perp_set();
			timingdial_refresh_time_set();
		}
		function conf2obj(){
			var rrt = document.getElementById("switch");
			if (document.form.timingdial_enable.value != "1") {
				document.getElementById('timingdial_detail_table').style.display = "none";
				rrt.checked = false;
			} else {
				document.getElementById('timingdial_detail_table').style.display = "";
				rrt.checked = true;
			}
		}		
		function buildswitch(){
			$("#switch").click(
			function(){
				if(document.getElementById('switch').checked){
					document.form.timingdial_enable.value = 1;
					document.getElementById('timingdial_detail_table').style.display = "";
				}else{
					document.form.timingdial_enable.value = 0;
					document.getElementById('timingdial_detail_table').style.display = "none";
				}
			});
		}
		
		function onSubmitCtrl(o, s) {
			document.form.action_mode.value = s;
			showLoading(10);
			document.form.submit();
			setTimeout("location.reload(true);", 10000);
		}

		function  timingdial_refresh_time_set() {
			check_selected("timingdial_wan0_ipaddr_prefix_set", db_timingdial_.timingdial_wan0_ipaddr_prefix_set);
			check_selected("timingdial_dial_num_set", db_timingdial_.timingdial_dial_num_set);
			check_selected("timingdial_refresh_set", db_timingdial_.timingdial_refresh_set);			
			check_selected("timingdial_refresh_time_min_set", db_timingdial_.timingdial_refresh_time_min_set);
			check_selected("timingdial_refresh_time_hour_set", db_timingdial_.timingdial_refresh_time_hour_set);
			check_selected("timingdial_refresh_time_day_set", db_timingdial_.timingdial_refresh_time_day_set);
			check_selected("timingdial_refresh_time_month_set", db_timingdial_.timingdial_refresh_time_month_set);
			check_selected("timingdial_refresh_time_week_set", db_timingdial_.timingdial_refresh_time_week_set);			
		}		
	    function  timingdial_perp_set() {
			check_selected("timingdial_perp_set", db_timingdial_.timingdial_perp_set);
}
		function check_selected(obj, m) {
			var o = document.getElementById(obj);
			for (var c = 0; c < o.length; c++) {
				if (o.options[c].value == m) {
					o.options[c].selected = true;
				break;
				}
			}
		}
		
		function timingdial_update(){
		  var dbus = {};
		  dbus["SystemCmd"] = "timingdial_update.sh";
		  dbus["action_mode"] = " Refresh ";
		  dbus["current_page"] = "Module_timingdial.asp";
		  jQuery.noConflict().ajax({
			type: "POST",
			url: '/applydb.cgi?p=timingdial_',
			contentType: "application/x-www-form-urlencoded",
			dataType: 'text',
			data: dbus,
			success: function(response) {
				showtimingdialPluginLoadingBar();
				noChange = 0;
				setTimeout("get_realtime_log()", 500);
			}
		  });
		}
		
		function showtimingdialPluginLoadingBar(seconds) {
		  if (window.scrollTo)
			window.scrollTo(0, 0);

		  disableCheckChangedStatus();

		  htmlbodyforIE = document.getElementsByTagName("html"); //this both for IE&FF, use "html" but not "body" because <!DOCTYPE html PUBLIC.......>
		  htmlbodyforIE[0].style.overflow = "hidden"; //hidden the Y-scrollbar for preventing from user scroll it.

		  winW_H();

		  var blockmarginTop;
		  var blockmarginLeft;
		  if (window.innerWidth)
			winWidth = window.innerWidth;
		  else if ((document.body) && (document.body.clientWidth))
			winWidth = document.body.clientWidth;

		  if (window.innerHeight)
			winHeight = window.innerHeight;
		  else if ((document.body) && (document.body.clientHeight))
			winHeight = document.body.clientHeight;

		  if (document.documentElement && document.documentElement.clientHeight && document.documentElement.clientWidth) {
			winHeight = document.documentElement.clientHeight;
			winWidth = document.documentElement.clientWidth;
		  }

		  if (winWidth > 1050) {

			winPadding = (winWidth - 1050) / 2;
			winWidth = 1105;
			blockmarginLeft = (winWidth * 0.3) + winPadding - 150;
		  } else if (winWidth <= 1050) {
			blockmarginLeft = (winWidth) * 0.3 + document.body.scrollLeft - 160;

		  }

		  if (winHeight > 660)
			winHeight = 660;

		  blockmarginTop = winHeight * 0.3 - 140

		  document.getElementById("loadingBarBlock").style.marginTop = blockmarginTop + "px";
		  document.getElementById("loadingBarBlock").style.marginLeft = blockmarginLeft + "px";
		  document.getElementById("loadingBarBlock").style.width = 770 + "px";
		  document.getElementById("LoadingBar").style.width = winW + "px";
		  document.getElementById("LoadingBar").style.height = winH + "px";

		  loadingSeconds = seconds;
		  progress = 100 / loadingSeconds;
		  y = 0;
		  LoadingtimingdialPluginProgress(seconds);
		}
		
		function LoadingtimingdialPluginProgress(seconds) {
		  document.getElementById("LoadingBar").style.visibility = "visible";
		  document.getElementById("loading_block3").innerHTML = "timingdial插件更新中 ..."
		  document.getElementById("loading_block2").innerHTML = "<li><font color='#ffcc00'>请等待日志显示完毕，并出现自动关闭按钮！</font></li><li><font color='#ffcc00'>在此期间请不要刷新本页面，不然可能导致问题！</font></li>"
		}
		
		function hidetimingdialLoadingBar() {
		  x = -1;
		  E("LoadingBar").style.visibility = "hidden";
		  refreshpage();
		}

		function count_down_close() {
		  if (x == "0") {
			hidetimingdialLoadingBar();
		  }
		  if (x < 0) {
			E("ok_button1").value = "手动关闭"
			return false;
		  }
		  E("ok_button1").value = "自动关闭（" + x + "）"
			--x;
		  setTimeout("count_down_close();", 1000);
		}

		function E(e) {
		  return (typeof(e) == 'string') ? document.getElementById(e) : e;
		}

		function get_realtime_log() {
		  jQuery.noConflict().ajax({
			url: '/cmdRet_check.htm',
			dataType: 'html',
			error: function(xhr) {
			  setTimeout("get_realtime_log();", 1000);
			},
			success: function(response) {
			  var retArea = E("log_content3");
			  if (response.search("XU6J03M6") != -1) {
				retArea.value = response.replace("XU6J03M6", " ");
				E("ok_button").style.display = "";
				retArea.scrollTop = retArea.scrollHeight;
				x = 5;
				count_down_close();
				return true;
			  } else {
				E("ok_button").style.display = "none";
			  }
			  if (_responseLen == response.length) {
				noChange++;
			  } else {
				noChange = 0;
			  }
			  if (noChange > 1000) {
				return false;
			  } else {
				setTimeout("get_realtime_log();", 250);
			  }
			  retArea.value = response.replace("XU6J03M6", " ");
			  retArea.scrollTop = retArea.scrollHeight;
			  _responseLen = response.length;
			},
			error: function() {
			  setTimeout("get_realtime_log();", 500);
			}
		  });
		}
			


		function reload_Soft_Center() {
			location.href = "/Main_Soft_center.asp";
		}
        </script>
    </head>
    <body onload="init();">
		<div id="TopBanner"></div>
		<div id="Loading" class="popup_bg"></div>
		<div id="LoadingBar" class="popup_bar_bg">
		<table cellpadding="5" cellspacing="0" id="loadingBarBlock" class="loadingBarBlock"  align="center">
			<tr>
			  <td height="100">
			  <div id="loading_block3" style="margin:10px auto;margin-left:10px;width:85%; font-size:12pt;"></div>
			  <div id="loading_block2" style="margin:10px auto;width:95%;"></div>
			  <div id="log_content2" style="margin-left:15px;margin-right:15px;margin-top:10px;overflow:hidden">
				<textarea cols="63" rows="21" wrap="on" readonly="readonly" id="log_content3" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" style="border:1px solid #000;width:99%; font-family:'Lucida Console'; font-size:11px;background:#000;color:#FFFFFF;outline: none;padding-left:3px;padding-right:22px;overflow-x:hidden"></textarea>
			  </div>
			  <div id="ok_button" class="apply_gen" style="background: #000;display: none;">
				<input id="ok_button1" class="button_gen" type="button" onclick="hidetimingdialLoadingBar()" value="确定">
			  </div>
			  </td>
			</tr>
		</table>
		</div>
		<iframe name="hidden_frame" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>
		<form method="post" name="form" action="/applydb.cgi?p=timingdial_" target="hidden_frame">
			<input type="hidden" name="current_page" value="Module_timingdial.asp"/>
			<input type="hidden" name="next_page" value="Module_timingdial.asp"/>
			<input type="hidden" name="group_id" value=""/>
			<input type="hidden" name="modified" value="0"/>
			<input type="hidden" name="action_mode" value=""/>
			<input type="hidden" name="action_script" value=""/>
			<input type="hidden" name="action_wait" value="5"/>
			<input type="hidden" name="first_time" value=""/>
			<input type="hidden" name="preferred_lang" id="preferred_lang" value="<% nvram_get("preferred_lang"); %>"/>
			<input type="hidden" name="SystemCmd" onkeydown="onSubmitCtrl(this, ' Refresh ')" value="timingdial_config.sh"/>
			<input type="hidden" name="firmver" value="<% nvram_get("firmver"); %>"/>
			<input type="hidden" id="timingdial_enable" name="timingdial_enable" value='<% dbus_get_def("timingdial_enable", "0"); %>'/>
			<table class="content" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td width="17">&nbsp;</td>
					<td valign="top" width="202">
						<div id="mainMenu"></div>
						<div id="subMenu"></div>
					</td>
					<td valign="top">
						<div id="tabMenu" class="submenuBlock"></div>
						<table width="98%" border="0" align="left" cellpadding="0" cellspacing="0">
							<tr>
								<td align="left" valign="top">
									<table width="760px" border="0" cellpadding="5" cellspacing="0" bordercolor="#6b8fa3" class="FormTitle" id="FormTitle">
										<tr>
											<td bgcolor="#4D595D" colspan="3" valign="top">
												<div>&nbsp;</div>
												<div style="float:left;" class="formfonttitle">定时拨号</div>
												<div style="float:right; width:15px; height:25px;margin-top:10px"><img id="return_btn" onclick="reload_Soft_Center();" align="right" style="cursor:pointer;position:absolute;margin-left:-30px;margin-top:-25px;" title="返回软件中心" src="/images/backprev.png" onMouseOver="this.src='/images/backprevclick.png'" onMouseOut="this.src='/images/backprev.png'"></img></div>
                                                <div style="margin-left:5px;margin-top:10px;margin-bottom:10px"><img src="/images/New_ui/export/line_export.png"></div>
                                                <div class="formfontdesc" style="padding-top:5px;margin-top:0px;float: left;" id="cmdDesc">
                                                <ul style="padding-top:5px;margin-top:10px;float: left;">
                                                <li>支持定时拨号</li>
												<li>支持获取特定前缀的拨号IP地址，默认重拨直到符合设定的IP地址</li>
                                                </ul>
                                                </div>
                                                <!--<div class="formfontdesc" id="cmdDesc"></div>-->
												<table style="margin:10px 0px 0px 0px;" width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable" id="routing_table">
													<thead>
													<tr>
														<td colspan="2">开关设置</td>
													</tr>
													</thead>
													<tr>
													<th>开启定时拨号</th>
														<td colspan="2">
															<div class="switch_field" style="display:table-cell;float: left;">
																<label for="switch">
																	<input id="switch" class="switch" type="checkbox" style="display: none;">
																	<div class="switch_container" >
																		<div class="switch_bar"></div>
																		<div class="switch_circle transition_style">
																			<div></div>
																		</div>
																	</div>
																	
																</label>

															</div>
                                                            <div id="timingdial_version_status" style="padding-top:5px;margin-left:30px;margin-top:0px;float:left;">
                                                                <i>当前版本：<% dbus_get_def("timingdial_version", "未知"); %>&nbsp;&nbsp;<a type="button"  target="_blank" href="https://github.com/gshang2017/merlin-timingdial"><em>【<u>插件主页</u>】</em></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id="timingdial_update" type="button" class="timingdial_btn" style="cursor:pointer" onclick="timingdial_update()">检查并更新</a></i>
                                                            </div>
													</td>
													</tr>
		                                    	</table>
												<table style="margin:10px 0px 0px 0px;" width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable" id="timingdial_detail_table">
													
													<thead>
													<tr>
														<td colspan="2">基本设置</td>
													</tr>
													</thead>
													<tr>
														<th width="35%">需求的IP地址前缀</th>
														<td>
															<input type="text" class="input_timingdial_table" style="width:auto;" size="4" id="timingdial_wan0_ipaddr_prefix_set" name="timingdial_wan0_ipaddr_prefix_set" maxlength="5" value='<% dbus_get_def("timingdial_wan0_ipaddr_prefix_set","0" ); %>' >
															<i>&nbsp;&nbsp;当前拨号IP地址：<% nvram_get("wan0_ipaddr", "未连网"); %></i>
														</td>
													</tr>
													<tr>
														<th width="35%">最大拨号次数</th>
														<td>
															<input type="text" class="input_timingdial_table" style="width:auto;" size="4" id="timingdial_dial_num_set" name="timingdial_dial_num_set" maxlength="5" value='<% dbus_get_def("timingdial_dial_num_set","5" ); %>' >
															<i>&nbsp;&nbsp;重拔次数</i>
														</td>
													</tr>
		                                    	    <tr>
													    <th width="35%">更新时间</th>
														<td>
															<select id="timingdial_refresh_set" name="timingdial_refresh_set" class="input_option"  >
																<option	value="1">拨号</option>																
																<option	value="2">监控</option>
																<option	value="3">全部</option>
															</select>
															<i>分钟</i>
															<select id="timingdial_refresh_time_min_set" name="timingdial_refresh_time_min_set" class="input_option"  >
																<option	value="0">0分</option>
																<option	value="1">1分</option>
																<option	value="2">2分</option>
																<option	value="3">3分</option>
																<option	value="4">4分</option>
																<option	value="5">5分</option>
																<option	value="6">6分</option>
																<option	value="7">7分</option>
																<option	value="8">8分</option>
																<option	value="9">9分</option>
																<option	value="10">10分</option>
																<option	value="11">11分</option>
																<option	value="12">12分</option>
																<option	value="13">13分</option>
																<option	value="14">14分</option>
																<option	value="15">15分</option>
																<option	value="16">16分</option>
																<option	value="17">17分</option>
																<option	value="18">18分</option>
																<option	value="19">19分</option>
																<option	value="20">20分</option>
																<option	value="21">21分</option>
																<option	value="22">22分</option>
																<option	value="23">23分</option>
																<option	value="24">24分</option>
																<option	value="25">25分</option>
																<option	value="26">26分</option>
																<option	value="27">27分</option>
																<option	value="28">28分</option>
																<option	value="29">29分</option>
																<option	value="30">30分</option>
																<option	value="31">31分</option>
																<option	value="32">32分</option>
																<option	value="33">33分</option>
																<option	value="34">34分</option>
																<option	value="35">35分</option>
																<option	value="36">36分</option>
																<option	value="37">37分</option>
																<option	value="38">38分</option>
																<option	value="39">39分</option>
																<option	value="40">40分</option>
																<option	value="41">41分</option>
																<option	value="42">42分</option>
																<option	value="43">43分</option>
																<option	value="44">44分</option>
																<option	value="45">45分</option>
																<option	value="46">46分</option>
																<option	value="47">47分</option>
																<option	value="48">48分</option>
																<option	value="49">49分</option>
																<option	value="50">50分</option>
																<option	value="51">51分</option>
																<option	value="52">52分</option>
																<option	value="53">53分</option>
																<option	value="54">54分</option>
																<option	value="55">55分</option>
																<option	value="56">56分</option>
																<option	value="57">57分</option>
																<option	value="58">58分</option>
																<option	value="59">59分</option>
															</select>
															<i>&nbsp;&nbsp;小时</i>															
															<select id="timingdial_refresh_time_hour_set" name="timingdial_refresh_time_hour_set" class="input_option"  >
																<option	value="0">0时</option>
																<option	value="1">1时</option>
																<option	value="2">2时</option>
																<option	value="3">3时</option>
																<option	value="4">4时</option>
																<option	value="5">5时</option>
																<option	value="6">6时</option>
																<option	value="7">7时</option>
																<option	value="8">8时</option>
																<option	value="9">9时</option>
																<option	value="10">10时</option>
																<option	value="11">11时</option>
																<option	value="12">12时</option>
																<option	value="13">13时</option>
																<option	value="14">14时</option>
																<option	value="15">15时</option>
																<option	value="16">16时</option>
																<option	value="17">17时</option>
																<option	value="18">18时</option>
																<option	value="19">19时</option>
																<option	value="20">20时</option>
																<option	value="21">21时</option>
																<option	value="22">22时</option>
															</select>
															<i>&nbsp;&nbsp;天</i>	
															<select id="timingdial_refresh_time_day_set" name="timingdial_refresh_time_day_set" class="input_option"  >
																<option	value="*">每天</option>
																<option	value="1">1日</option>
																<option	value="2">2日</option>
																<option	value="3">3日</option>
																<option	value="4">4日</option>
																<option	value="5">5日</option>
																<option	value="6">6日</option>
																<option	value="7">7日</option>
																<option	value="8">8日</option>
																<option	value="9">9日</option>
																<option	value="10">10日</option>
																<option	value="11">11日</option>
																<option	value="12">12日</option>
																<option	value="13">13日</option>
																<option	value="14">14日</option>
																<option	value="15">15日</option>
																<option	value="16">16日</option>
																<option	value="17">17日</option>
																<option	value="18">18日</option>
																<option	value="19">19日</option>
																<option	value="20">20日</option>
																<option	value="21">21日</option>
																<option	value="22">22日</option>
																<option	value="23">23日</option>
																<option	value="24">24日</option>
																<option	value="25">25日</option>
																<option	value="26">26日</option>
																<option	value="27">27日</option>
																<option	value="28">28日</option>
																<option	value="29">29日</option>
																<option	value="30">30日</option>
																<option	value="31">31日</option>
															</select>
															<i>&nbsp;&nbsp;月</i>
															<select id="timingdial_refresh_time_month_set" name="timingdial_refresh_time_month_set" class="input_option"  >
																<option	value="*">每月</option>												
																<option	value="1">1月</option>
																<option	value="2">2月</option>
																<option	value="3">3月</option>
																<option	value="4">4月</option>
																<option	value="5">5月</option>
																<option	value="6">6月</option>
																<option	value="7">7月</option>
																<option	value="8">8月</option>
																<option	value="9">9月</option>
																<option	value="10">10月</option>
																<option	value="11">11月</option>
																<option	value="12">12月</option>
															</select>
															<i>&nbsp;&nbsp;星期</i>	
															<select id="timingdial_refresh_time_week_set" name="timingdial_refresh_time_week_set" class="input_option"  >
																<option	value="*">每周</option>
																<option	value="0">日</option>																
																<option	value="1">一</option>
																<option	value="2">二</option>
																<option	value="3">三</option>
																<option	value="4">四</option>
																<option	value="5">五</option>
																<option	value="6">六</option>
															</select>
														</td>														
													</tr>											
		                                    	    <tr>
													    <th width="35%">守护进程</th>
														<td>
                                                           <select   id="timingdial_perp_set" name="timingdial_perp_set" class="input_option"  >
       						                           		<option value="0">关闭</option>
							                           		<option value="1">每分钟</option>
							                           		<option value="2">每10分钟</option>
								                           	<option value="3">每30分钟</option>
								                           	<option value="4">每1小时</option>
							                           	   </select>
														</td>
													</tr>

												</table>
												<div id="warn"class="SimpleNote">
													<i><li>设置需求的IP地址前缀，可以检查拨号获取的IP地址，默认重拨直到符合设定的IP地址，支持（0-255），默认为：0（不开启此功能）</li></i>
													<i><li>设置最大拨号次数，默认最多重拨5次，支持（1-15），其它值无效</li></i>
													<i><li>设置更新时间［拨号］，可以定时拨号</li></i>
													<i><li>设置更新时间［监控］，可以定时监控拨号IP地址</li></li>
													<i><li>设置更新时间［全部］，可以定时拨号和监控拨号IP地址</li></i>
													<i><li>开启守护进程后根据设置时间（建议每10分钟）检测cron任务，防止cron任务丢失导致程序无法正常运行。</li></li>
												</div>
												<div style="margin-left:5px;margin-top:10px;margin-bottom:10px"><img src="/images/New_ui/export/line_export.png"></div>
												<div class="apply_gen">
													<button id="cmdBtn" class="button_gen" onclick="onSubmitCtrl(this, ' Refresh ')">提交</button>
												</div>											
											</td>
										</tr>
									</table>
								</td>
								<td width="10" align="center" valign="top"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
		<div id="footer"></div>
    </body>
</html>
