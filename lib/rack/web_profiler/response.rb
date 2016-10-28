module Rack
  #
  class WebProfiler::Response < Rack::Response
    def initialize(request, body=[], status=200, header={})
      @request = request
      @version = "1.0"
      @version = "1.1" unless request.env["SERVER_PROTOCOL"] == "HTTP/1.0"

      super(body, status, header)
    end

    # Get full HTTP response in HTTP format.
    #
    # @return [String]
    def raw
      _headers = headers.map {|k, v| "#{k}: #{v}\r\n"}.join
      status_text = Rack::Utils::HTTP_STATUS_CODES[status]
      sprintf "HTTP/%s %s %s\r\n%s\r\n%s", @version, status, status_text, _headers, body.join
    end
  end
end