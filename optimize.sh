#!/bin/bash

echo "WARNINIG: Don't use this script anymore, it's deprecated. Use Symfony Flex instead to create more robusts Hello World applications."

# Script that optimizes a Symfony2 standard distribution for raw performance benchmarks

# Get the Symfony2 standard edition
mkdir benchmark
cd benchmark
git clone http://github.com/symfony/symfony-standard.git .

# Remove unneeded vendor specific code
cat > app/autoload.php <<EOF
<?php

return require __DIR__.'/../vendor/autoload.php';
EOF

# Remove unneeded vendor bundles
cat > app/AppKernel.php <<EOF
<?php

use Symfony\Component\HttpKernel\Kernel;
use Symfony\Component\Config\Loader\LoaderInterface;

class AppKernel extends Kernel
{
    public function registerBundles()
    {
        return array(
            new Symfony\Bundle\FrameworkBundle\FrameworkBundle(),
            new Acme\HelloBundle\AcmeHelloBundle(),
        );
    }

    public function registerContainerConfiguration(LoaderInterface \$loader)
    {
        \$loader->load(__DIR__.'/config/config.yml');
    }

    public function getRootDir()
    {
        return __DIR__;
    }
}
EOF

# Optimize the configuration
cat > app/config/config.yml <<EOF
framework:
    router:     { resource: "%kernel.root_dir%/config/routing.yml" }
    templating: { engines: ['php'] }
    secret:     foobar
    translator: { enabled: false }
EOF

# Add a route for the hello controller
cat > app/config/routing.yml <<EOF
_hello:
    pattern:  /hello/world
    defaults: { _controller: AcmeHelloBundle:Hello:index }
EOF

# Create the Hello bundle directory structure
mkdir -p src/Acme/HelloBundle/Controller
mkdir -p src/Acme/HelloBundle/Resources/views

# Create the bundle class
cat > src/Acme/HelloBundle/AcmeHelloBundle.php <<EOF
<?php

namespace Acme\HelloBundle;

use Symfony\Component\HttpKernel\Bundle\Bundle;

class AcmeHelloBundle extends Bundle
{
}
EOF

# Create the controller
cat > src/Acme/HelloBundle/Controller/HelloController.php <<EOF
<?php

namespace Acme\HelloBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class HelloController extends Controller
{
    public function indexAction()
    {
        return \$this->render('AcmeHelloBundle::index.html.php');
    }
}
EOF

# Create the template
cat > src/Acme/HelloBundle/Resources/views/index.html.php <<EOF
Hello world
EOF

# Remove unneeded vendors from dependencies
cat > composer.json <<EOF
{
    "name": "symfony/framework-hello-world-edition",
    "description": "The \"Symfony Hello World Edition\" distribution (to be used for benchmarks)",
    "autoload": {
        "psr-0": { "": "src/" }
    },
    "require": {
        "php": ">=5.3.3",
        "symfony/symfony": "@stable",
        "sensio/distribution-bundle": "@stable"
    },
    "replace": {
        "doctrine/common": "*",
        "twig/twig": "*"
    },
    "scripts": {
        "post-install-cmd": [
            "Sensio\\\Bundle\\\DistributionBundle\\\Composer\\\ScriptHandler::buildBootstrap",
            "Sensio\\\Bundle\\\DistributionBundle\\\Composer\\\ScriptHandler::clearCache",
            "Sensio\\\Bundle\\\DistributionBundle\\\Composer\\\ScriptHandler::installAssets",
            "Sensio\\\Bundle\\\DistributionBundle\\\Composer\\\ScriptHandler::installRequirementsFile"
        ],
        "post-update-cmd": [
            "Sensio\\\Bundle\\\DistributionBundle\\\Composer\\\ScriptHandler::buildBootstrap",
            "Sensio\\\Bundle\\\DistributionBundle\\\Composer\\\ScriptHandler::clearCache",
            "Sensio\\\Bundle\\\DistributionBundle\\\Composer\\\ScriptHandler::installAssets",
            "Sensio\\\Bundle\\\DistributionBundle\\\Composer\\\ScriptHandler::installRequirementsFile"
        ]
    },
    "extra": {
        "symfony-app-dir": "app",
        "symfony-web-dir": "web"
    }
}
EOF

cat > composer.lock <<EOF
EOF

curl -sS https://getcomposer.org/installer | php

# Set Symfony environment to production to disable use of Debug component
export SYMFONY_ENV=prod

# Install the dependencies:
php composer.phar install

# Benchmark!
