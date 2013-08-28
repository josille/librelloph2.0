{**
 * header.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Article View -- Header component.
 *}
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>{$article->getLocalizedTitle()|escape} | {$article->getFirstAuthor(true)|escape} | {$currentJournal->getLocalizedTitle()|escape}</title>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<meta name="description" content="{$article->getLocalizedTitle()|strip_tags|escape}" />
	{if $article->getLocalizedSubject()}
		<meta name="keywords" content="{$article->getLocalizedSubject()|escape}" />
	{/if}

	{if $displayFavicon}<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" />{/if}

	{include file="article/dublincore.tpl"}
	{include file="article/googlescholar.tpl"}
	{call_hook name="Templates::Article::Header::Metadata"}

	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery-2.0.2.min.js"></script>
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js"></script>
	<!-- script src="http://code.jquery.com/jquery.js"></script-->
	
	{$additionalHeadData}
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
<script type="text/javascript" src="{$baseUrl}/js/bootstrap_js/bootstrap.min.js"></script> 
<!-- script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0-rc1/js/bootstrap.min.js"></script-->
	
	
	<!-- Bootstrap -->
<link href="{$baseUrl}/styles/bootstrap_css/bootstrap.min.css" rel="stylesheet" media="screen"/>
<!-- link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0-rc1/css/bootstrap.min.css"-->

<link href="{$baseUrl}/styles/bootstrap_css/tweeks.css" rel="stylesheet" media="screen"/>
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
<div class="container">
<p class="navbar-text pull-right margin_top_10 margin_bottom_10"><a target="blank" style="background:none;" href="http://localhost/librelloph2.0/index.php/index/oai?verb=Identify">
<img width="45px" height="35px" alt="OAI" src="http://www.openarchives.org/images/OA100.gif"/>
</a></p>
<p class="navbar-text pull-right margin_top_10 margin_bottom_10"><a class="btn btn-default btn-xs"
	href="{url page="gateway"}/plugin/WebFeedGatewayPlugin/rss2">
<img src="{$publicFilesDir}/../../site/RSS_icon.png" width="26" height="26" alt="Rss"/></a></p>
<p class="navbar-text pull-right margin_top_10 margin_bottom_10"><a class="btn btn-default btn-xs"
	href="https://twitter.com/librello" target="blank"><img src="{$publicFilesDir}/../../site/Twitter_icon.png" width="26" height="26" alt="Twitter"/></a>
</p>
<p class="navbar-text pull-right margin_top_10 margin_bottom_10"><a class="btn btn-default btn-xs"
	href="http://www.linkedin.com/company/librello" target="blank"><img src="{$publicFilesDir}/../../site/Linkedin_icon.png" width="26" height="26" alt="LinkedIn"/></a></p>
	<p class="navbar-text pull-right margin_top_10 margin_bottom_10"><a class="btn btn-default btn-xs"
	href="https://plus.google.com/117721213017356591223" target="blank"><img src="{$publicFilesDir}/../../site/Google_icon.png" width="26" height="26" alt="Google +"/></a></p>
</div>
</div>

<div class="container" itemscope="" itemtype="http://schema.org/Article" id="container">
<div id="fade" class="black_overlay"></div>{* The background 'lightbox' effect *}

<div id="header">
<div id="headerTitle">
<h1>
{if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
	<img itemprop="image" src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" width="{$displayPageHeaderLogo.width|escape}" height="{$displayPageHeaderLogo.height|escape}" {if $displayPageHeaderLogoAltText != ''}alt="{$displayPageHeaderLogoAltText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} />
	<span itemprop="name" style='height:1px;display:none;'>{if $displayPageHeaderLogoAltText != ''}{$displayPageHeaderLogoAltText|escape}{else}{translate key="common.pageHeaderLogo.altText"}{/if}</span>
{/if}
{if $displayPageHeaderTitle && is_array($displayPageHeaderTitle)}
	<img itemprop="image" src="{$publicFilesDir}/{$displayPageHeaderTitle.uploadName|escape:"url"}" width="{$displayPageHeaderTitle.width|escape}" height="{$displayPageHeaderTitle.height|escape}" {if $displayPageHeaderTitleAltText != ''}alt="{$displayPageHeaderTitleAltText|escape}"{else}alt="{translate key="common.pageHeader.altText"}"{/if} />
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

{*
<div id="breadcrumb">
	<a href="{url page="index"}" target="_parent">{translate key="navigation.home"}</a> &gt;
	{if $issue}<a href="{url page="issue" op="view" path=$issue->getBestIssueId($currentJournal)}" target="_parent">{$issue->getIssueIdentification(false,true)|escape}</a> &gt;{/if}
	<a href="{url page="article" op="view" path=$articleId|to_array:$galleyId}" class="current" target="_parent" itemprop="url" >{$article->getFirstAuthor(true)|escape}</a>
</div>
*}
<ol class="breadcrumb margin_top_10">
  <li><a href="{url page="index"}" target="_parent">{translate key="navigation.home"}</a></li>
  {if $issue}
  <li><a href="{url page='issue' op='view' path=$issue->getBestIssueId($currentJournal)}" target="_parent">{$issue->getIssueIdentification(false,true)|escape}</a></li>
  {/if}
  <li class="active">{$article->getFirstAuthor(true)|escape}</li>
</ol>


<div id="content">

