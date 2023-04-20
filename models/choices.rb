require_relative 'base_model'

class Choice < BaseModel
  attribute :id, Integer
  attribute :type, String
  attribute :content, Array

  def initialize(attributes = {})
    super(attributes)
  end
end