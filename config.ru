# frozen_string_literal: true

#\ -w -p 3000

require 'rack'
require 'json'
require_relative 'api_schema'

class Api
  def initialize(schema, context = {})
    @schema = schema
    @context = context
  end

  def response(response, status: 200)
    [
      200,
      {
        'Content-Type' => 'application/json',
        'Content-Length' => response.bytesize.to_s
      },
      [response]
    ]
  end

  def call(env)
    handle_request(env)
    result = build_result

    response(result, status: 200)
  end

  private

  attr_reader :payload

  def handle_request(env)
    request = Rack::Request.new(env)

    @payload = if request.get?
      request.params
    elsif request.post?
      body = request.body.read
      JSON.parse(body)
    end
  end

  def build_result
    ApiSchema.execute(
      @payload['query'],
      variables: payload['variables'],
      operation_name: payload['operationName'],
      context: @context
    ).to_json
  end
end

run Api.new(schema: ApiSchema)