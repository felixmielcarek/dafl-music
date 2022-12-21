<?php

require '../vendor/autoload.php';
require '../app/config.php';

// App instantiation
$app = new \Slim\App(['settings' => $config]);
require '../app/dependencies.php';

// Routes
require '../app/routes.php';

// Run
$app->run();
