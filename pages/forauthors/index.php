<?php

/**
 * @defgroup pages_index
 */
 
/**
 * @file pages/privacy/index.php
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @ingroup pages_index
 * @brief Handle site index requests. 
 *
 */

// $Id$


switch ($op) {
	case 'index':
		define('HANDLER_CLASS', 'IndexHandler');
		import('pages.forauthors.IndexHandler');
		break;
}

?>
