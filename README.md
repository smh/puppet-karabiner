# Karabiner Puppet Module for Boxen

[![Build Status](https://travis-ci.org/boxen/puppet-karabiner.png?branch=master)](https://travis-ci.org/boxen/puppet-karabiner)

Installs [Karabiner](http://pqrs.org/macosx/karabiner/index.html.en) on your Mac.

## Usage

```puppet
include karabiner

# launch and add login-item
include karabiner::login_item

# enable remapping left control to left control + escape
karabiner::remap{ 'controlL2controlL_escape': }

# set the parameter.keyoverlaidmodifier_timeout to 300
karabiner::set{ 'parameter.keyoverlaidmodifier_timeout':
  value => '300'
}

# set the contents of the private.xml file.
karabiner::private_xml{ 'private.xml':
  content => '<some>xml</some>'
}
```

## Required Puppet Modules

* `boxen`
* `osx`

## Development

Write code. Run `script/cibuild` to test it. Check the `script`
directory for other useful tools.
