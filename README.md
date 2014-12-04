# Tribune::SvgoWrapper

This is a simple wrapper for the `svgo` command line tool.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tribune-svgo_wrapper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tribune-svgo_wrapper

## Usage

```ruby
require "svgo_wrapper"

# Create a wrapper with enabled and disabled plugins.
# All attributes are optional.
wrapper = SvgoWrapper.new enabled: :removeTitle,
                          disabled: [:convertColors, :removeMetadata],
                          timeout: 10 # seconds

# Parse image data
wrapper.optimize_images_data " <svg> </svg> "  #=> "<svg/>\n"
```
