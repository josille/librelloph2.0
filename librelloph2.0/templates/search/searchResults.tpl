{**
 * searchResults.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display article search results.
 *
 * $Id$
 *}
{strip}
{assign var=pageTitle value="search.searchResults"}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
<!--
function ensureKeyword() {
	if (document.search.query.value == '') {
		alert({/literal}'{translate|escape:"jsparam" key="search.noKeywordError"}'{literal});
		return false;
	}
	document.search.submit();
	return true;
}
// -->
{/literal}
</script>

<br/>

{if $basicQuery}
	<form method="post" name="search" action="{url op="results"}">
		<input type="text" size="40" maxlength="255" class="textField" name="query" value="{$basicQuery|escape}"/>&nbsp;&nbsp;
		<input type="hidden" name="searchField" value="{$searchField|escape}"/>
		<input type="submit" class="button defaultButton" onclick="ensureKeyword();" value="{translate key="common.search"}"/>
	</form>
	<br />
{else}
	<form name="revise" action="{url op="advanced"}" method="post">
		<input type="hidden" name="query" value="{$query|escape}"/>
		<input type="hidden" name="searchJournal" value="{$searchJournal|escape}"/>
		<input type="hidden" name="author" value="{$author|escape}"/>
		<input type="hidden" name="title" value="{$title|escape}"/>
		<input type="hidden" name="fullText" value="{$fullText|escape}"/>
		<input type="hidden" name="supplementaryFiles" value="{$supplementaryFiles|escape}"/>
		<input type="hidden" name="discipline" value="{$discipline|escape}"/>
		<input type="hidden" name="subject" value="{$subject|escape}"/>
		<input type="hidden" name="type" value="{$type|escape}"/>
		<input type="hidden" name="coverage" value="{$coverage|escape}"/>
		<input type="hidden" name="dateFromMonth" value="{$dateFromMonth|escape}"/>
		<input type="hidden" name="dateFromDay" value="{$dateFromDay|escape}"/>
		<input type="hidden" name="dateFromYear" value="{$dateFromYear|escape}"/>
		<input type="hidden" name="dateToMonth" value="{$dateToMonth|escape}"/>
		<input type="hidden" name="dateToDay" value="{$dateToDay|escape}"/>
		<input type="hidden" name="dateToYear" value="{$dateToYear|escape}"/>
	</form>
	<a href="javascript:document.revise.submit()" class="action">{translate key="search.reviseSearch"}</a><br />
{/if}

{call_hook name="Templates::Search::SearchResults::PreResults"}

{if $currentJournal}
	{assign var=numCols value=3}
{else}
	{assign var=numCols value=4}
{/if}

<div id="results">

<table width="100%" class="listing">
<tr><td colspan="{$numCols|escape}" class="headseparator">&nbsp;</td></tr>
<tr class="heading" valign="bottom">
	{if !$currentJournal}<td width="20%">{translate key="journal.journal"}</td>{/if}
	<td width="{if !$currentJournal}20%{else}40%{/if}">{translate key="issue.issue"}</td>
	<td width="60%" colspan="2">{translate key="article.title"}</td>
</tr>
<tr><td colspan="{$numCols|escape}" class="headseparator">&nbsp;</td></tr>
</table>


{iterate from=results item=result}
{assign var=publishedArticle value=$result.publishedArticle}
{assign var=article value=$result.article}
{assign var=issue value=$result.issue}
{assign var=issueAvailable value=$result.issueAvailable}
{assign var=journal value=$result.journal}
{assign var=section value=$result.section}
{assign var=articlePath value=$publishedArticle->getBestArticleId()}
{assign var=journalPath value=$publishedArticle->getJournalPath()}

<div class="row">
  <div class="col-3 col-sm-2 col-lg-2">
<a href="{url journal=$journal->getPath()}" alt="{$journal->getLocalizedTitle()|escape}"> <img
				style="margin-bottom: 10px; border-style: none;"
				src="/public/journals/{$journal->getJournalId()}/{$journal->getJournalInitials()}small.png" /></a>
	</div>
 <div class="col-3 col-sm-3 col-lg-3">
 <a href="{url journal=$journal->getPath() page="issue" op="view" path=$issue->getBestIssueId($journal)}">{$issue->getIssueIdentification()|escape}</a>
 </div>
 <div class="col-4 col-sm-4 col-lg-5">
 <strong>
	<a style='vertical-align:super;' href="{url journal="$journalPath" page="article" op="view" path=$articlePath}">
	{$article->getLocalizedTitle()|strip_unsafe_html}
	</a></strong>
 </div>
<div class="col-2 col-sm-2 col-lg-2">
	<a class="dropdown-toggle" data-toggle="dropdown" href="#">Download<span class="caret"></span></a>
	
  <ul class="dropdown-menu" role="menu">
  {foreach from=$publishedArticle->getGalleys() item=galley name=galleyList}
					{if $galley->isPdfGalley()}
					<li>
					<a target='blank' href="{url journal=$journalPath page='article' op='download' path=$articlePath|to_array:$galley->getPublicGalleyId()}">{$galley->getGalleyLabel()|escape}</a>
					</li>
					
					<li>
					<a href="{url journal=$journalPath page='article' op='viewXML' path=$articlePath}/xml">XML</a></li>
					{else}
					<li><a href="{url journal=$journalPath page='article' op='view' path=$articlePath|to_array:$galley->getPublicGalleyId()}" target="blank">{$galley->getGalleyLabel()|escape}</a></li>
					{/if}
				{/foreach}
  </ul>
  </div>
</div>
<div class="row">
<div class="col-9 col-sm-9 col-lg-8">
{$article->getAuthorAffiliationHTMLtpl()}
</div>
</div>
<hr style='margin-top:20px;'>
{/iterate}
{if $results->wasEmpty()}
<div class="row">
<div class="col-4 col-sm-6 col-lg-8">{translate key="search.noResults"}
</div>
</div>
{else}
<div class="row">
<div class="col-3 col-sm-4 col-lg-4">
{page_info iterator=$results}
</div>
<div class="col-3 col-sm-4 col-lg-4">
{if $basicQuery}
			{page_links anchor="results" iterator=$results name="search" query=$basicQuery searchField=$searchField}
		{else}
			{page_links anchor="results" iterator=$results name="search" query=$query searchJournal=$searchJournal author=$author title=$title fullText=$fullText supplementaryFiles=$supplementaryFiles discipline=$discipline subject=$subject type=$type coverage=$coverage dateFromMonth=$dateFromMonth dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateToMonth=$dateToMonth dateToDay=$dateToDay dateToYear=$dateToYear}
		{/if}
</div>
{/if}
</div>
<br/><br/>
<div class="row">
<div class="col-8 col-sm-8 col-lg-8">
<p>{translate key="search.syntaxInstructions"}</p>
</div>
</div>
</div>

{include file="common/footer.tpl"}

