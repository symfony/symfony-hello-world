Symfony Hello World Edition
===========================

Symfony Hello World Edition is the Symfony distribution you want to use when
doing "Hello World" benchmarks. It is configured to test the raw performance
of the framework. This is also the distribution used by the Symfony core team
to ensure that new versions of the framework do not degrade performance.

If you got it from Github, you must first install the dependencies by
executing the following script:

    ./bin/vendors.sh

Then, benchmark Symfony by getting the `index.php/hello/Symfony` URL.

You can also execute the `./bin/build.sh` script to create a small archive
with all the needed files.
