include DICOM
class DicomProcessor

  TEMP_PATH = "tmp/tmpstorage/"

  def self.convert_to_png(parsed_dicom_file)
    parsed_dicom_file.image.normalize
      .write("#{TEMP_PATH}#{Time.current.to_i}.png")
      .filename
  end

  def initialize(file)
    @file = file
  end

  def parse
    @parsed_dicom = DObject.parse(@file.blob.download)
  end

  def get_tag_value(tag)
    @parsed_dicom || parse
    @parsed_dicom.value(tag)
  end
end