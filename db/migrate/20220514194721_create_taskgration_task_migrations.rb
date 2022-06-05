class CreateTaskgrationTaskMigrations < ActiveRecord::Migration[7.0]
  def change
    create_table :taskgration_task_migrations do |t|
      t.string :name
      t.bigint :version
      t.text :description

      t.timestamps
    end
  end
end
