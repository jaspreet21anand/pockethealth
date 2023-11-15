require "test_helper"

class DicomFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dicom_file = DicomFile.new(name: "Xray Scan 1", dicom_image: File.open("test/fixtures/files/IM000012"))
  end

  test "should get index" do
    get dicom_files_url, as: :json
    assert_response :success
  end

  test "should create dicom_file" do
    assert_difference("DicomFile.count") do
      post dicom_files_url, params: { dicom_file: { data: @dicom_file.data } }, as: :json
    end

    assert_response :created
  end
end
