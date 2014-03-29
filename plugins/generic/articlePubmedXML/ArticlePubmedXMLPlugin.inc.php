<?php

/**
 * @file ArticlePubmedXMLPlugin.inc.php
 *
 * Copyright (c) 2009 <Mahmoud Saghaei>
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class ArticlePubmedXMLPlugin
 * @ingroup plugins_generic_articlepubmedxml
 *
 * @brief Adds XML link to the galley and abstract listing of articles in TOC
 */

import('classes.plugins.GenericPlugin');

class ArticlePubmedXMLPlugin extends GenericPlugin {

	function getName() {
		return 'ArticlePubmedXMLPlugin';
	}

	function getDisplayName() {
		return Locale::translate('plugins.generic.articlepubmedxml.displayName');
	}

	function getDescription() {
		return Locale::translate('plugins.generic.articlepubmedxml.description');
	}   

	/**
	 * Called as a plugin is registered to the registry
	 * @param @category String Name of category plugin was registered to
	 * @return boolean True iff plugin initialized successfully; if false,
	 * 	the plugin will not be registered.
	 */
	function register($category, $path) {
		if (parent::register($category, $path)) {
			if ($this->getEnabled()) {
				HookRegistry::register('LoadHandler', array(&$this, 'handleRequest'));
			}
			$this->addLocaleData();
			return true;
		}
		return false;
	}

	function handleRequest($hookName, $args) {
		$page =& $args[0];
		$op =& $args[1];
		$sourceFile =& $args[2];

		$op_arr = array('viewXML');
		if ($page === 'article' && in_array($op, $op_arr)) {
			$this->import('ArticleHandler');
			Registry::set('plugin', $this);
			define('HANDLER_CLASS', 'ArticleHandler');
			return true;
		}
		$op_arr = array('view', 'current');
		if ($page === 'issue' && in_array($op, $op_arr)) {
			$this->import('IssueHandler');
			Registry::set('plugin', $this);
			define('HANDLER_CLASS', 'IssueHandler');
			return true;
		}
     }

	/**
	 * Determine whether or not this plugin is enabled.
	 */
	function getEnabled() {
		$journal = &Request::getJournal();
		if (!$journal) return false;
		return $this->getSetting($journal->getJournalId(), 'enabled');
	}

	/**
	 * Set the enabled/disabled state of this plugin
	 */
	function setEnabled($enabled) {
		$journal = &Request::getJournal();
		if ($journal) {
			$this->updateSetting($journal->getJournalId(), 'enabled', $enabled ? true : false);
			return true;
		}
		return false;
	}

	/**
	 * Display verbs for the management interface.
	 */
	function getManagementVerbs() {
		$verbs = array();
		if ($this->getEnabled()) {
			$verbs[] = array(
				'disable',
				Locale::translate('manager.plugins.disable')
			);
		} else {
			$verbs[] = array(
				'enable',
				Locale::translate('manager.plugins.enable')
			);
		}
		return $verbs;
	}

	/**
	 * Perform management functions
	 */
	function manage($verb, $args) {

		switch ($verb) {
			case 'enable':
				$this->setEnabled(true);
				break;
			case 'disable':
				$this->setEnabled(false);
				break;
		}
	}

}

?>
