# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#   Create Roles
ActiveRecord::Base.connection.execute("insert into roles(name, created_at, updated_at) values ('admin', '#{Time.now}', '#{Time.now}'),
                                      ('user', '#{Time.now}', '#{Time.now}')")
#
#   Create Admin
admin_attributes = { :first_name => "admin", :last_name => "ADMIN", :email => "admin@gmail.com", 
                     :password => "admin@123", :password_confirmation => "admin@123" }
admin = User.create(admin_attributes)
admin.role_ids = [1]
