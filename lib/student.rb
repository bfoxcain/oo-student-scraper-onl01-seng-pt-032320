

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    #1takes in an argument of a hash and sets that new students's attributes 
    #using the key/value pairs of that hash
    #2adds that new student to the students class' collection of all 
    #existing students, stored in the '@@all' class variable
      self.send('name=', student_hash[:name])
      self.send('location=', student_hash[:location])
      self.send('profile_url=', student_hash[:profile_url])
      @@all << self
  end

  def self.create_from_collection(students_array)
    #uses the scraper class to the create new students with the correct 
    #name and location
    students_array.each do |student|
      self.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    #uses the scraper class to get a hash of a given students attributes
    #and uses that hash to set additional attributes for the students
    self.send("twitter=", attributes_hash[:twitter])
    self.send("linkedin=", attributes_hash[:linkedin])
    self.send("github=", attributes_hash[:github])
    self.send("blog=", attributes_hash[:blog])
    self.send("profile_quote=", attributes_hash[:profile_quote])
    self.send("bio=", attributes_hash[:bio])
    self.send("profile_url=", attributes_hash[:profile_url])
  end

  def self.all
    #returns the class variable @@all
    @@all
  end
end

