require "rails_helper"

RSpec.describe "PermissionService", type: :model do
  let(:allowed) { PermissionService.new(user).allow?(controller, action) }

  context "as a registered user" do
    let(:user) { Fabricate(:user, roles: %w(registered_user)) }

    { "homepage#index" => true,
      "projects#index" => true,
      "projects#show" => true,
      "categories#index" => true,
      "categories#show" => true,
      "companies#index" => true,
      "companies#show" => true,
      "companies/companies#dashboard" => nil,
      "companies/projects#index" => true,
      "companies/projects#show" => true,
      "companies/projects#create" => nil,
      "companies/projects#edit" => nil,
      "companies/projects#update" => nil,
      "companies/projects#destroy" => nil,
      "companies/users#index" => nil,
      "companies/users#new" => nil,
      "companies/users#create" => nil,
      "companies/users#search" => nil,
      "sessions#new" => true,
      "sessions#create" => true,
      "sessions#destroy" => true,
      "users#show" => true,
      "users#update" => true,
      "cart_items#index" => true,
      "cart_items#create" => true,
      "cart_items#update" => true,
      "cart_items#destroy" => true,
      "orders#index" => true,
      "orders#show" => true,
      "orders#create" => true,
      "users#create" => nil }.each do |pair, result|

      context "looking at #{pair}" do
        let(:controller) { pair.split('#').first }
        let(:action) { pair.split('#').last }

        it "#{result ? 'allows' : 'denies'} access" do
          expect(allowed).to be(result)
        end
      end
    end
  end

  context "as a guest user" do
    let(:user) { Fabricate(:user) }

    { "homepage#index" => true,
      "projects#index" => true,
      "projects#show" => true,
      "categories#index" => true,
      "categories#show" => true,
      "companies#index" => true,
      "companies#show" => true,
      "companies/companies#dashboard" => nil,
      "companies/projects#index" => true,
      "companies/projects#show" => true,
      "companies/projects#create" => nil,
      "companies/projects#edit" => nil,
      "companies/projects#update" => nil,
      "companies/projects#destroy" => nil,
      "companies/users#index" => nil,
      "companies/users#new" => nil,
      "companies/users#create" => nil,
      "companies/users#search" => nil,
      "sessions#new" => true,
      "sessions#create" => true,
      "sessions#destroy" => nil,
      "users#show" => nil,
      "users#update" => nil,
      "cart_items#index" => true,
      "cart_items#create" => true,
      "cart_items#update" => true,
      "cart_items#destroy" => true,
      "orders#index" => nil,
      "orders#show" => nil,
      "orders#create" => nil,
      "users#create" => true }.each do |pair, result|

      context "looking at #{pair}" do
        let(:controller) { pair.split('#').first }
        let(:action) { pair.split('#').last }

        it "#{result ? 'allows' : 'denies'} access" do
          expect(allowed).to be(result)
        end
      end
    end
  end

  context "as a company admin" do
    let(:user) { Fabricate(:user, roles: %w(company_admin)) }

    { "homepage#index" => true,
      "projects#index" => true,
      "projects#show" => true,
      "categories#index" => true,
      "categories#show" => true,
      "companies#index" => true,
      "companies#show" => true,
      "companies/companies#dashboard" => true,
      "companies/projects#index" => true,
      "companies/projects#show" => true,
      "companies/projects#new" => true,
      "companies/projects#create" => true,
      "companies/projects#edit" => true,
      "companies/projects#update" => true,
      "companies/projects#destroy" => true,
      "companies/users#index" => true,
      "companies/users#new" => true,
      "companies/users#create" => true,
      "companies/users#update" => true,
      "companies/users#search" => true,
      "sessions#new" => true,
      "sessions#create" => true,
      "sessions#destroy" => true,
      "users#show" => true,
      "users#update" => true,
      "cart_items#index" => true,
      "cart_items#create" => true,
      "cart_items#update" => true,
      "cart_items#destroy" => true,
      "orders#index" => true,
      "orders#show" => true,
      "orders#create" => true,
      "users#create" => nil }.each do |pair, result|

      context "looking at #{pair}" do
        let(:controller) { pair.split('#').first }
        let(:action) { pair.split('#').last }

        it "#{result ? 'allows' : 'denies'} access" do
          expect(allowed).to be(result)
        end
      end
    end
  end

  context "as a collaborator" do
    let(:user) { Fabricate(:user, roles: %w(collaborator)) }

    { "homepage#index" => true,
      "projects#index" => true,
      "projects#show" => true,
      "categories#index" => true,
      "categories#show" => true,
      "companies#index" => true,
      "companies#show" => true,
      "companies/companies#dashboard" => true,
      "companies/projects#index" => true,
      "companies/projects#show" => true,
      "companies/projects#new" => true,
      "companies/projects#create" => true,
      "companies/projects#edit" => true,
      "companies/projects#update" => true,
      "companies/projects#destroy" => true,
      "companies/users#index" => true,
      "companies/users#new" => nil,
      "companies/users#create" => nil,
      "companies/users#update" => nil,
      "companies/users#search" => nil,
      "sessions#new" => true,
      "sessions#create" => true,
      "sessions#destroy" => true,
      "users#show" => true,
      "users#update" => true,
      "cart_items#index" => true,
      "cart_items#create" => true,
      "cart_items#update" => true,
      "cart_items#destroy" => true,
      "orders#index" => true,
      "orders#show" => true,
      "orders#create" => true,
      "users#create" => nil }.each do |pair, result|

      context "looking at #{pair}" do
        let(:controller) { pair.split('#').first }
        let(:action) { pair.split('#').last }

        it "#{result ? 'allows' : 'denies'} access" do
          expect(allowed).to be(result)
        end
      end
    end
  end
end
