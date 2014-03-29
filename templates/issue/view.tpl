{**
 * view.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * View issue -- This displays the issue TOC or title page, as appropriate,
 * *without* header or footer HTML (see viewPage.tpl)
 *
 * $Id$
 *}

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
	
{if $coverPagePath}
 <div class='issuesTocDoi'>{$issue->getIssueDoi()}</div>
<div class='row'>
<div class="col-sm-2 col-md-2">
<img class="img-rounded" src="{$coverPagePath|escape}{$issue->getFileName($locale)|escape}"{if $coverPageAltText != ''} alt="{$coverPageAltText|escape}"{else} alt="{translate key="issue.coverPage.altText"}"{/if}/>
	
</div>
<div class="col-sm-6 col-md-3">

<div class="panel panel-success">
<div class="panel-heading">Download Issue as:</div>
  <div class="panel-body">
		        <a class="btn btn-default btn-xs btn-block" href="{url op='viewXML' path=$issue->getBestIssueId($currentJournal)}"><span class="glyphicon glyphicon-download"></span> Abstracts (XML)</a><br/>
		        <a class="btn btn-default btn-xs btn-block" href="{url op='downloadPDF' path=$issue->getBestIssueId($currentJournal)}"><span class="glyphicon glyphicon-download"></span> Complete Issue (PDF;  {$issue->getNiceFileSize($issue->getBestIssueId($currentJournal))})</a>
  </div>
</div>

</div>

</div>
		  <div>

		  <h4>Papers published:</h4>
		  <div id='journal_toc' style='padding-top:15px;'>
		      {include file="issue/issue.tpl"}
		      </div>
		  </div>
{/if}
{elseif $issue}
	<!--div id="issueDescription">{$issue->getLocalizedDescription()|strip_unsafe_html|nl2br}</div-->
	<!--  h3>{translate key="issue.toc"}</h3>-->
	
	{include file="issue/issue.tpl"}
	
{else}
	{translate key="current.noCurrentIssueDesc"}
{/if}