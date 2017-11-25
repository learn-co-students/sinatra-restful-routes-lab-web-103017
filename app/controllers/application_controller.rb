class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
#index page_lists everything.

  get '/recipes' do
    @all_recipes = Recipe.all
    erb :index
  end

#create
  get '/recipes/new' do
    erb :new
  end
  post '/recipes'do
    @new_recipe = Recipe.create(:name => params["name"], :ingredients => params["ingredients"], :cook_time => params["cook_time"])
    redirect to "/recipes/#{params[:id]}"
  end
#read
  get '/recipes/:id' do
    @a_recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

#update
  get '/recipes/:id/edit' do
    @a_recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @a_recipe = Recipe.find_by_id(params[:id])
    @a_recipe.name = params["name"]
    @a_recipe.ingredients = params["ingredients"]
    @a_recipe.cook_time = params["cook_time"]
    @a_recipe.save
    redirect to "/recipes/#{params[:id]}"
  end
#delete
  delete '/recipes/:id/delete' do
    @a_recipe = Recipe.find_by_id(params[:id])
    @a_recipe.delete
    redirect to '/recipes'
  end
end
