class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.string :resume_pdf_file

      t.timestamps null: false
    end
  end
end
