class CreateEncryptableTestModels < ActiveRecord::Migration
  def change
    create_table :encryptable_test_models do |t|
      t.string :token
    end
  end
end
