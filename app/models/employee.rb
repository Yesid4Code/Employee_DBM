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
    CSV.foreach(file.path, headers: true) do |row|
      employee_elements = row.to_h
      employee = find_or_create_by!(name: employee_elements['name'],
                                    last_name: employee_elements['last_name'],
                                    email: employee_elements['email'],
                                    phone: employee_elements['phone'],
                                    position: employee_elements['position'],
                                    salary: employee_elements['salary'],
                                    department: employee_elements['department'])
      employee.update(employee_elements)
    end
  end
  
end
