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
{assign var="pageTitle" value="navigation.formerjournals"}
{include file="common/header_master.tpl"}
{/strip}

	<div id="forauthors">
	<p><b>Former Journals</b></p>
    <p>
        The following journals have been developed and launched by Librello,
        but are currently being published by a different publishing house.

        <ul id="journals_menu" class="nav nav-pills nav-stacked">

            <li><a href="http://www.librelloph.com/mediaandcommunication" class="mainjournal" style="font-style: italic; background: none; padding-left:0;"> <img style="margin-bottom: 10px; border-style: none;" alt="MaC" src="http://www.librelloph.com/ojs/../submission/public/site/../journals/5/MaCsmall.png">

                </a></li>
            <li><a href="http://www.librelloph.com/politicsandgovernance" class="mainjournal" style="font-style: italic; background: none; padding-left:0;"> <img style="margin-bottom: 10px; border-style: none;" alt="PaG" src="http://www.librelloph.com/ojs/../submission/public/site/../journals/2/PaGsmall.png">

                </a></li>
            <li><a href="http://www.librelloph.com/socialinclusion" class="mainjournal" style="font-style: italic; background: none; padding-left:0;"> <img style="margin-bottom: 10px; border-style: none;" alt="SI" src="http://www.librelloph.com/ojs/../submission/public/site/../journals/6/SIsmall.png">

                </a></li>
        </ul>

	</p>
	</div>


{include file="common/footer.tpl"}