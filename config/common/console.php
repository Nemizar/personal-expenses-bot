<?php

declare(strict_types=1);

use Nemizar\PersonalExpensesBot\Console\HelloCommand;

return [
    'config' => [
        'console' => [
            'commands' => [
                HelloCommand::class,
            ],
        ],
    ],
];
