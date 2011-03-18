#!/usr/bin/env php
<?php

require_once __DIR__.'/../vendor/symfony/src/Symfony/Component/ClassLoader/UniversalClassLoader.php';

/*
 * This file is part of the Symfony package.
 *
 * (c) Fabien Potencier <fabien@symfony.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

use Symfony\Component\ClassLoader\UniversalClassLoader;
use Symfony\Component\ClassLoader\ClassCollectionLoader;

require_once __DIR__.'/../app/autoload.php';

$file = __DIR__.'/../app/bootstrap.php.cache';
if (file_exists($file)) {
    unlink($file);
}

ClassCollectionLoader::load(array(
    'Symfony\\Component\\Config\\ConfigCache',
    'Symfony\\Component\\Config\\FileLocatorInterface',
    'Symfony\\Component\\Config\\FileLocator',
    'Symfony\\Component\\Config\\Loader\\LoaderInterface',

    'Symfony\\Component\\DependencyInjection\\ContainerInterface',
    'Symfony\\Component\\DependencyInjection\\Container',
    'Symfony\\Component\\DependencyInjection\\ContainerAwareInterface',
    'Symfony\\Component\\DependencyInjection\\ContainerAware',

    'Symfony\\Component\\HttpKernel\\Bundle\\BundleInterface',
    'Symfony\\Component\\HttpKernel\\Bundle\\Bundle',
    'Symfony\\Component\\HttpKernel\\HttpKernelInterface',
    'Symfony\\Component\\HttpKernel\\HttpKernel',
    'Symfony\\Component\\HttpKernel\\KernelInterface',
    'Symfony\\Component\\HttpKernel\\Kernel',
    'Symfony\\Component\\HttpKernel\\Config\\FileLocator',

    'Symfony\\Component\\HttpFoundation\\ParameterBag',
    'Symfony\\Component\\HttpFoundation\\FileBag',
    'Symfony\\Component\\HttpFoundation\\ServerBag',
    'Symfony\\Component\\HttpFoundation\\HeaderBag',
    'Symfony\\Component\\HttpFoundation\\Request',
    'Symfony\\Component\\HttpFoundation\\ApacheRequest',

    'Symfony\\Component\\ClassLoader\\ClassCollectionLoader',
    'Symfony\\Component\\ClassLoader\\UniversalClassLoader',

    'Symfony\\Bundle\\FrameworkBundle\\Routing\\LazyLoader',
    'Symfony\\Bundle\\FrameworkBundle\\HttpKernel',
    'Symfony\\Bundle\\FrameworkBundle\\FrameworkBundle',
    'Symfony\\Bundle\\FrameworkBundle\\Templating\\GlobalVariables',
), dirname($file), basename($file, '.php.cache'), false, false, '.php.cache');

file_put_contents($file, "<?php\n\nnamespace { require_once __DIR__.'/autoload.php'; }\n\n".substr(file_get_contents($file), 5));
