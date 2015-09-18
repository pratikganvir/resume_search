json.array!(@resumes) do |resume|
  json.extract! resume, :id, :resume_pdf_file
  json.url resume_url(resume, format: :json)
end
