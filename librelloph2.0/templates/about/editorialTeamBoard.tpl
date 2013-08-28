{**
 * editorialTeam.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * About the Journal index.
 *
 * $Id$
 *}
{strip}
{assign var="pageTitle" value="about.editorialTeam"}
{include file="common/header.tpl"}
{/strip}
{call_hook name="Templates::About::EditorialTeam::Information"}


{counter start=0 skip=1 assign="count"}
{foreach from=$groups item=group name=foo}
{assign var=groupId value=$group->getId()}
{assign var=members value=$teamInfo[$groupId]}

{if $smarty.foreach.foo.first}
<div class="row">
{/if}

{foreach from=$members item=member}
{assign var=user value=$member->getUser()}


<div class="col-sm-6 col-md-3 padding_5_5">
    <div class="thumbnail">
   
      <div class="caption font_size_12">
      	<strong><em>{$group->getLocalizedTitle()}</em></strong>
        <div class='font_size_16'><strong>{$user->getFullName()|escape}</strong></div>
        <p class='font_size_12'>
      {if $user->getLocalizedAffiliation()}{$user->getLocalizedAffiliation()|escape}{/if}{if $user->getCountry()}{assign var=countryCode value=$user->getCountry()}{assign var=country value=$countries.$countryCode}, {$country|escape}{/if}
      </p>	
	<p>
	<!-- Button trigger modal -->
  <a data-toggle="modal" href="#bioModal_{$user->getId()}" class="btn btn-success btn-xs">View Bio</a>
</p>
  <!-- Modal -->
  <div class="modal fade" id="bioModal_{$user->getId()}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title">{$user->getFullName()|escape}</h4>
        </div>
        <div class="modal-body">
          {assign var="profileImage" value=$user->getSetting('profileImage')}
	{if $profileImage}
	<p>
<img class="img-rounded" height="{$profileImage.height|escape}" width="{$profileImage.width|escape}" alt="{translate key="user.profile.profileImage"}" src="{$sitePublicFilesDir}/{$profileImage.uploadName}" />
</p>
{/if}

<p class='font_size_12'>
	<em>{$user->getFullName()|escape}</em>
	{if $publishEmail}
		{assign_mailto var=address address=$user->getEmail()|escape}
		{icon name="mail" url=$address}
	{/if}
	<br />
	{if $user->getUrl()}<a href="{$user->getUrl()|escape:"quotes"}" target="_new">{$user->getUrl()|escape}</a><br/>{/if}
	{if $user->getLocalizedAffiliation()}{$user->getLocalizedAffiliation()|escape}{assign var=needsComma value=1}{/if}{if $country}{if $needsComma}, {/if}{$country|escape}{/if}
</p>

{if $user->getLocalizedBiography()}

<div class='font_size_12'>
  {$user->getLocalizedBiography()|nl2br|strip_unsafe_html}
 </div>
   {/if}

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div><!-- /.modal -->
	
	
	
      </div>
    </div>
  </div>

{counter}
{*Can then use the $count var*}
   {if $count is div by 4}
      </div>
      <br/>
<div class="row">
   {/if}


{/foreach}

{if $smarty.foreach.foo.last}
</div>
{/if}

{/foreach}


{* $groups *}

{include file="common/footer.tpl"}

