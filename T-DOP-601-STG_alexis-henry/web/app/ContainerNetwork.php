<?php

declare(strict_types=1);

namespace App;

class ContainerNetwork
{

    private string $input;
    private string $output;

    public function __construct(
        private Container $container
    ) {
        $network = trim(shell_exec("docker container stats {$container->getId()} --no-stream --format '{{.NetIO}}'"));
        [$this->input, $this->output] = explode(' / ', $network);
    }

    public function getInput(): string
    {
        return $this->input;
    }

    public function getOutput(): string
    {
        return $this->output;
    }
}
