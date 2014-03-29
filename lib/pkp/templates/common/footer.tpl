{**
 * footer.tpl
 *
 * Copyright (c) 2000-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site footer.
 *
 *}
  </div><!-- content -->
 </div><!-- inner row -->
</div><!-- row -->

</div><!-- body -->

{if $displayCreativeCommons}
{translate key="common.ccLicense"}
{/if}
{if $pageFooter}
{$pageFooter}
{/if}
{call_hook name="Templates::Common::Footer::PageFooter"}
{get_debug_info}
{if $enableDebugStats}{include file=$pqpTemplate}{/if}
<div class='well well-sm font_size_10'>
<span class="glyphicon glyphicon-copyright-mark"></span> 2012 - {'Y'|date}  Librello, Switzerland.
</div>
</div><!-- container -->

<meta itemprop="email" content="support@librelloph.com"/>
<span itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
<meta itemprop="addressLocality" content="Basel"/>
<meta itemprop="addressCountry" content="Switzerland"/></span>

</body>
</html>