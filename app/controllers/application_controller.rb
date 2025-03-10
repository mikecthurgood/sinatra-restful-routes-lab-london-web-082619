class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes/?' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    @recipe = Recipe.new
    erb :new
  end

  get '/recipes/:id' do
    id = params[:id]
    @recipe = Recipe.find(id)

    erb :show
  end

  post '/recipes/?' do
    @recipe = Recipe.create(params)
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id/edit' do
    id = params[:id]
    @recipe = Recipe.find(id)

    erb :edit
  end

  patch '/recipes/:id' do
    id = params[:id]
    @recipe = Recipe.find(id)
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save

    redirect "/recipes/#{@recipe.id}"
    erb :show
  end

  delete '/recipes/:id' do
    id = params[:id]
    Recipe.destroy(id)

    redirect "/recipes"
  end



end
