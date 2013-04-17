class StudentMailer < ActionMailer::Base
  default from: "UTCALDev@utcal.com"

  def sign_to_courses(prof, emails)
    @prof = prof
    @url = "http://99.228.135.47:3000/users/sign_to_courses"
    @newID = "1111"

    emails.each do |email|
      mail(:to => email, :subject => "Sign up for courses")
  
    end
  end
end
