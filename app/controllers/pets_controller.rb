require 'pry'
class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = find_pet()
    @owners = Owner.all
    erb :'/pets/edit'
  end

  post '/pets' do 
    owner = params[:owner_id] ? 
            find_owner() : 
            Owner.create(name: params[:create_owner])
    @pet = Pet.create(name: params[:pet_name], owner_id: owner.id)
    redirect to "pets/#{@pet.id}"
  end

  patch '/pets/:id' do 
    pet = find_pet()
    owner = params[:new_owner_name] != "" ? 
            Owner.create(name: params[:new_owner_name]) : 
            Owner.find_by(name: params[:owner][:name])
            
    pet.update(name: params[:pet_name], owner_id: owner.id)
    redirect to "pets/#{@pet.id}"
  end

  def find_pet()
    Pet.find(params[:id])
  end

  def find_owner()
    Owner.find(params[:owner_id])
  end

end