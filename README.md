# Rackapp

A simple rack-based application that has a few features.

## Routes

Basic index:

    GET /

Simple output:

    GET /health

Random 500:

    GET /flaky

## Custom chef

This repository has a set of custom cookbooks that modify your Engine Yard environment. Cookbooks are stored in the `cookbooks` directory of this app and are checked into git.

You can upload your cookbooks by running `ey recipies upload -e <environment>`

Once you have uploaded your recipes, you can apply them to the servers in your environment by running `ey recipes apply -e <environment>`.

For more information about custom chef, [see our documentation](https://support.cloud.engineyard.com/entries/21406977-Custom-Chef-Recipes-Examples-Best-Practices).

### Upload and apply configuration

Custom chef recipes are defined for this environment. To upload and apply these recipes run:

    ey recipes upload -e <environment name>
    ey recipes apply -e <environment name>

This will setup basic god monitoring.

### Adding your monitored process

Create or modify your custom cookbook. See `cookbooks/myapp` directory for an example

Once you have added your monitored process, you should apply the cookbooks

Have your application cookbook drop a god configuration file in `/etc/god/<filename>.rb`. See `cookbooks/myapp/recipes/default.rb` in this repo

## Working with god

`god` runs as root, so you should issue all commands as the either the root user or via `sudo`.

The custom cookbooks in this repo run `god` via `init` (/etc/inittab) and relevant logs go to `/var/log/god.log` and `/root/god.log`. By default, these cookbooks only install `god` on application servers (solo, app master and app slaves).

To check status:

    $ sudo god status
    api-workers:
      api-worker-1: up
    $

To restart your process:

    $ sudo god restart api-workers
    Sending 'restart' command

    The following watches were affected:
      api-worker-1
    $

To stop monitoring a process:

    $ sudo god unmonitor api-workers
    Sending 'unmonitor' command

    The following watches were affected:
      api-worker-1
    $ sudo god status
    api-workers:
      api-worker-1: unmonitored
    $

To restart a process:

    $ sudo god restart api-workers
    Sending 'restart' command

    The following watches were affected:
      api-worker-1
    $

Additional God configuration and commands can be found at [godrb.com](http://godrb.com/).

## Monitored processes and deploys

After a deploy, you will want to reload your monitored processes. You will need to add a deploy hook, which tells `god` to restart your processes. See `deploy/after_restart.rb` in this repo.

For more information about deploy hooks [check out our documentation](https://support.cloud.engineyard.com/entries/21016568-Use-Deploy-Hooks).

Remember, any changes to deploy hooks must be committed to your source repository and deployed to the environment.

Happy hacking!
