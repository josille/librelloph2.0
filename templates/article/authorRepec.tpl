{foreach from=$authors_arr item=author name=authorIter}
Author-Name:  {$author.name}
{*Author-Email:  doe@someuni.edu*}
{foreach from=$arr_affi item=aff name=affIter}
Author-Workplace-Name: {$aff}
{/foreach}
{/foreach}