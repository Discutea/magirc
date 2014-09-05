<h1>{t 1=$target}Channel activity for %1{/t}</h1>

<form>
	<div id="radio" class="choser">
		<input type="radio" id="radio0" name="radio" value="total" /><label for="radio0">{t}Total{/t}</label>
		<input type="radio" id="radio1" name="radio" value="daily" /><label for="radio1">{t}Today{/t}</label>
		<input type="radio" id="radio2" name="radio" value="weekly" /><label for="radio2">{t}This Week{/t}</label>
		<input type="radio" id="radio3" name="radio" value="monthly" checked="checked" /><label for="radio3">{t}This Month{/t}</label>
	</div>
</form>

<div id="chart_activity" style="height: 225px;"></div>

<table id="tbl_activity" class="display clickable">
	<thead>
		<tr><th>{t}Nickname{/t}</th><th>{t}Letters{/t}</th><th>{t}Words{/t}</th><th>{t}Lines{/t}</th><th>{t}Actions{/t}</th><th>{t}Smileys{/t}</th><th>{t}Kicks{/t}</th><th>{t}Modes{/t}</th><th>{t}Topics{/t}</th></tr>
	</thead>
	<tbody>
		<tr><td colspan="9">{t}Loading{/t}...</td></tr>
	</tbody>
</table>

{jsmin}
<script type="text/javascript">
var target = '{$target|escape:'url'}';
{literal}
$(document).ready(function() {
	var type = 'monthly';
	var chart_activity = new Highcharts.Chart({
		chart: { renderTo: 'chart_activity', type: 'column' },
		xAxis: { type: 'linear', categories: [ 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23 ], title: { text: 'Hour' } },
		yAxis: { min: 0, title: { text: 'Lines' } },
		tooltip: { enabled: false },
		series: [{ name: 'Lines', data: [] }]
	});
	function updateChart() {
		$.getJSON('rest/service.php/channels/'+target+'/hourly/'+type, function(result) {
			chart_activity.series[0].setData(result);
		});
	}
	var table = $('#tbl_activity').dataTable({
		"serverSide": true,
		"pageLength": 10,
		"order": [[ 3, "desc" ]],
		"ajax": "rest/service.php/channels/"+target+"/activity/"+type+"?format=datatables",
		"columns": [
			{ "data": "uname", "render": function(data, type, row) {
				return getUserStatus(row) + ' ' + getCountryFlag(row) + ' ' + data + getUserExtra(row);
			} },
			{ "data": "letters" },
			{ "data": "words" },
			{ "data": "lines" },
			{ "data": "actions" },
			{ "data": "smileys" },
			{ "data": "kicks" },
			{ "data": "modes" },
			{ "data": "topics" }
		]
	});
	$("#tbl_activity tbody").on("click", "tr", function(event) {
		if (this.id) window.location = url_base + 'user/stats:' + encodeURIComponent(this.id) + '/profile#activity';
	});
	$("#radio").buttonset();
	$("#radio").change(function(event) {
		type = $('input[name=radio]:checked').val();
		table.ajax.url("rest/service.php/channels/"+target+"/activity/"+type+"?format=datatables").load();
		updateChart();
	});
	updateChart();
});
{/literal}
</script>
{/jsmin}
