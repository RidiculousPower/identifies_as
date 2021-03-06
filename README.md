# Identifies As #

http://rubygems.org/gems/identifies_as

# Summary #

Identities are interfaces. Sometimes it makes more sense to test an identity than a method- but then you don't want to limit flexibility.

So why not let objects that claim to implement your interface identify as your object?

IdentifiesAs permits objects to identify as if they are other types of objects.

# Description #

Provides IdentifiesAs, which offers :identifies_as!, :instances_identify_as!, :identifies_as?, :instances_identify_as?, :stop_identifying_as!, :stop_instances_identifying_as, :identities, :instance_identities, and overrides :is_a? and :===.

# Install #

* sudo gem install identifies_as

# Usage #

* Example One:

```ruby

class SomeOtherClass
end

class NotAnArray
  include IdentifiesAs
  instances_identify_as!( Array )
  identifies_as!( SomeOtherClass )
end

NotAnArray.is_a?( SomeOtherClass )
# => true

instance = NotAnArray.new

instance.identifies_as?( Array )
# => true

instance.is_a?( Array )
# => true

Array === instance
# => true
```

* Example Two:

```ruby
instance = Object.new

instance.extend( IdentifiesAs )

instance.identifies_as!( Array )

instance.identifies_as?( Array )
# => true

instance.is_a?( Array )
# => true

Array === instance
# => true
```

# License #

  (The MIT License)

  Copyright (c) Asher

  Permission is hereby granted, free of charge, to any person obtaining
  a copy of this software and associated documentation files (the
  'Software'), to deal in the Software without restriction, including
  without limitation the rights to use, copy, modify, merge, publish,
  distribute, sublicense, and/or sell copies of the Software, and to
  permit persons to whom the Software is furnished to do so, subject to
  the following conditions:

  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.