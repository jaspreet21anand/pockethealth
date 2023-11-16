require "test_helper"

class DicomProcessorTest < ActiveSupport::TestCase
  setup do
    @dicom_file = DicomFile.new(name: "Xray Scan 1", dicom_image: File.open("test/fixtures/files/IM000012"))
    @dicom_file.save

    @dicom_processor = DicomProcessor.new(@dicom_file.dicom_image)
  end

  test "convert_to_png returns filename of the png file created" do
    filename = DicomProcessor.convert_to_png(@dicom_file.parsed_dicom_file)
    assert filename.is_a? String
  end

  test "get_tag_value returns the queried tag" do
    assert_equal "19880314", @dicom_processor.get_tag_value("0010,0030")
  end
end