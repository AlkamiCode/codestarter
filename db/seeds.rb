class Seed
  def self.start
    seed = Seed.new
    seed.generate_companies
    seed.generate_categories
    seed.generate_projects
    seed.generate_registered_user_role
    seed.generate_former_collaborator_role
    seed.generate_company_admin_role
    seed.generate_collaborator_role
    seed.generate_customers
    seed.generate_company_admins
    seed.generate_alkami
  end

  def generate_projects
    500.times do |i|
      project = Project.create!(
        name: Faker::App.name,
        description: Faker::Hacker.say_something_smart,
        image: Faker::Company.logo,
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
        username: Faker::Name.first_name + "#{i}",
        password: "password",
        email: Faker::Internet.email,
      )
      customer.roles << Role.find(rand(1..2))
      puts "Customer #{i}: #{customer.username} successfully created!"
    end
  end

  def generate_company_admins
    20.times do |i|
      admin = User.create!(
        username: Faker::Name.last_name + "#{i}",
        password: "password",
        email: Faker::Internet.email,
        company_id: i + 1,
      )
      admin.roles << Role.find(3)
      puts "Company admin #{i}: #{admin.username} successfully created!"
    end
  end

  def generate_alkami
    alkami = User.create!(
      username: "alkami",
      password: "alkami21",
      email: "dmitry@alkami.io",
      company_id: 1,
    )
    alkami.roles << Role.find(3)
    puts "alkami successfully created!"
  end

  def generate_registered_user_role
    Role.create!(name: "registered_user")
    puts "Registered user role successfully created!"
  end

  def generate_company_admin_role
    Role.create!(name: "company_admin")
    puts "Company admin role successfully created!"
  end

  def generate_collaborator_role
    Role.create!(name: "collaborator")
    puts "Collaborator role successfully created!"
  end

  def generate_former_collaborator_role
    Role.create!(name: "former_collaborator")
    puts "Former collaborator role successfully created!"
  end
end

Seed.start
