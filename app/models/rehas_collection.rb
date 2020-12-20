class RehasCollection
  
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  REHA_NUM = 40
  attr_accessor :collection

  def initialize(attributes = [])
    if attributes.present?
      self.collection = attributes.map do |value|
        Reha.new(
          user_id: value['user_id'],
          patient_id: value['patient_id'],
          day: value['day'],
          unit: value['unit']
        )
      end
    else
      self.collection = REHA_NUM.times.map{ Reha.new }
    end
  end

  def persisted?
    false
  end

  def save
    is_success = true
    ActiveRecord::Base.transaction do
      collection.each do |result|
        result.save
      end
      raise ActiveRecord::RecordInvalid unless is_success
    end
    rescue
      p 'エラー'
    ensure
      return is_success
  end
end