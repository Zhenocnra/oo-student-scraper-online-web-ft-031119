require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    source = Nokogiri::HTML(open(index_url))
    student_index_array = []
    source.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_full_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        student_profile_url = "#{student.attr('href')}"
        student_index_array << {name: student_full_name, location: student_location, profile_url: student_profile_url}
      end
    end
    student_index_array
  end

  def self.scrape_profile_page(profile_url)

  end

end
