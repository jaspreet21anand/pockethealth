require "test_helper"

class DicomFilesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dicom_files_url, as: :json
    assert_response :success
  end

  test "should create dicom_file" do
    assert_difference("DicomFile.count") do
      post dicom_files_url, params: { dicom_file: { name: "X-Rayscan 1",
                        dicom_image: Rack::Test::UploadedFile.new("test/fixtures/files/IM000012", "application/dicom") } }
    end

    assert_response :created
  end

  test "should return queried tag value from dicom_file" do
    post dicom_files_url, params: { dicom_file: { name: "X-Rayscan 1",
                      dicom_image: Rack::Test::UploadedFile.new("test/fixtures/files/IM000012", "application/dicom") },
                      tag: "0010,0030"
                    }

    json_body = JSON.parse(body)
    assert_equal("0010,0030", json_body["tag"])
    assert_equal("19880314", json_body["tag_value"])
    assert_response :created
  end
end
