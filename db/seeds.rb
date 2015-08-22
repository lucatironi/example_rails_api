User.create(email: "admin@example.com", password: "password")

[
  { full_name: "John Doe",   email: "john.doe@example.com",   phone: "033 1234 5678"},
  { full_name: "Mark Smith", email: "mark.smith@example.com", phone: "034 6789 1234"},
  { full_name: "Tom Clark",  email: "tom.clark@example.com",  phone: "033 4321 9876"},
  { full_name: "Sue Palmer", email: "sue.palmer@example.com", phone: "034 9876 1234"},
  { full_name: "Kate Lee",   email: "kate.lee@example.com",   phone: "033 6789 4321"}
].each do |customer_attributes|
  Customer.create(customer_attributes)
end
