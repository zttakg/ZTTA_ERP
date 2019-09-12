module Ckeditor
  class Picture < Ckeditor::Asset
    mount_uploader :data, CkeditorPictureUploader, mount_on: :data_file_name

    def url_content
      ENV['URL_CURRENT_SERVER'] + url(:content)
    end

    def self.inheritance_column
      nil
    end
  end
end
