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
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_profile = {
      profile_quote: doc.css("div.profile-quote").text.strip,
      biography: doc.css("div.description-holder p").text
      }
      doc.css("div.social-icon-container a").each do |anchor|
        a = anchor['href']
        case
        when a.include?('twit')
          student_file[:twitter] = a
        when a.include?('link')
          student_file[:linkedin] = a
        when a.include?('git')
          student_file[:github] = a
        else
           student_file[:blog] = a
        end
    end
    student_profile
  end

end
