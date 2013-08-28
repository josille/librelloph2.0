{**
 * index.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Journal index page.
 *
 * $Id$
 *}
{strip}
{assign var="pageTitleTranslated" value=$siteTitle}
{include file="common/header.tpl"}
{/strip}

{if $journalDescription}
	<div id='journal_main_desc' class='view' itemprop="articleBody">{$journalDescription}</div>
	<div id='journal_view_more1'><a href="{url page="about"}">View more about this Journal...</a></div>
{/if}

{call_hook name="Templates::Index::journal"}
<hr/>
{if $homepageImage}
<br />
<div id="homepageImage"><img src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" width="{$homepageImage.width|escape}" height="{$homepageImage.height|escape}" {if $homepageImageAltText != ''}alt="{$homepageImageAltText|escape}"{else}alt="{translate key="common.journalHomepageImage.altText"}"{/if} /></div>
{/if}

{if $additionalHomeContent}
<br />
{$additionalHomeContent}
{/if}

{if $enableAnnouncementsHomepage}
	{* Display announcements *}
	<div id="announcementsHome">
		<h3>{translate key="announcement.announcementsHome"}</h3>
		{include file="announcement/list.tpl"}	
		<table class="announcementsMore">
			<tr>
				<td><a href="{url page="announcement"}">{translate key="announcement.moreAnnouncements"}</a></td>
			</tr>
		</table>
	</div>
{/if}

{if $issue && $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
	{* Display the table of contents or cover page of the current issue. *}
	<!-- h4>{$issue->getIssueIdentification(false,false,false,true)|strip_unsafe_html|nl2br}</h4-->
	<h4 style='padding-top:15px;'>Latest publications</h4>

		<div id='journal_toc' style='padding-top:15px;'>
		{include file="issue/view.tpl"}
		</div>
	
{/if}

{include file="common/footer.tpl"}

