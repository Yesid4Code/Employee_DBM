class Employee < ApplicationRecord
  def self.to_csv(fields = column_names, options = {})
    CSV.generate(options) do |csv|
      csv << fields
      all.each do |employee|
        csv << employee.attributes.values_at(*fields)
      end
    end
  end

  def self.import(file)
  end
end
