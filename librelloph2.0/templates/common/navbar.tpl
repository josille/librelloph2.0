{** * navbar.tpl * * Copyright (c) 2003-2012 John Willinsky *
Distributed under the GNU GPL v2. For full terms see the file
docs/COPYING. * * Navigation Bar * *}


<div id="navbar">{if $isUserLoggedIn}
<div style="position: relative; float: right; bottom: 10px;">{translate
key="plugins.block.user.loggedInAs"} <strong>{$loggedInUsername|escape}</strong>
</div>
{/if}
<div>
<hr />
</div>
<div class="dropdown">

<ul class="nav nav-pills menu_top">
	{if $currentJournal && $currentJournal->getSetting('publishingMode') !=
	$smarty.const.PUBLISHING_MODE_NONE} {if !$currentJournal}
	<li id="librello"><a itemprop="url" href="{$baseUrl}">librello</a></li>
	{else}
	<li id="librello"><a href="{$baseUrl}"><span
		itemprop="publisher" itemscope
		itemtype="http://schema.org/Organization"> <span itemprop="name">librello</span></span></a></li>
	{/if}
	<li class='spaces_test'>&#183;</li>
	{/if}
	<li id="home"><a itemprop="url" href="{url page="index"}">{translate
	key="navigation.home"}</a></li>
	<li class='spaces_test'>&#183;</li>
		
	{if $currentJournal && $currentJournal->getSetting('publishingMode') !=
	$smarty.const.PUBLISHING_MODE_NONE}
	
	<li id="about" class="dropdown"><a class="dropdown-toggle"
		data-toggle="dropdown" href="{url page="about"}">{translate
	key="navigation.about"}<span class="caret"></span></a>
	
	<ul class="dropdown-menu" role="menu">
		<li class="dropdown-submenu"><a href="#">{translate
		key="about.people"}</a>
		<ul class="dropdown-menu" role="menu">
			<li><a href="{url page=" about" op="contact"}">{translate
			key="about.contact"}</a></li>

			<li><a href="{url page=" about" op="editorialTeam"}">{translate
			key="about.editorialTeam"}</a></li>
			{iterate from=peopleGroups item=peopleGroup}
			<li><a href="{url page=" about" op="displayMembership"
				path=$peopleGroup->getId()}">{$peopleGroup->getLocalizedTitle()|escape}</a></li>
			{/iterate} {call_hook name="Templates::About::Index::People"}
		</ul>
		</li>
		<li class="dropdown-submenu"><a href="#">{translate
		key="about.policies"}</a>
		<ul class="dropdown-menu" role="menu">
			{if $currentJournal->getLocalizedSetting('focusScopeDesc') != ''}
			<li><a href="{url page=" about" op="editorialPolicies"
				anchor="focusAndScope"}">{translate key="about.focusAndScope"}</a></li>
			{/if}
			<li><a href="{url page=" about" op="editorialPolicies"
				anchor="sectionPolicies"}">{translate key="about.sectionPolicies"}</a></li>
			{if $currentJournal->getLocalizedSetting('reviewPolicy') != ''}
			<li><a href="{url page=" about"  op="editorialPolicies"
				anchor="peerReviewProcess"}">{translate
			key="about.peerReviewProcess"}</a></li>
			{/if} {if $currentJournal->getLocalizedSetting('pubFreqPolicy') !=
			''}
			<li><a href="{url page=" about"  op="editorialPolicies"
				anchor="publicationFrequency"}">{translate
			key="about.publicationFrequency"}</a></li>
			{/if} {if $currentJournal->getSetting('publishingMode') ==
			$smarty.const.PUBLISHING_MODE_OPEN &&
			$currentJournal->getLocalizedSetting('openAccessPolicy') != ''}
			<li><a href="{url page=" about"  op="editorialPolicies"
				anchor="openAccessPolicy"}">{translate key="about.openAccessPolicy"}</a></li>
			{/if} {if $journalSettings.enableLockss &&
			$currentJournal->getLocalizedSetting('lockssLicense') != ''}
			<li><a href="{url page=" about"  op="editorialPolicies"
				anchor="archiving"}">{translate key="about.archiving"}</a></li>
			{/if} {if $paymentConfigured &&
			$journalSettings.journalPaymentsEnabled &&
			$journalSettings.membershipFeeEnabled &&
			$journalSettings.membershipFee > 0}
			<li><a href="{url page=" about"  op="memberships"}">{translate
			key="about.memberships"}</a></li>
			{/if} {if $currentJournal->getSetting('publishingMode') ==
			$smarty.const.PUBLISHING_MODE_SUBSCRIPTION}
			<li><a href="{url op="subscriptions"}">{translate
			key="about.subscriptions"}</a></li>
			{if !empty($journalSettings.enableAuthorSelfArchive)}
			<li><a href="{url  page=" about" op="editorialPolicies"
				anchor="authorSelfArchivePolicy"}">{translate
			key="about.authorSelfArchive"}</a></li>
			{/if} {if !empty($journalSettings.enableDelayedOpenAccess)}
			<li><a href="{url  page=" about" op="editorialPolicies"
				anchor="delayedOpenAccessPolicy"}">{translate
			key="about.delayedOpenAccess"}</a></li>
			{/if} {/if}{* $currentJournal->getSetting('publishingMode') ==
			$smarty.const.PUBLISHING_MODE_SUBSCRIPTION *} {foreach key=key
			from=$customAboutItems item=customAboutItem} {if
			$customAboutItem.title!=''}
			<li><a href="{url  page=" about" op="editorialPolicies"
				anchor=custom-$key}">{$customAboutItem.title|escape}</a></li>
			{/if} {/foreach} {call_hook name="Templates::About::Index::Policies"}
		</ul>
		</li>
		<li class="dropdown-submenu"><a href="#">{translate
		key="about.submissions"}</a>
		<ul class="dropdown-menu" role="menu">
			<li><a href="{url page=" about" op="submissions"
				anchor="onlineSubmissions"}">{translate
			key="about.onlineSubmissions"}</a></li>
			{if $currentJournal->getLocalizedSetting('authorGuidelines') != ''}
			<li><a href="{url page=" about" op="submissions"
				anchor="authorGuidelines"}">{translate key="about.authorGuidelines"}</a></li>
			<li><a href="{url page=" pages" op="view"}/guidelinesreviewers">Guidelines
			for Reviewers</a></li>
			{/if} {if $currentJournal->getLocalizedSetting('copyrightNotice') !=
			''}
			<li><a href="{url page=" about" op="submissions"
				anchor="copyrightNotice"}">{translate key="about.copyrightNotice"}</a></li>
			{/if} {if $currentJournal->getLocalizedSetting('privacyStatement') !=
			''}
			<li><a href="{url page=" about" op="submissions"
				anchor="privacyStatement"}">{translate key="about.privacyStatement"}</a></li>
			{/if} {if $currentJournal->getSetting('journalPaymentsEnabled') &&
			($currentJournal->getSetting('submissionFeeEnabled') ||
			$currentJournal->getSetting('fastTrackFeeEnabled') ||
			$currentJournal->getSetting('publicationFeeEnabled'))}
			<li><a href="{url page=" about" op="submissions" anchor="authorFees"}">{translate
			key="about.authorFees"}</a></li>
			{/if} {call_hook name="Templates::About::Index::Submissions"}
		</ul>
		</li>
		<li><a href="{url page='pages" op='view'}/indexArchive">Indexing and
		Archiving</a></li>
		<li class="dropdown-submenu"><a href="#">{translate key="about.other"}</a>
		<ul class="dropdown-menu" role="menu">
			{if not ($currentJournal->getSetting('publisherInstitution') == '' &&
			$currentJournal->getLocalizedSetting('publisherNote') == '' &&
			$currentJournal->getLocalizedSetting('contributorNote') == '' &&
			empty($journalSettings.contributors) &&
			$currentJournal->getLocalizedSetting('sponsorNote') == '' &&
			empty($journalSettings.sponsors))}
			<li><a href="{url page=" about" op="journalSponsorship"}">{translate
			key="about.journalSponsorship"}</a></li>
			{/if} {if $currentJournal->getLocalizedSetting('history') != ''}
			<li><a href="{url page=" about" op="history"}">{translate
			key="about.history"}</a></li>
			{/if}
			<li><a href="{url page=" about" op="siteMap"}">{translate
			key="about.siteMap"}</a></li>
			<li><a href="{url page=" about" op="aboutThisPublishingSystem"}">{translate
			key="about.aboutThisPublishingSystem"}</a></li>
			{if $publicStatisticsEnabled}
			<li><a href="{url page=" about" op="statistics"}">{translate
			key="about.statistics"}</a></li>
			{/if} {call_hook name="Templates::About::Index::Other"}
		</ul>
		</li>
	</ul>
	{else}
	
	<li id="about"><a href="{url page="about"}">{translate
	key="navigation.about"}</a>
	
	{/if}
	
	</li>
	{if !$currentJournal}
	<li class='spaces_test'>&#183;</li>
	<li id="forauthors"><a href="{url page="forauthors"}">{translate
	key="navigation.forauthors"}</a></li>
	<li class='spaces_test'>&#183;</li>
	<li id="membership" class="dropdown"><a class="dropdown-toggle"
		data-toggle="dropdown" href="#">{translate
	key="navigation.membership"}<span class="caret"></span></a>
	<ul class="dropdown-menu" role="menu">
		<li><a href="{url page="membership"}">Become a member</a></li>
		<li id="membershipList"><a href="{url page="membershipList"}">Members
		list</a></li>
	</ul>
	</li>
	<li class='spaces_test'>&#183;</li>
	<li id="contact"><a href="{url page="indexing"}">{translate
	key="navigation.indexing"}</a></li>
	<li class='spaces_test'>&#183;</li>
	<li id="contact"><a href="{url page="contact"}">{translate
	key="navigation.contact"}</a></li>
	<li class='spaces_test'>&#183;</li>
	<li id="privacy"><a href="{url page="privacy"}">{translate
	key="navigation.privacy"}</a></li>
	{else}
	<li class='spaces_test'>&#183;</li>
	<li><a href="{url page=" about" op="editorialTeam"}">{translate
	key="about.editorialTeam"}</a></li>
	{/if} {if $isUserLoggedIn}
	<li class='spaces_test'>&#183;</li>
	<li id="userHome"><a href="{url page="user"}">{translate
	key="navigation.userHome"}</a></li>
	{/if} {if $currentJournal &&
	$currentJournal->getSetting('publishingMode') !=
	$smarty.const.PUBLISHING_MODE_NONE}
	<li class='spaces_test'>&#183;</li>
	<li id="membership"><a href="{url page="pages"}/view/membership">{translate
	key="navigation.membership"}</a></li>
	{/if} {if !$currentJournal ||
	$currentJournal->getSetting('publishingMode') !=
	$smarty.const.PUBLISHING_MODE_NONE}
	<li class='spaces_test'>&#183;</li>
	<li id="search"><a href="{url page="search"}">{translate
	key="navigation.search"}</a></li>
	{/if} {if $currentJournal &&
	$currentJournal->getSetting('publishingMode') !=
	$smarty.const.PUBLISHING_MODE_NONE}
	<li class='spaces_test'>&#183;</li>

	{if $currentJournal->getJournalId() == '4'}
	<li id="current"><a href="{url page=" issue" op="current"}">{translate
	key="navigation.current"}</a></li>

	{else}
	<li id="issues" class="dropdown"><a class="dropdown-toggle"
		data-toggle="dropdown" href="{url page="issue" op="archive"}">Issues<span
		class="caret"></span></a>
	<ul class="dropdown-menu" role="menu">
		<li id="current"><a href="{url page="issue" op="current"}">{translate
		key="navigation.current"}</a></li>
		<li id="specialissues"><a href="{url page="pages"}/view/specialissues">Special
		Issues</a></li>
		<li id="allissues"><a href="{url page="issue" op="archive"}">All
		issues</a></li>
	</ul>
	</li>
	{/if} {/if} {call_hook
	name="Templates::Common::Header::Navbar::CurrentJournal"} {foreach
	from=$navMenuItems item=navItem} {if $navItem.url != '' &&
	$navItem.name != ''}
	<li class='spaces_test'>&#183;</li>
	<li id="navItem"><a
		href="{if $navItem.isAbsolute}{$navItem.url|escape}{else}{$navItem.url|escape}{/if}">{if
	$navItem.isLiteral}{$navItem.name|escape}{else}{translate
	key=$navItem.name}{/if}</a></li>
	{/if} {/foreach}
	
	{if $currentJournal}
	<li class="active pull-right"><a target='blank' href="{$submissionBaseUrl}/{$currentJournal->getPath()}/author/submit">Submit an article
    </a></li>
    <!-- li class="active"><a href="{url page="author" op="submit"}">Submit an article
    </a></li-->
    {*
	{if $donationEnabled}
	<li>submit</li>
	{/if}
	
<li class='pull-right login_main_form'>
<button class="btn btn-default btn-sm dropdown-toggle" type="button" data-toggle="dropdown">
    Login <span class="caret"></span>
  </button>
  <ul class="dropdown-menu">
    <li>
    {if $leftSidebarCode || $rightSidebarCode}
	<div id="sidebar">
		{if $leftSidebarCode}
			<div id="leftSidebar">
				{$leftSidebarCode}
			</div>
		{/if}
		{if $rightSidebarCode}
			<div id="rightSidebar">
				{$rightSidebarCode}
			</div>
		{/if}
	</div>
{/if}
    </li>
  </ul>
</li>
*}
{/if}
</ul>

</div>

<div>
<hr />
</div>

</div>

