require 'meg-jsontoolkit'
require 'nokogiri'
require 'pry'

doc = Nokogiri::HTML IO.read "./test2.html"

doc.css('img').each do |image|
  source_path = image['src'].gsub 'file://localhost', ''
  image_data = Meg::Jsontoolkit.base64_encode_file source_path
  if image_data
    image['src'] = image_data 
    image['style'] = 'max-width:300px;'
  end
end

doc.css('table').each do |table|
  table.remove
end

IO.write 'test3.html', doc.to_s
