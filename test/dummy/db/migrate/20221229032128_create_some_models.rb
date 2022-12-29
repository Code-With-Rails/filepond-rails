# frozen_string_literal: true

class CreateSomeModels < ActiveRecord::Migration[7.0]
  def change
    create_table :some_models, &:timestamps
  end
end
