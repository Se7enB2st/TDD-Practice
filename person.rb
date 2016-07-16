# Use TDD principles to build out name functionality for a Person.
# Here are the requirements:
# - Add a method to return the full name as a string. A full name includes
#   first, middle, and last name. if middle_name is nil it won't add a extra spaces between

class Person
  def intialize(first_name:, middle_name: nil, last_name:)
    @first_name = first_name
    @middle_name = middle_name
    @last_name = last_name
  end

  def concatenates_full_name(first_name:,middle_name: nil,last_name:)
    if middle_name == nil
      "#{first_name} #{last_name}"
    else
      "#{first_name} #{middle_name} #{last_name}"
    end
  end
end

RSpec.describe Person do
  describe "#full_name"
  it "concatenates first name, middle name, and last name with spaces" do
    person = Person.new

    expect(person.concatenates_full_name(first_name:"Ethan",middle_name: "William",last_name:"He")).to eq("Ethan William He")
  end

  it "if middle name is emplty, it won't concatenates full name with extra space" do
    person = Person.new

    expect(person.concatenates_full_name(first_name:"Ethan",last_name: "He")).to eq("Ethan He")
  end
end
