class Seed
  def self.start
    seed = Seed.new
    seed.generate_companies
    seed.generate_projects
  end

  def generate_projects
    500.times do |i|
      project = Project.create!(
        name: Faker::Lorem.word,
        description: Faker::Lorem.paragraph,
        image: Faker::Avatar.image,
        company_id: rand(1..20),
        current_funding: rand(0..5000),
        funding_goal: rand(500..10000),
        end_date: Faker::Date.forward(30),
        )
      puts "Project #{i}: #{project.name} successfully created!"
    end
  end

  def generate_companies
    20.times do |i|
      company = Company.create!(
        name: Faker::Company.name,
        description: Faker::Company.catch_phrase,
        logo: Faker::Company.logo
      )
    puts "Company #{i}: #{company.name} successfully created!"
    end
  end
end

Seed.start
