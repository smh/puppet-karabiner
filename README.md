# Karabiner Puppet Module for Boxen

[![Build Status](https://travis-ci.org/boxen/puppet-karabiner.svg?branch=master)](https://travis-ci.org/boxen/puppet-karabiner)

Installs [Karabiner](http://pqrs.org/macosx/karabiner/index.html.en) on your Mac.

**Note**: This module was previously known as [puppet-keyremap4macbook](https://github.com/boxen/puppet-keyremap4macbook).
This is a continuation of that module to accomodate the name change as of `10.0.0`.

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

# create & select the profile 'foo' (default profile is 'Default')
karabiner::profile{ 'foo': }

# set the parameter.keyoverlaidmodifier_timeout to 300 in profile 'foo'
karabiner::set{ 'parameter.keyoverlaidmodifier_timeout':
  value   => '300',
  profile => 'foo'
}
```

## Required Puppet Modules

* `boxen`
* `osx`

## Development

Write code. Run `script/cibuild` to test it. Check the `script`
directory for other useful tools.
