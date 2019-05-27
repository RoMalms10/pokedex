class PokemonsController < ApplicationController
  require "open-uri" # Allows us to send GET requests and receive the response
  require "json" # Allows us to parse the reponse into a JSON object/hash

  def index
    @pokemons = Pokemon.all
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end

  def new
    puts("New method")

    @pokemon = Pokemon.new
  end

  def create
    puts("Create")
    params.require(:pokemon).permit(:name)
    name = params[:pokemon][:name]
    puts("the name", name)

    url = "http://pokeapi.co/api/v2/pokemon/#{name}"
    response = open(url).read
    json = JSON.parse(response)
    jsonMoves = json["moves"]
    moves = Array.new
    jsonMoves.each do |move|
      moves.push(move["move"]["name"])
    end
    jsonAbilities = json["abilities"]
    abilities = Array.new
    jsonAbilities.each do |ability|
      abilities.push(ability["ability"]["name"])
    end

    jsonTypes = json["types"]
    types = Array.new
    jsonTypes.each do |type|
      types.push(type["type"]["name"])
    end
    pokemon = Pokemon.create(:name => name, :abilties => abilities, :moves => moves, :types => types)
    puts(json["name"])
    puts(abilities)
    puts(moves)
    puts(types)

    redirect_to pokemon_path(pokemon)
  end
end
