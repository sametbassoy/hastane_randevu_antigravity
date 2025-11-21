require 'net/http'
require 'json'
require 'uri'

BASE_URL = 'http://localhost:3000'

def request(method, path, body = nil)
  uri = URI("#{BASE_URL}#{path}")
  http = Net::HTTP.new(uri.host, uri.port)
  request = case method
            when :get then Net::HTTP::Get.new(uri)
            when :post then Net::HTTP::Post.new(uri)
            end
  request['Content-Type'] = 'application/json'
  request.body = body.to_json if body
  response = http.request(request)
  puts "#{method.upcase} #{path} => #{response.code}"
  JSON.parse(response.body) rescue response.body
end

# 1. Create Doctor (via console/seeds usually, but here we assume DB is empty or we seed it)
# Since we don't have an endpoint to create doctors, we'll use Rails runner to seed data first.

puts "Seeding data..."
system("bundle exec rails runner \"Doctor.create!(name: 'Dr. House', specialization: 'Diagnostician', available_from: Time.now, available_to: Time.now + 8.hours); Patient.create!(name: 'John Doe', email: 'john@example.com', phone: '1234567890')\"")

# 2. List Doctors
puts "\nListing Doctors..."
doctors = request(:get, '/doctors/available')
puts doctors.inspect

if doctors.any?
  doctor_id = doctors.first['id']
  # We need a patient ID, let's assume 1 or fetch it if we had an endpoint.
  # We know we just created one, so it should be the last one.
  # Ideally we'd have an endpoint for patients too, but for this task we only have 2 endpoints.
  # We'll fetch patient ID via runner or just guess it's the latest.
  patient_id = `bundle exec rails runner "print Patient.last.id"`.to_i
  
  # 3. Create Appointment
  puts "\nCreating Appointment..."
  appointment = request(:post, '/appointments', {
    appointment: {
      doctor_id: doctor_id,
      patient_id: patient_id,
      appointment_time: Time.now + 3600
    }
  })
  puts appointment.inspect
else
  puts "No doctors found!"
end
