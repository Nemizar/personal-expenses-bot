<?php

declare(strict_types=1);

use Nemizar\PersonalExpensesBot\Http\Action\HomeAction;
use Slim\App;

return static function (App $app): void {
    $app->get('/', HomeAction::class);
};
