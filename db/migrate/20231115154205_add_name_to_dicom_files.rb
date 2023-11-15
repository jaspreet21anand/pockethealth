class AddNameToDicomFiles < ActiveRecord::Migration[7.1]
  def change
    add_column :dicom_files, :name, :string
  end
end
