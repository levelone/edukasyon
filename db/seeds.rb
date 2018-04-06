require 'faker'

def create_courses
  faker_educator = Faker::Educator.unique

  Course::LOCAL_IMAGE_URLS.each do |img_url|
    Course.create!(
      name: "#{faker_educator.course}",
      description: Faker::Lorem.paragraph,
      image_url: img_url
    )
  end
end

def create_teachers
  faker_name = Faker::Name.unique
  faker_internet = Faker::Internet.unique

  (0..9).each do |n|
    Teacher.create!(
      first_name: faker_name.first_name,
      last_name: faker_name.last_name,
      email: faker_internet.email,
      password: 'password',
      password_confirmation: 'password',
      image_url: Teacher::LOCAL_IMAGE_URLS.sample
    )
  end
end

def create_students
  faker_name = Faker::Name.unique
  faker_internet = Faker::Internet.unique

  Student.create!(
    first_name: faker_name.first_name,
    last_name: faker_name.last_name,
    email: 'test_student@edukasyon.com',
    password: 'Password123',
    password_confirmation: 'Password123'
  )

  (0..19).each do |n|
    Student.create!(
      first_name: faker_name.first_name,
      last_name: faker_name.last_name,
      email: faker_internet.email,
      password: 'password',
      password_confirmation: 'password'
    )
  end
end

def create_klasses
  course_ids = Course.pluck(:id)

  Teacher.all.each do |teacher|
    n = (1..5).to_a.sample
    course_ids.sample(n).each do |course_id|
      if teacher.klasses.where(course_id: course_id).blank?
        teacher.klasses.create!(course_id: course_id)
      end
    end
  end
end

def enroll_students
  students = Student.all
  offered_klasses = Klass.offered_klasses

  students.each do |student|
    n = (1..5).to_a.sample
    offered_klasses.sample(n).each do |klass|
      Klass.create!(
        student_id: student.id,
        course_id: klass.course_id,
        teacher_id: klass.teacher_id
      )
    end
  end
end

def create_reviews
 students = Student.all

 students.each do |student|
   student.klasses.each do |klass|
     n = (1..5).to_a.sample
     review = Review.new(description: Faker::Lorem.sentence, rating: n)
     review.save!
     klass.review_id = review.id
     klass.save!
   end
 end
end

ActiveRecord::Base.transaction do
  create_courses
  create_teachers
  create_klasses
  create_students
  enroll_students
  create_reviews
end
