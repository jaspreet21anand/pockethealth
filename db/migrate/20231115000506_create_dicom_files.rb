class CreateDicomFiles < ActiveRecord::Migration[7.1]
  def change
    create_table :dicom_files do |t|
      t.text :data

      t.timestamps
    end
  end
end
