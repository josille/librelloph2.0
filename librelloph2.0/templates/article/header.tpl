{**
 * header.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Article View -- Header component.
 *}<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Open Access | {$article->getLocalizedTitle()|escape} | {$article->getFirstAuthor(true)|escape}{if $galley}{if $galley->isHTMLGalley()} | html{elseif $galley->isPdfGalley()} | pdf{/if}{/if}</title>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	{if $article->getAbstract(null)}
	<meta name="description" content="Abstract: {foreach from=$article->getAbstract(null) key=metaLocale item=metaValue}{$metaValue|strip_tags|escape}{/foreach}, Author(s): {foreach from=$article->getAuthorString()|explode:', ' item=dc_author}{$dc_author|escape}{/foreach}, Category: {$article->getSectionTitle()}, Pages: {$article->getPages()}"/>
	{/if}
	
	{if $article->getLocalizedSubject()}
		<meta name="keywords" content="{$article->getLocalizedSubject()|escape}" />
	{/if}
	<meta http-equiv="Content-Language" content="en">
	{if $displayFavicon}<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" />{/if}

	{include file="article/dublincore.tpl"}
	{include file="article/googlescholar.tpl"}
	{call_hook name="Templates::Article::Header::Metadata"}

	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery-2.0.3.min.js"></script>
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js"></script>
	<!-- script src="http://code.jquery.com/jquery.js"></script-->
	
	{*$additionalHeadData*}
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
<script type="text/javascript" src="{$baseUrl}/js/bootstrap_js/bootstrap.min.js"></script> 
<!-- script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0-rc1/js/bootstrap.min.js"></script-->
	
	<link href="https://plus.google.com/117721213017356591223" rel="publisher"/>
	
	<!-- Bootstrap -->
<link href="{$baseUrl}/styles/bootstrap_css/bootstrap.min.css" rel="stylesheet" media="screen"/>
<link media="only screen and (max-width: 500px)" href="{$baseUrl}/styles/bootstrap_css/small.css" type="text/css" rel="stylesheet" />
<link media="only screen and (max-width: 650px)" href="{$baseUrl}/styles/bootstrap_css/medium.css" type="text/css" rel="stylesheet" />
	
<!-- link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0-rc1/css/bootstrap.min.css"-->

<link href="{$baseUrl}/styles/bootstrap_css/tweeks.css" rel="stylesheet" media="screen"/>
{if $galley}
{if $galley->isHTMLGalley()}
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="{$baseUrl}/styles/articles/articles_html.css" rel="stylesheet" media="screen"/>
<script type="text/javascript" src="{$baseUrl}/js/articles/articles_html.js"></script>
<script type="text/javascript" src="https://c328740.ssl.cf1.rackcdn.com/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
{/if}
{/if}

	<script type="text/javascript" src="{$baseUrl}/js/bootstrap_js/tweeks_size_journals.js"></script>
</head>
<body>

<!-- AddThis Smart Layers BEGIN -->
<!-- Go to http://www.addthis.com/get/smart-layers to customize -->
<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-52134487777ec3ae"></script>
<script type="text/javascript">
{literal}
  addthis.layers({
    'theme' : 'gray',
    'share' : {
      'position' : 'left',
      'numPreferredServices' : 6
    }   
  });
  {/literal}
</script>
<!-- AddThis Smart Layers END -->

<div class="navbar navbar-inverse navbar-fixed-top">
<div id='top_nav_bar_journal' class="container">
<p class="navbar-text pull-right margin_top_18 margin_bottom_10"><a target="blank" style="background:none;" href="http://www.librelloph.com/submission/index.php/index/oai?verb=Identify">
<img width="38px" height="28px" alt="OAI" src="http://www.openarchives.org/images/OA100.gif"/>
</a></p>
<p class="navbar-text pull-right margin_top_18 margin_bottom_10"><a href="{url page="gateway"}/plugin/WebFeedGatewayPlugin/rss2">
<img src="{$baseUrl}/images/rss_top.png" width="26" height="26" alt="Rss"/></a></p>
<p class="navbar-text pull-right margin_top_18 margin_bottom_10"><a href="https://twitter.com/librello" target="blank"><img src="{$baseUrl}/images/twitter_top.png" width="26" height="26" alt="Twitter"/></a>
</p>
<p class="navbar-text pull-right margin_top_18 margin_bottom_10"><a href="http://www.linkedin.com/company/librello" target="blank"><img src="{$baseUrl}/images/linkedin_top.png" width="26" height="26" alt="LinkedIn"/></a></p>
<p class="navbar-text pull-right margin_top_18 margin_bottom_10"><a href="https://plus.google.com/117721213017356591223?rel=author" rel="author" target="blank"><img src="{$baseUrl}/images/google_top.png" width="26" height="26" alt="Google +"/></a></p>
<p class="navbar-text pull-left margin_top_10 margin_bottom_10 margin_left_0">
<a href="http://www.librelloph.com">
<span itemprop="publisher" itemscope itemtype="http://schema.org/Organization">
<span itemprop="name">
<img src="{$baseUrl}/images/librello_logo_top_small.png" height="35" width="131" alt="Librello Home"/>
</span>
</span>
</a>
</p>
</div>

</div>

<div class="container" itemscope="" itemtype="http://schema.org/Article" id="container">
<div id="fade" class="black_overlay"></div>{* The background 'lightbox' effect *}

<div id="header">
<div id="headerTitle">
<h1 class='margin_top_5'>
{if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
	<img id='librello_logo_img' itemprop="image" src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" width="{$displayPageHeaderLogo.width|escape}" {if $displayPageHeaderLogoAltText != ''}alt="{$displayPageHeaderLogoAltText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} />
	<span itemprop="name" style='height:1px;display:none;'>{if $displayPageHeaderLogoAltText != ''}{$displayPageHeaderLogoAltText|escape}{else}{translate key="common.pageHeaderLogo.altText"}{/if}</span>
{/if}
{if $displayPageHeaderTitle && is_array($displayPageHeaderTitle)}
<a href="{url page="index"}" alt='Librello Publishing' style="background:none;">
	<img id='librello_logo_img' itemprop="image" src="{$publicFilesDir}/{$displayPageHeaderTitle.uploadName|escape:"url"}" width="{$displayPageHeaderTitle.width|escape}" {if $displayPageHeaderTitleAltText != ''}alt="{$displayPageHeaderTitleAltText|escape}"{else}alt="{translate key="common.pageHeader.altText"}"{/if} />
	</a>
	<span itemprop="name" style='height:1px;display:none;'>{if $displayPageHeaderTitleAltText != ''}{$displayPageHeaderTitleAltText|escape}{else}{translate key="common.pageHeader.altText"}{/if} </span>
{elseif $displayPageHeaderTitle}
	{$displayPageHeaderTitle}
{elseif $alternatePageHeader}
	{$alternatePageHeader}
{elseif $siteTitle}
	{$siteTitle}
{else}
	{$applicationName}
{/if}
</h1>

{include file="common/navbar.tpl"}
</div>
</div>

<div id="body">

<div id="main">

<ol class="breadcrumb margin_top_10">
  <li><a href="{url page="index"}" target="_parent">{translate key="navigation.home"}</a></li>
  {if $issue}
  <li><a href="{url page='issue' op='view' path=$issue->getBestIssueId($currentJournal)}" target="_parent">{$issue->getIssueIdentification(false,true)|escape}</a></li>
  {/if}
  
  {if $galley}
  	{if $galley->isHTMLGalley()}
  		<li><a href="{url page='article' op='view' path=$article->getBestArticleId($currentJournal)}">{$article->getFirstAuthor(true)|escape}</a></li>
  		<li class="active">{$galley->getGalleyLabel()|escape}</li>
  	{elseif $galley->isPdfGalley()}
  		<li><a href="{url page='article' op='view' path=$article->getBestArticleId($currentJournal)}">{$article->getFirstAuthor(true)|escape}</a></li>
  		<li class="active">{$galley->getGalleyLabel()|escape}</li>
  	{else}
  		<li class="active">{$article->getFirstAuthor(true)|escape}</li>
  	{/if}
  {else}
  	<li class="active">{$article->getFirstAuthor(true)|escape}</li>
  {/if}
</ol>

<div id="content">