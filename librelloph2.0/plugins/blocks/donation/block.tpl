{**
 * block.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- donation links.
 *
 *}
 
 
<div class="block">
<span class="blockTitle"><a href="{url page="author" op="submit"}" style="background:none;"><!--{translate key="payment.type.donation"}-->
    <img src="/public/site/submit.png" alt="Submissions" />
    </a></span>
</div>
 
{if $donationEnabled}
<div class="block" id="sidebarDonation">
	<span class="blockTitle"><a href="{url page="donations"}" style="background:none;"><!--{translate key="payment.type.donation"}-->
    <img src="/public/site/donate.png" alt="Donations" />
    </a></span>
</div>
{/if}



<!-- div class="block">


<script type="IN/Share" data-url="{$currentJournal->getUrl()}"></script>
</div>

<div class="block">
<a href="https://twitter.com/Librello" class="twitter-follow-button" data-show-count="false">Follow @Librello</a>

</div-->


<div class="block">
			<div class="fb-like" data-href="{$currentJournal->getUrl()}" data-send="true" 
			data-layout="box_count" data-width="90" data-show-faces="false" data-font="arial" 
			data-action="recommend"></div>	
</div>
<br/><br/>
<div class="block">
			<a href="{$baseUrl}/index.php/index/oai?verb=Identify" style="background:none;" target="blank">
    <img src="http://www.openarchives.org/images/OA100.gif" width="100px" height="70px" alt="OAI" />
    </a>
</div>

<div class="block">
			<a target='blank' href="https://plus.google.com/117721213017356591223" rel="publisher">Find us on Google+</a>
</div>