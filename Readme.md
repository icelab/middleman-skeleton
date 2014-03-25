# Middleman Skeleton

A starter skeleton for [Middleman](http://middlemanapp.com) projects. It’s worth
spending a little bit of time reading the
[Middleman docs](http://middlemanapp.com/basics/getting-started/) to get a bit
of an understand of what Middleman is supposed to do.

## Running the app

Setup:

    bundle install --binstubs

Running locally:

    bundle exec rake watch

Will spin up the server at <http://localhost:4567>

## Features

### Assets

The Rails asset-pipeline — Sprockets — is included out-of-the-box in Middleman.
This means we can use most, if not all, the niceties we’re used to using in
Rails.

* Sass
* CoffeeScript
* Sprockets’ `require` and `stub` directives

The Gemfile is also pre-configured to allow you to use [Bower](http://bower.io/)
packages through [rails-assets.org](http://rails-assets.org/). If there’s a
Bower package for a third-party bit of JavaScript you want to use, then
rails-assets is our preferred method of including that code.

Bundled rails-assets packages are automatically included in the asset pipeline
lookup, so most of the time you’ll be able to simply do something like
`//= require jquery` to include them. Note: you might have to `bundle open` the
specific rails-asset gem to check the exact location of the assets you want to
include.

### Templates

Templates are set up to use [Slim](http://slim-lang.com/) by default. You can
use `filename.html.slim` in the same way you’d expect in Rails (with the
exception of `/layouts`).

You can also use `.erb` if you have a particular need to.

### Content

In general Middleman maps files and folders in `/source` folder to URLs:

    /source/about/index.html.markdown -> /about/
    /source/about/contact-us.html.slim -> /about/contact-us/

As you can see those files can be either slim templates, or they can be
markdown if you have general content files to deal with.

### Data

You can make data available in your templates by adding YAML files to the
`/data` directory. For example, any data in `/data/example.yml` will be
available in templates under `data.example`.


### JSON

If you want to play around with JSON data, there’s support for it through
jbuilder. See `/source/index.json.jbuilder` for an example.

### React

Support for pre-processing React's JSX templates in `.js.jsx.coffee` and
`.js.jsx` files is included by default. Remember sure to include the
`###* @jsx React.DOM ###` (CoffeeScript) or  `/** @jsx React.DOM */` (JS)
comments at the beginning of the files.

To remove this support:

1. Remove "middleman-react" from the `Gemfile`.
2. Remove `activate :react` from `config.rb`.

### Testing

Out of the box the skeleton is set up for testing your JavaScript using
[Jasmine](http://jasmine.github.io/), it uses the
[`middleman-jasmine`](https://github.com/mrship/middleman-jasmine) gem.

There are some dummy spec files under `/spec`. If you add any `spec.js` files
to `/spec/` and Jasmine will automatically run the tests using livereload at
<http://localhost:4567/jasmine/>. You’ll need to restart Middleman after you
add new spec files.

Spec files are in the sprockets load path, so you can simply `//= require foo`
any specific files you need to test. At the moment specs have to be written
in JavaScript.

To remove this support:

1. Remove "middleman-jasmine" from the `Gemfile`.
2. Remove `activate :jasmine` from `config.rb`.
