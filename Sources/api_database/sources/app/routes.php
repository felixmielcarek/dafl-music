<?php

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

require "Model.php";
require "Connection.php";

// Test route
$app->get('/hello/{name}', function (Request $request, Response $response, array $args) {
    $name = $args['name'];
    $response->getBody()->write("Hello, $name");

    return $response;
});

// Get information of a user
$app->get('/users/{id}', function (Request $request, Response $response, array $args) {
    $mdl = new Model();
    $response->getBody()->write(json_encode($mdl->getInformationsUser($args['id'])));
    return $response;
});

// Add a user
$app->post('/users/{id}', function (Request $request, Response $response, array $args) {
    $mdl = new Model();
    $data = $request->getParsedBody();
    $mdl->addUser($args['id'], $data['idSpotify'], $data['passw']);
    return $response;
});


// Update information of a user
$app->put('/users/{id}', function (Request $request, Response $response, array $args) {
    $res = "Update infos of user " . $args['id'];
    $response->getBody()->write($res);

    return $response;
});

// Delete a user
$app->delete('/users/{id}', function (Request $request, Response $response, array $args) {
    $res = "Delete user " . $args['id'];
    $response->getBody()->write($res);

    return $response;
});

// Like someone
$app->post('/user/{id}/like', function (Request $request, Response $response, array $args) {
    $res = "User " . $args['id'] . " liked " . $args['liked'];
    $response->getBody()->write($res);

    return $response;
});

// Add a new song as a preference for a situation
$app->post('/users/{id}/preferences', function (Request $request, Response $response, array $args) {
    $res = "User " . $args['id'] . " add music " . $args['music'] . " to his preferences for category " . $args['categ'];
    $response->getBody()->write($res);

    return $response;
});
