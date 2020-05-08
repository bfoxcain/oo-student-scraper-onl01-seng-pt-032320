require 'open-uri'
require 'pry'
require 'Nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    #is a class method tht scrapes the student index page and returns
    #an array of hashes in which each has represents on student
    student_array = []
    html = Nokogiri::HTML(open(index_url))
    html.css(".student-card").collect do |student|
      student_info = {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a").attribute("href").value
      }
      student_array << student_info
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    #is a class method that scrapes a student's profile page and returns
    #a hash of attributes describing an individual student
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    links = doc.css(".social-icon-container").children.css("a").map do |platform|
      student_platform = "#{platform.attr('href')}"
    end
    student_hash = {}
    links.each do |link|
      if link.include?("twitter")
        student_hash[:twitter] = link
      elsif link.include?("linkedin")
        student_hash[:linkedin] = link
      elsif link.include?("github")
        student_hash[:github] = link
      else
        student_hash[:blog] = link
      end
      student_hash[:profile_quote] = doc.css(".profile-quote").text
      student_hash[:bio] = doc.css(".description-holder").children.css("p").text
    end
    student_hash
  end

end

