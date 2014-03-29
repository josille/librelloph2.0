{**
 * site.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * About the Journal site.
 *
 * $Id$
 *}
{strip}
{assign var="pageTitle" value="about.aboutSite"}
{include file="common/header_master.tpl"}
{/strip}

{if !empty($about)}
	<div id="about">
	<p>{$about|nl2br}</p>
	</div>
{/if}


<br/><br/><br/>
<a href="{url op="aboutThisPublishingSystem"}" style='font-size:10px;' target='blank'>{translate key="about.aboutThisPublishingSystem"}</a>

{include file="common/footer.tpl"}

