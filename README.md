Underscore templates compiler for Ruby
====================================================

Imagine, you've got a rails project using
[Backbone.js](http://documentcloud.github.com/backbone) and just want to use
the [Underscore.js](http://documentcloud.github.com/underscore/)'s
[`_.template` function](http://documentcloud.github.com/underscore/#template)
without having an anonymous function like
[ejs](http://github.com/sstephenson/ruby-ejs) does.
`underscore-template` allows you to use
[`sprockets`](http://github.com/sstephenson/sprockets)'s'
[`JST`](https://github.com/sstephenson/sprockets#javascript-templating-with-ejs-and-eco)
templating directly with `_.template` function

Just add this to your `Gemfile` :

    gem 'underscore-template'

    <!-- templates/hello.jst._ -->
    <div>Hello, <span><%= name %></span>!</div>

    // application.js
    //= require templates/hello
    $("#hello").html(JST["templates/hello"]({ name: "Sam" }));

Invoke the function in a JavaScript environment to produce a string
value. You can pass an optional object specifying local variables for
template evaluation.

The underscore template tag syntax is as follows:

* `<% ... %>` silently evaluates the statement inside the tags.
* `<%= ... %>` evaluates the expression inside the tags and inserts
  its string value into the template output.
* `<%- ... %>` behaves like `<%= ... %>` but HTML-escapes its output.

If you have the [ExecJS](https://github.com/sstephenson/execjs/)
library and a suitable JavaScript runtime installed, you can pass a
template and an optional hash of local variables to `UnderscoreTemplate.evaluate`:

    Underscore::Template.evaluate("Hello <%= name %>", :name => "world")
    # => "Hello world"

-----

&copy; 2012 Jean-Sébastien Ney

(actually most of credits goes to [@sstephenson](http://github.com/sstephenson))

Released under the MIT license
