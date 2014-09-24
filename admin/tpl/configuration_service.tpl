<h1>Database settings</h1>
<form id="{$service}-form">
<table width="100%" border="0" cellspacing="0" cellpadding="5">
	<tr>
		<td align="right">Username</td>
		<td align="left"><input name="username" type="text" id="username" value="{$db.username}" size="32" maxlength="64" /></td>
	</tr>
	<tr>
		<td align="right">Password</td>
		<td align="left"><input type="password" name="password" id="password" value="{$db.password}" size="32" maxlength="64" /></td>
	</tr>
	<tr>
		<td align="right">Database Name</td>
		<td align="left"><input type="text" name="database" id="database" value="{$db.database}" size="32" maxlength="64" /></td>
	</tr>
    {if $service eq 'anope'}
	<tr>
		<td align="right">Database Prefix</td>
		<td align="left"><input type="text" name="prefix" id="prefix" value="{$db.prefix}" size="16" maxlength="64" /></td>
	</tr>
    {/if}
	<tr>
		<td align="right">Hostname</td>
		<td align="left"><input type="text" name="hostname" id="hostname" value="{$db.hostname}" size="32" maxlength="64" /></td>
	</tr>
	<tr>
		<td align="right">TCP Port</td>
		<td align="left"><input type="text" name="port" id="port" value="{$db.port}" size="32" maxlength="64" /></td>
	</tr>
	<tr>
		<td align="right">Enable SSL</td>
		<td align="left"><input type="checkbox" name="ssl" id="ssl" value="1" {if $db.ssl}checked="checked" {/if}/></td>
	</tr>
	<tr>
		<td align="right">Path to SSL Key</td>
		<td align="left"><input type="text" name="ssl_key" id="ssl_key" value="{$db.ssl_key}" size="32" maxlength="256" /></td>
	</tr>
	<tr>
		<td align="right">Path to SSL Certificate</td>
		<td align="left"><input type="text" name="ssl_cert" id="ssl_cert" value="{$db.ssl_cert}" size="32" maxlength="256" /></td>
	</tr>
	<tr>
		<td align="right">Path to SSL CA</td>
		<td align="left"><input type="text" name="ssl_ca" id="ssl_ca" value="{$db.ssl_ca}" size="32" maxlength="256" /></td>
	</tr>
	{if $service eq 'denora'}
        <tr>
            <td align="right">'current' table name</td>
            <td align="left"><input type="text" name="current" id="current" value="{$db.current|default:"current"}" size="32" maxlength="256" /></td>
        </tr>
        <tr>
            <td align="right">'maxvalues' table name</td>
            <td align="left"><input type="text" name="maxvalues" id="maxvalues" value="{$db.maxvalues|default:"maxvalues"}" size="32" maxlength="256" /></td>
        </tr>
        <tr>
            <td align="right">'user' table name</td>
            <td align="left"><input type="text" name="user" id="user" value="{$db.user|default:"user"}" size="32" maxlength="256" /></td>
        </tr>
        <tr>
            <td align="right">'server' table name</td>
            <td align="left"><input type="text" name="server" id="server" value="{$db.server|default:"server"}" size="32" maxlength="256" /></td>
        </tr>
        <tr>
            <td align="right">'stats' table name</td>
            <td align="left"><input type="text" name="stats" id="stats" value="{$db.stats|default:"stats"}" size="32" maxlength="256" /></td>
        </tr>
        <tr>
            <td align="right">'channelstats' table name</td>
            <td align="left"><input type="text" name="channelstats" id="channelstats" value="{$db.channelstats|default:"channelstats"}" size="32" maxlength="256" /></td>
        </tr>
        <tr>
            <td align="right">'serverstats' table name</td>
            <td align="left"><input type="text" name="serverstats" id="serverstats" value="{$db.serverstats|default:"serverstats"}" size="32" maxlength="256" /></td>
        </tr>
        <tr>
            <td align="right">'ustats' table name</td>
            <td align="left"><input type="text" name="ustats" id="ustats" value="{$db.ustats|default:"ustats"}" size="32" maxlength="256" /></td>
        </tr>
        <tr>
            <td align="right">'cstats' table name</td>
            <td align="left"><input type="text" name="cstats" id="cstats" value="{$db.cstats|default:"cstats"}" size="32" maxlength="256" /></td>
        </tr>
        <tr>
            <td align="right">'chan' table name</td>
            <td align="left"><input type="text" name="chan" id="chan" value="{$db.chan|default:"chan"}" size="32" maxlength="256" /></td>
        </tr>
        <tr>
            <td align="right">'ison' table name</td>
            <td align="left"><input type="text" name="ison" id="ison" value="{$db.ison|default:"ison"}" size="32" maxlength="256" /></td>
        </tr>
        <tr>
            <td align="right">'aliases' table name</td>
            <td align="left"><input type="text" name="aliases" id="aliases" value="{$db.aliases|default:"aliases"}" size="32" maxlength="256" /></td>
        </tr>
	{/if}
</table>

<pre>The configuration file <em>{$db_config_file}</em> is {if $writable}<span style="color:green;">writable</span>
{else}<span style="color:red;">not writable</span><br />Please ensure that it has enough write permissions. Try chmod 0666 or 0777.
{if $smarty.post.button}
<br />Alternatively, please copy the following text<br />and paste it into the {$db_config_file} file:<br />
<textarea name="sql_buffer" cols="64" rows="10" readonly="readonly">{$db_buffer}</textarea>
{/if}
{/if}
</pre>

<button id="{$service}-submit" type="button">Save</button>
</form>

<div id="{$service}-manual" style="display:none;">
	<br />MagIRC was unable to write the file.<br />Please create {$db_config_file} and paste the following code:
	<div id="{$service}-file" class="file"></div>
</div>

{jsmin}
<script type="text/javascript">
var service = '{$service}';
{literal}
$(document).ready(function() {
	$("#"+service+"-submit").button().click(function() {
		$("#"+service+"-form").ajaxSubmit({ url: 'index.php/configuration/'+service+'/database', type: 'post', success: function(data) {
			if (data) {
                $("#success").show().delay(1500).fadeOut(500);
            } else {
				$("#failure").show().delay(1500).fadeOut(500);
				$("#"+service+"-manual").show();

                var config = "<pre>&lt;?php\n$db = array(\n";
                var params = [];
                if (service == 'anope') {
                    params = ['username', 'password', 'database', 'hostname', 'port', 'prefix'];
                } else if (service == 'denora') {
                    params = ['username', 'password', 'database', 'hostname', 'port', 'current', 'maxvalues', 'user', 'server', 'stats', 'channelstats', 'serverstats', 'ustats', 'cstats', 'chan', 'ison', 'aliases'];
                }
                $.each(params, function(index, value){
                    config += "    '"+value+"' => \""+$("#"+value).val()+"\",\n";
                });
                config += ");</pre>";
				$("#"+service+"-file").html(config);
			}
		} });
	});
});
{/literal}
</script>
{/jsmin}