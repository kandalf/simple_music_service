module Response
  def json_response(object, status, extra_headers = {})
    response.headers.merge(extra_headers)
    render json: object, status: status
  end

  def json_created(body = {}, extra_headers = {})
    json_response(body, :created, extra_headers)
  end

  def json_bad_request(errors = {}, extra_headers = {})
    json_response({ errors: errors }, :bad_request, extra_headers)
  end

  def json_error(message = "Internal Server Error", extra_headers = {})
    json_response({ message: message }, :error, extra_headers)
  end
end
