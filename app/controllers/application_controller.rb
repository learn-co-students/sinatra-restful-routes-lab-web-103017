class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :"../views/index"
  end

  get '/recipes/new' do
    erb :"../views/new"
  end

  post '/recipes' do
    binding.pry
    @recipe = Recipe.create(name: params['name'], ingredients: params['recipe']['ingredients'], cook_time: params['recipe']['cook_time'])
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :"../views/show"
  end

  get '/recipes/:id/edit' do  #load edit form
    @recipe = Recipe.find_by_id(params[:id])
    erb :'../views/edit'
  end

  patch '/recipes/:id' do #edit action
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.update(name: params['recipe']['name'], ingredients: params['recipe']['ingredients'], cook_time: params['recipe']['cook_time'])
    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id/delete' do #delete action
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.destroy
    redirect to "/recipes"
  end


end
