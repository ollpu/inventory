class IndexController < ApplicationController
  def index
    authorize :index
  end
end
