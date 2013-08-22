{**
 * site.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Site index.
 *
 * $Id$
 *}
 {strip}
{assign var="pageTitle" value="navigation.membershipList"}
{include file="common/header_master.tpl"}
{/strip}

	<div id="membership">
	<p><strong>Librello Members</strong></p>
	<p>Librello thanks our Institutional Members for helping us in our effort to create a 
	sustainable and comprehensive system of open-access publishing.</p>
	<p>The following institutions are members of Librello, all their affiliated members can submit an unlimited number of manuscripts to any of our journals without the need for an individual membership.</p>
	
		<ul style='list-style-type:none;padding-top:20px;'>
			<li>
			<div><h4>Centre for Citizenship and Globalisation</h4>
			<p>
			<a href='http://www.deakin.edu.au/arts-ed/ccg/' target='blank'>
				<img width="310" height="80" alt="Centre for Citizenship and Globalisation" src="{$publicFilesDir}/ccg_header_small.png"/>
			</a>
				<br/><br/>
			The Centre for Citizenship and Globalisation seeks to enlarge our knowledge and understanding of the problems associated with citizenship and globalisation, and to communicate them to a wider audience. A key focus is on issues contemporary and historical, arising from the research spheres of state and society, culture and heritage, economy and society, gender and health, and the international system.
			</p>
			</div>
			</li>
		</ul>
	
	</div>


{include file="common/footer.tpl"}