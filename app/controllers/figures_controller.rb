class FiguresController < ApplicationController

    get '/figures' do
      @figures = Figure.all
      erb :'/figures/index'
    end

    get '/figures/new' do
      erb :'/figures/new'
    end

    post '/figures' do
      @figure = Figure.create(params[:figure])
    if !Landmark.all.include?(params[:landmark])
      new_landmark = Landmark.create(params[:landmark])
      @figure.landmarks << new_landmark
      @figure.save
    end
    if !Title.all.include?(params[:title])
      new_title = Title.create(params[:title])
      @figure.titles << new_title
      @figure.save
    end
      redirect :"/figures/#{@figure.id}"
    end

    get '/figures/:id' do
      @figure = Figure.find(params[:id])
      erb :'/figures/show'
    end

    get '/figures/:id/edit' do
      @figure = Figure.find(params[:id])
      erb :"/figures/edit"
    end

    patch '/figures/:id' do
      @figure = Figure.find(params[:id])
      @figure.name = (params[:figure][:name])
      new_landmark = Landmark.new(params[:landmark])
      @figure.landmarks << new_landmark
      @figure.save
      redirect to :"/figures/#{@figure.id}"
    end

end
