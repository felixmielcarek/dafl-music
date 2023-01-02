<?php

class LikesGateway
{
	private Connection $con;

	public function __construct(Connection $con)
	{
		$this->con = $con;
	}

	public function addLike($user,$liked):bool
	{
		$query = 'INSERT INTO likes VALUES (:user,:liked)';
		$this->con->executeQuery($query,array(':user'=>array($user,PDO::PARAM_STR),':liked'=>array($liked,PDO::PARAM_STR)));
		$query = 'SELECT * FROM likes WHERE (user=:user AND liked=:liked) OR (liked=:liked AND user=:user )';
		$this->con->executeQuery($query,array(':user'=>array($user,PDO::PARAM_STR),':liked'=>array($liked,PDO::PARAM_STR)));
		$res=$this->con->getResults();
		if(count($res) == 2) {
			$query = 'INSERT INTO matches VALUES (:user,:liked)';
			$this->con->executeQuery($query,array(':user'=>array($user,PDO::PARAM_STR),':liked'=>array($liked,PDO::PARAM_STR)));
			return true;
		}
		return false;
	}
}
