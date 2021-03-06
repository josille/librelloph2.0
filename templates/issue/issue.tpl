{** * issue.tpl * * Copyright (c) 2003-2012 John Willinsky * Distributed
under the GNU GPL v2. For full terms see the file docs/COPYING. * *
Issue * * $Id$ *} 

{*foreach name=sections from=$publishedArticles item=section key=sectionId*}
<!-- {if $section.title}<h4 class="tocSectionTitle">{$section.title|escape}</h4>{/if} -->

{*foreach from=$section.articles item=article*} {iterate from=articles
item=article} {assign var=articlePath
value=$article->getBestArticleId($currentJournal)}			

<div class="row">{call_hook
name="Templates::Issue::Issue::ArticleCoverImage"} {if
$article->getLocalizedAbstract() == ""} {assign var=hasAbstract value=0}
{else} {assign var=hasAbstract value=1} {/if} {assign var=articleId
value=$article->getId()} {if (!$subscriptionRequired ||
$article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN ||
$subscribedUser || $subscribedDomain || ($subscriptionExpiryPartial &&
$articleExpiryPartial.$articleId))} {assign var=hasAccess value=1}
{else} {assign var=hasAccess value=0} {/if}

<div class="col-xs-9 col-sm-10 col-md-10 col-lg-10">

<span style='float: left; font-style: italic;'>
    {assign var=articleType value=$article->getSectionTitle()}
    {if $articleType eq 'Articles'}
        Research Article
    {elseif $articleType eq 'Commentaries'}
        Commentary
    {elseif $articleType eq 'Communications'}
        Communication
    {elseif $articleType eq 'Editorials'}
        Editorial
    {elseif $articleType eq 'Reviews'}
        Review
    {elseif $articleType eq 'Short Notes'}
        Short Note
    {elseif $articleType eq 'Book Review'}
        Book Review
    {elseif $articleType eq 'Research Notes'}
        Research Note
    {elseif $articleType eq 'Opinions'}
        Opinion
    {else}
        {$articleType}
    {/if}
</span>

<span
	style='overflow: hidden; display: block; border-bottom: 1.5px dotted black; height: 16px; margin-bottom: 6px;'>&nbsp;</span>

<div class='padding_left_15'>
<strong><a href="{url page='article' op='view' path=$articlePath}">
{$article->getLocalizedTitle()|strip_unsafe_html}</a> </strong>
</div>
</div>

<div class="col-xs-3 col-sm-2 col-md-2 col-lg-2">

{if
$article->getPages()|strstr:"-"} pp. {else} p. {/if}
{$article->getPages()|escape}
</div>
</div>

<div class="row padding_left_15">
<div class="col-xs-9 col-sm-6 col-md-12 col-lg-12 font_size_10 margin_bottom_5 margin_top_10">
{assign var=issueArt value=$article->getArticleIssue()}

doi: {$article->getDOI()} | Volume {$issueArt->getVolume()} ({$issueArt->getYear()}) | Issue {$issueArt->getNumber()}</div>
</div>

<div class="row padding_left_15">
<div class="col-xs-11 col-sm-10 col-md-9 col-lg-9">
{$article->getAuthorAffiliationHTMLtpl()}</div>

<div class="col-xs-4 col-sm-3 col-md-2 col-lg-2 font_size_10">

<div class="table-responsive">
  <table class="table table-condensed table_margin_bottom_0">
    <tr>
    	<td><a title="" class='tooltipTOC' data-toggle="tooltip" data-original-title="{$article->getViews()} abstract views.">Views</a></td>
    	<td><span class="badge">{$article->getViews()}</span> <span class="glyphicon glyphicon-eye-open"></span></td>
    </tr>
{foreach from=$article->getGalleys() item=galley name=galleyList}

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
  
{/foreach}
  
  </table>
</div>
</div>

</div>

<div class="row padding_left_15">
<div class="col-xs-10 col-sm-10 col-md-12 col-lg-12 font_size_12 margin_top_10">
Publication Date: {$article->getDatePublished()|date_format:"%e %B %Y"}
</div>
</div>

<div class="row">
<div class="col-xs-10 col-sm-10 col-md-12 col-lg-12 ">

<div class="btn-toolbar padding_left_15">

<div class="btn-group btn-group-xs">
<a class="margin_top_10 btn btn-success btn-sm accordion-toggle"  data-toggle="collapse"
	data-parent="#accordion_{$article->getId()}"
	href="#collapse_{$article->getId()}"><span class="glyphicon glyphicon-tags"></span> View abstract</a>

</div>

<div class="btn-group btn-group-xs margin_top_10">

<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-download"></span> Download <span class="caret"></span></button>
	
  <ul class="dropdown-menu" role="menu">
				{foreach from=$article->getGalleys() item=galley name=galleyList} {if
	$galley->isPdfGalley()}
	<li><a href="{url page='article' op='download'
		path=$articlePath|to_array:$galley->getBestGalleyId($currentJournal)}"
	class="file">Full text PDF</a></li>

	<li><a href="{url page='article' op='viewXML' path=$articlePath}/xml" class="file">Abstract XML</a></li>
	{else}
	<li><a href="{url page='article' op='view'
		path=$articlePath|to_array:$galley->getBestGalleyId($currentJournal)}"
	class="file" target="blank">{$galley->getGalleyLabel()|escape}</a></li>
	{/if} {/foreach}
				</ul>

</div>

<div class="btn-group margin_top_10 ">

<button type="button" class="btn btn-link btn-xs dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-send"></span> Share this article <span class="caret"></span></button>

<ul class="dropdown-menu" role="menu">
	<li>
	<div class='twitter_div margin_bottom_10 padding_left_15'>
				<a href="https://twitter.com/share" class="twitter-share-button" 
				data-url="{url page='article' op='view' path=$articlePath}" 
				data-text='{$article->getLocalizedTitle()|strip_unsafe_html|escape}' data-via="Librello" data-related="Librello" data-hashtags="Librello">Tweet</a>
		</div>
	</li>
	<li>
		
		<div class='linkedin_div margin_bottom_10 padding_left_15'>
					<script type="IN/Share" data-url="{url page='article' op='view' path=$articlePath}" data-counter="right"></script>
		</div>
		
		
	</li>
	<li>
	<div class='margin_bottom_10 padding_left_15'>
	<!-- div class="fb-send" data-href="http://example.com"></div-->
	</div>
	</li>

</ul>

</div>


</div>

</div></div>


<div class="row padding_left_15">
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



<hr class='margin_bottom_5' />

{/iterate} {*/foreach*} {if !$smarty.foreach.sections.last}
<div class="separator"></div>
<br />
{/if} {*/foreach*}

