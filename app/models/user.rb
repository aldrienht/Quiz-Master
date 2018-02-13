class User < ApplicationRecord
  validates_uniqueness_of :fullname, message: "already registered!"
  validates_uniqueness_of :username, message: "must be unique!"
  validates_uniqueness_of :email

  validates_presence_of :fullname, :username, :email, :role
  validates_format_of :email, :with => /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,6}\Z/i

  has_secure_password

  
  def is_admin?
    self.role == 'admin'
  end

  def is_student?
    self.role == 'student'
  end

  def is_teacher?
    self.role == 'teacher'
  end
end
