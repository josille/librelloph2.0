{**
 * index.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User index.
 *
 * $Id$
 *}
{strip}
{assign var="pageTitle" value="user.userHome"}
{include file="common/header.tpl"}
{/strip}
<h2>Buy Institutional Membership</h2>


<div id="content">



<p><img src="http://www.librelloph.com/ojs/plugins/paymethod/paypal/images/paypal_cards.png" alt="paypal" /></p>
<p>If you have already consulted us about the membership for your institutions, click the Continue button bellow to go to the PayPal site, where credit cards can be used to pay the fee (without having to join PayPal). Use the "Return to Merchant" button after making the payment to return to this site. </p>
<form action="https://www.paypal.com/cgi-bin/webscr" id="paypalPaymentForm" name="paypalPaymentForm" method="post" style="margin-bottom: 0px;">
			<table class="data" width="100%">
		<tr>
			<td class="label" width="20%">Title</td>
			<td class="value" width="80%"><strong>Institutional membership</strong></td>
		</tr>
	</table>
		
			<input type="hidden" name="charset" value="utf-8" />
			<input type="hidden" name="business" value="membership@librelloph.com" />
			<input type="hidden" name="item_name" value="Institutional membership - {$userId}" />
			<input type="hidden" name="amount" value="0" />
			<input type="hidden" name="quantity" value="1" />
			<input type="hidden" name="no_note" value="0" />
			<input type="hidden" name="no_shipping" value="0" />
			<input type="hidden" name="currency_code" value="CHF" />
			<input type="hidden" name="lc" value="US" />
			<input type="hidden" name="custom" value="53" />
			<input type="hidden" name="notify_url" value="http://www.librelloph.com/ojs/index.php/{$journalPath}/payment/plugin/Paypal/ipn" />
			<input type="hidden" name="return" value="http://www.librelloph.com/ojs/index.php/{$journalPath}/donations/thankYou" />
			<input type="hidden" name="cancel_return" value="http://www.librelloph.com/ojs/index.php/{$journalPath}/payment/plugin/Paypal/cancel" />
			<input type="hidden" name="first_name" value="librello_admin" />
			<input type="hidden" name="last_name" value="librello_admin" />
			<input type="hidden" name="item_number" value="0" />
			<input type="hidden" name="cmd" value="_xclick" />
		
	<p><input type="submit" name="submitBtn" value="Continue" class="button defaultButton" /></p>
    <p>
If you are interested in an institutional membership but have not consulted us yet, please write to <a href="mailto:membership@librelloph.com">membership@librelloph.com</a>.</p>
</form>
{include file="common/footer.tpl"}

