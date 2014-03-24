# Middleman Skeleton

A starter skeleton for [Middleman](http://middlemanapp.com) projects.

## Running the app

Setup:

    bundle install --binstubs

Running locally:

    bundle exec rake watch

Will spin up the server at <http://localhost:4567>

## Features

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

If you want to use it just run:

    bundle exec jasmine init

And it’ll create a dummy spec under `/spec`. You can now add any `spec.js` files
to `/spec/` and Jasmine will automatically run the tests using livereload at
<http://localhost:4567/jasmine/>.

Spec files are in the sprockets load path, so you can simply `//= require foo`
any specific files you need to test. At the moment specs have to be written
in JavaScript.

To remove this support:

1. Remove "middleman-jasmine" from the `Gemfile`.
2. Remove `activate :jasmine` from `config.rb`.
