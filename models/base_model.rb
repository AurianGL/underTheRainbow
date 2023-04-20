require 'csv'

class BaseModel
  attr_accessor :id

  def initialize(attributes = {})
    @id = attributes[:id] || next_id
    update_attributes(attributes)
  end

  def self.all
    unless File.file?(csv_path)
      CSV.open(csv_path, "wb") do |csv|
        csv << attribute_names
      end
    end
    CSV.table(csv_path, headers: true, header_converters: :symbol).map do |row|
      new(row.to_h)
    end
    # CSV.read(csv_path).map do |row|
    #   new(id: row[0], **CSV.parse_line(row[1]))
    # end
  end

  def self.find(id)
    all.find { |model| model.id == id }
  end

  def self.create(attributes = {})
    model = new(attributes)
    model.save
    model
  end

  def attributes
    self.class.attribute_names.map { |attr| [attr, send(attr)] }.to_h
  end

  def update_attributes(attributes)
    attributes.each do |attr_name, value|
      setter_method = "#{attr_name}="
      if respond_to?(setter_method)
        send(setter_method, value)
      end
    end
  end

  def save
    # CSV.open(self.class.csv_path, 'a+') do |csv|
    #   csv << [id, to_csv]
    # end
    all_records = self.class.all
    record_index = all_records.find_index { |record| record.id == id }
    if record_index
      all_records[record_index] = self
    else
      all_records << self
    end
    CSV.open(self.class.csv_path, "wb") do |csv|
      csv << self.class.attribute_names
      all_records.each do |record|
        csv << record.attributes.values
      end
    end
  end

  def update(attributes = {})
    id = attributes[:id]
    if self.class.find(id)
      update_attributes(attributes)
      save
    else
      raise "Record with ID #{id} not found"
    end
  end

  def destroy
    self.class.all.reject! { |model| model.id == id }
    CSV.open(self.class.csv_path, 'w') do |csv|
      self.class.all.each do |model|
        csv << [model.id, model.to_csv]
      end
    end
  end

  def self.csv_path
    "#{self.name.downcase}s.csv"
  end

  def self.attribute_names
    @attribute_names ||= []
  end

  def self.attribute(name, type)
    attribute_names << name
    define_method(name) { instance_variable_get("@#{name}") }
    define_method("#{name}=") do |value|
      # if value.is_a?(type)
        instance_variable_set("@#{name}", value)
      # else
      #   raise ArgumentError, "Invalid type for #{name}: expected #{type}, got #{value.class} for #{value}"
      # end
    end
  end

  private

  def next_id
    all_ids = self.class.all.map(&:id)
    if all_ids.empty?
      1
    else
      max_id = all_ids.max
      next_id = max_id + 1
      while all_ids.include?(next_id)
        next_id += 1
      end
      next_id
    end
  end

  def to_csv
    instance_variables.map do |ivar|
      value = instance_variable_get(ivar)
      if value.is_a?(Time)
        value.to_s
      else
        value.to_s.gsub(',', '\,')
      end
    end.join(',')
  end
end
