require_relative "./controllers/choices_controller"
require 'uri'

class Router
  def self.route(url)
    # Split the URL into its parts
    url = URI.encode(url)
    url_parts = url.split("?")[0].split("/")
    controller_name = url_parts[0].capitalize + "Controller"
    action_name = url_parts[1]

    # Extract the query parameters and parse them into a hash
    query_string = url.split("?")[1]
    query_params = query_string.nil? ? {} : URI.decode_www_form(query_string).to_h

    # Dynamically instantiate the controller based on the URL
    controller = Object.const_get(controller_name).new

    # Call the controller action with any URL parameters and query parameters
    if query_params.empty?
      if url_parts.length == 3
        controller.send(action_name)
      else
        controller.send(action_name, *url_parts[3..-1])
      end
    else
      controller.send(action_name, *url_parts[3..-1], query_params)
    end
  end
end