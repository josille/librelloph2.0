<?php

/**
 * @defgroup pages_sitemap
 */
 
/**
 * @file pages/sitemap/index.php
 *
 * Copyright (c) 2013 Rodrigo De la garza
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @ingroup pages_sitemap
 * @brief Will post rss updates into social networks
 *
 */

// $Id$


switch ($op) {
	case 'index':
		define('HANDLER_CLASS', 'SNPostHandler');
		import('pages.snpost.SNPostHandler');
		break;
}

?>
