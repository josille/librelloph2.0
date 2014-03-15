{**
 * siteMap.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * About the Journal / Site Map.
 *
 * TODO: Show the site map.
 *
 * $Id$
 *}
{strip}
{assign var="pageTitle" value="about.siteMap"}
{/strip}
{include file="common/header.tpl"}

<div id="siteMap">
<ul class="plain">
<li>
	<a href="{url journal="index" page="index" op="index"}">{translate key="navigation.home"}</a><br/>
	{if $isUserLoggedIn}<a href="{url journal="index" page="user"}">{translate key="navigation.userHome"}</a><br/>{/if}
	<ul class="plain">
	{if $journals|@count>1 && !$currentJournal}
		<li>Journals:
		<ul class="plain">
		{foreach from=$journals item=journal}
			<li><a href="{url journal=$journal->getPath() page="about" op="siteMap"}">{$journal->getLocalizedTitle()|escape}</a></li>
		{/foreach}
		</ul>
		</li>
		<li><a href="{url page="about"}">{translate key="navigation.about"}</a></li>
		<li><a href="{url page="forauthors"}">{translate key="navigation.forauthors"}</a></li>
		<li>{translate key="navigation.membership"}
			<ul class="plain">
				<li><a href="{url page="membership"}">Become a member</a></li>
				<li><a href="{url page="membershipList"}">Members list</a></li>
			</ul>
		</li>
		<li><a href="{url page="indexing"}">{translate key="navigation.indexing"}</a></li>
		<li><a href="{url page="contact"}">{translate key="navigation.contact"}</a></li>
		<li><a href="{url page="privacy"}">{translate key="navigation.privacy"}</a></li>
		<li><a href="{url page="search"}">{translate key="navigation.search"}</a></li>
	{else}
		{if $journals|@count==1}
			{assign var=currentJournal value=$journals[0]}
		{else}
			<li><a href="{url journal="index" page="about" op="siteMap"}">{translate key="journal.journals"}</a><br/>
			<ul class="plain">
			{assign var=onlyOneJournal value=1}
		{/if}

		<li><a href="{url journal=$currentJournal->getPath()}">{$currentJournal->getLocalizedTitle()|escape}</a><br/>
			<ul class="plain">
				<li><a href="http://www.librelloph.com">librello</a></li>
				<li><a href="{url journal=$currentJournal->getPath() page="about"}">{translate key="navigation.about"}</a>
				
					{if $isUserLoggedIn}
						<ul class="plain">
							{assign var=currentJournalId value=$currentJournal->getId()}
							{foreach from=$rolesByJournal[$currentJournalId] item=role}
								{translate|assign:"roleName" key=$role->getRoleName()}
								<li><a href="{url journal=$currentJournal->getPath() page=$role->getRolePath()}">{$roleName|escape}</a></li>
							{/foreach}
						</ul>
					{else}
						<ul class="plain">
							<li>{translate key="about.people"}</li>
							<ul class="plain">
								<li><a href="{url page="about" op="contact"}">{translate key="about.contact"}</a></li>
								<li><a href="{url page="about" op="editorialTeam"}">{translate key="about.editorialTeam"}</a></li>
								{iterate from=peopleGroups item=peopleGroup}
									<li><a href="{url page="about" op="displayMembership" path=$peopleGroup->getId()}">{$peopleGroup->getLocalizedTitle()|escape}</a></li>
								{/iterate}
							</ul>
							<li>{translate key="about.policies"}</li>
							<ul class="plain">
								{if $currentJournal->getLocalizedSetting('focusScopeDesc') != ''}
								<li><a href="{url page="about" op="editorialPolicies" anchor="focusAndScope"}">{translate key="about.focusAndScope"}</a></li>
								{/if}
								<li><a href="{url page="about" op="editorialPolicies" anchor="sectionPolicies"}">{translate key="about.sectionPolicies"}</a></li>
								{if $currentJournal->getLocalizedSetting('reviewPolicy') != ''}
								<li><a href="{url page="about" op="editorialPolicies" anchor="peerReviewProcess"}">{translate key="about.peerReviewProcess"}</a></li>
								{/if}
								{if $currentJournal->getLocalizedSetting('pubFreqPolicy') != ''}
								<li><a href="{url page="about" op="editorialPolicies" anchor="publicationFrequency"}">{translate key="about.publicationFrequency"}</a></li>
								{/if}
								{if $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_OPEN && $currentJournal->getLocalizedSetting('openAccessPolicy') != ''}
								<li><a href="{url page="about" op="editorialPolicies" anchor="openAccessPolicy"}">{translate key="about.openAccessPolicy"}</a></li>
								{/if}
								{if $journalSettings.enableLockss && $currentJournal->getLocalizedSetting('lockssLicense') != ''}
								<li><a href="{url page="about" op="editorialPolicies" anchor="archiving"}">{translate key="about.archiving"}</a></li>
								{/if}
								{if $paymentConfigured && $journalSettings.journalPaymentsEnabled && $journalSettings.membershipFeeEnabled && $journalSettings.membershipFee > 0}
								<li><a href="{url page="about"  op="memberships"}">{translate key="about.memberships"}</a></li>
								{/if}
								{if $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION}
									<li><a href="{url op="subscriptions"}">{translate key="about.subscriptions"}</a></li>
									{if !empty($journalSettings.enableAuthorSelfArchive)}
									<li><a href="{url  page="about" op="editorialPolicies" anchor="authorSelfArchivePolicy"}">{translate key="about.authorSelfArchive"}</a></li>
									{/if}
									{if !empty($journalSettings.enableDelayedOpenAccess)}
									<li><a href="{url  page="about" op="editorialPolicies" anchor="delayedOpenAccessPolicy"}">{translate key="about.delayedOpenAccess"}</a></li>
									{/if}
								{/if}
								{foreach key=key from=$customAboutItems item=customAboutItem}
								{if	$customAboutItem.title!=''}
								<li><a href="{url  page="about" op="editorialPolicies" anchor=custom-$key}">{$customAboutItem.title|escape}</a></li>
								{/if}
								{/foreach}
							</ul>
							<li>{translate key="about.submissions"}</li>
							<ul class="plain">
								<li><a href="{url page="about" op="submissions" anchor="onlineSubmissions"}">{translate key="about.onlineSubmissions"}</a></li>
								{if $currentJournal->getLocalizedSetting('authorGuidelines') != ''}
								<li><a href="{url page="about" op="submissions" anchor="authorGuidelines"}">{translate key="about.authorGuidelines"}</a></li>
								<li><a href="{url page="pages" op="view"}/guidelinesreviewers">Guidelines for Reviewers</a></li>
								{/if}
								{if $currentJournal->getLocalizedSetting('copyrightNotice') != ''}
								<li><a href="{url page="about" op="submissions" anchor="copyrightNotice"}">{translate key="about.copyrightNotice"}</a></li>
								{/if}
								{if $currentJournal->getLocalizedSetting('privacyStatement') != ''}
								<li><a href="{url page="about" op="submissions" anchor="privacyStatement"}">{translate key="about.privacyStatement"}</a></li>
								{/if}
								{if $currentJournal->getSetting('journalPaymentsEnabled') && ($currentJournal->getSetting('submissionFeeEnabled') || $currentJournal->getSetting('fastTrackFeeEnabled') || $currentJournal->getSetting('publicationFeeEnabled'))}
								<li><a href="{url page="about" op="submissions" anchor="authorFees"}">{translate key="about.authorFees"}</a></li>
								{/if}
							</ul>
							<li><a href="{url page='pages' op='view'}/indexArchive">Indexing and Archiving</a></li>
							<li>{translate key="about.other"}</li>
							<ul class="plain">
								{if not ($currentJournal->getSetting('publisherInstitution') == '' && $currentJournal->getLocalizedSetting('publisherNote') == '' && $currentJournal->getLocalizedSetting('contributorNote') == '' && empty($journalSettings.contributors) && $currentJournal->getLocalizedSetting('sponsorNote') == '' && empty($journalSettings.sponsors))}
								<li><a href="{url page="about" op="journalSponsorship"}">{translate key="about.journalSponsorship"}</a></li>
								{/if}
								{if $currentJournal->getLocalizedSetting('history') != ''}
								<li><a href="{url page="about" op="history"}">{translate key="about.history"}</a></li>
								{/if}
								<li><a href="{url page="about" op="siteMap"}">{translate key="about.siteMap"}</a></li>
								<li><a href="{url page="about" op="aboutThisPublishingSystem"}">{translate key="about.aboutThisPublishingSystem"}</a></li>
								{if $publicStatisticsEnabled}
								<li><a href="{url page="about" op="statistics"}">{translate key="about.statistics"}</a></li>
								{/if}
							</ul>
							<li><a href="{url page="about" op="editorialTeam"}">{translate key="about.editorialTeam"}</a></li>
							<li><a href="{url page="pages"}/view/membership">{translate key="navigation.membership"}</a></li>
							<li><a href="{url page="search"}">{translate key="navigation.search"}</a></li>
							<li><a href="{url page="issue" op="archive"}">Issues</a></li>
							<ul class="plain">
								<li><a href="{url page="issue" op="current"}">{translate key="navigation.current"}</a></li>
								<li><a href="{url page="pages"}/view/specialissues">Special Issues</a></li>
								<li><a href="{url page="issue" op="archive"}">All issues</a></li>
							</ul>
							<li><a href="{$submissionBaseUrl}/index.php/{$currentJournal->getPath()}/author/submit">Submit an article</a></li>
							<li><a href="{url journal=$currentJournal->getPath() page="login"}">{translate key="navigation.login"}</a></li>
						</ul>
					{/if}
				</li>
			</ul>
		</li>	
		{if $onlyOneJournal}</ul></li>{/if}

	{/if}
	</ul>
</li>
{if $isSiteAdmin}
	<li><a href="{url journal="index" page=$isSiteAdmin->getRolePath()}">{translate key=$isSiteAdmin->getRoleName()}</a></li>
{/if}
<li><a href="https://plus.google.com/117721213017356591223?rel=author" target="blank">Google +</a></li>
<li><a href="http://www.linkedin.com/company/librello" target="blank">LinkedIn</a></li>
<li><a href="https://twitter.com/librello">twitter</a></li>
{if $currentJournal}
<li><a href="{url page="gateway"}/plugin/WebFeedGatewayPlugin/rss2">rss</a></li>
{/if}
<li><a href="{url page="oai"}?verb=Identify">OAI</a></li>
<li><a href="http://pkp.sfu.ca/ojs">{translate key="common.openJournalSystems"}</a></li>
<!-- li><a href="javascript:openHelp('{url journal="index" page="help"}')">{translate key="help.help"}</a></li-->
</ul>
</div>
{include file="common/footer.tpl"}

