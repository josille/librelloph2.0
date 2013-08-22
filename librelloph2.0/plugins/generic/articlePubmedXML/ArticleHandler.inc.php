<?php

/**
 * @file ArticleHandler.inc.php
 *
 * Copyright (c) 2009 Mahmoud Saghaei
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @package pages.article
 * @class ArticleHandler
 *
 * Handle requests for viewXML article functions. 
 *
 * $Id: ArticleHandler.inc.php,v 1.72 2009/02/02 17:07:01 Mahmoud Saghaei Exp $
 */

import('classes.handler.Handler');

class ArticleHandler extends Handler {

	function viewXML($args) {
		$articleId = isset($args[0]) ? $args[0] : 0;
		PluginRegistry::loadCategory('importexport');
		$templateMgr = &TemplateManager::getManager();
		$plugin = &PluginRegistry::getPlugin('importexport', 'PubMedExportPlugin');
		$arr = array("exportArticle", $articleId);
		return $plugin->display($arr);
	}

}

?>
