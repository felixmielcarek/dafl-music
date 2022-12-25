<?php
// Files auto-loading
require '../vendor/autoload.php';

// Configuration
require '../app/config.php';

// App instantiation
$app = new \Slim\App(['settings' => $config]);

// Routes
require '../app/routes.php';

// Run
$app->run();
