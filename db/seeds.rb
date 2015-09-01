class Seed
  def self.start
    seed = Seed.new
    seed.generate_companies
    seed.generate_categories
    seed.generate_projects
    seed.generate_customers
    seed.generate_company_admins
    seed.generate_jorge
  end

  def generate_projects
    500.times do |i|
      project = Project.create!(
        name: Faker::Commerce.product_name,
        description: Faker::Lorem.paragraph,
        image: Faker::Avatar.image,
        company_id: rand(1..20),
        category_id: rand(1..10),
        current_funding: rand(0..2000),
        funding_goal: rand(2000..20000),
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

  def generate_categories
    10.times do |i|
      category = Category.create!(
        name: Faker::Commerce.department
      )
      puts "Category #{i}: #{category.name} successfully created!"
    end
  end

  def generate_customers
    100.times do |i|
      customer = User.create!(
        username: Faker::Name.first_name,
        password: "password",
        email: Faker::Internet.email
      )
      puts "Customer #{i}: #{customer.username} successfully created!"
    end
  end

  def generate_company_admins
    20.times do |i|
      admin = User.create!(
        username: Faker::Name.first_name,
        password: "password",
        email: Faker::Internet.email,
        company_id: i + 1
      )
      puts "Company admin #{i}: #{customer.username} successfully created!"
    end
  end

  def generate_jorge
    jorge = User.create!(
      username: "jorge",
      password: "password",
      email: "jorge@turing.io",
      company_id: 1
    )
    puts "jorge successfully created!"
  end
end

Seed.start
