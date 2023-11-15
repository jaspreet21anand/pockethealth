class DicomFilesController < ApplicationController

  # GET /dicom_files
  def index
    @dicom_files = DicomFile.all

    render json: @dicom_files
  end

  # POST /dicom_files
  def create
    @dicom_file = DicomFile.new(dicom_file_params)

    if @dicom_file.save
      tag_value = @dicom_file.get_tag_value(params[:tag])

      render json: @dicom_file.as_json
                    .merge(
                      { tag: params[:tag], tag_value: tag_value }
                    ),
                    status: :created
    else
      render json: @dicom_file.errors, status: :unprocessable_entity
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def dicom_file_params
      params.require(:dicom_file).permit(:dicom_image, :name)
    end
end
