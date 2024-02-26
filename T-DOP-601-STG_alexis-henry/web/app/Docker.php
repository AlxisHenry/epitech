<?php

declare(strict_types=1);

namespace App;

class Docker
{
    private array $containers = [];

    public static function setup(): self
    {
        $docker = new self();
        $docker->registerContainers();
        return $docker;
    }

    private function registerContainers(): void
    {
        $containers = explode("\n", trim(shell_exec('docker ps --format "{{.Names}}"')));
        foreach ($containers as $name) {
            $this->addContainer($name, new Container($name));
        }
    }

    public function addContainer(string $name, Container $container): void
    {
        $this->containers[$name] = $container;
    }

    public function getContainer(string $name)
    {
        if (!isset($this->containers[$name])) {
            throw new \Exception("Container $name not found");
        }

        return $this->containers[$name]();
    }

    public function getContainers(): array
    {
        return $this->containers;
    }
}
