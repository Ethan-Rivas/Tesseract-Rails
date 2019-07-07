require 'fileutils'

class Photo < ApplicationRecord
   has_attached_file :image, :use_timestamp => false

   #This validates the type of file uploaded. According to this, only images are allowed.
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  before_destroy :delete_files

  def generate_pdf(lang)
    docs_folder = Dir.pwd + "/public/documents"
    file_base_name = File.basename(self.image.url, File.extname(self.image.url))

    # Tesseract will try to find this path outside your project
    # Using the current project location and passing the public folder will fix this "issue"
    image = RTesseract.new(Dir.pwd + "/public" + self.image.url, lang: lang)
    converted_img = image.to_pdf # Convert image to PDF

    # Because tesseract creates the PDF inside the tmp folder of our machine
    # Move file from the local tmp folder to project documents folder
    FileUtils.mv(converted_img, docs_folder)

    # Rename default tesseract file name with original file name (uploaded photo)
    base_name = File.basename(converted_img)
    File.rename(docs_folder + "/" + base_name, docs_folder + "/" + file_base_name + ".pdf")

    # To have a reference of what document belongs to a photo
    # Save the document path to it and set the title equal to the file base name
    pdf_path = "/documents/" + file_base_name + ".pdf"
    self.update_attribute(:document_path, pdf_path)
    self.update_attribute(:title, file_base_name)
  end

  def generate_text(lang)
    docs_folder = Dir.pwd + "/public/documents"
    file_base_name = File.basename(self.image.url, File.extname(self.image.url))

    # Tesseract will try to find this path outside your project
    # Using the current project location and passing the public folder will fix this "issue"
    image = RTesseract.new(Dir.pwd + "/public" + self.image.url, lang: lang)
    converted_img = image.to_s # Convert image to TEXT string

    # To have a reference of what text file belongs to a photo
    # Save the text path to it
    path_name = "#{docs_folder}/#{file_base_name}.txt"
    File.open(path_name, 'w') { |f| f.write(converted_img) }
    self.update_attribute(:text_path, "/documents/#{file_base_name}.txt")
  end

  def delete_files
    File.delete(Dir.pwd + "/public" + self.document_path) # Destroy PDF File
    File.delete(Dir.pwd + "/public" + self.text_path) # Destroy TXT FIle
  end
end
