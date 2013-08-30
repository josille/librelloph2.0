
<table>
	<tbody>
		<tr>
			<td>
			<div>{foreach from=$authors_arr item=author name=authorIter} {if
			$smarty.foreach.authorIter.last AND not
			$smarty.foreach.authorIter.first} and {/if} 
			{if $extended}
			<a data-toggle="modal" href="#bioModal_{$author.user->getId()}">{$author.name}</a>
			{else}
			{$author.name}
			{/if}{if not $single_author}<sup>{foreach
			from=$author.ref item=aff name=affIter}{$aff}{if not
			$smarty.foreach.affIter.last},{/if}{/foreach}</sup>{/if}{foreach
			from=$author.corr item=corr}<sup>,</sup><span
				style='font-size: larger;'>{$corr}</span>{/foreach}{if not
			$smarty.foreach.authorIter.last AND
			$smarty.foreach.authorIter.iteration <
			($smarty.foreach.authorIter.total-1)},{/if} 
			
			{if $extended}
			
			
			<!-- Modal -->
  <div class="modal fade" id="bioModal_{$author.user->getId()}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title">{$author.user->getFullName()|escape}</h4>
        </div>
        <div class="modal-body">
         
<p class='font_size_12'>
	<em>{$author.user->getFullName()|escape}</em>
</p>
{if $author.user->getLocalizedBiography()}

<div class='font_size_12'>
  {$author.user->getLocalizedBiography()|nl2br|strip_unsafe_html}
 </div>
   {/if}

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div><!-- /.modal -->

			
			{/if}
			{/foreach}
			</div>
			</td>
		</tr>
		{foreach from=$arr_affi item=aff name=affIter}
		<tr>
			<td style="padding-left: 7px;">
			{if not $single_author}
			<sup>{$smarty.foreach.affIter.iteration}</sup>
			{/if}{$aff}</td>
		</tr>
		{/foreach} {if $corrFlag}
		<tr>
			<td style="padding-left: 7px;"><span style="font-size: larger;">*</span>
			Corresponding author</td>
		</tr>
		{/if}
	</tbody>
</table>
