<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

require '../vendor/autoload.php';
require '../app/config.php';




// App instantiation
$app = new \Slim\App(['settings' => $config]);
require '../app/dependencies.php';




// Routes
$app->get('/hello/{name}', function (Request $request, Response $response, array $args) {
    $name = $args['name'];
    $response->getBody()->write("Hello, $name");

    return $response;
});

$app->get('/users/{id}', function (Request $request, Response $response, array $args) {
	$res="Get infos of user ".$args['id'];
	$response->getBody()->write($res);

	return $response;
});

$app->post('/users/{id}', function (Request $request, Response $response, array $args) {
	$res="Add user ".$args['id'];
	$response->getBody()->write($res);

	return $response;
});

$app->put('/users/{id}', function (Request $request, Response $response, array $args) {
	$res="Update infos of user ".$args['id'];
	$response->getBody()->write($res);

	return $response;
});

$app->delete('/users/{id}', function (Request $request, Response $response, array $args) {
	$res="Delete user ".$args['id'];
	$response->getBody()->write($res);

	return $response;
});

$app->post('/user/{id}/like', function (Request $request, Response $response, array $args) {
	$res="User ".$args['id']." liked ".$args['liked'];
	$response->getBody()->write($res);

	return $response;
});

$app->post('/users/{id}/preferences', function (Request $request, Response $response, array $args) {
	$res="User ".$args['id']." add music ".$args['music']." to his preferences for category ".$args['categ'];
	$response->getBody()->write($res);

	return $response;
});




// Run
$app->run();
