# EasyApiDoc

This project rocks and uses MIT-LICENSE.

## Installation
Add to your application's Gemfile:

    gem 'easy_api_doc'

or

    gem 'easy_api_doc', :git => 'git@github.com:AbleTech/easy_api_doc.git'

## Usage

### Config files

See *test/dummy/doc/api_doc.yml* for an example YAML config file.

This project is a work in progress, and doesn't hold your hand with validating the config file format yet.
It's current supported format is: (nodes named with <> are to be named whatever you like)

Use the rails convention of specifying dynamic url paramaters via `:id`

    api:
      <version_number>:
        defaults:
          domain: api.example.com
          protocol: http
          ...
        <namespace>:
          description: "..."
          detail:      "..."
          formats: "json, xml"
          authentication:
            type: basic
            user: admin
            password: password
          resources:
            <users>:
              description: "..."
              actions:
                <update>:
                  http_method: POST
                  uri: /users/:id
                  description: "..."
                  parameters:
                    <id>:
                      type: integer
                      example: 1
                    <account_type>:
                      type: string
                      default: personal
                    <nested_record>:
                      <nested_attr>:
                        type: string
                        example: test@example.com

### Routes
Add to your application's routes.rb:

    mount EasyApiDoc::Engine => "/api_docs"

## Options
Put your options in an initializer, like *config/initializers/easy_api_doc.rb*

Example:

    EasyApiDoc.options do |options|
        # options here
    end


### Authentication
By default authentication is non-existent and anyone can access the docs.
You can specify authentication like so...

    options.authenticate_with do
        authenticate_user!
    end

Whatever you pass to `authenticate_with` is evaluated as a before_filter on EasyApiDoc controllers.
The example above uses the Devise method `authenticate_user!`

### Authorization
There is no authorization unless specified. Anyone can access anything.

#### Custom
Whatever you pass to `authorize_with` is evaluated as a before_filter on EasyApiDoc controllers.

    options.authorize_with do
      redirect_to root_path unless user.is_admin?
    end

#### CanCan
You can use [CanCan](https://github.com/ryanb/cancan) to authorize access.

You need to send `:cancan` to the `athorize_with` option. You *must* also send (as a second parameter) the name of the method used to access the current user. e.g. with Devise this is `current_user`.

    options.authorize_with :cancan, :current_user
