require './app/models/digg_api'

class WelcomeController < ApplicationController
  def index
    response = DiggApi.get_response('http://digg.com/rss/top.rss')
    @digg_stories = DiggApi.parse(response.body)
  end
end