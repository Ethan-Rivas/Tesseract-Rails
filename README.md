# Tesseract-Rails (DiaxyScan)

Basic Rails application created to try OCR Tesseract, using [rtesseract](https://github.com/dannnylo/rtesseract) gem

## Getting Started

In order to get this project running without any problem you should install some dependencies.

### Prerequisites

First of all, because of this project uses the [paperclip](https://github.com/thoughtbot/paperclip) gem you'll need to have [imagemagick](https://imagemagick.org/index.php) pre-installed in your system.

Some operative system have this library by default, but if this isn't your case you can download it from here:

```
https://imagemagick.org/script/download.php
```

Secondly, it is really neccesary to install the [OCR Tesseract](https://opensource.google.com/projects/tesseract) library on your system. 

Information related about how install it depending on your operative system:

```
https://github.com/tesseract-ocr/tesseract/wiki#installation
```

### Installing

In order to get the project running just:

Clone the repository

```
https://github.com/Ethan-Rivas/Tesseract-Rails.git
```

Go to the project folder and install all the dependencies/gems needed (Gemfile)

```
bundle install
```

Lastly, run the migrations needed to run the database

```
rails db:migrate
```

## Running the Project

To start the server just run

```
rails server
```

Open your browser and go to

```
http://localhost:3000
```

### Routes and Information

- /photos -> List of photos with buttons to watch PDF or TXT files.
- /photos/new -> Upload an image to the system and generates a PDF and TXT file and relates them with the image. 

```
@photo.document_path #PDF Path
@photo.text_path #TXT Path
```

- When an image is removed/deleted from the system both documents related to the image are deleted too.
