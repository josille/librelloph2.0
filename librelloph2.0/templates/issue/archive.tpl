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
<div class="bs-example">
	<div class='row'>
	
{iterate from=issues item=issue}
	{if $issue->getYear() != 0 && $issue->getVolume() != 0 && $issue->getNumber() != 0}
		
		{if !$FirstLoopIssue}
		<div class="col-sm-6 col-md-11">
			<h3>Issues</h3>
			<div class="separator" style="clear:left;"></div>
			{assign var=FirstLoopIssue value=1}
		</div>
		{/if}
			
	
	
	{if $issue->getLocalizedFileName() && $issue->getShowCoverPage($locale) && !$issue->getHideCoverPageArchives($locale)}
				
		
		  <div class="col-sm-6 col-md-3">
		    <div class="thumbnail">
		    <a href="{url op="view" path=$issue->getBestIssueId($currentJournal)}">
		     <img  class="img-rounded" src="{$coverPagePath|escape}{$issue->getFileName($locale)|escape}"{if $issue->getCoverPageAltText($locale) != ''} alt="{$issue->getCoverPageAltText($locale)|escape}"{else} alt="{translate key="issue.coverPage.altText"}"{/if}/>
		      </a>
		    
		      <div class="caption">
		        <a href="{url op="view" path=$issue->getBestIssueId($currentJournal)}">
		<strong><h5>
		{$issue->getIssueIdentification(false,false,false,true)|escape}
		</h5></strong>
		</a>
		       
		        <p>{$issue->getLocalizedDescription()|strip_unsafe_html|nl2br}</p>
		        <div>
		        <p>
		        <a class="btn btn-default btn-xs btn-block" href="{url op='viewXML' path=$issue->getBestIssueId($currentJournal)}"><span class="glyphicon glyphicon-download"></span> Abstracts (XML)</a><br/>
		        <a class="btn btn-default btn-xs btn-block" href="{url op='downloadPDF' path=$issue->getBestIssueId($currentJournal)}"><span class="glyphicon glyphicon-download"></span> Complete Issue (PDF;  {$issue->getNiceFileSize($issue->getBestIssueId($currentJournal))})</a></p>
		      	</div>
		      </div>
		      </div>
		  </div>
		
			
	{else}
	
		  <div class="col-sm-6 col-md-3">
		    <div class="thumbnail">
		    <a href="{url op="view" path=$issue->getBestIssueId($currentJournal)}">
		     <img  class="img-rounded" src="{$coverPagePath|escape}/cover_issue_current_en_US.jpg" alt='Current'/>
		     </a>
		   
		      <div class="caption">
		        <a href="{url op="view" path=$issue->getBestIssueId($currentJournal)}">
		<strong><h5>
		{$issue->getIssueIdentification(false,false,false,true)|escape}
		</h5></strong>
		</a>
		       
		        <p>{$issue->getLocalizedDescription()|strip_unsafe_html|nl2br}</p>
		        <div>
		        <p>
		        <a class="btn btn-default btn-xs btn-block" href="{url op='viewXML' path=$issue->getBestIssueId($currentJournal)}"><span class="glyphicon glyphicon-download"></span> Abstracts (XML)</a>
		      	</div>
		      </div>
		       </div>
		  </div>
		
	
	{/if}

	{/if}
	
{/iterate}


		



{iterate from=issuesSI item=issueSI}

	{if $issueSI->getVolume() == 0}
		
		{if !$FirstLoopSI}
		<div class="col-sm-6 col-md-11">
			<h3>Special Issues</h3>
			<div class="separator" style="clear:left;"></div>
			{assign var=FirstLoopSI value=1}
		</div>
		{/if}
	
	
	{if $issueSI->getLocalizedFileName() && $issueSI->getShowCoverPage($locale) && !$issueSI->getHideCoverPageArchives($locale)}
		<div class="col-sm-6 col-md-3">
		
		 <div class="thumbnail">
		 <a href="{url op="view" path=issueSI->getBestIssueId($currentJournal)}">
		    <img class="img-rounded" src="{$coverPagePath|escape}{$issue->getFileName($locale)|escape}"{if $issue->getCoverPageAltText($locale) != ''} alt="{$issue->getCoverPageAltText($locale)|escape}"{else} alt="{translate key="issue.coverPage.altText"}"{/if}/>
		     </a>
		      <div class="caption">
		        <a href="{url op="view" path=issueSI->getBestIssueId($currentJournal)}">
		        <strong><h5>
		        {$issue->getIssueIdentification()|escape}
		        </h5></strong>
		        </a>
		       
		        <p>{$issueSI->getLocalizedCoverPageDescription()|strip_unsafe_html|nl2br}</p>
		        <div>
		        <p>
		        <a class="btn btn-default btn-xs btn-block" href="{url op='viewXML' path=$issueSI->getBestIssueId($currentJournal)}"><span class="glyphicon glyphicon-download"></span> Abstracts (XML)</a>
		      	</div>
		      </div>
		       </div>		
		</div>	
	{else}
	<div class="col-sm-6 col-md-3">
	
	<div class="thumbnail">
	<a href="{url op="view" path=$issueSI->getBestIssueId($currentJournal)}">
		<img  class="img-rounded" src="{$coverPagePath|escape}/cover_issue_current_en_US.jpg" alt='Current'/>
		     </a>
		      <div class="caption">
		        <a href="{url op="view" path=$issueSI->getBestIssueId($currentJournal)}">
		        <strong><h5>
		        {$issueSI->getIssueIdentification()|escape}
		        </h5></strong>
		        </a>
		       
		        <p>{$issueSI->getLocalizedDescription()|strip_unsafe_html|nl2br}</p>
		        <div>
		        <p>
		        <a class="btn btn-default btn-xs btn-block" href="{url op='viewXML' path=$issueSI->getBestIssueId($currentJournal)}"><span class="glyphicon glyphicon-download"></span> Abstracts (XML)</a>
		      	</div>
		      </div>
		       </div>		
		</div>
	{/if}

	
	{/if}
	
{/iterate}

</div>
	</div>
</div>

{include file="common/footer.tpl"}

