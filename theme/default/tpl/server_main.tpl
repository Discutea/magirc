{* $Id$ *}
{extends file="components/main.tpl"}
{block name="content"}
<div id="content">

{*<h2>Servers today</h2>*}
<script type="text/javascript" src="js/highstock.js"></script>
<div id="container" style="height: 350px; min-width: 700px"></div>

{*<h2>Server list</h2>*}
<table border="0" cellpadding="0" cellspacing="0" class="display">
<thead>
	<tr>
		<th>Status</th>
		<th>Server</th>
		<th>Description</th>
		<th>Users</th>
		<th>Operators</th>
	</tr>
</thead>
<tbody>
	<tr><td colspan="5">Loading...</td></tr>
</tbody>
</table>

</div>

<script type="text/javascript">
<!--
$(document).ready(function() {
    $.getJSON('rest/denora.php/servers/hourlystats', function(data) {
        window.chart = new Highcharts.StockChart({
            chart: {
                renderTo: 'container'
            },
			xAxis: {
				ordinal: false // Firefox hang workaround
			},
			yAxis: {
				min: 0
			},
            rangeSelector: {
                selected: 1
            },
            title: {
                text: 'Servers History'
            },
            series: [{
                name: 'Servers online',
                data: data,
                step: true,
                tooltip: {
                    valueDecimals: 0
                }
            }]
        });
    });
	$('.display').dataTable({
		"bJQueryUI": true,
		"bAutoWidth": false,
		"bProcessing": true,
		"bFilter": true,
		"bInfo": true,
		"bLengthChange": true,
		"bPaginate": true,
		"bSort": true,
		"bStateSave": false,
		"iDisplayLength": 10,
		"sPaginationType": "full_numbers",
		"aaSorting": [[ 1, "asc" ]],
		//TODO
		//"aoColumnDefs": [{ "sType": "natural", "aTargets": [ '_all' ] }],
		//"oLanguage": dtLang,
		"sAjaxSource": 'rest/denora.php/servers?format=datatables',
		"aoColumns": [
			{ "mDataProp": "online", "fnRender": function (oObj) { return oObj.aData['online'] ? '<img src="theme/default/img/status/online.png" alt="online" title="online" \/>' : '<img src="theme/default/img/status/offline.png" alt="offline" title="offline" \/>'; } },
			{ "mDataProp": "server", "fnRender": function (oObj) { return "<strong>" + oObj.aData['server'] + "<\/strong>"; } },
			{ "mDataProp": "comment" },
			{ "mDataProp": "currentusers" },
			{ "mDataProp": "opers" }
		]
	});
});
-->
</script>
{/block}