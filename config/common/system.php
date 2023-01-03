<?php

declare(strict_types=1);

use Psr\Http\Message\ResponseFactoryInterface;
use Slim\Psr7\Factory\ResponseFactory;

return [
    'config' => [
        'debug' => (bool)getenv('APP_DEBUG'),
    ],
    ResponseFactoryInterface::class => Di\get(ResponseFactory::class),
];
