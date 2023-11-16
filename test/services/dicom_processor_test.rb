require "test_helper"

class DicomProcessorTest < ActiveSupport::TestCase
  setup do
    @dicom_file = DicomFile.new(name: "Xray Scan 1", dicom_image: File.open("test/fixtures/files/IM000012"))
  end

  test "test" do
  end
end