<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */
$public_url         = 'https://wordpress-daw8.fornes.cat';
$production_server     = 'localhost';
// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', getenv('WORDPRESS_DB_NAME') );

/** Database username */
define( 'DB_USER', getenv('WORDPRESS_DB_USER') );

/** Database password */
define( 'DB_PASSWORD', getenv('WORDPRESS_DB_PASSWORD') );

/** Database hostname */
define( 'DB_HOST', getenv('WORDPRESS_DB_HOST') );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

define('FORCE_SSL_ADMIN', true);
// in some setups HTTP_X_FORWARDED_PROTO might contain
// a comma-separated list e.g. http,https
// so check for https existence
if (strpos($_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false)
	$_SERVER['HTTPS']='on';

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
//define( 'AUTH_KEY',         'put your unique phrase here' );
//define( 'SECURE_AUTH_KEY',  'put your unique phrase here' );
//define( 'LOGGED_IN_KEY',    'put your unique phrase here' );
//define( 'NONCE_KEY',        'put your unique phrase here' );
//define( 'AUTH_SALT',        'put your unique phrase here' );
//define( 'SECURE_AUTH_SALT', 'put your unique phrase here' );
//define( 'LOGGED_IN_SALT',   'put your unique phrase here' );
//define( 'NONCE_SALT',       'put your unique phrase here' );
define('AUTH_KEY',         'k4kPju!S)=W$.^nZ]-jD9Qy}pGiE@) `9-E}+EEk(:P${s#kExcU+em@8ra$1`p3');
define('SECURE_AUTH_KEY',  'o|(&-}TO|9g~2^7gAntpk&!=>yi|`cv`iWl+@J[=~|*0 UGbxU|R:xq%jw`$-#Z|');
define('LOGGED_IN_KEY',    's/j-aUhvyc?bn--c`*{[@~ZX=zCF0&}<S>x9#x24K|cC^;-uC:2VECK7jmzfUEu6');
define('NONCE_KEY',        ':mT,y|U|UB$&cFl]VCd46s3P+[f5.=r5%^OXL&9PYWos_g|+)E*?:^V(6tAOLoER');
define('AUTH_SALT',        ' KaZd}9IrdgiJ;#ca)hS_hdv7/w ^68g2p{7u#3]TJQIkfVSU_tDjP|P/tT|{?1L');
define('SECURE_AUTH_SALT', 'fvnXsmX3}_p|&UDY#klrR+r:/~+>8R*Ta1W[&.>Wz;+@(!x_=p56P0GSI;ls&/7X');
define('LOGGED_IN_SALT',   'g#K_-9YQGR0[onIv8)lESed^5Q=<0E4in~w&)q-KohsTq5XZw#IU-X? 5lrW7B b');
define('NONCE_SALT',       'Pg0?wy:a$>]?dFEpDx+Rdn}G4#|*Q/aAT^Z5wBaM~[I8KV!1+/&-p(lXUA|y;^,n');

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
