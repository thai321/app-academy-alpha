class Student
  attr_accessor :first_name, :last_name, :courses

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = []
  end

  def name
    first_name + " " + last_name
  end

  def enroll(course)
    is_conflict = courses.any? { |c| c.conflicts_with?(course) }
    raise 'Already enrolled course' if is_conflict

    if !@courses.include?(course) && !course.students.include?(self)
      @courses << course
      course.students << self
    end
  end

  def course_load
    hash = Hash.new(0)
    @courses.each { |course| hash[course.department] += course.credits}
    hash
  end

end
