# frozen_string_literal: true

require 'graphql'
require_relative 'query'

class ApiSchema < GraphQL::Schema
  query QueryType
end
