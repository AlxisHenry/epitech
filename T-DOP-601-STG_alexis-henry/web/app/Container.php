<?php

declare(strict_types=1);

namespace App;

class Container
{
    private string $id;
    private string $uuid;
    private string $name;
    private string $status;
    private array $ips;
    private string $image;
    private string $ports;
    private string $volumes;
    private string $command;
    private string $cpuUsagePercentage;
    private string $memoryUsagePercentage;
    private ContainerMemory $memory;
    private ContainerNetwork $network;
    private ContainerBlock $block;
    private int $pids = 0;

    public function __construct(
        string $name
    ) {
        if (!$this->exists($name)) {
            throw new \Exception("Container $name not found");
        }

        $this->parse($name);
    }

    private function exists(string $name): bool
    {
        return in_array($name, explode("\n", trim(shell_exec('docker ps --format "{{.Names}}"'))));
    }

    private function parse(string $name): void
    {
        $this->id = trim(shell_exec("docker ps --filter name=$name --format '{{.ID}}'"));
        $this->uuid = trim(shell_exec("docker inspect --format '{{.Id}}' $name"));
        $this->name = $name;
        $this->status = trim(shell_exec("docker inspect --format '{{.State.Status}}' $name"));
        $this->ips = explode("\n", trim(shell_exec("docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $name")));
        $this->image = trim(shell_exec("docker inspect --format '{{.Config.Image}}' $name"));
        $this->ports = trim(shell_exec("docker inspect --format '{{range .NetworkSettings.Ports}}{{.HostIP}}:{{.HostPort}} -> {{.ContainerPort}}{{end}}' $name"));
        $this->volumes = trim(shell_exec("docker inspect --format '{{range .Mounts}}{{.Source}} -> {{.Destination}}{{end}}' $name"));
        $this->command = trim(shell_exec("docker inspect --format '{{.Config.Cmd}}' $name"));
        $this->cpuUsagePercentage = trim(shell_exec("docker stats --no-stream --format '{{.CPUPerc}}' $name"));
        $this->memoryUsagePercentage = trim(shell_exec("docker stats --no-stream --format '{{.MemPerc}}' $name"));
        $this->memory = new ContainerMemory($this);
        $this->network = new ContainerNetwork($this);
        $this->block = new ContainerBlock($this);
        $this->pids = (int)trim(shell_exec("docker inspect --format '{{.HostConfig.PidsLimit}}' $name"));
    }

    public function getCommand(): string
    {
        return $this->command;
    }

    public function getUuid(): string
    {
        return $this->uuid;
    }

    public function getId(): string
    {
        return $this->id;
    }

    public function getName(): string
    {
        return $this->name;
    }

    public function getStatus(): string
    {
        return $this->status;
    }

    public function getIps(): array
    {
        return $this->ips;
    }

    public function getImage(): string
    {
        return $this->image;
    }

    public function getPorts(): string
    {
        return $this->ports;
    }

    public function getVolumes(): string
    {
        return $this->volumes;
    }

    public function isOnline(): bool
    {
        return $this->status === 'running';
    }

    public function getMemoryUsagePercentage(): string
    {
        return $this->memoryUsagePercentage;
    }

    public function getCpuUsagePercentage(): string
    {
        return $this->cpuUsagePercentage;
    }

    public function getMemory(): ContainerMemory
    {
        return $this->memory;
    }

    public function getNetwork(): ContainerNetwork
    {
        return $this->network;
    }

    public function getBlock(): ContainerBlock
    {
        return $this->block;
    }

    public function getPids(): int
    {
        return $this->pids;
    }
}
