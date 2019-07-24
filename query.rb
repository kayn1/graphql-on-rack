# frozen_string_literal: true

require 'graphql'

class QueryType < GraphQL::Schema::Object
  description 'Hello World Query'

  field :say_hello, String, null: false

  def say_hello
    'Hello from Graphql!'
  end
end
