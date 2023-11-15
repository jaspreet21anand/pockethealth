require "test_helper"

class DicomFileTest < ActiveSupport::TestCase
  setup do
    @dicom_file = DicomFile.new(name: "Xray Scan 1", dicom_image: File.open("test/fixtures/files/IM000012"))
  end

  test "name can not be blank" do
    @dicom_file.name = nil
    assert_not @dicom_file.valid?
    assert @dicom_file.errors[:name].present?, "Name field should contain errors"
  end

  test "application/dicom is valid" do
    assert @dicom_file.valid?
    assert_equal "application/dicom", @dicom_file.dicom_image.content_type
    assert @dicom_file.errors[:dicom_image].blank?, "invalid content type"
  end

  test "application/png is invalid" do
    @dicom_file.dicom_image = File.open("test/fixtures/files/test.png")
    assert_not @dicom_file.valid?
    assert_equal "image/png", @dicom_file.dicom_image.content_type
    assert @dicom_file.errors[:dicom_image].present?, "invalid content type"
  end

  test "as_json returns name and url fields" do
    @dicom_file.save
    assert @dicom_file.as_json.keys.include? :name
    assert @dicom_file.as_json.keys.include? :dicom_image_url
    assert @dicom_file.as_json.keys.include? :browser_viewable_image_url
  end

  test "after save browser_viewable_image is created and attached" do
    assert_not @dicom_file.browser_viewable_image.attached?
    @dicom_file.save
    assert @dicom_file.browser_viewable_image.attached?
  end

  test "get_tag_value returns early if the object does not persist" do
    assert_nil @dicom_file.get_tag_value("0010,0020")
  end

  test "get_tag_value returns value when object persists" do
    @dicom_file.save
    assert_not_nil @dicom_file.get_tag_value("0010,0020")
  end
end
