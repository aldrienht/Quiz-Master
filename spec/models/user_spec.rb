require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_many(:questions) }
  it { should have_many(:exam_results).class_name('ExamResult') }
  # it { should have_many(:categories).through(:categorizations) }

  it 'should filter by role' do
    student = create(:student)
    teacher = create(:teacher)

    expect(User.all_students).to include(student)
    expect(User.all_teachers).to include(teacher)
  end

  it 'should validate presence of required fields' do
    record = User.new

    record.fullname = '' # invalid state
    record.valid? # run validations
    expect(record.errors[:fullname]).to include("can't be blank") # check for presence of error

    record.username = '' # invalid state
    record.valid? # run validations
    expect(record.errors[:username]).to include("can't be blank") # check for presence of error

    record.email = '' # invalid state
    record.valid? # run validations
    expect(record.errors[:email]).to include("can't be blank") # check for presence of error

    record.email = 'valid@email.com' # valid state
    record.valid? # run validations
    expect(record.errors[:email]).not_to include("can't be blank") # check for absence of error

    record.role = '' # invalid state
    record.valid? # run validations
    expect(record.errors[:role]).to include("can't be blank") # check for presence of error
  end

  it 'should valid uniqueness' do
    student = create(:student)

    user = User.new
    user.fullname = student.fullname
    user.valid?
    expect(user.errors[:fullname]).to include('must be unique!')

    user.username = student.username
    user.valid?
    expect(user.errors[:username]).to include('must be unique!')

    user.email = student.email
    user.valid?
    expect(user.errors[:email]).to include('must be unique!')
  end

  it 'should validate invalid email format' do
    user = User.new
    user.email = 'invalid-email'
    user.valid?
    expect(user.errors[:email]).to include('is invalid')
  end

  it 'should check user role' do
    admin = create(:admin)
    student = create(:student)
    teacher = create(:teacher)

    expect(admin.is_admin?).to eq(true)
    expect(student.is_student?).to eq(true)
    expect(teacher.is_teacher?).to eq(true)
  end
end
