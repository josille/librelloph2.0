{**
 * archive.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Issue Archive.
 *
 * $Id$
 *}
{strip}
{assign var="pageTitle" value="archive.archives"}
{include file="common/header.tpl"}
{/strip}

<div class="issues">

{iterate from=issues item=issue}
	{if $issue->getYear() != 0 && $issue->getVolume() != 0 && $issue->getNumber() != 0}
		
		{if !$FirstLoopIssue}
			<h3>Issues</h3>
			<div class="separator" style="clear:left;"></div>
			{assign var=FirstLoopIssue value=1}
		{/if}
			
	
	
	<div id="issue" style="clear:left;padding-top:20px;">
	{if $issue->getLocalizedFileName() && $issue->getShowCoverPage($locale) && !$issue->getHideCoverPageArchives($locale)}
		<table border='0' style='width:100%'>
		<tr>
		<td style='width:400px;'>
		<div class="issueCoverImage"><a href="{url op="view" path=$issue->getBestIssueId($currentJournal)}"><img src="{$coverPagePath|escape}{$issue->getFileName($locale)|escape}"{if $issue->getCoverPageAltText($locale) != ''} alt="{$issue->getCoverPageAltText($locale)|escape}"{else} alt="{translate key="issue.coverPage.altText"}"{/if}/></a>
		</div>
		<h4><a href="{url op="view" path=$issue->getBestIssueId($currentJournal)}">
		{if $issue->getCurrent() == 1}
			(Current)
			{/if}
		{$issue->getIssueIdentification(false,false,false,true)|escape}</a></h4>
		
		<div class="issueCoverDescription">{$issue->getLocalizedCoverPageDescription()|strip_unsafe_html|nl2br}</div>
		</td>
		<td style='vertical-align:top;'>
		<div style='margin:0.75em 1em 0.25em 0'>
			<a style="float:left;" href="{url op="viewXML" path=$issue->getBestIssueId($currentJournal)}">Download Abstracts (XML)</a><br/>
			<a style="float:left;" href="{url op="downloadPDF" path=$issue->getBestIssueId($currentJournal)}">Download Complete Issue (PDF;  {$issue->getNiceFileSize($issue->getBestIssueId($currentJournal))})</a>
		</div>
		</td>
		</tr>
		</table>	
	{else}
		<table border='0'>
		<tr>
		<td style='width:400px;'>
		<h4>
			<a href="{url op="view" path=$issue->getBestIssueId($currentJournal)}">
			{if $issue->getCurrent() == 1}
			(Current)&nbsp;&nbsp;&nbsp;&nbsp;
			{/if}
			{$issue->getIssueIdentification(false,false,false,true)|escape}
			</a>
		</h4>
		<div class="issueDescription">{$issue->getLocalizedDescription()|strip_unsafe_html|nl2br}</div>
		</td>
		<td style='vertical-align:bottom;'>
		<div style='margin:0.75em 1em 0.25em 0;'>
			<a style="float:left;" href="{url op="viewXML" path=$issue->getBestIssueId($currentJournal)}">Download Abstracts (XML)</a>
		</div>
		</td>
		</tr>
		</table>
	{/if}
	</div>
	
	{/if}
	
	
{/iterate}

</div>
<div class="issues" style='margin-top:40px;'>
{iterate from=issuesSI item=issueSI}

	{if $issueSI->getVolume() == 0}
		
		{if !$FirstLoopSI}
			<h3>Special Issues</h3>
			<div class="separator" style="clear:left;"></div>
			{assign var=FirstLoopSI value=1}
		{/if}
	
	
	<div id="issue" style="clear:left;">
	{if $issueSI->getLocalizedFileName() && $issueSI->getShowCoverPage($locale) && !$issueSI->getHideCoverPageArchives($locale)}
		<table border='0'>
		<tr>
		<td>
		<div class="issueCoverImage"><a href="{url op="view" path=$issueSI>getBestIssueId($currentJournal)}"><img src="{$coverPagePath|escape}{$issue->getFileName($locale)|escape}"{if $issue->getCoverPageAltText($locale) != ''} alt="{$issue->getCoverPageAltText($locale)|escape}"{else} alt="{translate key="issue.coverPage.altText"}"{/if}/></a>
		</div>
		<h4><a href="{url op="view" path=issueSI>getBestIssueId($currentJournal)}">{$issue->getIssueIdentification()|escape}</a></h4>
		
		<div class="issueCoverDescription">{$issueSI->getLocalizedCoverPageDescription()|strip_unsafe_html|nl2br}</div>
		</td>
		<td style='vertical-align:bottom;'>
			<a style="float:right;" href="{url op="viewXML" path=$issueSI>getBestIssueId($currentJournal)}">Download abstracts in XML</a>
		</td>
		</tr>
		</table>	
	{else}
		<table border='0'>
		<tr>
		<td>
		<h4>
			<a href="{url op="view" path=$issueSI->getBestIssueId($currentJournal)}">{$issueSI->getIssueIdentification()|escape}</a>
		</h4>
		<div class="issueDescription">{$issueSI->getLocalizedDescription()|strip_unsafe_html|nl2br}</div>
		</td>
		<td style='vertical-align:bottom;'>
			<a style="float:right;" href="{url op="viewXML" path=$issueSI->getBestIssueId($currentJournal)}">Download abstracts in XML</a>
		</td>
		</tr>
		</table>
	{/if}
	</div>
	
	{/if}
	
{/iterate}

</div>

<!-- div id="issues">
{iterate from=issues item=issue}
	{if $issue->getYear() != $lastYear}
		{if !$notFirstYear}
			{assign var=notFirstYear value=1}
		{else}
			</div>
			<br />
			<div class="separator" style="clear:left;"></div>
		{/if}
		<div style="float: left; width: 100%;">
		<h3>{$issue->getYear()|escape}</h3>
		{assign var=lastYear value=$issue->getYear()}
	{/if}

	<div id="issue" style="clear:left;">
	{if $issue->getLocalizedFileName() && $issue->getShowCoverPage($locale) && !$issue->getHideCoverPageArchives($locale)}
		<table border='0'>
		<tr>
		<td>
		<div class="issueCoverImage"><a href="{url op="view" path=$issue->getBestIssueId($currentJournal)}"><img src="{$coverPagePath|escape}{$issue->getFileName($locale)|escape}"{if $issue->getCoverPageAltText($locale) != ''} alt="{$issue->getCoverPageAltText($locale)|escape}"{else} alt="{translate key="issue.coverPage.altText"}"{/if}/></a>
		</div>
		<h4><a href="{url op="view" path=$issue->getBestIssueId($currentJournal)}">{$issue->getIssueIdentification()|escape}</a></h4>
		
		<div class="issueCoverDescription">{$issue->getLocalizedCoverPageDescription()|strip_unsafe_html|nl2br}</div>
		</td>
		<td style='vertical-align:bottom;'>
			<a style="float:right;" href="{url op="viewXML" path=$issue->getBestIssueId($currentJournal)}">Download abstracts in XML</a>
		</td>
		</tr>
		</table>	
	{else}
		<table border='0'>
		<tr>
		<td>
		<h4>
			<a href="{url op="view" path=$issue->getBestIssueId($currentJournal)}">{$issue->getIssueIdentification()|escape}</a>
		</h4>
		<div class="issueDescription">{$issue->getLocalizedDescription()|strip_unsafe_html|nl2br}</div>
		</td>
		<td style='vertical-align:bottom;'>
			<a style="float:right;" href="{url op="viewXML" path=$issue->getBestIssueId($currentJournal)}">Download abstracts in XML</a>
		</td>
		</tr>
		</table>
	{/if}
	
	</div>

{/iterate}
{if $notFirstYear}<br /></div>{/if}

{if !$issues->wasEmpty()}
	{page_info iterator=$issues}&nbsp;&nbsp;&nbsp;&nbsp;
	{page_links anchor="issues" name="issues" iterator=$issues}
{else}
	{translate key="current.noCurrentIssueDesc"}
{/if}
</div-->
{include file="common/footer.tpl"}

