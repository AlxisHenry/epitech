<?php

declare(strict_types=1);

namespace App;

class ContainerMemory
{
    private string $usage;
    private string $limit;

    public function __construct(
        private Container $container
    ) {
        $memory = trim(shell_exec("docker container stats {$container->getId()} --no-stream --format '{{.MemUsage}}'"));
        [$this->usage, $this->limit] = explode(' / ', $memory);
    }

    public function getUsage(): string
    {
        return $this->usage;
    }

    public function getLimit(): string
    {
        return $this->limit;
    }
}
