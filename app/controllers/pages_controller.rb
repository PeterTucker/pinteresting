# Three places to add a new page: 
# 1. under the controller method under pages_controller.rb
# 2. create a page: home.html.erb
# 3. then finally under routes.rb: get 'about' =>'pages#about'
class PagesController < ApplicationController
  def home
  end

  def about
  end
end
