<?php

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

require "Model.php";
require "Connection.php";

// Get information about a user
$app->get('/users/{id}', function (Request $request, Response $response, array $args) {
    try {
        $mdl = new Model();
        $res = $mdl->getInformationsUser($args['id']);
    } catch (Exception $e) {
        $res = array("Error: " . $e->getMessage());
    } finally {
        $response->getBody()->write(json_encode($res));
        return $response;
    }

});

// Add a user
$app->post('/users/new', function (Request $request, Response $response, array $args) {
    try {
        $mdl = new Model();
        $data = $request->getParsedBody();
        if (!isset($data['idDafl']) || !isset($data['idSpotify']) || !isset($data['passw'])) {
            throw new Exception("missing arguments");
        }
        $mdl->addUser($data['idDafl'], $data['idSpotify'], $data['passw']);
        $res = "Ok";
    } catch (Exception $e) {
        $res = array("Error: " . $e->getMessage());
    } finally {
        $response->getBody()->write(json_encode($res));
        return $response;
    }
});

/*
// Update information about a user
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
 */
// Like someone
$app->post('/user/{id}/like', function (Request $request, Response $response, array $args) {
	try {
		$mdl = new Model();
		$data = $request->getParsedBody();
		if (!isset($data['liked'])) {
			throw new Exception("missing arguments");
		}
		$res=($mdl->like($args["id"],$data["liked"])) ? "Match" : "Ok";
	} catch (Exception $e) {
		$res = array("Error: " . $e->getMessage());
	} finally {
		$response->getBody()->write(json_encode($res));
		return $response;
	}
});
/*
// Add a new song as a preference for a situation
$app->post('/users/{id}/preferences', function (Request $request, Response $response, array $args) {
    $res = "User " . $args['id'] . " add music " . $args['music'] . " to his preferences for category " . $args['categ'];
    $response->getBody()->write($res);

    return $response;
});
 */
