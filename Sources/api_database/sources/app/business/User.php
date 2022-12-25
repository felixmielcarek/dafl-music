<?php

class User
{
    private string $idDafl;
    private string $idSpotify;

    public function __construct(string $idDafl, string $idSpotify)
    {
        $this->idDafl = $idDafl;
        $this->idSpotify = $idSpotify;
    }

    /**
     * @return string
     */
    public function getIdDafl(): string
    {
        return $this->idDafl;
    }

    /**
     * @return string
     */
    public function getIdSpotify(): string
    {
        return $this->idSpotify;
    }

    public function getInformations(): array
    {
        return array($this->idDafl, $this->idSpotify);
    }

}
