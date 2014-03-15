{** * site.tpl * * Copyright (c) 2003-2012 John Willinsky * Distributed
under the GNU GPL v2. For full terms see the file docs/COPYING. * * Site
index. * * $Id$ *} {strip} {if $siteTitle} {assign
var="pageTitleTranslated" value=$siteTitle} {/if} {include
file="common/header_master.tpl"} {/strip} {if $intro}
<span itemprop="description">{$intro|nl2br}</span>
{/if}

<br />
<br />
<h4>Latest publications</h4>
{iterate from=articles item=article} {assign var=articlePath
value=$article->getBestArticleId()} {assign var=journalPath
value=$article->getJournalPath()} {assign var=journalInitials
value=$article->getJournalInitials()}

<div class="row row_over" id='row_over_{$article->getId()}'>
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

<div class="row">
<div class="col-xs-2 col-sm-1 col-md-1 col-lg-1">
<img alt="{$journalInitials}"
	src="{$publicFilesDir}/../journals/{$article->getJournalId()}/{$journalInitials}_small_notext.png"
	style='float: left; margin: 4px 10px 4px 4px;' />

</div>
<div class="col-xs-10 col-sm-11 col-md-10 col-lg-11">

<div class="row">
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-11">

<div class="row">
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"><strong> <a
	style='vertical-align: super;' href='{url journal="$journalPath" page="article" op="view" path=$articlePath}'>{$article->getArticleTitle()|strip_unsafe_html}</a>
</strong></div>

<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 font_size_10 margin_bottom_5 margin_top__4">
{assign var=issueArt value=$article->getArticleIssue()}
doi: {$article->getDOI()} | {$article->getJournalTitle()} | {$issueArt->getYear()} | Volume {$issueArt->getVolume()} | Issue {$issueArt->getNumber()}
</div>
</div>
</div>



</div>

<div class="row">
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-9 font_size_12">
{$article->getAuthorAffiliationHTMLtpl()}
</div>
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-3 font_size_10">
{foreach from=$article->getGalleys() item=galley name=galleyList}


<div class="table-responsive">
  <table class="table table-condensed table_margin_bottom_0">
    <tr>
    	<td><a title="" class='tooltipTOC' data-toggle="tooltip" data-original-title="{$article->getViews()} abstract views.">Views</a></td>
    	<td><span class="badge">{$article->getViews()}</span> <span class="glyphicon glyphicon-eye-open"></span></td>
    </tr>
    {if $galley->getViews() >5}
    
    	{if $galley->isPdfGalley()}
    		<tr>
    	<td><a title="" class='tooltipTOC' data-toggle="tooltip" data-original-title="{$galley->getViews()} Full-Text PDF downloads.">PDF</a></td>
    	<td><span class="badge">{$galley->getViews()}</span> <span class="glyphicon glyphicon-download-alt"></span></td>
    	</tr>
    
	    {else}
	    	<tr>
		    	<td><a title="" class='tooltipTOC' data-toggle="tooltip" data-original-title="{$galley->getViews()} {$galley->getGalleyLabel()|escape} views.">{$galley->getPublicGalleyId()|escape|upper}</td>
		    	<td><span class="badge">{$galley->getViews()}</span><span class="glyphicon glyphicon-bookmark"></span></td>
		    	</tr>
		    	
    	{/if}
    {/if}
    
  </table>
</div>


{/foreach}
</div>
</div>

<div class="row">
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 font_size_12 margin_top_10">
Publication Date: {$article->getDatePublished()|date_format:"%e %B %Y"}
</div>
</div>

<div class="row">
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 ">

<div class="btn-toolbar">
<div class="btn-group btn-group-xs">
<a	class="margin_top_10 btn btn-sm btn-success accordion-toggle"
	data-toggle="collapse" data-parent="#accordion_{$article->getId()}"
	href="#collapse_{$article->getId()}"> <span
	class="glyphicon glyphicon-tags"></span> View abstract</a>

</div>
<div class="btn-group btn-group-xs margin_top_10">
<button type="button" class="btn btn-sm btn-info dropdown-toggle"
	data-toggle="dropdown"><span class="glyphicon glyphicon-download"></span>
Download <span class="caret"></span></button>

<ul class="dropdown-menu" role="menu">
	{foreach from=$article->getGalleys() item=galley name=galleyList} {if
	$galley->isPdfGalley()}
	<li><a 
		href="{url journal=$journalPath page='article' op='download' path=$articlePath|to_array:$galley->getPublicGalleyId()}">Full text PDF{if $galley->getViews() > 20}<span class="badge badgeLibrello">{$galley->getViews()} <span class="glyphicon glyphicon-bookmark"></span></span>{/if}</a>
	</li>

	<li><a
		href="{url journal=$journalPath page='article' op='viewXML' path=$articlePath}/xml">Abstract XML</a></li>
	{else}
	<li><a
		href="{url journal=$journalPath page='article' op='view' path=$articlePath|to_array:$galley->getPublicGalleyId()}"
		target="_blank">{$galley->getGalleyLabel()|escape}{if $galley->getViews() > 20}<span class="badge badgeLibrello">{$galley->getViews()} <span class="glyphicon glyphicon-bookmark"></span></span>{/if}</a></li>
	{/if} {/foreach}
</ul>
</div>

<div class="btn-group margin_top_10 ">
<button type="button" class="btn btn-link btn-xs dropdown-toggle"
	data-toggle="dropdown"><span class="glyphicon glyphicon-send"></span>
Share this article <span class="caret"></span></button>


<ul class="dropdown-menu padding_left_15" role="menu">
	<li>
	<div class='twitter_div margin_bottom_10 padding_left_15'><a
		href="https://twitter.com/share" class="twitter-share-button"
		data-url="{url page='article' op='view' path=$articlePath}"
		data-text='{$article->getLocalizedTitle()|strip_unsafe_html|escape}'
		data-via="Librello" data-related="Librello" data-hashtags="Librello">Tweet</a>
	</div>
	</li>
	<li>

	<div class='linkedin_div margin_bottom_10 padding_left_15'><script
		type="IN/Share"
		data-url="{url page='article' op='view' path=$articlePath}"
		data-counter="right"></script></div>


	</li>
	<li>
	<div class='margin_bottom_10 padding_left_15'></div>
	</li>

</ul>
</div>


</div>

</div>
</div>


</div>

</div>
</div>

</div>
<div class="row">
<div class="col-xs-2 col-sm-1 col-md-1 col-lg-1">&nbsp;
</div>
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-11">

<div class="row">
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 margin_top_10">
<div class="accordion" id="accordion_{$article->getId()}">
<div class="accordion-group accordion-group_noborders">
<div id="collapse_{$article->getId()}" class="accordion-body collapse">
<div class="accordion-inner">{if $article->getLocalizedAbstract()}
<div id='abs_{$article->getId()}'><strong>Abstract:
</strong>{$article->getLocalizedAbstract()|strip_unsafe_html|nl2br}</div>
{/if}</div>
</div>
</div>

</div>
</div>
</div>

</div>

</div>


<hr class='margin_bottom_5' />
{/iterate} {iterate from=journals item=journal} {assign
var="displayHomePageImage"
value=$journal->getLocalizedSetting('homepageImage')} {assign
var="displayHomePageLogo"
value=$journal->getLocalizedPageHeaderLogo(true)} {assign
var="displayPageHeaderLogo"
value=$journal->getLocalizedPageHeaderLogo()}

<div style="clear: left;">{if $displayHomePageImage &&
is_array($displayHomePageImage)} {assign var="altText"
value=$journal->getLocalizedSetting('homepageImageAltText')}
<div class="homepageImage"><a href="{url journal=$journal->getPath()}"
	class="action"><img
	src="{$journalFilesPath}{$journal->getId()}/{$displayHomePageImage.uploadName|escape:"
	url"}" {if $altText !='' }alt="{$altText|escape}"
	{else}alt="{translate key=" common.pageHeaderLogo.altText"}"{/if} /></a></div>
{elseif $displayHomePageLogo && is_array($displayHomePageLogo)} {assign
var="altText"
value=$journal->getLocalizedSetting('homeHeaderLogoImageAltText')}
<div class="homepageImage"><a href="{url journal=$journal->getPath()}"
	class="action"><img
	src="{$journalFilesPath}{$journal->getId()}/{$displayHomePageLogo.uploadName|escape:"
	url"}" {if $altText !='' }alt="{$altText|escape}"
	{else}alt="{translate key=" common.pageHeaderLogo.altText"}"{/if} /></a></div>
{elseif $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
{assign var="altText"
value=$journal->getLocalizedSetting('pageHeaderLogoImageAltText')}
<div class="homepageImage"><a href="{url journal=$journal->getPath()}"
	class="action"><img
	src="{$journalFilesPath}{$journal->getId()}/{$displayPageHeaderLogo.uploadName|escape:"
	url"}" {if $altText !='' }alt="{$altText|escape}"
	{else}alt="{translate key=" common.pageHeaderLogo.altText"}"{/if} /></a></div>
{/if}</div>

{/iterate}
<br />
<br />

{include file="common/footer.tpl"}

