class ResumesController < ApplicationController
  before_action :set_resume, only: [:show, :edit, :update, :destroy]

  # GET /resumes
  # GET /resumes.json
  def index
    @resumes = Resume.all
  end

  # GET /resumes/1
  # GET /resumes/1.json
  def show
    send_file File.open(@resume.resume_pdf_file.path), :disposition => 'attachment'
  end

  # GET /resumes/new
  def new
    @resume = Resume.new
  end

  # GET /resumes/1/edit
  def edit
  end

  # POST /resumes
  # POST /resumes.json
  def create
  if resume_params[:resume_pdf_file].nil?
    redirect_to :action => :new, :notice => 'Please select pdf file'
  elsif File.extname(resume_params[:resume_pdf_file].tempfile) == '.pdf'
      @resume = Resume.new(resume_params)
      reader = PDF::Reader.new(resume_params[:resume_pdf_file].tempfile)
      text = []

      reader.pages.each do |page|
        text << page.text
      end
      @resume.resume_text = text.join
      respond_to do |format|
        if @resume.save
          format.html { redirect_to @resume, notice: 'Resume was successfully created.' }
          format.json { render :show, status: :created, location: @resume }
        else
          format.html { render :new }
          format.json { render json: @resume.errors, status: :unprocessable_entity }
        end
      end
   else
    redirect_to :action => :new, :notice => 'Please select pdf file'
   end
  end

  # PATCH/PUT /resumes/1
  # PATCH/PUT /resumes/1.json
  def update
    respond_to do |format|
      if @resume.update(resume_params)
        format.html { redirect_to @resume, notice: 'Resume was successfully updated.' }
        format.json { render :show, status: :ok, location: @resume }
      else
        format.html { render :edit }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resumes/1
  # DELETE /resumes/1.json
  def destroy
    @resume.destroy
    respond_to do |format|
      format.html { redirect_to resumes_url, notice: 'Resume was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @resumes = Resume.where('resume_text like ?',"%#{params[:search_term]}%") if params[:search_term]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resume
      @resume = Resume.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resume_params
      params.require(:resume).permit(:resume_pdf_file,:resume_text)
    end
end
