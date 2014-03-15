{**
 * block.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- user tools.
 *
 * $Id$
 *}
<div class="block" id="sidebarUser">
	{if !$implicitAuth}
		<span class="blockTitle">{translate key="navigation.user"}</span>
	{/if}
	
	{if $isUserLoggedIn}
		{translate key="plugins.block.user.loggedInAs"}<br />
		<strong>{$loggedInUsername|escape}</strong>
		<ul>
			{if $hasOtherJournals}
				<li><a href="{url journal="index" page="user"}">{translate key="plugins.block.user.myJournals"}</a></li>
			{/if}
			<li><a href="{url page="user" op="profile"}">{translate key="plugins.block.user.myProfile"}</a></li>
			<li><a href="{url page="login" op="signOut"}">{translate key="plugins.block.user.logout"}</a></li>
			{if $userSession->getSessionVar('signedInAs')}
				<li><a href="{url page="login" op="signOutAsUser"}">{translate key="plugins.block.user.signOutAsUser"}</a></li>
			{/if}
		</ul>
	{else}
		{if $implicitAuth}	
			<a href="{url page="login" op="implicitAuthLogin"}">Journals Login</a>		
		{else}
			<form class="form-inline" method="post" action="{$userBlockLoginUrl}">
				<table>
					<tr>
						<td><input placeholder="{translate key="user.username"}" class="form-control" type="text" id="sidebar-username" name="username" value="" size="12" maxlength="32" class="textField" /></td>
					</tr>
					<tr>
						<td><input placeholder="{translate key="user.password"}" class="form-control" type="password" id="sidebar-password" name="password" value="{$password|escape}" size="12" maxlength="32" class="textField" /></td>
					</tr>
					<tr>
						<td><input  type="checkbox" id="remember" name="remember" value="1" /> <label for="remember">{translate key="plugins.block.user.rememberMe"}</label></td>
					</tr>
					<tr>
						<td><input type="submit" value="{translate key="user.login"}" class="button" /></td>
					</tr>
				</table>
			</form>
		{/if}
	{/if}
</div>
