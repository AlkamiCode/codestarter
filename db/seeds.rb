class Seed
  def self.start
    seed = Seed.new
    seed.generate_projects
  end

  def generate_projects
    500.times do |i|
      project = Project.create!(
        name: Faker::Book.title,
        description: Faker::Lorem.paragraph,
        image_url: Faker::Avatar.image,
        company_id: rand(1..20)
        )
      puts "Category #{i}: #{category.name} successfully created!"
    end
  end
end

Seed.start
