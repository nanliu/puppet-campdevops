# campdevops

After cloning, make sure you run:

    % git submodule update --init

This will clone any/all submodules to pull in some of the other dependencies


### Testing a manifest/class

    % puppet apply --noop modules/jenkins/tests/init.pp # for example

### Testing the node definition

    % puppet agent -t --noop

