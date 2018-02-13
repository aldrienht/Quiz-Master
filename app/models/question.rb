class Question < ApplicationRecord
  validates_presence_of :content, :answer
end
