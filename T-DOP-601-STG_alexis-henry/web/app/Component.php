<?php

declare(strict_types=1);

namespace App;

class Component
{

    public static function container(Container $container): string
    {
        $status = $container->isOnline() ? 'online' : 'offline';
        $ips = implode(', ', $container->getIps());

        return <<<HTML
        <div class="container" data-uuid="{$container->getUuid()}">
            <div class="header">
                <div class="status $status" title="{$container->getStatus()}"></div>
                <div class="primary-details">
                    <div class="name">
                        {$container->getName()}
                    </div>
                </div>
                <div class="more">
                    <div class="arrow">
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            height="48"
                            viewBox="0 -960 960 960"
                            width="48"
                            >
                            <path d="M504-480 320-664l56-56 240 240-240 240-56-56 184-184Z" />
                        </svg>
                    </div>
                </div>
            </div>
            <div class="main">
                <ul>
                    <li class="value">{$container->getId()}</li>
                    <li class="value">{$ips}</li>
                    <li class="value">{$container->getPids()}</li>
                    <li class="value">{$container->getImage()}</li>
                    <li class="value">{$container->getPorts()}</li>
                    <li class="value">{$container->getVolumes()}</li>
                    <li class="value">{$container->getCommand()}</li>
                    <li class="value">Memory U{$container->getMemoryUsagePercentage()} %</li>
                    <li class="value">{$container->getMemory()->getUsage()} / {$container->getMemory()->getLimit()}</li>
                    <li class="value">CPU U{$container->getCpuUsagePercentage()} %</li>
                </ul>
            </div>
        </div>
        HTML;
    }
}
