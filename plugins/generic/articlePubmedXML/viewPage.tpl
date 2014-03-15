{**
 * viewPage.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * View issue: This adds the header and footer code to view.tpl.
 *
 * $Id$
 *}
{strip}
{if $issue && !$issue->getPublished()}
	{translate|assign:"previewText" key="editor.issues.preview"}
	{assign var="pageTitleTranslated" value="$issueHeadingTitle $previewText"}
{else}
	{assign var="pageTitleTranslated" value=$issueHeadingTitle}
{/if}
{if $issue && $issue->getShowTitle() && $issue->getLocalizedTitle() && ($issueHeadingTitle != $issue->getLocalizedTitle())}
	{* If the title is specified and should be displayed then show it as a subheading *}
	{assign var="pageSubtitleTranslated" value=$issue->getLocalizedTitle()}
{/if}
{include file="common/header.tpl"}
{/strip}

{if $subscriptionRequired && $showGalleyLinks && $showToc}
	<div id="accessKey">
		<img src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_open_medium.gif" alt="{translate key="article.accessLogoOpen.altText"}" />
		{translate key="reader.openAccess"}&nbsp;
		<img src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_restricted_medium.gif" alt="{translate key="article.accessLogoRestricted.altText"}" />
		{if $purchaseArticleEnabled}
			{translate key="reader.subscriptionOrFeeAccess"}
		{else}
			{translate key="reader.subscriptionAccess"}
		{/if}
	</div>
{/if}
{if !$showToc && $issue}
	{if $issueId}
		{url|assign:"currentUrl" page="issue" op="view" path=$issueId|to_array:"showToc"}
	{else}
		{url|assign:"currentUrl" page="issue" op="current" path="showToc"}
	{/if}
	<ul class="menu">
		<li><a href="{$currentUrl}">{translate key="issue.toc"}</a></li>
	</ul>
	<br />
	{if $coverPagePath}<div id="issueCoverImage"><a href="{$currentUrl}"><img src="{$coverPagePath|escape}{$issue->getFileName($locale)|escape}"{if $coverPageAltText != ''} alt="{$coverPageAltText|escape}"{else} alt="{translate key="issue.coverPage.altText"}"{/if}{if $width} width="{$width|escape}"{/if}{if $height} height="{$height|escape}"{/if}/></a></div>{/if}
	<div id="issueCoverDescription">{$issue->getLocalizedCoverPageDescription()|strip_unsafe_html|nl2br}</div>
{elseif $issue}
	<div id="issueDescription">{$issue->getLocalizedDescription()|strip_unsafe_html|nl2br}</div>
	<h3>{translate key="issue.toc"}</h3>
{foreach name=sections from=$publishedArticles item=section key=sectionId}
{if $section.title}<h4 class="tocSectionTitle">{$section.title|escape}</h4>{/if}

{foreach from=$section.articles item=article}
	{assign var=articlePath value=$article->getBestArticleId($currentJournal)}
	
<table class="tocArticle" width="100%">
<tr valign="top">
	{if $article->getLocalizedFileName() && $article->getLocalizedShowCoverPage() && !$article->getHideCoverPageToc($locale)}
	<td rowspan="2">
		<div class="tocArticleCoverImage">
		<a href="{url page="article" op="view" path=$articlePath}" class="file">
		<img src="{$coverPagePath|escape}{$article->getFileName($locale)|escape}"{if $article->getCoverPageAltText($locale) != ''} alt="{$article->getCoverPageAltText($locale)|escape}"{else} alt="{translate key="article.coverPage.altText"}"{/if}/></a></div>
	</td>
	{/if}
	{call_hook name="Templates::Issue::Issue::ArticleCoverImage"}

	{if $article->getLocalizedAbstract() == ""}
		{assign var=hasAbstract value=0}
	{else}
		{assign var=hasAbstract value=1}
	{/if}

	{assign var=articleId value=$article->getId()}
	{if (!$subscriptionRequired || $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN || $subscribedUser || $subscribedDomain || ($subscriptionExpiryPartial && $articleExpiryPartial.$articleId))}
		{assign var=hasAccess value=1}
	{else}
		{assign var=hasAccess value=0}
	{/if}

	<td class="tocTitle">{if !$hasAccess || $hasAbstract}<a href="{url page="article" op="view" path=$articlePath}">{$article->getLocalizedTitle()|strip_unsafe_html}</a>{else}{$article->getLocalizedTitle()|strip_unsafe_html}{/if}</td>
	<td class="tocGalleys">
		{if $hasAccess || ($subscriptionRequired && $showGalleyLinks)}
			{foreach from=$article->getGalleys() item=galley name=galleyList}
				<a href="{url page="article" op="view" path=$articlePath|to_array:$galley->getBestGalleyId($currentJournal)}" class="file">{$galley->getGalleyLabel()|escape}</a>
				{if $subscriptionRequired && $showGalleyLinks && $restrictOnlyPdf}
					{if $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN || !$galley->isPdfGalley()}	
						<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_open_medium.gif" alt="{translate key="article.accessLogoOpen.altText"}" />
					{else}
						<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_restricted_medium.gif" alt="{translate key="article.accessLogoRestricted.altText"}" />
					{/if}
				{/if}
			{/foreach}
			{if $subscriptionRequired && $showGalleyLinks && !$restrictOnlyPdf}
				{if $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN}
					<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_open_medium.gif" alt="{translate key="article.accessLogoOpen.altText"}" />
				{else}
					<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_restricted_medium.gif" alt="{translate key="article.accessLogoRestricted.altText"}" />
				{/if}
			{/if}				
		{/if}
	<a href="{url page="article" op="viewXML" path=$articlePath}" class="file">XML</a>
	</td>
</tr>
<tr>
	<td class="tocAuthors">
		{if (!$section.hideAuthor && $article->getHideAuthor() == 0) || $article->getHideAuthor() == 2}
			{foreach from=$article->getAuthors() item=author name=authorList}
				{$author->getFullName()|escape}{if !$smarty.foreach.authorList.last},{/if}
			{/foreach}
		{else}
			&nbsp;
		{/if}
	</td>
	<td class="tocPages">{$article->getPages()|escape}</td>
</tr>
</table>
{/foreach}

{if !$smarty.foreach.sections.last}
<div class="separator"></div>
{/if}
{/foreach}
{else}
	{translate key="current.noCurrentIssueDesc"}
{/if}
{include file="common/footer.tpl"}

