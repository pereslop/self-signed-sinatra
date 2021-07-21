require 'sinatra/base'
require 'sinatra/namespace'

class MyWay < Sinatra::Base
  configure do
    set :bind, '0.0.0.0'
    enable :logging
  end

  register Sinatra::Namespace
  namespace '/api' do
    get '/webhooks' do
      logger.info "WEBHOOK parameters: #{params}"
      params.merge({it_works: true}).inspect
    end

    post '/webhooks' do
      logger.info "WEBHOOK parameters: #{params}"
      params.merge({it_works: true}).inspect
    end
  end
end


