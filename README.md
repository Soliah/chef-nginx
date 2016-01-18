[![Circle CI](https://circleci.com/gh/kinesisptyltd/chef-nginx.svg?style=svg)](https://circleci.com/gh/kinesisptyltd/chef-nginx)

# chef-nginx

Installs the [nginx](http://nginx.org) web server. This has been heavily modified from [upstream](https://github.com/phlipper/chef-nginx) for my needs.

## Requirements

Only tested to be working on the following Ubuntu versions below, but may work on earlier versions too.

- Ubuntu 14.04

## Attributes

## LWRP

### nginx_site

## Usage

Just include `nginx` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[nginx]"
  ]
}
```
