class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.string :usuario
      t.string :contenido

      t.timestamps
    end
  end
end
