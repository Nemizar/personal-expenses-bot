<?php

declare(strict_types=1);

namespace Nemizar\PersonalExpensesBot\Http\Action;

use Psr\Http\Message\ResponseFactoryInterface;
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\RequestHandlerInterface;

class HomeAction implements RequestHandlerInterface
{
    public function __construct(private readonly ResponseFactoryInterface $factory)
    {
    }

    public function handle(ServerRequestInterface $request): ResponseInterface
    {
        $response = $this->factory->createResponse();
        $response->getBody()->write('{}');
        return $response->withHeader('Content-Type', 'application/json');
    }
}
