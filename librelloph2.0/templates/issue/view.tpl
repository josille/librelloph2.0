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
	<!-- ul class="menu">
		<li><a href="{$currentUrl}">{translate key="issue.toc"}</a></li>
	</ul>
	<br /-->
	{if $issue->getLocalizedCoverPageDescription()}
		<div id="issueCoverDescription" style='padding-bottom:20px;'>{$issue->getLocalizedCoverPageDescription()|strip_unsafe_html|nl2br}</div>
	{/if}
	{*if $coverPagePath}
	<table border='0' style='width:100%'>
		<tr>
		<td style='width:150px;'>
		<div class="issueCoverImage">
			<a href="{$currentUrl}">
				<!-- img src="{$coverPagePath|escape}{$issue->getFileName($locale)|escape}"{if $coverPageAltText != ''} alt="{$coverPageAltText|escape}"{else} alt="{translate key="issue.coverPage.altText"}"{/if}{if $width} width="{$width|escape}"{/if}{if $height} height="{$height|escape}"{/if}/></a-->
				<img src="{$coverPagePath|escape}{$issue->getFileName($locale)|escape}"{if $coverPageAltText != ''} alt="{$coverPageAltText|escape}"{else} alt="{translate key="issue.coverPage.altText"}"{/if}/></a>
		</div>
		
		</td>
		<td style='vertical-align:top;'>
		<div style='margin:0.75em 1em 0.25em 0'>
			<a style="float:left;" href="{url op="viewXML" path=$issue->getBestIssueId($currentJournal)}">Download Abstracts (XML)</a><br/>
			<a style="float:left;" href="{url op="downloadPDF" path=$issue->getBestIssueId($currentJournal)}">Download Complete Issue (PDF;  {$issue->getNiceFileSize($issue->getBestIssueId($currentJournal))})</a>
		</div>
		</td>
		</tr>
		<tr>
			<td colspan="2" style='padding-top:25px;padding-bottom:15px;'>
				<h2>Papers published:</h2>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				{include file="issue/issue.tpl"}
			</td>
		</tr>
		</table>
	{/if*}
{if $coverPagePath}
<div class='row'>
<div class="col-sm-6 col-md-3">
<div class="thumbnail">
		     <img src="{$coverPagePath|escape}{$issue->getFileName($locale)|escape}"{if $coverPageAltText != ''} alt="{$coverPageAltText|escape}"{else} alt="{translate key="issue.coverPage.altText"}"{/if}/>
		      <div class="caption">
		        <strong><h5><a href="{url op="view" path=$issue->getBestIssueId($currentJournal)}">
		
		{$issue->getIssueIdentification(false,false,false,true)|escape}</a></h5></strong>
		       
		        <p>{$issue->getLocalizedDescription()|strip_unsafe_html|nl2br}</p>
		        <div>
		        <p>
		        <a class="btn btn-default btn-xs btn-block" href="{url op='viewXML' path=$issue->getBestIssueId($currentJournal)}"><span class="glyphicon glyphicon-download"></span> Abstracts (XML)</a><br/>
		        <a class="btn btn-default btn-xs btn-block" href="{url op='downloadPDF' path=$issue->getBestIssueId($currentJournal)}"><span class="glyphicon glyphicon-download"></span> Complete Issue (PDF;  {$issue->getNiceFileSize($issue->getBestIssueId($currentJournal))})</a></p>
		      	</div>
		      </div>
		      </div>
</div>
</div>
		  <div style='padding-top:25px;padding-bottom:15px;'>

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