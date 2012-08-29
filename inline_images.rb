require 'meg-jsontoolkit'
require 'nokogiri'
require 'pry'

doc = Nokogiri::HTML IO.read "./test.html"

doc.css('img').each do |image|
  source_path = image['src'].gsub 'file://localhost', ''
  image_data = Meg::Jsontoolkit.base64_encode_file source_path
  image['src'] = image_data if image_data
end

doc.css('table').each do |table|
  table.remove
end

IO.write 'test2.html', doc.to_s
