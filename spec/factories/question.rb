FactoryBot.define do
  factory :question do
    content 'How many vowels are there in English Alphabet?'
    answer 5
    published true
    # association :teacher, factory: :teacher
	end

  factory :another_question, class: Question do
    content 'How many vowels are there in Filipino Alphabet?'
    answer 'five'
    published true
  end

  factory :invalid_question, class: Question do
    content ''
    answer ''
    published ''
    teacher_id ''
  end
end
