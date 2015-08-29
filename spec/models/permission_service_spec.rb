require "rails_helper"

RSpec.describe "PermissionService", type: :model do
  let(:allowed) { PermissionService.new(user).allow?(controller, action) }

  context "as a registered user" do
    let(:user) { Fabricate(:user, roles: %w(registered_user)) }

    context "visiting the home page" do
      let(:controller) { "homepage" }

      context "looking at homepage#index" do
        let(:action) { "index" }

        it "allows access" do
          expect(allowed).to be true
        end
      end

      context "visiting companies" do
        let(:controller) { "companies" }

        context "looking at companies#index" do
          let(:action) { "index" }

          it "allows access" do
            expect(allowed).to be true
          end
        end

        context "looking at companies#show" do
          let(:action) { "show" }

          it "allows access" do
            expect(allowed).to be true
          end
        end
      end

      context "logging in or out" do
        let(:controller) { "sessions" }

        context "looking at sessions#new" do
          let(:action) { "new" }

          it "allows access" do
            expect(allowed).to be true
          end
        end

        context "looking at sessions#create" do
          let(:action) { "create" }

          it "allows access" do
            expect(allowed).to be true
          end
        end

        context "looking at sessions#destroy" do
          let(:action) { "destroy" }

          it "allows access" do
            expect(allowed).to be true
          end
        end
      end

      context "visiting projects" do
        let(:controller) { "projects" }

        context "looking at projects#index" do
          let(:action) { "index" }

          it "allows access" do
            expect(allowed).to be true
          end
        end

        context "looking at projects#show" do
          let(:action) { "show" }

          it "allows access" do
            expect(allowed).to be true
          end
        end
      end

      context "visiting companies/projects" do
        let(:controller) { "companies/projects" }

        context "looking at companies/projects#index" do
          let(:action) { "index" }

          it "allows access" do
            expect(allowed).to be true
          end
        end

        context "looking at companies/projects#show" do
          let(:action) { "show" }

          it "allows access" do
            expect(allowed).to be true
          end
        end
      end

      context "visiting users" do
        let(:controller) { "users" }

        context "looking at users#show" do
          let(:action) { "show" }

          it "allows access" do
            expect(allowed).to be true
          end
        end

        context "looking at users#update" do
          let(:action) { "update" }

          it "allows access" do
            expect(allowed).to be true
          end
        end
      end

      context "visiting cart_items" do
        let(:controller) { "cart_items" }

        context "looking at cart_items#index" do
          let(:action) { "index" }

          it "allows access" do
            expect(allowed).to be true
          end
        end

        context "looking at cart_items#create" do
          let(:action) { "create" }

          it "allows access" do
            expect(allowed).to be true
          end
        end

        context "looking at cart_items#update" do
          let(:action) { "update" }

          it "allows access" do
            expect(allowed).to be true
          end
        end

        context "looking at cart_items#destroy" do
          let(:action) { "destroy" }

          it "allows access" do
            expect(allowed).to be true
          end
        end
      end

      context "visiting orders" do
        let(:controller) { "orders" }

        context "looking at orders#index" do
          let(:action) { "index" }

          it "allows access" do
            expect(allowed).to be true
          end
        end

        context "looking at orders#create" do
          let(:action) { "create" }

          it "allows access" do
            expect(allowed).to be true
          end
        end

        context "looking at orders#show" do
          let(:action) { "show" }

          it "allows access" do
            expect(allowed).to be true
          end
        end
      end
    end
  end

  context "as a guest user" do

  end

  context "as a company admin" do

  end
end
