class BaseService
  def initialize(params = {})
    @params = params
    @errors = []
  end
  
  def self.call(...)
    new(...).call
  end

  def call
    raise NotImplementedError, 'Subclasses must implement #call'
  end

  def success?
    @errors.empty?
  end

  def errors
    @errors
  end

  private

  attr_reader :params

  def add_error(error)
    @errors << error
  end
end
