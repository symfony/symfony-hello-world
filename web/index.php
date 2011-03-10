<?php

require_once __DIR__.'/../app/bootstrap.php.cache';
require_once __DIR__.'/../app/AppKernel.php';

use Symfony\Component\HttpFoundation\ApacheRequest;

$kernel = new AppKernel('prod', false);
$kernel->handle(ApacheRequest::createFromGlobals())->send();
