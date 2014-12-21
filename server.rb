require 'sinatra'
require 'net/http'
require 'uri'
require 'json'
require 'active_support/inflector'

set :erb, layout: true

FIELDS = {
  "Times died"                  => "stat.deaths",
  "Times killed by <%= arg %>"  => "stat.entityKilledBy",
  "<%= arg.pluralize %> killed" => "stat.killEntity",
}

get '/' do
  errors = []

  locals = {}
  users = {}

  stats_path = ENV['STATS_PATH']
  if (stats_path)
    Dir.glob("#{stats_path}/*").each do |file|
      # Parse the user's UUID from their file name
      # *A hack?* Actually, no. It's the only way to do it
      uuid = file.match(/([\w|-]*).json/).captures.first.delete("-")

      # Request this user's names from the Mojang API
      uri = URI("https://api.mojang.com/user/profiles/#{uuid}/names")
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        request = Net::HTTP::Get.new(uri)
        http.request(request)
      end

      # If the server gives a proper reply, add first name in history to list
      if response.code == '200'
        username = JSON.parse(response.body).first
        user_data = JSON.parse(File.read(file))

        # The running time of this is like O(n^2). Not cool.
        user = {}
        FIELDS.each do |field_name, field_start|
          user_data.each do |key, value|
            if key.start_with?(field_start)
              # Parse arg from stats key name
              arg = key.match(/\.(\w*)$/).captures.first

              # Put the arg in the field name
              new_key = ERB.new(field_name).result(binding)
              user[new_key] = value
            end
          end
        end

        # Add user's data to hash
        users[username] = user
      end
    end
  else
    errors.push("The STATS_PATH environment variable has not been set")

    locals[:errors] = errors
  end

  locals[:users] = users
  erb :index, locals: locals
end
