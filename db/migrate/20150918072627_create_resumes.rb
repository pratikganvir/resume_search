class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.string :resume_pdf_file
      t.text :resume_text, :limit => 4294967295
      t.timestamps null: false
    end
  end
end
