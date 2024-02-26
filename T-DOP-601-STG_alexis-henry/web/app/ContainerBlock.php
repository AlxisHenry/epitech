<?php

declare(strict_types=1);

namespace App;

class ContainerBlock
{
    private string $input;
    private string $output;

    public function __construct(
        private Container $container
    ) {
        $block = trim(shell_exec("docker container stats {$container->getId()} --no-stream --format '{{.BlockIO}}'"));
        [$this->input, $this->output] = explode(' / ', $block);
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
