class DicomFile < ApplicationRecord
  attr_reader :parsed_dicom_file

  has_one_attached :dicom_image, dependent: :destroy
  has_one_attached :browser_viewable_image, dependent: :destroy


  validates :name, :dicom_image, presence: true
  validates :name, uniqueness: true, if: :present?
  validate :content_type_of_dicom_image

  after_commit :extract_and_convert_dicom_image, on: :create

  def get_tag_value(tag)
    return unless persisted?
    dicom_processor.get_tag_value(tag)
  end

  # View Helpers
  def dicom_image_url
    image_url(dicom_image) if dicom_image.present?
  end

  def browser_viewable_image_url
    image_url(browser_viewable_image) if browser_viewable_image.present?
  end

  def as_json
    { 
      name: name, dicom_image_url: dicom_image_url, browser_viewable_image_url: browser_viewable_image_url
    }
  end

  private
    def content_type_of_dicom_image
      if dicom_image.present? && dicom_image.content_type != "application/dicom"
        errors.add(:dicom_image, "Invalid dicom_image file. Only dicom file types are accepted")
      end
    end

    def extract_dicom_headers
      @parsed_dicom_file ||= dicom_processor.parse
    end

    def convert_dicom_to_browser_viewable_image
      self.browser_viewable_image.attach(File.open(DicomProcessor.convert_to_png(@parsed_dicom_file)))
    end

    def extract_and_convert_dicom_image
      begin
        extract_dicom_headers
        convert_dicom_to_browser_viewable_image
      rescue => e
        # Notify error in parsing
      end
    end

    def dicom_processor
      @dicom_processor ||= DicomProcessor.new(dicom_image)
    end

    def image_url(image)
      Rails.application.routes.url_helpers.rails_blob_url(image)
    end
end
