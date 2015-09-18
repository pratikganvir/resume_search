class Resume < ActiveRecord::Base
  mount_uploader :resume_pdf_file, ResumeUploader
 #  before_create :save_resume_text

 #  def save_resume_text
 #  	reader = PDF::Reader.new(resume_pdf_file.path)
 #    text = []

	# reader.pages.each do |page|
	#   text << page.text
	# end
	# resume_text = text.join
	# byebug
 #  end
end
