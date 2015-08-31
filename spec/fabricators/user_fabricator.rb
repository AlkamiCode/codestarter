Fabricator(:user) do
  username "marla"
  password "password"
  password_confirmation "password"
  email "user@email.com"
  company_id ""
  transient :roles

  after_build do |user, transients|
    if transients[:roles]
      transients[:roles].each do |role|
        user.roles << Role.where(name: role).first_or_initialize
      end
    end
  end
end
