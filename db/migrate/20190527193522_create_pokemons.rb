class CreatePokemons < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.string :moves
      t.string :abilities
      t.string :types

      t.timestamps
    end
  end
end
